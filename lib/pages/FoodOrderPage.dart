import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/cartList.dart';
import 'package:flutter_app/controllers/userInfo.dart';
import 'package:flutter_app/models/bookingDetail_Model.dart';
import 'package:flutter_app/models/response/booking_response.dart';
import 'package:flutter_app/pages/FoodOrderConfirm.dart';
import 'package:intl/intl.dart';

import '../animation/ScaleRoute.dart';
import '../common/button.dart';
import '../themes/constant.dart';

class FoodOrderPage extends StatefulWidget {
  int people;
  String table;
  String timeValue;
  FoodOrderPage(
      @required this.people, @required this.table, @required this.timeValue);
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  int counter = 3;
  int price = 0;
  int cal_total = 0;
  double average_calory = 0;

  void calculate() async {
    var sumPrice;
    var sumDeposit;
    var sumCal;
    var sumAverage;
    price = 0;
    cal_total = 0;
    average_calory = 0;
    for (var i in CartFood) {
      sumPrice = i.price * i.quantity;
      sumCal = i.cal * i.quantity;
      price = price + sumPrice;
      cal_total = cal_total + sumCal;
    }
    average_calory = (cal_total / widget.people);
    setState(() {});
  }

  @override
  void initState() {
    calculate();
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              "Your Food Cart",
              style: TextStyle(
                  color: Color(0xFF3a3737),
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          brightness: Brightness.light,
          actions: <Widget>[
            Icon(
              Icons.abc,
              color: Colors.transparent,
              size: 50,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: CartFood.length,
                  itemBuilder: (context, index) {
                    FoodMenu result = CartFood[index];
                    return CartItem(
                      productName: result.name,
                      productPrice: "Price ${result.price}",
                      productCalory: "Calory: ${result.cal}",
                      productCartQuantity: result.quantity.toString(),
                      funcDel: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              "Notification",
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Are you sure to delete '${result.name}' out of cart? ",
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

                                  setState(() {
                                    CartFood.removeWhere((element) =>
                                        element.name == result.name);
                                    calculate();
                                  });
                                },
                                child: Text("Confirm"),
                              ),
                            ],
                          ),
                        );
                      },
                      funcIncrease: () {
                        for (var i = 0; i < CartFood.length; i++) {
                          if (CartFood[i].name == result.name) {
                            setState(() {
                              CartFood[i].quantity++;
                              calculate();
                            });
                            break;
                          }
                        }
                      },
                      funcDecrease: () {
                        for (var i = 0; i < CartFood.length; i++) {
                          if (CartFood[i].name == result.name) {
                            if (CartFood[i].quantity == 1) {
                              showDialog(
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
                                        "Are you sure to delete '${result.name}' out of cart? ",
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
                                        setState(() {
                                          CartFood.removeAt(i);
                                          calculate();
                                        });
                                      },
                                      child: Text("Confirm"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              setState(() {
                                CartFood[i].quantity--;
                                calculate();
                              });
                            }
                            break;
                          }
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TotalCalculationWidget(
                  price,
                  cal_total,
                  average_calory,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.notification_important_outlined,
                      size: defaultIconSize,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Each meal should not exceed 700 kcal.",
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonKYP(
                  height: 50,
                  width: 370,
                  text: "Confirm Order",
                  process: () async {
                    List<FoodMenu> foodPriceMenu = [];
                    for (FoodMenu i in CartFood) {
                      var sum = i.price * i.quantity;
                      foodPriceMenu.add(
                        FoodMenu(
                          name: i.name,
                          cal: i.cal,
                          price: i.price,
                          quantity: i.quantity,
                        ),
                      );
                    }

                    var timeBook = formatTimeOfDay(
                      TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    String dateBook =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());

                    BookingDetailModel resultConfirm = BookingDetailModel(
                        fullname: user.fullname,
                        phone: user.phonenumber,
                        tableName: widget.table,
                        people: widget.people,
                        dateBook: dateBook,
                        timeBook: timeBook,
                        timeValue: widget.timeValue,
                        foodList: foodPriceMenu,
                        totalAllPrice: price,
                        cal: cal_total,
                        avgCal: average_calory);
                    Navigator.push(
                      context,
                      ScaleRoute(
                        page: FoodOrderConfirm(
                          orderFood: resultConfirm,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class TotalCalculationWidget extends StatelessWidget {
  int price;
  int cal_total;
  double average_cal;
  TotalCalculationWidget(
    this.price,
    this.cal_total,
    this.average_cal,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Food Price Total",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "${price} ฿",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
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
                    "${cal_total} kcal",
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
                    "Average Calorie for a person",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "${average_cal.toStringAsFixed(2)} kcal",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  String productName;
  String productPrice;
  String productCalory;
  String productCartQuantity;
  Function() funcDel;
  Function() funcIncrease;
  Function() funcDecrease;

  CartItem({
    Key key,
    @required this.productName,
    @required this.productPrice,
    @required this.productCalory,
    @required this.productCartQuantity,
    @required this.funcDel,
    @required this.funcIncrease,
    @required this.funcDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "$productName",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "$productPrice",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "$productCalory",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    GestureDetector(
                      onTap: funcDel,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/images/menus/ic_delete.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerRight,
                  child: AddToCartMenu(
                    int.parse(productCartQuantity),
                    funcIncrease,
                    funcDecrease,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class CartIconWithBadge extends StatelessWidget {
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.business_center,
              color: Color(0xFF3a3737),
            ),
            onPressed: () {}),
        counter != 0
            ? Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  int productCounter;
  Function() add;
  Function() remove;

  AddToCartMenu(
    this.productCounter,
    this.add,
    this.remove,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: remove,
            icon: Icon(Icons.remove),
            color: Colors.black,
            iconSize: 18,
          ),
          InkWell(
            child: Container(
              width: 100.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Color(0xFFfd2c2c),
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text(
                  'Add To $productCounter',
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: add,
            icon: Icon(Icons.add),
            color: Color(0xFFfd2c2c),
            iconSize: 18,
          ),
        ],
      ),
    );
  }
}
