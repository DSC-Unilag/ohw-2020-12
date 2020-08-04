import app from "../../app";
import supertest from "supertest";
import User from "../../models/User";
import mongoose from "mongoose";

process.env.NODE_ENV = "test";

// REGISTRATION
describe("The registration flow", () => {
  beforeAll(async () => {
    jest.setTimeout(10000);
    // connect to the test database
    await mongoose
      .connect(process.env.TEST_DB, {
        useNewUrlParser: true,
        useCreateIndex: true,
        useUnifiedTopology: true,
      })
      .catch((err) => console.error(err));
    // clear the database
    await User.deleteMany({});
  });

  it("should register a new user to the database when provided complete user details and return a success response", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      username: "Johnny",
      password: "notSoSecret",
      email: "johndoe@gmail.com",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(201);
    expect(response.body.status).toBe(201);
    expect(response.body.message).toBe("Successfully created a new account.");
    expect(response.body.user).toBeDefined();
    expect(response.body.token).toBeDefined();
  });

  it("should return a failure response if name is not provided ", async () => {
    // Arrange
    const registrationDetails = {
      username: "Johnny",
      password: "notSoSecret",
      email: "johndoe@gmail.com",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if username is not provided ", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      password: "notSoSecret",
      email: "johndoe@gmail.com",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if password is not provided ", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      email: "johndoe@gmail.com",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if email is not provided ", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      password: "notSoSecret",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if provided email is not valid", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      password: "notSoSecret",
      email: "he",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if a user with the provided email is already registered", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      password: "notSoSecret",
      email: "hello@gmail.com",
    };
    await User.create(registrationDetails);
    registrationDetails.username = "JBoy";

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.errors[0]).toBe(
      "User with the given email already exist. Please login."
    );
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
  });

  it("should return a failure response if a user with the provided username is already registered", async () => {
    // Arrange
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      password: "notSoSecret",
      email: "hello@gmail.com",
    };
    await User.create(registrationDetails);
    registrationDetails.email = "hee@gmail.com";

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(registrationDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.errors[0]).toBe(
      "User with the given username already exist. Please login."
    );
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
  });
});

// LOGIN
describe("The login flow", () => {
  beforeAll(async () => {
    jest.setTimeout(10000);
    // connect to the test database
    await mongoose
      .connect(process.env.TEST_DB, {
        useNewUrlParser: true,
        useCreateIndex: true,
        useUnifiedTopology: true,
      })
      .catch((err) => console.error(err));
    // clear the database
    await User.deleteMany({});
  });

  it("should log a registered user in", async () => {
    // Arrange
    // create a user
    const registrationDetails = {
      name: "John Doe",
      username: "johny",
      password: "notSoSecret",
      email: "hello@gmail.com",
    };
    await User.create(registrationDetails);
    const loginDetails = {
      email: registrationDetails.email,
      password: registrationDetails.password,
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/login")
      .send(loginDetails);

    // Assert
    expect(response.status).toBe(200);
    expect(response.body.status).toBe(200);
    expect(response.body.errors).toBeUndefined();
    expect(response.body.message).toBe("Successfully logged in.");
    expect(response.body.user).toBeDefined();
    expect(response.body.user.email).toBe(loginDetails.email);
    expect(response.body.user.username).toBe(registrationDetails.username);
    expect(response.body.token).toBeDefined();
  });

  it("should not log a user in if they are not registered", async () => {
    // Arrange
    // create a user
    const loginDetails = {
      email: "notregistered@gmail.com",
      password: "I should be out!",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/login")
      .send(loginDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.errors).toBeDefined();
    expect(response.body.errors[0]).toBe(
      "These credentials do not match our records."
    );
    expect(response.body.user).toBeUndefined();
    expect(response.body.token).toBeUndefined();
  });

  it("should return a failure response if email is not provided ", async () => {
    // Arrange
    const loginDetails = {
      password: "notSoSecret",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(loginDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if email is not valid ", async () => {
    // Arrange
    const loginDetails = {
      email: "invalidEmail",
      password: "notSoSecret",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(loginDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });

  it("should return a failure response if password is not provided ", async () => {
    // Arrange
    const loginDetails = {
      email: "myemail@gmail.com",
    };

    // Act
    const response = await supertest(app)
      .post("/api/v1/auth/register")
      .send(loginDetails);

    // Assert
    expect(response.status).toBe(400);
    expect(response.body.status).toBe(400);
    expect(response.body.message).toBeUndefined();
    expect(response.body.user).toBeUndefined();
    expect(response.body.errors).toBeDefined();
  });
});
