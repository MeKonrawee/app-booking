"use strict";

const firebase = require("../db");
const firestore = firebase.firestore();

const Register = async (req, res, next) => {
  try {
    const data = req.body;
    console.log(data);
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
    const id = req.params.id;
    const data = req.body;
    const account = await firestore.collection("account").doc(id);
    await account.update(data);
    return res.status(200).json("account updated successfully");
  }  catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  RegisterService: Register,
  LoginService: Login,
  UpdateAccountService: updateAccount
};
