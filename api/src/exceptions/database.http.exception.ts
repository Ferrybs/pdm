import HttpException from "./http.exceptions";

class DatabaseHttpException extends HttpException{
    message: string;
    constructor(message: string){
        super(500,`Database error: ${message}`)
}
}

export default DatabaseHttpException;