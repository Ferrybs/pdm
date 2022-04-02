import express from 'express';
import bodyParser from 'body-parser';
 
class App {
  public app: express.Application;
  public port: number;
 
  constructor(port: number) {
    this.app = express();
    this.port = port;
 
    this.initializeMiddlewares();
  }
 
  private initializeMiddlewares() {
    this.app.use(bodyParser.json());
  }

 
  public listen() {
    this.app.listen(this.port, () => {
      console.log(`App listening on the port ${this.port}`);
    });
  }
}
 
export default App;