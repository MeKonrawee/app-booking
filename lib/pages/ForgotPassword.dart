import 'package:flutter/material.dart';
import 'package:flutter_app/pages/ChangePassword.dart';
import 'package:flutter_app/services/forgotPassword_services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../animation/ScaleRoute.dart';
import '../common/button.dart';
import '../themes/constant.dart';
import 'SignInPage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = new TextEditingController();
  bool otp = false;
  String code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: otp
          ? Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
              width: double.infinity,
              height: double.infinity,
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 230,
                    height: 100,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/menus/kyp.png",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      "OTP",
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontFamily: defaultFontFamily,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  OTPTextField(
                    length: 3,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 80,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      if (pin == code) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChangePassworod(email: email.text),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          : Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
              width: double.infinity,
              height: double.infinity,
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 230,
                          height: 100,
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/menus/kyp.png",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: email,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: "Email",
                          ),
                          // controller: email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonKYP(
                          height: 55,
                          width: 350,
                          text: "Send Email",
                          process: () async {
                            if (email.text != "") {
                              code = await ForgotPasswordservices.sendOTP(
                                  email.text);
                              setState(() {
                                otp = true;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Have an account? ",
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context, ScaleRoute(page: SignInPage())),
                            child: Container(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xFFf7418c),
                                  fontFamily: defaultFontFamily,
                                  fontSize: defaultFontSize,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
