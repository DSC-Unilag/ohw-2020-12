import express, { Router } from "express";
import categoryController from "../../controllers/v1/category.controller";

const categoryRouter: Router = express.Router();

categoryRouter.get("/all", categoryController.getAll);
categoryRouter.get("/:id", categoryController.getOne);

export default categoryRouter;
