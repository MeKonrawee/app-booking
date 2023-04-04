import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/common/button.dart';
import 'package:flutter_app/models/response/table_response.dart';
import 'package:flutter_app/pages/BookTable.dart';
import 'package:flutter_app/pages/TableAvailable.dart';
import 'package:flutter_app/services/table_services.dart';
import 'package:flutter_app/widgets/MenuWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import '../themes/constant.dart';

class BookTableWidget extends StatefulWidget {
  final String tableNumber;
  BookTableWidget(this.tableNumber);
  @override
  _BookTableWidgetState createState() => _BookTableWidgetState(tableNumber);
}

class _BookTableWidgetState extends State<BookTableWidget> {
  String tableNumber;
  _BookTableWidgetState(this.tableNumber);
  String nameTable = "";
  TextEditingController amount = new TextEditingController();
  TextEditingController timeValue = new TextEditingController();
  TimeOfDay pickedTime = TimeOfDay.now();

  @override
  void initState() {
    if (tableNumber != null) {
      nameTable = tableNumber;
      setState(() {});
    }
    super.initState();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<TableResponse>>(
            future: TablesService.getTables(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<TableResponse> carouselCard = snapshot.data;
                carouselCard.sort((a, b) => a.id.compareTo(b.id));
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MasonryGridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    itemCount: carouselCard.length,
                    itemBuilder: (context, index) {
                      return BookTableTiles(
                        name: carouselCard[index].number,
                        status: carouselCard[index].status,
                        func: carouselCard[index].status
                            ? () {
                                nameTable = carouselCard[index].number;
                                Navigator.pushReplacement(
                                  context,
                                  ScaleRoute(
                                    page: BookTable(nameTable),
                                  ),
                                );
                              }
                            : () {},
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          Container(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/Table/table.png",
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Available',
                      style: TextStyle(
                        color: Color.fromARGB(255, 45, 44, 44),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/Table/untable.png",
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Unavailable',
                      style: TextStyle(
                        color: Color.fromARGB(255, 45, 44, 44),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          nameTable == ""
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Table Booking : ${nameTable}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 45, 44, 44),
                            fontFamily: defaultFontFamily,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        StatefulBuilder(
                          builder: (context, refresh) {
                            return Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: TextField(
                                    controller: amount,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]'),
                                      ),
                                    ],
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4.5, horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.people_alt_rounded,
                                        color: Color(0xFF666666),
                                        size: defaultIconSize,
                                      ),
                                      fillColor: Color(0xFFF2F3F5),
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 56, 55, 55),
                                          fontFamily: defaultFontFamily,
                                          fontSize: defaultFontSize),
                                      hintText: "Amount of Customers",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (amount.text == "") {
                                      refresh(() {
                                        amount.text = "1";
                                      });
                                    } else {
                                      if (int.parse(amount.text) < 99) {
                                        refresh(() {
                                          amount.text =
                                              (int.parse(amount.text) + 1)
                                                  .toString();
                                        });
                                      }
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFFF2F3F5),
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 56, 55, 55),
                                      size: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (amount.text != "" &&
                                        int.parse(amount.text) == 1) {
                                      refresh(() {
                                        amount.text = "";
                                      });
                                    } else {
                                      if (amount.text != "" &&
                                          int.parse(amount.text) > 0) {
                                        refresh(() {
                                          amount.text =
                                              (int.parse(amount.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFFF2F3F5),
                                    child: Icon(
                                      Icons.remove,
                                      color: Color.fromARGB(255, 56, 55, 55),
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time = await showTimePicker(
                                context: context, initialTime: pickedTime);
                            if (time == null) return null;
                            timeValue.text = formatTimeOfDay(time);
                          },
                          child: TextField(
                            enabled: false,
                            showCursor: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 4.5),
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
                                Icons.date_range,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Time of Booking",
                            ),
                            controller: timeValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ButtonKYP(
                            height: 40,
                            width: 120,
                            text: "OK",
                            process: () {
                              if (nameTable != "" &&
                                  amount.text != "" &&
                                  timeValue.text != "") {
                                if (amount.text == "0") {
                                  setState(() {
                                    amount.text = "";
                                  });
                                } else {
                                  // รอ API
                                  // print(nameTable);
                                  // print(amount.text);
                                  // print(timeValue.text);
                                  // print("send");
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text(
                                        "Notification",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Table Booking : ${nameTable}",
                                          ),
                                          Text(
                                            "Customer Amounts : ${amount.text} People",
                                          ),
                                          Text(
                                            "Time : ${timeValue.text}",
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MenuWidget(
                                                  int.parse(amount.text),
                                                  nameTable,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Confirm"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
