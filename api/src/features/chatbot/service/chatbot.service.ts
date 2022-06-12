import dialogflow, { SessionsClient } from "@google-cloud/dialogflow";
import HttpException from "../../../exceptions/http.exceptions";
import _ from "lodash";
import Services from "../../../services/services";
import NotFoundHttpException from "../../../exceptions/not.found.http.exception";
import ChatbotSession from "../entities/chatbot.session.entity";
import ChatbotMessageRequestDTO from "../dto/chatbot.message.request.dto";
import ChatbotMessageResponseDTO from "../dto/chatbot.message.response.dto";
import { DataSource } from "typeorm";
import ClientChatbotDTO from "../dto/client.chatbot.dto";
import ChatbotMessage from "../entities/chatbot.message.entity";
import Client from "../../../features/client/entities/client.entity";
import validateEnv from "../../../utils/validateEnv";

export default class ChatbotService extends Services{
    private _privateKey: string;
    private _dialogflowprojectId: string;
    private _dialogflowSessionClient: SessionsClient;

    constructor(dataSource: DataSource){
      super(dataSource);
      this._privateKey = _.replace(validateEnv.DIALOGFLOW_PRIVATE_KEY, new RegExp("\\\\n", "\g"), "\n");
      this._dialogflowprojectId = validateEnv.DIALOGFLOW_PROJECT_ID;
      this.initialize();
    }
    private initialize(){
      try {
        this._dialogflowSessionClient = new dialogflow.SessionsClient({
            credentials: {
                client_email: validateEnv.DIALOGFLOW_CLIENT_EMAIL,
                private_key: this._privateKey
            }
        })
    } catch (error) {
        if (error instanceof HttpException){
            throw new HttpException(404, "Dialogflow Session Client Error: " + error.message);
        } else{
            throw error;
        }
    }
    }
    public async sendText(chatbotMessageRequestDTO: ChatbotMessageRequestDTO, clientDTO: ClientChatbotDTO): Promise<ChatbotMessageResponseDTO>{
      if (!clientDTO){
        throw new NotFoundHttpException('Client');
      }

      var chatbotSession = await this._chatbotDatabase.findChatbotSessionBySessionId(chatbotMessageRequestDTO.sessionId);
      if (!chatbotSession){
        const client = new Client();
        client.id = clientDTO.id;

        const newChatbotSession = new ChatbotSession();
        newChatbotSession.client = client;
        newChatbotSession.id = chatbotMessageRequestDTO.sessionId;

        chatbotSession = await this._chatbotDatabase.insertChatbotSession(newChatbotSession);
      } else if (! (await this.isMatchSessionChatbot(chatbotSession.id,clientDTO.id))) {
          throw new NotFoundHttpException("ChatbotSession");
      }

      const chatbotMessage = new ChatbotMessage();
      chatbotMessage.message = chatbotMessageRequestDTO.text;
      chatbotMessage.date = new Date(chatbotMessageRequestDTO.date);
      chatbotMessage.type = this.getClientTypeMessage();
      chatbotMessage.chatbotSession = chatbotSession;

      await this._chatbotDatabase.insertChatbotMessage(chatbotMessage);

        const _sessionPath = this._dialogflowSessionClient.projectAgentSessionPath(this._dialogflowprojectId, chatbotSession.id);
        const {value} = await require("pb-util");

        try {
            var res = await this._dialogflowSessionClient.detectIntent(
              {
                session: _sessionPath,
                queryInput: {
                  text: {
                    text: `${chatbotMessage.message}`,
                    languageCode: "pt-BR"
                  }
                },
                queryParams: {
                  contexts: [
                    {
                      name: `projects/${this._dialogflowprojectId}/agent/sessions/${chatbotSession.id}/contexts/_context_data`,
                      lifespanCount: 5,
                      parameters: value.encode({ u_email: clientDTO.credentialsDTO.email, sessionId: chatbotSession.id })
                    }
                  ]
                }
              }
            );
        } catch (error) {
            console.log(error);
        }

        const newChatbotMessage = new ChatbotMessage();
        newChatbotMessage.message = res[0].queryResult.fulfillmentText;
        newChatbotMessage.date = new Date();
        newChatbotMessage.type = this.getBotTypeMessage();
        newChatbotMessage.chatbotSession = chatbotSession;        

        await this._chatbotDatabase.insertChatbotMessage(newChatbotMessage);

        const newChatbotMessageDTO = new ChatbotMessageResponseDTO();
        newChatbotMessageDTO.text = newChatbotMessage.message;
        newChatbotMessageDTO.date = newChatbotMessage.date.toString();
        newChatbotMessageDTO.sessionId = newChatbotMessage.chatbotSession.id;
        newChatbotMessageDTO.type = newChatbotMessage.type;

        try {
          if(res[0]?.queryResult?.fulfillmentMessages[1]?.payload?.fields["suggestions"]["listValue"]["values"]){
            var suggestions = res[0]?.queryResult?.fulfillmentMessages[1]?.payload?.fields["suggestions"]["listValue"]["values"];
            newChatbotMessageDTO.suggestions = suggestions.map((value)=>value["stringValue"]);
          }
        } catch (error) {
          throw new HttpException(400,error.message);
        }

        return newChatbotMessageDTO;
    }


    public async getAllMessagesSession(clientDTO: ClientChatbotDTO, id: string): Promise<ChatbotMessageResponseDTO[]>{

      if (!id){
        throw new NotFoundHttpException('ChatbotSessionId');
      }

        if(await this.isMatchSessionChatbot(id,clientDTO.id)){    
          const chatbotMessages = await this._chatbotDatabase.findChatbotMessagesBySessionId(id);
          const chatbotMessagesDTO: ChatbotMessageResponseDTO[] = [];
          if (chatbotMessages){
            chatbotMessages.forEach((chatbotMessage) => {
              const newChatbotMessageDTO = new ChatbotMessageResponseDTO();
              newChatbotMessageDTO.sessionId = chatbotMessage.id;
              newChatbotMessageDTO.date = chatbotMessage.date.toString();
              newChatbotMessageDTO.text = chatbotMessage.message;
              newChatbotMessageDTO.type = chatbotMessage.type;
    
              chatbotMessagesDTO.push(newChatbotMessageDTO);
            });
          }
    
          return chatbotMessagesDTO;
        }else{
            throw new NotFoundHttpException("Messages");
        }
    }

    public async deleteAllMessagesBySessionId(clientDTO: ClientChatbotDTO, id: string): Promise<boolean>{
      if (!id){
        throw new NotFoundHttpException('ChatbotSessionId');
      }

        if(await this.isMatchSessionChatbot(id,clientDTO.id)){    
          return await this._chatbotDatabase.deleteAllMessagesBySessionId(id);
        }else{
            throw new NotFoundHttpException("Session");
        }
    }

    public async isMatchSessionChatbot(sessionId: string, clientId: string): Promise<boolean>{
      if (clientId && sessionId) {
          const session = await this._chatbotDatabase.findChatbotSessionById(sessionId);
          if (session) {
                  if (session.client.id == clientId) {
                      return true;
                  } else {
                    return false
                  }
          }
      }
      return true;
  }
}