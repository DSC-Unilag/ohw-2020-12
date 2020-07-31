import express, { Router } from "express";
import recipeController from "../../controllers/v1/recipe.controller";
import { multerUploads } from "../../middleware/multer";
import checkAuth from "../../middleware/auth";

const recipeRouter: Router = express.Router();

recipeRouter.post("/create", multerUploads, checkAuth, recipeController.create);
recipeRouter.get("/all", recipeController.getAll);
recipeRouter.get("/:id", recipeController.getOne);

export default recipeRouter;
