"use strict";

const firebase = require("../db");
const firestore = firebase.firestore();

const getPayment = async (req, res, next) => {
  try {
    const payment = await firestore.collection("booking");
    const data = await payment.get();
    if (data.empty) {
      return res.status(404).json("No payment found");
    } else {
      const paymentArray = [];
      for (const book of data.docs) {
        const table = await firestore
          .collection("table")
          .where("number", "==", book.data().table_number);
        const tableCheck = await table.get();
        if (tableCheck.empty) {
          return res.status(404).json("No table found");
        } else {
          for (const doc of tableCheck.docs) {
            if (doc.data().status === false) {
              paymentArray.push({
                id: doc.id,
                food_menu: book.data().food_menu,
                table_number: book.data().table_number,
              });
            }
          }
        }
      }
      return res.status(200).json(paymentArray);
    }
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  PaymentService: getPayment,
};
