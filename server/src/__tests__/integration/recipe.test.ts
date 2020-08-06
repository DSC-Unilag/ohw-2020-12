import app from "../../app";
import supertest from "supertest";
import Recipe from "../../models/Recipe";
import mongoose, { mongo } from "mongoose";
import jwt from "jsonwebtoken";
import path from "path";
import configuration from "../../config/config";
import data from "../../utils/data";

const image = path.join(__dirname, "frittata.jpg");
process.env.NODE_ENV = "test";
const { JWT_KEY } = configuration("test");

const payload = {
  email: "johndoe@gmail.com",
  _id: mongoose.Types.ObjectId(),
  username: "Johny",
};
const token = jwt.sign(payload, JWT_KEY, { expiresIn: "1h" });

// REGISTRATION
describe("Recipe creation", () => {
  beforeAll(async () => {
    jest.setTimeout(10000);
    // connect to the test database
    await mongoose
      .connect(process.env.TEST_DB, {
        useNewUrlParser: true,
        useCreateIndex: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
      })
      .catch((err) => console.error(err));
    // clear the database
    await Recipe.deleteMany({});
  });

  it("should create a new recipe if the user is authenticated and all values are provided.", async () => {
    // Arrange
    const recipeDetails = {
      title: "test recipe",
      description: "A wonderful recipe",
      time: "10mins",
      category: "Lunch",
      cusine: "French",
      utensils: "Frying pan",
      instructions: "Fry the damn thin!",
      ingredients: [{ item: "oil", quantity: "1 ounce" }],
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/recipe/create")
      .set({
        Accept: "multipart/form-data",
        authorization: `Bearer ${token}`,
      })
      .attach("image", image)
      .field("title", recipeDetails.title)
      .field("description", recipeDetails.description)
      .field("time", recipeDetails.time)
      .field("category", recipeDetails.category)
      .field("cusine", recipeDetails.cusine)
      .field("utensils", recipeDetails.utensils)
      .field("instructions", recipeDetails.instructions)
      .field(
        "ingredients",
        '[{"item": "onion", "quantity": "medium (chopped)"}]'
      );

    // Assert
    expect(response.status).toBe(201);
    expect(response.body.status).toBe(201);
    expect(response.body.recipe).toBeDefined();
    expect(response.body.message).toBe("Successfully created a new recipe.");
  });

  it("should not create a new recipe if the an image file is not provided.", async () => {
    // Arrange
    const recipeDetails = {
      title: "test recipe",
      description: "A wonderful recipe",
      time: "10mins",
      category: "Lunch",
      cusine: "French",
      utensils: "Frying pan",
      instructions: "Fry the damn thin!",
      ingredients: [{ item: "oil", quantity: "1 ounce" }],
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/recipe/create")
      .set({
        Accept: "multipart/form-data",
        authorization: `Bearer ${token}`,
      })
      .field("title", recipeDetails.title)
      .field("description", recipeDetails.description)
      .field("time", recipeDetails.time)
      .field("category", recipeDetails.category)
      .field("cusine", recipeDetails.cusine)
      .field("utensils", recipeDetails.utensils)
      .field("instructions", recipeDetails.instructions)
      .field(
        "ingredients",
        '[{"item": "onion", "quantity": "medium (chopped)"}]'
      );

    // Assert
    expect(response.status).toBe(500);
    expect(response.body.status).toBe(500);
    expect(response.body.recipe).toBeUndefined();
    expect(response.body.errors[0]).toBe(
      "Please provide an image for the recipe."
    );
  });

  it("should not create a new recipe if user is not authenticated.", async () => {
    // Arrange
    const recipeDetails = {
      title: "test recipe",
      description: "A wonderful recipe",
      time: "10mins",
      category: "Lunch",
      cusine: "French",
      utensils: "Frying pan",
      instructions: "Fry the damn thin!",
      ingredients: "Oil, obviously.",
      file: "../assets/image.jpg",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/recipe/create")
      .set({
        Accept: "multipart/form-data",
      })
      .attach("image", image)
      .field("title", recipeDetails.title)
      .field("description", recipeDetails.description)
      .field("time", recipeDetails.time)
      .field("category", recipeDetails.category)
      .field("cusine", recipeDetails.cusine)
      .field("utensils", recipeDetails.utensils)
      .field("instructions", recipeDetails.instructions)
      .field(
        "ingredients",
        '[{"item": "onion", "quantity": "medium (chopped)"}]'
      );

    // Assert
    expect(response.status).toBe(401);
    expect(response.body.status).toBe(401);
    expect(response.body.recipe).toBeUndefined();
    expect(response.body.errors[0]).toBe("Authentication Failed");
  });

  afterAll(async () => {
    await mongoose.connection.close();
  });
});

describe("Recipe retrieving process", () => {
  beforeAll(async () => {
    jest.setTimeout(10000);
    // connect to the test database
    await mongoose
      .connect(process.env.TEST_DB, {
        useNewUrlParser: true,
        useCreateIndex: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
      })
      .catch((err) => console.error(err));
    // clear the database
    await Recipe.deleteMany({});
  });

  it("should get a given recipe by id", async () => {
    // Arrange
    const { _id: id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app).get(`/api/v1/recipe/${id}`);

    // Assert
    expect(response.status).toBe(302);
    expect(response.body.status).toBe(302);
    expect(response.body.message).toBe("Successfully got a recipe.");
    expect(response.body.recipe).toBeDefined();
  });

  it("should not get a recipe if an id is not provided", async () => {
    // Arrange
    await Recipe.create(data[0]);

    // Act
    const response = await supertest(app).get(`/api/v1/recipe/`);

    // Assert
    expect(response.status).toBe(404);
  });

  it("should not get a recipe if an invalid id is provided", async () => {
    // Arrange
    await Recipe.create(data[0]);

    // Act
    const response = await supertest(app).get(`/api/v1/recipe/kdkduedkkue`);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors[0].msg).toBe("Invalid recipe ID.");
    expect(response.body.recipe).toBeUndefined();
  });

  it("should get all the recipes in the application", async () => {
    // Arrange
    await Recipe.create(data[0]);
    await Recipe.create(data[1]);
    await Recipe.create(data[2]);

    // Act
    const response = await supertest(app).get(`/api/v1/recipe/all`);

    // Assert
    expect(response.status).toBe(302);
    expect(response.body.status).toBe(302);
    expect(response.body.message).toBe("Successfully got all recipes.");
    expect(response.body.recipes).toBeDefined();
  });

  it("should search for recipes and return those that match a search string", async () => {
    // Arrange
    await Recipe.create(data[0]);
    await Recipe.create(data[1]);
    await Recipe.create(data[2]);

    // Act
    const response = await supertest(app).post(`/api/v1/recipe/search`).send({
      searchString: "chinese",
    });

    // Assert
    expect(response.status).toBe(302);
    expect(response.body.status).toBe(302);
    expect(response.body.message).toBe(
      "Successfully got all recipes matching your search."
    );
    expect(response.body.result).toBeDefined();
  });

  it("should not return any recipe if a search string is not provided.", async () => {
    // Arrange
    await Recipe.create(data[0]);
    await Recipe.create(data[1]);
    await Recipe.create(data[2]);

    // Act
    const response = await supertest(app).post(`/api/v1/recipe/search`).send({
      searchString: "",
    });

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.recipes).toBeUndefined();
  });

  afterAll(async () => {
    // clear the database
    await Recipe.deleteMany({});
  });
});
