import HttpException from './http.exceptions';

class ClientWithThatEmailAlreadyExistsException extends HttpException {
  constructor(email: string) {
    super(400, `Client with email ${email} already exists`);
  }
}

export default ClientWithThatEmailAlreadyExistsException;