import express, { Router } from "express";
import authRouter from "./v1/auth";
import recipeRouter from "./v1/recipe";

const v1Router: Router = express.Router();

v1Router.use("/api/v1/auth", authRouter);

v1Router.use("/api/v1/recipe", recipeRouter);

export default v1Router;
