import { IsDate, IsDateString, MaxLength, MinLength, ValidateNested } from "class-validator";
import ChatbotTypeMessageDTO from "./chatbot.type.message.dto";

export default class ChatbotMessageRequestDTO {
    @MinLength(6)
    public sessionId?: string;
    
    @MinLength(1)
    public text?: string;

    @IsDateString()
    public date: string;
}