import mongoose from "mongoose";
import jwt from "jsonwebtoken";
import configuration from "../../config/config";
import Recipe from "../../models/Recipe";
import data from "../../utils/data";
import app from "../../app";
import supertest from "supertest";
import User from "../../models/User";

process.env.NODE_ENV = "test";
const { JWT_KEY } = configuration("test");

let payload = {};
let token = "";
let id = "";

describe("User operations", () => {
  beforeAll(async () => {
    jest.setTimeout(10000);
    // connect to the test database
    await mongoose.connect(process.env.TEST_DB, {
      useNewUrlParser: true,
      useCreateIndex: true,
      useUnifiedTopology: true,
      useFindAndModify: false,
    });

    // create a user
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      password: "notSoSecret",
      email: "hello@gmail.com",
    };
    const user = await User.create(registrationDetails);
    payload = {
      email: user.email,
      _id: user._id,
      username: user.username,
    };
    id = user._id;
    token = jwt.sign(payload, JWT_KEY, { expiresIn: "1h" });
    // clear the database
    await Recipe.deleteMany({});
  });

  it("should save a recipe to an authenticated user's saved list", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/save/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      });

    // Assert

    expect(response.status).toBe(200);
    expect(response.body.status).toBe(200);
    expect(response.body.user).toBeDefined();
    expect(response.body.message).toBe("Successfully saved recipe.");
  });

  it("should not save a recipe twice to an authenticated user's saved list", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    // save it a first time
    await supertest(app)
      .post(`/api/v1/user/save/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      });
    // now try to save it again
    const response = await supertest(app)
      .post(`/api/v1/user/save/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      });

    // Assert

    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors[0]).toBe("Bad Request. Recipe already saved.");
  });

  it("should add a recipe to an authenticated user's favorite list", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/favorite/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      });

    // Assert
    expect(response.status).toBe(200);
    expect(response.body.status).toBe(200);
    expect(response.body.user).toBeDefined();
    expect(response.body.message).toBe(
      "Successfully added recipe to favorites."
    );
  });

  it("should not add a recipe to an authenticated user's favorite list twice", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    // add to favorite the first time
    await supertest(app)
      .post(`/api/v1/user/favorite/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      });
    // now try to add to favorite again
    const response = await supertest(app)
      .post(`/api/v1/user/favorite/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      });

    // Assert

    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors[0]).toBe(
      "Bad Request. Recipe already favorite."
    );
  });

  it("should get the details of a user by id", async () => {
    // Arrange

    // Act
    const response = await supertest(app).get(`/api/v1/user/${id}`);

    // Assert
    expect(response.status).toBe(302);
    expect(response.body.status).toBe(302);
    expect(response.body.message).toBe("Successfully got user details.");
    expect(response.body.user).toBeDefined();
    expect(response.body.user.saved_recipes).toBeDefined();
    expect(response.body.user.favorite_recipes).toBeDefined();
  });

  it("should create a review by a an authenticated user", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/review/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      })
      .send({ stars: 5, review: "Excellent", username: "Johny" });

    // Assert

    expect(response.status).toBe(201);
    expect(response.body.status).toBe(201);
    expect(response.body.updatedRecipe).toBeDefined();
    expect(response.body.message).toBe("Successfully reviewed recipe.");
  });

  it("should not create a review if stars value is not provided", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/review/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      })
      .send({ review: "Excellent", username: "Johny" });

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.updatedRecipe).toBeUndefined();
  });

  it("should not create a review if review value is not provided", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/review/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      })
      .send({ stars: 4, username: "Johny" });

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.recipe).toBeUndefined();
  });

  it("should not create a review if username is not provided", async () => {
    // Arrange
    // create a recipe
    const { _id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/review/${_id}`)
      .set({
        Accept: "application/json",
        authorization: `Bearer ${token}`,
      })
      .send({ review: "Good", stars: 4 });

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.recipe).toBeUndefined();
  });

  afterAll(async () => {
    await mongoose.connection.close();
  });
});
