const express = require("express");
const { RegisterService: Register } = require("../controllers/loginController");
const { LoginService: Login } = require("../controllers/loginController");
const {
  BookingService: getBooking,
  InsertBookingService: insertBooking,
} = require("../controllers/bookingController");
const {
  InsertMenuService: insertMenu,
  GetMenuService: getMenu,
  DeleteMenuService: deleteMenu,
} = require("../controllers/menuController");
const {
  GetTableService: getTable,
  DeleteTableService: deleteTable,
  AddTableService: addTable,
} = require("../controllers/tableController");
const swaggerUi = require("swagger-ui-express");
const swaggerDoc = require("../swagger");

const router = express.Router();

router.use("/swagger", swaggerUi.serve, swaggerUi.setup(swaggerDoc));

router.post("/register", Register);
router.post("/login", Login);
router.post("/menus", insertMenu);
router.get("/menus", getMenu);
router.get("/menus/delete/:id", deleteMenu);
router.get("/booking", getBooking);
router.post("/booking", insertBooking);
router.get("/tables", getTable);
router.get("/tables/delete/:id", deleteTable);
router.get("/tables/add/:number", addTable);

module.exports = {
  routes: router,
};
