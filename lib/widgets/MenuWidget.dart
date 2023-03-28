import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/controllers/cartList.dart';
import 'package:flutter_app/models/response/booking_response.dart';
import 'package:flutter_app/models/response/menu_response.dart';
import 'package:flutter_app/pages/FoodOrderPage.dart';
import 'package:flutter_app/services/menu_services.dart';
import 'package:flutter_app/widgets/PopularFoodsWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../themes/constant.dart';

class MenuWidget extends StatefulWidget {
  int people;
  String table;
  MenuWidget(@required this.people, @required this.table);
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfae3e2),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          "Korn-yapa Menu",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        brightness: Brightness.light,
      ),
      body: FutureBuilder<List<MenusResponse>>(
        future: MenusService.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<MenusResponse> carouselCard = snapshot.data;
            carouselCard.sort((a, b) => a.price.compareTo(b.price));
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: MasonryGridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: carouselCard.length,
                itemBuilder: (context, index) {
                  return BoxItemFood(
                    dataMenu: carouselCard[index],
                    func: () {
                      setState(() {
                        var duplicate = CartFood.firstWhere(
                          (element) => element.name == carouselCard[index].name,
                          orElse: () => null,
                        );
                        if (duplicate == null) {
                          CartFood.add(
                            FoodMenu(
                              name: carouselCard[index].name,
                              cal: carouselCard[index].calories,
                              price: carouselCard[index].price,
                              quantity: 1,
                            ),
                          );
                        } else {
                          duplicate.quantity++;
                        }
                      });
                    },
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),

      floatingActionButton: Container(
        child: FittedBox(
          child: Stack(
            alignment: Alignment(1.4, -1.5),
            children: [
              FloatingActionButton(
                // Your actual Fab
                onPressed: () async {
                  await Navigator.push(
                    context,
                    ScaleRoute(
                      page: FoodOrderPage(widget.people, widget.table),
                    ),
                  );
                  setState(() {});
                },
                child: Icon(Icons.shopping_cart),
                backgroundColor: Colors.orange,
              ),
              Container(
                // This is your Badge
                child: Center(
                  // Here you can put whatever content you want inside your Badge
                  child: Text(
                    CartFood.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(minHeight: 32, minWidth: 32),
                decoration: BoxDecoration(
                  // This controls the shadow
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: Colors.black.withAlpha(50),
                    )
                  ],
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.orange[900], // This would be color of the Badge
                ),
              ),
            ],
          ),
        ),
      ),
      // FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //     Navigator.push(
      //       context,
      //       ScaleRoute(
      //         page: FoodOrderPage(),
      //       ),
      //     );
      //   },
      //   backgroundColor: Colors.orange,
      //   child: Stack(
      //     alignment: Alignment.topCenter,
      //     children: [
      //       const Icon(Icons.shopping_cart),
      //       Text(
      //         "1",
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 15,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class BoxItemFood extends StatelessWidget {
  BoxItemFood({
    Key key,
    this.dataMenu,
    this.func,
  }) : super(key: key);

  MenusResponse dataMenu;
  Function() func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
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
              Image.network(dataMenu.image),
              SizedBox(
                height: 7,
              ),
              Text(
                "Food Name : ${dataMenu.name}",
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
                "Calories : ${dataMenu.calories}",
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
                "Price : ${dataMenu.price}",
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
    );
  }
}
