import 'dart:async';
import 'package:flutter_app/controllers/cartList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/button.dart';
import 'package:flutter_app/models/bookingDetail_Model.dart';
import 'package:flutter_app/models/response/booking_response.dart';
import 'package:flutter_app/pages/mainScreen.dart';
import 'package:flutter_app/services/booking_services.dart';

import '../animation/ScaleRoute.dart';
import '../themes/constant.dart';

class FoodOrderConfirm extends StatefulWidget {
  BookingDetailModel orderFood;
  FoodOrderConfirm({
    Key key,
    @required this.orderFood,
  }) : super(key: key);

  @override
  State<FoodOrderConfirm> createState() => _FoodOrderConfirmState();
}

class _FoodOrderConfirmState extends State<FoodOrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfae3e2),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        leading: BackButton(color: Color(0xFF3a3737)),
        title: Text(
          "Detail Booking",
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
                        "Name : ${widget.orderFood.fullname}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Phone : ${widget.orderFood.phone}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Table Number : ${widget.orderFood.tableName}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Customer Amounts : ${widget.orderFood.people}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Time : ${widget.orderFood.timeBook}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Booking date : ${widget.orderFood.dateBook}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Booking Time : ${widget.orderFood.timeValue}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontFamily: defaultFontFamily,
                          fontSize: 14,
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
                    "Detail Order Booking",
                    style: TextStyle(
                      color: Color.fromARGB(255, 32, 32, 32),
                      fontFamily: defaultFontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
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
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.orderFood.foodList.length,
                              itemBuilder: (context, index) {
                                var menu = widget.orderFood.foodList[index];
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${menu.name} x${menu.quantity}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF3a3a3b),
                                        ),
                                      ),
                                      Text(
                                        "${menu.price} ฿",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF3a3a3b),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    fontSize: 14,
                                    color: Color(0xFF3a3a3b),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.orderFood.totalAllPrice} ฿",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                      fontSize: 14,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.orderFood.cal} kcal",
                                  style: TextStyle(
                                      fontSize: 14,
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
                                  "Average Calorie/person",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.orderFood.avgCal.toStringAsFixed(2)} kcal",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14,
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
            ButtonKYP(
              height: 50,
              width: 370,
              text: "Payment",
              process: () async {
                var res = await BookingServices.BookingFood(BookingModel(
                  id: "",
                  averageCalories:
                      int.parse(widget.orderFood.avgCal.toStringAsFixed(0)),
                  date:
                      "${widget.orderFood.dateBook} ${widget.orderFood.timeBook}",
                  foodMenu: widget.orderFood.foodList,
                  fullName: widget.orderFood.fullname,
                  personNumber: widget.orderFood.people.toString(),
                  timeValue: widget.orderFood.timeValue,
                  tableNumber: widget.orderFood.tableName,
                  tel: widget.orderFood.phone,
                  totalPrice: double.parse(
                    widget.orderFood.totalAllPrice.toString(),
                  ),
                ));
                // print(res);
                if (res) {
                  CartFood.clear();
                  showDialog(
                    context: context,
                    builder: (_) => imageDialog('QRcode', context),
                  );
                  Timer(Duration(seconds: 5), () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      ScaleRoute(
                        page: MainScreen(),
                      ),
                    );
                  });
                }
                // Navigator.push(context, ScaleRoute(page: History()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget imageDialog(text, context) {
  return Dialog(
    // backgroundColor: Colors.transparent,
    // elevation: 0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        Container(
          width: 220,
          height: 200,
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}
