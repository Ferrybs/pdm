import { Entity, ManyToOne, OneToMany, PrimaryColumn } from "typeorm";
import ChatbotMessage from "./chatbot.message.entity";
import Client from "./client.entity";

@Entity()
export default class ChatbotSession{
    @PrimaryColumn()
    public id?: string;

    @OneToMany(() => ChatbotMessage, chatbotMessage => chatbotMessage.id )
    public chatbotMessages?: ChatbotMessage[];

    @ManyToOne(() => Client, client => client.id, {nullable: false})
    public client?: Client;
}