"use strict";

const nodemailer = require("nodemailer");
const md5 = require("md5");
const firebase = require("../db");
const firestore = firebase.firestore();

const sendEmail = async (req, res, next) => {
  try {
    const email = req.params.email;
    const verifyNumber = Math.floor(Math.random() * 1000) + 1;
    const verifyHash = md5(verifyNumber.toString());

    const ForgotPassword = await firestore
      .collection("forgot_password")
      .doc("AVWb4QYvNNTTeYOP8grS");
    const Update = { verify: verifyHash };
    await ForgotPassword.update(Update);

    var transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "konrawee.p62@chandra.ac.th",
        pass: "1320700283965",
      },
    });

    var mailOptions = {
      from: "findjobmobileapp@gmail.com",
      to: email,
      subject: "KYP app [reset password]",
      html:
        "<center><h1>Verify Reset password : " +
        verifyNumber +
        "</h1></center>",
    };

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        return res.status(404).send(error);
      } else {
        return res.status(200).send("ส่งรหัส verify แล้ว");
      }
    });
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  SendEmailService: sendEmail,
};
