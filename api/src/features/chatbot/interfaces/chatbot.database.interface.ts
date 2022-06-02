import ChatbotMessage from "../entity/chatbot.message.entity";
import ChatbotSession from "../entity/chatbot.session.entity";

export default interface ChatbotDatabase{
    findChatbotSessionBySessionId(id: string): Promise<ChatbotSession>;
    findChatbotMessagesBySessionId(id: string): Promise<ChatbotMessage[]>;
    findChatbotSessionById(id: string): Promise<ChatbotSession>;

    insertChatbotSession(chatbotSession: ChatbotSession): Promise<ChatbotSession>;
    insertChatbotMessage(chatbotMessage: ChatbotMessage): Promise<ChatbotMessage>;

    deleteAllMessagesBySessionId(sessionId: string): Promise<boolean>;
}