import app from "../../app";
import supertest from "supertest";
import Recipe from "../../models/Recipe";
import data from "../../utils/data";
import mongoose from "mongoose";
import Category from "../../models/Category";

describe("Categories fetching process", () => {
  beforeAll(async () => {
    jest.setTimeout(10000);
    // connect to the test database
    await mongoose.connect(process.env.TEST_DB, {
      useNewUrlParser: true,
      useCreateIndex: true,
      useUnifiedTopology: true,
      useFindAndModify: false,
    });
    // clear the database
    await Recipe.deleteMany({});
  });

  it("should get all the categories of recipes in the application", async () => {
    // Arrange
    await Recipe.create(data[0]);
    await Recipe.create(data[1]);
    await Recipe.create(data[2]);

    // Act
    const response = await supertest(app).get(`/api/v1/category/all`);

    // Assert
    expect(response.status).toBe(302);
    expect(response.body.status).toBe(302);
    expect(response.body.message).toBe("Successfully got all categories.");
    expect(response.body.categories).toBeDefined();
  });

  it("should get all the recipes under a given category", async () => {
    // Arrange
    await Recipe.create(data[0]);
    await Recipe.create(data[1]);
    const category = await Category.find({});
    const id = category[0]._id;

    // Act
    const response = await supertest(app).get(`/api/v1/category/${id}`);

    // Assert
    expect(response.status).toBe(302);
    expect(response.body.status).toBe(302);
    expect(response.body.message).toBe(
      "Successfully got all recipes in this category."
    );
    expect(response.body.category.recipes).toBeDefined();
  });
});
