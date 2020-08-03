import express, { Router } from "express";
import categoryController from "../../controllers/v1/category.controller";
import validator from "../../middleware/validator";

const categoryRouter: Router = express.Router();

categoryRouter.get("/all", categoryController.getAll);

categoryRouter.get("/:id", validator.categoryId, categoryController.getOne);

export default categoryRouter;
