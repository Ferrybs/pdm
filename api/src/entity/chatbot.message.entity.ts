import { Column, Entity, ManyToOne, OneToOne, PrimaryColumn } from "typeorm";
import ChatbotSession from "./chatbot.session.entity";
import Client from "./client.entity";

@Entity()
export default class ChatbotMessage{
    @PrimaryColumn()
    public id?: string;

    @Column({nullable:false})
    public message?: string;

    @ManyToOne(() => ChatbotSession, chatbotSession => chatbotSession.id, {nullable: false})
    public chatbotSession?: ChatbotSession;
}