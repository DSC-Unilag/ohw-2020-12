import express, { Router } from "express";
import recipeController from "../../controllers/v1/recipe.controller";
import { multerUploads } from "../../middleware/multer";

const recipeRouter: Router = express.Router();

recipeRouter.post("/create", multerUploads, recipeController.create);
recipeRouter.get("/all", recipeController.getAll);
recipeRouter.get("/:id", recipeController.getOne);
recipeRouter.post("/review/:id", recipeController.createReview);

export default recipeRouter;
