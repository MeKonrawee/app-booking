"use strict";

const firebase = require("../db");
const firestore = firebase.firestore();

const Register = async (req, res, next) => {
  try {
    const data = req.body;
    const bmi =
      Number(data.weight) /
      ((Number(data.height) / 100) * (Number(data.height) / 100));
    data.bmi = bmi.toFixed(2);
    if (data.sex === "Female") {
      const bmr = 655 + 9.6 * data.weight + 1.8 * data.height - 4.7 * data.age;
      data.bmr = bmr.toFixed(2);
    } else {
      const bmr = 66 + 13.7 * data.weight + 5 * data.height - 6.8 * data.age;
      data.bmr = bmr.toFixed(2);
    }
    await firestore.collection("account").doc().set(data);

    return res.status(201).json("Success!");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const Login = async (req, res, next) => {
  try {
    const username = req.body.username;
    const password = req.body.password;

    const login = await firestore
      .collection("account")
      .where("username", "==", username)
      .where("password", "==", password);
    const check = await login.get();
    if (check.empty) {
      return res.status(200).json(false);
    }

    const response = check.docs.map((doc) => {
      return doc.data();
    });
    return res.status(200).json(response[0]);
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const updateAccount = async (req, res, next) => {
  try {
    const fullname = req.params.fullname;
    const data = req.body;
    const account = await firestore
      .collection("account")
      .where("fullname", "==", fullname);
    const check = await account.get();
    if (check.empty) {
      return res.status(200).json("account not found");
    }

    const response = check.docs.map((doc) => {
      return doc.id;
    });
    const id = response[0];
    await firestore.collection("account").doc(id).update(data);
    return res.status(200).json("Success!");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  RegisterService: Register,
  LoginService: Login,
  UpdateAccountService: updateAccount,
};
