import app from "../../app";
import supertest from "supertest";
import User from "../../models/User";

process.env.NODE_ENV = "test";

describe("The registration flow", () => {
  // clear the database first
  beforeAll(async () => {
    jest.setTimeout(10000);
    await User.deleteMany({});
  });

  it("should register a new user to the database and return a success response", async () => {
    const response = await supertest(app).post("/api/v1/register").send({
      name: "John Doe",
      username: "Johnny",
      password: "notSoSecret",
      email: "johndoe@gmail.com",
    });

    expect(response.status).toBe(201);
    expect(response.body.status).toBe(201);
    expect(response.body.message).toBe("Successfully created a new account.");
    expect(response.body.user).toBeDefined();
    expect(response.body.token).toBeDefined();
  });
});
