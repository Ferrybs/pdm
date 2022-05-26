import Controller from "../controllers/controller";
import HttpException from "../exceptions/http.exceptions";
import { Response } from "express";
import HttpData from "../interfaces/http.data.interface";
import RequestWithToken from "../interfaces/request.token.interface";

export default class ChatbotController extends Controller{

    public async sendText(request: RequestWithToken, response: Response){
        if (request.error){
            const httpData: HttpData = { ok: false, message: request.error};
            response.status(400).send(httpData);
        } else {
            try {
                var { text, email, sessionId } = request.body;
                const result = await this.chatbotService.sendText(text, email, sessionId);
                response.status(200).send({ok: true, result});                
            } catch (error) {
                if(error instanceof(HttpException)){
                    response.status(error.status).send(error.data);
                  }else{
                    const httpData: HttpData = { ok: false, message: error.message};
                    response.status(500).send(httpData);
                  }
            }
        }
    }
}