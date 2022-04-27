import HttpException from "./http.exceptions";

class SessionHttpException extends HttpException{
    constructor(type: string, message: string){
        super(500,`Failed to ${type}: ${message}`)
}
}

export default SessionHttpException;