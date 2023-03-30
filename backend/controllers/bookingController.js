"use strict";

const firebase = require("../db");
const firestore = firebase.firestore();
const BookingResponse = require("../models/booking");

const getBooking = async (req, res, next) => {
  try {
    const menus = await firestore.collection("booking");
    const data = await menus.get();
    const tableArray = [];
    if (data.empty) {
      return res.status(404).json("No table found");
    } else {
      data.forEach((doc) => {
        const menu = new BookingResponse(
          doc.id,
          doc.data().food_menu,
          doc.data().full_name,
          doc.data().person_number,
          doc.data().table_number,
          doc.data().tel,
          doc.data().date
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

const insertBooking = async (req, res, next) => {
  try {
    const data = req.body;
    await firestore.collection("booking").doc().set(data);

    const checkTable = await firestore
      .collection("table")
      .where("number", "==", data.table_number)
      .get();
    if (checkTable.empty) {
      return res.status(404).json("No table found");
    }
    checkTable.forEach((doc) => {
      firestore.collection("table").doc(doc.id).update({
        status: false,
      });
    });
    return res.status(200).json("Success!");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const getHistory = async (req, res, next) => {
  try {
    const name = req.params.name;
    const menus = await firestore
      .collection("booking")
      .where("full_name", "==", name);
    const data = await menus.get();
    if (data.empty) {
      return res.status(404).json("No table found");
    } else {
      return res.status(200).json(
        data.docs.map((doc) => {
          return {
            id: doc.id,
            food_menu: doc.data().food_menu,
            full_name: doc.data().full_name,
            person_number: doc.data().person_number,
            table_number: doc.data().table_number,
            tel: doc.data().tel,
            date: doc.data().date,
            total_price: doc.data().total_price,
            average_calories: doc.data().average_calories,
          };
        })[0]
      );
    }
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  BookingService: getBooking,
  InsertBookingService: insertBooking,
  HistoryBookingService: getHistory,
};
