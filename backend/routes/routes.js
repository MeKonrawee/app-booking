const express = require("express");
const { RegisterService: Register } = require("../controllers/loginController");
const { LoginService: Login } = require("../controllers/loginController");
const swaggerUi = require("swagger-ui-express");
const swaggerDoc = require("../swagger");

const router = express.Router();

router.use("/swagger", swaggerUi.serve, swaggerUi.setup(swaggerDoc));

router.post("/register", Register);
router.post("/login", Login);

module.exports = {
  routes: router,
};
