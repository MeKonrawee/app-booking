"use strict";

const nodemailer = require("nodemailer");

const sendEmail = async (req, res, next) => {
  try {
    const url = require("url");
    const querystring = require("querystring");
    const urlObj = url.parse(req.url);
    const queryParams = querystring.parse(urlObj.query);
    let transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "konrawee.p62@chandra.ac.th",
        pass: "1320700283965",
      },
    });

    let mailOptions = {
      from: "konrawee.p62@chandra.ac.th",
      to: queryParams.email,
      subject: "You forgot the password",
      text: "OTP is 4656",
    };

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
  SendEmailService: sendEmail,
};
