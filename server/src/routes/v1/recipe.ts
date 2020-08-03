import express, { Router } from "express";
import recipeController from "../../controllers/v1/recipe.controller";
import { multerUploads } from "../../middleware/multer";
import checkAuth from "../../middleware/auth";
import validator from "../../middleware/validator";

const recipeRouter: Router = express.Router();

recipeRouter.post(
  "/create",
  checkAuth,
  multerUploads,
  validator.createRecipe,
  recipeController.create
);
recipeRouter.get("/all", recipeController.getAll);
recipeRouter.get("/:id", validator.recipeId, recipeController.getOne);
recipeRouter.post("/search", validator.search, recipeController.searchRecipes);

export default recipeRouter;
