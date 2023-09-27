const { Pool } = require("pg");
require("dotenv").config();

const pool = new Pool({
  user: "pwjobrtb",
  host: "john.db.elephantsql.com",
  database: "pwjobrtb",
  password: process.env.DB_PASSWORD,
  port: 5432,
  ssl: {
    rejectUnauthorized: false,
  },
});

module.exports = pool;
