import express, { Router } from "express";
import authController from "../../controllers/v1/auth.controller";
import validator from "../../middleware/validator";

const authRouter: Router = express.Router();

authRouter.post("/login", validator.login, authController.login);

authRouter.post("/register", validator.register, authController.register);

export default authRouter;
