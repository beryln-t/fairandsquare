const sequelize = require("../config/database");
const User = require("../Model/User");

const modelName = process.argv[2];

if (modelName === "User") {
  User.sync()
    .then(() => console.log("User table has been created."))
    .catch((error) => console.error("Failed to create User table:", error));
}
