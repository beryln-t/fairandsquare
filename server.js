const express = require("express");
const path = require("path");
const logger = require("morgan");
require("dotenv").config();
require("./config/database");

//define routes
const usersRouter = require("./routes/usersRouter");
const billsRouter = require("./routes/billsRouter");
const contactsRouter = require("./routes/contactsRouter");
const paymentsRouter = require("./routes/paymentsRouter");
const adjustmentsRouter = require("./routes/adjustmentsRouter");

const app = express();
const port = process.env.PORT || 3000;

app.use(logger("dev"));
app.use(express.json());
app.use(express.static(path.join(__dirname, "dist")));

//use routes
app.use("/api/user", usersRouter);
app.use("/api/bills", billsRouter);
app.use("/api/contacts", contactsRouter);
app.use("/api/payments", paymentsRouter);
app.use("/api/adjustments", adjustmentsRouter);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
