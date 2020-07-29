import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app: express.Application = express();

app.get("/", (req, res) => {
  res.send("Hello World!!!");
});

export default app;
