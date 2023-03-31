import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/common/button.dart';
import 'package:flutter_app/pages/SignInPage.dart';
import 'package:flutter_app/services/forgotPassword_services.dart';
import 'package:flutter_app/themes/constant.dart';

class ChangePassworod extends StatefulWidget {
  String email;
  ChangePassworod({
    Key key,
    this.email,
  }) : super(key: key);

  @override
  State<ChangePassworod> createState() => _ChangePassworodState();
}

class _ChangePassworodState extends State<ChangePassworod> {
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                  "Change Password",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: defaultFontFamily,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              TextField(
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: defaultFontFamily,
                    fontSize: defaultFontSize,
                  ),
                  hintText: "Password",
                ),
                controller: password,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: defaultFontFamily,
                    fontSize: defaultFontSize,
                  ),
                  hintText: "Confirm Password",
                ),
                controller: confirmpassword,
              ),
              SizedBox(
                height: 15,
              ),
              ButtonKYP(
                text: "save",
                process: () async {
                  if (password.text == confirmpassword.text &&
                      password.text != "" &&
                      confirmpassword.text != "") {
                    var result = await ForgotPasswordservices.changePassword(
                        widget.email, password.text);
                    if (result == '"Success!"') {
                      Navigator.pushReplacement(
                        context,
                        ScaleRoute(
                          page: SignInPage(),
                        ),
                      );
                    }
                  }
                },
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
