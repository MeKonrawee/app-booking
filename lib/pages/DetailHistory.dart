import 'package:flutter/material.dart';
import 'package:flutter_app/models/response/history_response.dart';
import 'package:flutter_app/themes/constant.dart';

class DetailHistory extends StatefulWidget {
  HistoryModel detail;
  DetailHistory({Key key, this.detail}) : super(key: key);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  String time;
  String date;
  int cal_total = 0;

  void cal() async {
    cal_total = 0;
    for (var i in widget.detail.foodMenu) {
      int sum = i.cal * i.quantity;
      cal_total = cal_total + sum;
    }
    setState(() {});
  }

  @override
  void initState() {
    cal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var split = widget.detail.date.split(" ");
    time = split[1];
    date = split[0];
    return Scaffold(
      backgroundColor: Color(0xFFfae3e2),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        leading: BackButton(color: Color(0xFF3a3737)),
        title: Text(
          "Detail History",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w600),
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
                        "Name : ${widget.detail.fullName}",
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
                        "Phone : ${widget.detail.tel}",
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
                        "Table Number : ${widget.detail.tableNumber}",
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
                        "Person Number : ${widget.detail.personNumber}",
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
                        "Time : ${time}",
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
                        "Booking date : ${date}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ButtonKYP(
            //   height: 40,
            //   width: 120,
            //   text: "Menu",
            //   process: () {
            //     Navigator.push(context, ScaleRoute(page: MenuWidget()));
            //   },
            // ),
            Divider(
              color: Colors.orange,
              thickness: 2,
              indent: 40,
              endIndent: 40,
            ),
            // PopularFoodsWidget(),
            Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    "Detail Order Food",
                    style: TextStyle(
                      color: Color.fromARGB(255, 32, 32, 32),
                      fontFamily: defaultFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                              "Order List",
                              style: TextStyle(
                                color: Color.fromARGB(255, 32, 32, 32),
                                fontFamily: defaultFontFamily,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.detail.foodMenu.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "${widget.detail.foodMenu[index].name} x${widget.detail.foodMenu[index].quantity}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF3a3a3b),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "${widget.detail.foodMenu[index].price} ฿",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF3a3a3b),
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Food Price Total",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF3a3a3b),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.detail.totalPrice} ฿",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF3a3a3b),
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Calories Total",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${cal_total.toString()} kcal",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Average Calory for a person",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.detail.averageCalories} kcal",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
