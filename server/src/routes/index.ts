import express, { Router } from "express";
import authRouter from "./v1/auth";
import recipeRouter from "./v1/recipe";
import userRouter from "./v1/user";
import categoryRouter from "./v1/categories";

const v1Router: Router = express.Router();

v1Router.use("/api/v1/auth", authRouter);

v1Router.use("/api/v1/recipe", recipeRouter);

v1Router.use("/api/v1/user", userRouter);

v1Router.use("/api/v1/category", categoryRouter);

export default v1Router;
