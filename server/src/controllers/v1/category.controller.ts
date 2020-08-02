import { Request, Response } from "express";
import Category, { CategoryDocument } from "../../models/Category";

/**
 * This method gets all the categories
 * @param req - Request object
 * @param res - Response object
 */

const getAll = async (req: Request, res: Response) => {
  const categories: CategoryDocument[] = await Category.find({});

  if (categories) {
    return res.status(200).json({
      status: 200,
      categories,
      message: "Successfully got all categories.",
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not get all categories.",
  });
};

/**
 * This method gets all the recipes under a signle category by id
 * @param req - Request object
 * @param res - Response object
 */
const getOne = (req: Request, res: Response) => {
  const id: string = req.params.id;

  Category.findOne({ _id: id })
    .populate("recipes")
    .then((category: CategoryDocument) => {
      return res.status(200).json({
        status: 200,
        category,
        message: "Successfully got all recipes in this category.",
      });
    })
    .catch((e: Error) => {
      console.log(e);
      return res.status(500).json({
        status: 500,
        error:
          "Something went wrong. Could not get all recipes in this category.",
      });
    });
};

export default { getAll, getOne };
