import dialogflow, { SessionsClient } from "@google-cloud/dialogflow";
import HttpException from "../exceptions/http.exceptions";
import _ from "lodash";
import Services from "../services/services";
import struct from "pb-util";
import { response } from "express";

export default class ChatbotService extends Services{
    private _privateKey: string;
    private _dialogflowprojectId: string;
    private _dialogflowSessionClient: SessionsClient;

    constructor(){
        super();
        this._privateKey = _.replace(process.env.DIALOGFLOW_PRIVATE_KEY, new RegExp("\\\\n", "\g"), "\n");
        this._dialogflowprojectId = process.env.DIALOGFLOW_PROJECT_ID;

        try {
            this._dialogflowSessionClient = new dialogflow.SessionsClient({
                credentials: {
                    client_email: process.env.DIALOGFLOW_CLIENT_EMAIL,
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
    
    public async sendText(text: any, email: any, sessionId: any){
        var _sessionPath = this._dialogflowSessionClient.projectAgentSessionPath(this._dialogflowprojectId, sessionId);
        var request = {
            session: _sessionPath,
            queryInput: {
              text: {
                text: `${text}`,
                languageCode: "pt-BR"
              }
            },
            queryParams: {
              contexts: [
                {
                  name: `projects/${this._dialogflowprojectId}/agent/sessions/${sessionId}/contexts/_context_data`,
                  lifespanCount: 5,
                  parameters: struct.struct.encode({ u_email: email, sessionId: sessionId })
                }
              ]
            }
          };

        try {
            var res = await this._dialogflowSessionClient.detectIntent(request);
        } catch (error) {
            console.log(error);
        }

        return response.send(res);
    }


}