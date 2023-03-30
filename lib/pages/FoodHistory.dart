import 'package:flutter/material.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/controllers/userInfo.dart';
import 'package:flutter_app/models/response/history_response.dart';
import 'package:flutter_app/pages/DetailHistory.dart';
import 'package:flutter_app/services/history_services.dart';
import 'package:flutter_app/themes/constant.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List resultHistory = [];

  void getHistory() async {
    resultHistory = await HistoryService.getMenu(user.fullname);
    resultHistory.sort((a, b) => b.date.compareTo(a.date));
    setState(() {});
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfae3e2),
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          title: Text(
            "All Booking History",
            style: TextStyle(
                color: Color(0xFF3a3737),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          brightness: Brightness.light,
        ),
        body: ListView.builder(
          itemCount: resultHistory.length,
          itemBuilder: (context, index) {
            return BoxHistory(resultHistory[index]);
          },
        )
        //  SingleChildScrollView(
        //   child:
        //    Column(
        //     children: [

        //       BoxHistory(),
        //       BoxHistory(),
        //     ],
        //   ),
        // ),
        );
  }

  GestureDetector BoxHistory(HistoryModel detail) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ScaleRoute(
            page: DetailHistory(detail: detail),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${detail.date}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 32, 32, 32),
                    fontFamily: defaultFontFamily,
                    fontSize: 16,
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text("Detail"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward_outlined)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
