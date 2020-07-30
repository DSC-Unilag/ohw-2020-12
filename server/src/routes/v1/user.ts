import express, { Router } from "express";
import userController from "../../controllers/v1/user.controller";
import checkAuth from "../../middleware/auth";

const userRouter: Router = express.Router();

userRouter.post("/save/:id", checkAuth, userController.saveRecipe);
userRouter.post("/favorite/:id", checkAuth, userController.favorite);
userRouter.post("/review/:id", checkAuth, userController.createReview);
userRouter.get("/all", userController.getAll);
userRouter.get("/:id", userController.getOne);

export default userRouter;
