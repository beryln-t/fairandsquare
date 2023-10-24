const { DataTypes } = require("sequelize");
const sequelize = require("../config/database"); // Assuming your Sequelize configuration is in this file

const User = sequelize.define(
  "User",
  {
    user_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING(50),
      unique: true,
      allowNull: false,
    },
    mobileNumber: {
      type: DataTypes.STRING(320),
      unique: true,
      allowNull: false,
    },
    isContact: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
  },
  {
    timestamps: true,
    underscored: true,
  }
);

module.exports = User;
