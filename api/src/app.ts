import express from 'express';
import bodyParser from 'body-parser';
import Controller from './interfaces/controller.interface';
 
class App {
  public app: express.Application;
  public port: number;
 
  constructor(port: number, controllers: Controller[]) {
    this.app = express();
    this.port = port;
 
    this.initializeMiddlewares();
    this.initializeControllers(controllers);
  }
 
  private initializeMiddlewares() {
    this.app.use(bodyParser.json());
  }

 
  public listen() {
    this.app.listen(this.port, () => {
      console.log(`App listening on the port ${this.port}`);
    });
  }
  private initializeControllers(controllers: Controller[]) {
    controllers.forEach((controller) => {
      this.app.use('/', controller.router);
    });
  }
}
 
export default App;