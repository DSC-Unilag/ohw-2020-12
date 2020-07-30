import express from "express";
import dotenv from "dotenv";
import bodyParser from "body-parser";
import v1Router from "./routes/index";

dotenv.config();

const app: express.Application = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(v1Router);

export default app;
