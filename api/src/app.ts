import express from 'express';
import bodyParser from 'body-parser';
import routes from './interfaces/routes.interface';
import Routes from 'interfaces/routes.interface';
import cookieParser from 'cookie-parser'
 
class App {
  public app: express.Application;
  public port: number;
 
  constructor(port: number, routes: Routes[]) {
    this.app = express();
    this.port = port;
 
    this.initializeMiddlewares();
    this.initializeroutes(routes);
  }
 
  private initializeMiddlewares() {
    this.app.use(bodyParser.json());
    this.app.use(cookieParser());
  }

 
  public listen() {
    this.app.listen(this.port, () => {
      console.log(`App listening on the port ${this.port}`);
    });
  }
  private initializeroutes(routes: routes[]) {
    routes.forEach((routes) => {
      this.app.use('/', routes.router);
    });
  }
}
 
export default App;