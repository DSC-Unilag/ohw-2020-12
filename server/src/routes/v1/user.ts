import express, { Router } from "express";
import userController from "../../controllers/v1/user.controller";
import checkAuth from "../../middleware/auth";
import validator from "../../middleware/validator";

const userRouter: Router = express.Router();

userRouter.post(
  "/save/:id",
  checkAuth,
  validator.recipeId,
  userController.saveRecipe
);
userRouter.post(
  "/favorite/:id",
  checkAuth,
  validator.recipeId,
  userController.favorite
);
userRouter.post(
  "/review/:id",
  validator.createReview,
  userController.createReview
);
userRouter.get("/:id", validator.userId, userController.getOne);
// userRouter.get("/all", userController.getAll);

export default userRouter;
