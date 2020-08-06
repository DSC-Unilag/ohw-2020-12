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
    token = jwt.sign(payload, JWT_KEY, { expiresIn: "1h" });
    // clear the database
    await Recipe.deleteMany({});
  });

  it('should save a recipe to an authenticated user"s saved list', async () => {
    // Arrange
    // create a recipe
    const { _id: id } = await Recipe.create(data[0]);

    // Act
    const response = await supertest(app)
      .post(`/api/v1/user/save/${id}`)
      .set({
        Accept: "multipart/form-data",
        authorization: `Bearer ${token}`,
      });

    // Assert

    expect(response.status).toBe(200);
    expect(response.body.status).toBe(200);
    expect(response.body.user).toBeDefined();
    expect(response.body.message).toBe("Successfully saved recipe.");
  });

  afterAll(async () => {
    await mongoose.connection.close();
  });
});
