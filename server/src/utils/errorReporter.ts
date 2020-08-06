import express from "express";
import { Result, ValidationError } from "express-validator";

const sendValidationError = (
  res: express.Response,
  errors: Result<ValidationError>
) => {
  if (!errors.isEmpty()) {
    return res.status(400).json({
      status: 400,
      errors: errors.array(),
    });
  }
};

export default sendValidationError;
