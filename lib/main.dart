import 'package:flutter/material.dart';
import 'package:flutter_app/pages/SignInPage.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
        // home: CaloryCount(),

        home: SignInPage()
        // MainScreen(),
        ),
  );
}
