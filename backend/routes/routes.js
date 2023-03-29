const express = require("express");
const { RegisterService: Register } = require("../controllers/loginController");
const { LoginService: Login } = require("../controllers/loginController");
const {
  BookingService: getBooking,
  InsertBookingService: insertBooking,
  HistoryBookingService: getHistory,
} = require("../controllers/bookingController");
const {
  InsertMenuService: insertMenu,
  UpdateMenuService: updateMenu,
  GetMenuService: getMenu,
  DeleteMenuService: deleteMenu,
  FindMenuService: findMenu,
} = require("../controllers/menuController");
const {
  GetTableService: getTable,
  DeleteTableService: deleteTable,
  AddTableService: addTable,
} = require("../controllers/tableController");
const {
  PaymentService: getPayment,
} = require("../controllers/paymentController");
const swaggerUi = require("swagger-ui-express");
const swaggerDoc = require("../swagger");

const router = express.Router();

router.use("/swagger", swaggerUi.serve, swaggerUi.setup(swaggerDoc));

router.post("/register", Register);
router.post("/login", Login);
router.post("/menus", insertMenu);
router.post("/menus/:id", updateMenu);
router.get("/menus", getMenu);
router.get("/menus/delete/:id", deleteMenu);
router.get("/menus/find/:id", findMenu);
router.get("/booking", getBooking);
router.post("/booking", insertBooking);
router.get("/tables", getTable);
router.get("/tables/delete/:id", deleteTable);
router.get("/tables/add/:number", addTable);
router.get("/history/:name", getHistory);
router.get("/payment/list", getPayment);

module.exports = {
  routes: router,
};
