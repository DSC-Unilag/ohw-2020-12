import dotenv from "dotenv";

dotenv.config();

interface ConfigObject {
  connectionString: string;
  JWT_KEY: string;
}

function configuration(NODE_ENV: string): ConfigObject {
  if (NODE_ENV === "test") {
    return {
      connectionString: process.env.TEST_DB,
      JWT_KEY: "anythingAnything",
    };
  }

  if (NODE_ENV === "production") {
    return {
      connectionString: process.env.DATABASE_URL,
      JWT_KEY: process.env.JWT_KEY,
    };
  }

  if (NODE_ENV === "development") {
    return {
      connectionString: process.env.DATABASE_URL,
      JWT_KEY: process.env.JWT_KEY,
    };
  }
  throw new Error(`Environment configuration ${NODE_ENV} does not exist`);
}

export default configuration;
