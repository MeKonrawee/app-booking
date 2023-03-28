"use strict";

const firebase = require("../db");
const firestore = firebase.firestore();
const TableResponse = require("../models/table");

const getTable = async (req, res, next) => {
  try {
    const table = await firestore.collection("table");
    const data = await table.get();
    const tableArray = [];
    if (data.empty) {
      return res.status(404).json("No menu found");
    } else {
      data.forEach((doc) => {
        const menu = new TableResponse(
          doc.id,
          doc.data().number,
          doc.data().status
        );
        tableArray.push(menu);
      });
      return res.status(200).json(tableArray);
    }
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const deleteTable = async (req, res, next) => {
  try {
    const id = req.params.id;
    await firestore.collection("table").doc(id).delete();
    return res.status(200).json("Table deleted successfully");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  GetTableService: getTable,
  DeleteTableService: deleteTable,
};
