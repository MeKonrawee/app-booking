import 'package:flutter/material.dart';
import 'package:flutter_app/themes/constant.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfae3e2),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        leading: BackButton(color: Color(0xFF3a3737)),
        title: Text(
          "All Booking History",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking date : ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Time : ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Name : ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Phone : ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Table Number : ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Person Number : ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
