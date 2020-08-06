import Recipe, { RecipeDocument } from "../../models/Recipe";
import { Request, Response } from "express";
import User, { UserDocument } from "../../models/User";
import Review, { ReviewDocument } from "../../models/Review";
import { validationResult } from "express-validator";
import sendValidationError from "../../utils/errorReporter";

/**
 * this method allows saving a recipe by an authenticated user
 * @param req
 * @param res
 */
const saveRecipe = async (req: Request, res: Response) => {
  const recipeId: string = req.params.id;
  const userId: string = req.currentUser._id;

  // find the validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  // find the recipe document
  const recipe: RecipeDocument = await Recipe.findOne({ _id: recipeId });
  if (recipe) {
    // check if the recipe is not saved already
    const user = await User.findOne({ _id: userId });
    if (user.saved_recipes.includes(recipeId)) {
      return res.status(400).json({
        status: 400,
        errors: ["Bad Request. Recipe already saved."],
      });
    }
    // update the user
    const updatedUser: UserDocument = await User.findOneAndUpdate(
      { _id: userId },
      { $push: { saved_recipes: recipeId } },
      // {new: true} to return the updated document, by default it returns the original
      { new: true }
    );
    updatedUser.password = undefined;
    // return the updated recipe
    if (updatedUser) {
      updatedUser.password = undefined;
      return res.status(200).json({
        status: 200,
        user: updatedUser,
        message: "Successfully saved recipe.",
      });
    }
  }

  return res.status(500).json({
    status: 500,
    errors: ["Something went wrong. Could not save recipe."],
  });
};

/**
 * Add a recipe to favorites
 * @param req
 * @param res
 */
const favorite = async (req: Request, res: Response) => {
  const recipeId: string = req.params.id;
  const userId: string = req.currentUser._id;

  // find the validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  // find the recipe document
  const recipe: RecipeDocument = await Recipe.findOne({ _id: recipeId });

  // check if the recipe is not saved already
  const user = await User.findOne({ _id: userId });
  if (recipe) {
    if (user.favorite_recipes.includes(recipeId)) {
      return res.status(400).json({
        status: 400,
        errors: ["Bad Request. Recipe already favorite."],
      });
    }
    // update the user
    const updatedUser: UserDocument = await User.findOneAndUpdate(
      { _id: userId },
      { $push: { favorite_recipes: recipeId } },
      // {new: true} to return the updated document, by default it returns the original
      { new: true }
    );
    // return the updated recipe
    if (updatedUser) {
      updatedUser.password = undefined;
      return res.status(200).json({
        status: 200,
        user: updatedUser,
        message: "Successfully added recipe to favorites.",
      });
    }
  }

  return res.status(500).json({
    status: 500,
    errors: ["Something went wrong. Could not add recipe to favorites."],
  });
};

/**
 * This method gets all the registered users
 * @param req - Request object
 * @param res - Response object
 */

const getAll = async (req: Request, res: Response) => {
  const users: UserDocument[] = await User.find({});

  const protectedUsers = users.map((user) => {
    // I don't know why delete user.password does not work
    user.password = undefined;
    return user;
  });

  if (users) {
    return res.status(302).json({
      status: 302,
      users: protectedUsers,
      message: "Successfully got all users.",
    });
  }

  return res.status(500).json({
    status: 500,
    errors: ["Something went wrong. Could not get all users."],
  });
};

/**
 * This method gets a single user by ID alongside their saved recipes
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

  User.findOne({ _id: id })
    .populate("saved_recipes")
    .populate("favorite_recipes")
    .then((user) => {
      user.password = undefined;
      return res.status(302).json({
        status: 302,
        user,
        message: "Successfully got user details.",
      });
    })
    .catch((e) => {
      return res.status(500).json({
        status: 500,
        errors: ["Something went wrong. Could not get the user."],
      });
    });
};

/**
 * Given a recipe id, this method creates a review for it
 * @param req - Request object
 * @param res - Response object
 */
//
const createReview = async (req: Request, res: Response) => {
  const { stars, review, username } = req.body;

  const id: string = req.params.id;

  // find the validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }
  // first create the review
  const createdReview: ReviewDocument = await Review.create({
    stars,
    review,
    author: username,
  });

  if (createdReview) {
    // find the recipe
    const updatedRecipe: RecipeDocument = await Recipe.findOneAndUpdate(
      { _id: id },
      { $push: { reviews: createdReview._id } },
      // {new: true} to return the updated document, by default it returns the original
      { new: true }
    );

    // return the updated recipe
    if (updatedRecipe) {
      return res.status(201).json({
        status: 201,
        updatedRecipe,
        message: "Successfully reviewed recipe.",
      });
    }
  }

  return res.status(500).json({
    status: 500,
    errors: ["Something went wrong. Could not review recipe."],
  });
};

export default { getAll, getOne, saveRecipe, createReview, favorite };
