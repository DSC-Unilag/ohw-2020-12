import Recipe, { RecipeDocument } from "../../models/Recipe";
import { Request, Response } from "express";
import { validationResult, Result, ValidationError } from "express-validator";
import { dataUri } from "../../middleware/multer";
import { uploader } from "../../config/cloudinary.config";
import Category from "../../models/Category";
import sendValidationError from "../../utils";

// TODO: implement add ingredients

/**
 * This function creates a new recipe
 * @param req - Request object
 * @param res - Response object
 */
const create = async (req: Request, res: Response) => {
  const {
    title,
    description,
    time,
    category,
    cusine,
    utensils,
    ingredients,
  }: RecipeDocument = req.body;

  if (!ingredients) {
    return res.status(400).json({
      status: 400,
      errors: ["Ingredients must be provided."],
    });
  }

  if (!Array.isArray(ingredients)) {
    return res.status(400).json({
      status: 400,
      errors: ["Ingredients must be an array of objects."],
    });
  }

  const isValidIngredientsArray = ingredients.every((ingredient) => {
    return (
      ingredient.type !== null &&
      ingredient.quantity !== null &&
      typeof ingredient.type === "string" &&
      typeof ingredient.quantity === "string"
    );
  });

  if (!isValidIngredientsArray)
    return res.status(400).json({
      status: 400,
      errors: ["Each ingredient object must have a type and a quantity."],
    });

  // validate the text inputs

  // find the validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  let image: string;

  if (req.file) {
    const file = dataUri(req).content;
    const result = await uploader.upload(file);
    image = result.url;
  }

  const recipe: RecipeDocument = await Recipe.create({
    title,
    description,
    time,
    image,
    category,
    ownerId: req.currentUser._id,
    cusine,
    utensils,
    user: req.currentUser.username,
  });

  if (recipe) {
    try {
      const createdCategory = await Category.findOneAndUpdate(
        { title: category },
        { $push: { recipes: recipe._id } },
        { new: true, upsert: true }
      );
      if (!createdCategory) {
        res.status(500).json({
          status: 500,
          error: "Something went wrong. Could not add recipe to the category.",
        });
      }
    } catch (error) {
      console.error(error);
    }
  }

  if (recipe && image) {
    return res.status(201).json({
      status: 201,
      recipe,
      message: "Successfully created a new recipe.",
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not create recipe.",
  });
};

/**
 * This method gets all the recipes in the database
 * @param req - Request object
 * @param res - Response object
 */

const getAll = async (req: Request, res: Response) => {
  const recipes: RecipeDocument[] = await Recipe.find({});

  if (recipes) {
    return res.status(302).json({
      status: 302,
      recipes,
      message: "Successfully got all recipes.",
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not get all recipe.",
  });
};

/**
 * This method gets a single recipe by ID
 * @param req - Request object
 * @param res - Response object
 */
const getOne = (req: Request, res: Response) => {
  const id: string = req.params.id;

  // find the validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  Recipe.findOne({ _id: id })
    .populate("reviews")
    .then((recipe) => {
      return res.status(302).json({
        status: 302,
        recipe,
        message: "Successfully got a recipe.",
      });
    })
    .catch((e) => {
      return res.status(500).json({
        status: 500,
        error: "Something went wrong. Could not get the recipe.",
      });
    });
};

const searchRecipes = async (req: Request, res: Response) => {
  // get the search term
  const { searchString } = req.body;
  // find the validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  const searchResult = await Recipe.find({
    title: { $regex: searchString, $options: "i" },
  });
  if (searchResult) {
    return res.status(302).json({
      status: 302,
      result: searchResult,
      message: "Successfully got all recipes matching your search.",
    });
  } else {
    return res.status(404).json({
      status: 404,
      message: "Sorry, no records matched your search.",
    });
  }
};

export default { create, getAll, getOne, searchRecipes };
