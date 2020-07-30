import express, { Router } from "express";
import recipeController from "../../controllers/v1/recipe.controller";

const recipeRouter: Router = express.Router();

recipeRouter.post("/create", recipeController.create);

export default recipeRouter;
