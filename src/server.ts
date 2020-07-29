import app from "./app";
import http from "http";

const port : number = 3000;
const server = http.createServer(app);

// tslint:disable-next-line: no-console
server.listen(port, () => console.log(`App started on this port: ${port}`));

export default server;
