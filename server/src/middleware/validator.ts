import { check, body } from "express-validator";

const validator: any = {};

validator.login = [
  body("email")
    .exists()
    .withMessage("Email must be provided")
    .isEmail()
    .withMessage("Invalid email address.")
    .trim()
    .escape(),

  body("password")
    .exists()
    .withMessage("Password must be provided")
    .isLength({ min: 5 })
    .withMessage("Passord must be at least 5 chars long")
    .trim()
    .escape(),
];

validator.register = [
  body("email")
    .exists()
    .withMessage("Email must be provided")
    .isEmail()
    .withMessage("Invalid email address.")
    .trim()
    .escape(),

  body("name")
    .exists()
    .withMessage("Name must be provided")
    .isLength({ min: 3 })
    .withMessage("Name must be at least 3 chars long.")
    .trim()
    .escape(),

  body("username")
    .exists()
    .withMessage("Username must be provided")
    .isLength({ min: 3 })
    .withMessage("Username must be at least 3 chars long.")
    .trim()
    .escape(),

  body("password")
    .exists()
    .withMessage("Password must be provided")
    .isLength({ min: 5 })
    .withMessage("Passord must be at least 5 chars long")
    .trim()
    .escape(),
];

validator.search = [
  check("searchString")
    .exists()
    .withMessage("Search string must be provided")
    .isLength({ min: 2 })
    .withMessage("Search string must be at least 2 chars long")
    .trim()
    .escape(),
];

validator.createRecipe = [
  body("title")
    .exists()
    .withMessage("Title must be provided")
    .notEmpty()
    .withMessage("Recipe title cannot be empty")
    .isLength({ min: 3 })
    .withMessage("Title must be at least 3 characters long.")
    .trim()
    .escape(),

  body("description")
    .exists()
    .withMessage("Description must be provided")
    .notEmpty()
    .withMessage("Recipe description cannot be empty")
    .isLength({ min: 10 })
    .withMessage("Description must be at least 10 characters long.")
    .trim()
    .escape(),

  body("time")
    .exists()
    .withMessage("Time duration must be provided")
    .notEmpty()
    .withMessage("Duration time cannot be empty.")
    .trim()
    .escape(),

  body("category")
    .exists()
    .withMessage("Category must be provided")
    .notEmpty()
    .withMessage("Category cannot be empty.")
    .trim()
    .escape(),

  body("cusine")
    .exists()
    .withMessage("Cusine must be provided")
    .notEmpty()
    .withMessage("Cusine cannot be empty.")
    .trim()
    .escape(),

  body("utensils")
    .exists()
    .withMessage("Utensils must be provided")
    .notEmpty()
    .withMessage("utensils cannot be empty.")
    .trim()
    .escape(),
];

validator.recipeId = [
  check("id")
    .exists()
    .withMessage("Recipe ID must be provided")
    .notEmpty()
    .withMessage("Id cannot be empty.")
    .isMongoId()
    .withMessage("Invalid recipe ID."),
];

validator.categoryId = [
  check("id")
    .exists()
    .withMessage("Category ID must be provided")
    .notEmpty()
    .withMessage("Id cannot be empty.")
    .isMongoId()
    .withMessage("Invalid category ID."),
];

validator.userId = [
  check("id")
    .exists()
    .withMessage("User ID must be provided")
    .notEmpty()
    .withMessage("User ID cannot be empty.")
    .isMongoId()
    .withMessage("Invalid user ID."),
];

validator.createReview = [
  body("stars")
    .exists()
    .withMessage("Stars rating must be provided")
    .notEmpty()
    .withMessage("Stars rating cannot be empty.")
    .isInt()
    .withMessage("Star rating must be an integer")
    .trim()
    .escape(),

  body("review")
    .exists()
    .withMessage("Review comment must be provided")
    .notEmpty()
    .withMessage("Review comment cannot be empty.")
    .trim()
    .escape(),
  body("username")
    .exists()
    .withMessage("Username must be provided")
    .notEmpty()
    .withMessage("Username cannot be empty.")
    .trim()
    .escape(),
  check("id")
    .exists()
    .withMessage("Recipe Id must be provided.")
    .isMongoId()
    .withMessage("Invalid id"),
];
export default validator;
