"use strict";

const nodemailer = require("nodemailer");
const firestore = firebase.firestore();

const sendEmail = async (req, res, next) => {
  try {
    const emailUser = req.params.email;
    let transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "konrawee.p62@chandra.ac.th",
        pass: "1320700283965",
      },
    });

    // setup email data
    let mailOptions = {
      from: "konrawee.p62@chandra.ac.th",
      to: emailUser,
      subject: "You forgot the password",
      text: "OTP is 4656",
    };

    // send email
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log(error);
      } else {
        console.log("Email sent: " + info.response);
      }
    });
    return res.status(200).json("Sent");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  SendemailService: sendEmail,
};
