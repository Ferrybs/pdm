export default class SendEmailException extends Error {
    constructor(message?: string){
        super(message);
        this.name = "SendEmailException";
        this.stack = (<any> new Error()).stack;
    }
}