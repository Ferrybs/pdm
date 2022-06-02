import { IsDateString, MinLength, ValidateNested } from "class-validator";
import ChatbotTypeMessageDTO from "./chatbot.type.message.dto";

export default class ChatbotMessageResponseDTO {
    @MinLength(6)
    public sessionId?: string;
    
    @MinLength(1)
    public text?: string;

    @IsDateString()
    public date: string;

    @ValidateNested()
    public type: ChatbotTypeMessageDTO;
}