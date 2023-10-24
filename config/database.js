const { Sequelize } = require("sequelize");
require("dotenv").config();

const sequelize = new Sequelize(
  "pwjobrtb",
  "pwjobrtb",
  process.env.DB_PASSWORD,
  {
    host: "john.db.elephantsql.com",
    port: 5432,
    dialect: "postgres",
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false,
      },
    },
  }
);

module.exports = sequelize;
