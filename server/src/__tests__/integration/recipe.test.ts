import app from "../../app";
import supertest from "supertest";
import Recipe from "../../models/Recipe";
import mongoose from "mongoose";
import jwt from "jsonwebtoken";
import path from "path";

const image = path.join(__dirname, "image.jpg");
process.env.NODE_ENV = "test";
const jwtSecret = process.env.JWT_KEY;

const payload = {
  email: "johndoe@gmail.com",
  _id: mongoose.Types.ObjectId(),
  username: "Johny",
};
const token = jwt.sign(payload, jwtSecret, { expiresIn: "1h" });

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
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      })
      .send(recipeDetails);

    // Assert
    expect(response.status).toBe(500);
    expect(response.body.status).toBe(500);
    expect(response.body.recipe).toBeUndefined();
    expect(response.body.errors[0]).toBe(
      "Something went wrong. Could not create recipe."
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
      .send(recipeDetails);

    // Assert
    expect(response.status).toBe(401);
    expect(response.body.status).toBe(401);
    expect(response.body.recipe).toBeUndefined();
    expect(response.body.errors[0]).toBe("Authentication Failed");
  });
});
