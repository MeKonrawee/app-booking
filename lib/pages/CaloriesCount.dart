import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/userInfo.dart';
import 'package:flutter_app/models/response/menu_response.dart';
import 'package:flutter_app/services/history_services.dart';
import 'package:flutter_app/services/menu_services.dart';
import 'package:flutter_app/themes/constant.dart';

class CaloriesCount extends StatefulWidget {
  @override
  _CaloriesCountState createState() => _CaloriesCountState();
}

List<String> eventSelect = [
  "Sedentary (little to no exercise + work a desk job)",
  "Lightly Active (light exercise 1-2 days / week)",
  "Moderately Active (moderate exercise 3-5 days / week)",
  "Very Active (heavy exercise 6-7 days / week)",
  "Extremely Active (very heavy exercise, hard labor job, training 2x / day)",
];

class _CaloriesCountState extends State<CaloriesCount> {
  String currentEvent = "";
  double tdee = 0;
  List resultHistory = [];

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  void getHistory() async {
    resultHistory = await HistoryService.getMenu(user.fullname);
    resultHistory.sort((a, b) => a.date.compareTo(b.date));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFFfae3e2),
          // appBar: AppBar(
          //   backgroundColor: Color(0xFFFAFAFA),
          //   elevation: 0,
          //   title: Text(
          //     "What would you like to eat?",
          //     style: TextStyle(
          //         color: Color(0xFF3a3737),
          //         fontSize: 16,
          //         fontWeight: FontWeight.w500),
          //   ),
          //   brightness: Brightness.light,
          //   actions: <Widget>[
          //     IconButton(
          //         icon: Icon(
          //           Icons.notifications_none,
          //           color: Color(0xFF3a3737),
          //         ),
          //         onPressed: () {
          //           Navigator.push(context, ScaleRoute(page: SignInPage()));
          //         })
          //   ],
          // ),
          body: Column(
            children: [
              TabBar(
                indicatorColor: Colors.orange,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.pending_actions_sharp,
                      color: Colors.orange,
                    ),
                    child: Text(
                      "Calories",
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.pending_actions_sharp,
                      color: Colors.orange,
                    ),
                    child: Text(
                      "Recommend",
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 30, left: 30),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoxShowCalories(
                                title: "Body Mass Index (BMI)",
                                value: "${user.bmi}"),
                            BoxShowCalories(
                                title: "Basal Metabolic Rate (BMR)",
                                value: "${user.bmr}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Total daily energy expenditure (TDEE)"),
                            SizedBox(
                              height: 5,
                            ),
                            currentEvent != ""
                                ? BoxShowText(
                                    text:
                                        "${currentEvent} = ${tdee * double.parse(user.bmr)} kcal",
                                  )
                                : Column(
                                    children: [
                                      Text("Select A Activity"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ListTile(
                                        title: const Text(
                                            'Sedentary (little to no exercise + work a desk job)'),
                                        leading: Radio(
                                          value: eventSelect[0],
                                          groupValue: currentEvent,
                                          onChanged: (value) {
                                            setState(() {
                                              currentEvent = value;
                                              tdee = 1.2;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text(
                                            'Lightly Active (light exercise 1-2 days / week)'),
                                        leading: Radio(
                                          value: eventSelect[1],
                                          groupValue: currentEvent,
                                          onChanged: (value) {
                                            setState(() {
                                              currentEvent = value;
                                              tdee = 1.375;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text(
                                            'Moderately Active (moderate exercise 3-5 days / week)'),
                                        leading: Radio(
                                          value: eventSelect[2],
                                          groupValue: currentEvent,
                                          onChanged: (value) {
                                            setState(() {
                                              currentEvent = value;
                                              tdee = 1.55;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text(
                                            'Very Active (heavy exercise 6-7 days / week)'),
                                        leading: Radio(
                                          value: eventSelect[3],
                                          groupValue: currentEvent,
                                          onChanged: (value) {
                                            setState(() {
                                              currentEvent = value;
                                              tdee = 1.725;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text(
                                            'Extremely Active (very heavy exercise, hard labor job, training 2x / day)'),
                                        leading: Radio(
                                          value: eventSelect[4],
                                          groupValue: currentEvent,
                                          onChanged: (value) {
                                            setState(() {
                                              currentEvent = value;
                                              tdee = 1.9;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                            currentEvent != ""
                                ? FutureBuilder<List<MenusResponse>>(
                                    future: MenusService.getMenuCal(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        List<MenusResponse> carouselCard =
                                            snapshot.data;
                                        return GridView.builder(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 250,
                                            childAspectRatio: 3 / 4,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              alignment: Alignment.centerLeft,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                        carouselCard[index]
                                                            .image),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "Food Name : ${carouselCard[index].name}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 32, 32, 32),
                                                        fontFamily:
                                                            defaultFontFamily,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "Calories : ${carouselCard[index].calories}",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 32, 32, 32),
                                                        fontFamily:
                                                            defaultFontFamily,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "Price : ${carouselCard[index].price}",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 32, 32, 32),
                                                        fontFamily:
                                                            defaultFontFamily,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : SizedBox()
                            // SearchWidget(),
                            // PopularFoodsWidget(),
                            // BestFoodWidget(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Name : ${resultHistory.length == 0 ? "" : resultHistory.last.fullName}"),
                                    SizedBox(height: 5),
                                    Text(
                                        "Your Daily Calorie Intake\n= ${tdee == 0 ? 0 : tdee * double.parse(user.bmr)} kcal"),
                                    SizedBox(height: 5),
                                    Text(
                                        "Your Current Meal Calorie Intake\n= ${resultHistory.length == 0 ? "" : resultHistory.last.averageCalories} kcal"),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline),
                                  Text(
                                    "Select A TDEE First for Next Meal Recommendation",
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Recommention for Your Next Meal"),
                            FutureBuilder<List<MenusResponse>>(
                              future: MenusService.getMenuCal(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  List<MenusResponse> carouselCard =
                                      snapshot.data;
                                  carouselCard.sort((a, b) =>
                                      b.calories.compareTo(a.calories));
                                  return ListView.builder(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${carouselCard[index].name} ${carouselCard[index].calories} kcal",
                                                maxLines: 2,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(20),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Image.network(
                                                      carouselCard[index].image,
                                                      // height: 150.0,
                                                      // width: 100.0,
                                                    ),
                                                  )
                                                  // Image.network(
                                                  //     "https://thketo.com/wp-content/uploads/2021/07/%E0%B8%AA%E0%B8%A5%E0%B8%B1%E0%B8%94%E0%B8%97%E0%B8%B9%E0%B8%99%E0%B9%88%E0%B8%B2-%E0%B8%AD%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%A3%E0%B8%84%E0%B8%A5%E0%B8%B5%E0%B8%99.jpg"),
                                                  )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          // bottomNavigationBar: BottomNavBarWidget(),
        ),
      ),
    );
  }
}

class BoxShowCalories extends StatelessWidget {
  BoxShowCalories({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10),
              child: Text(title),
            ),
            BoxShowText(text: value),
          ],
        ),
      ),
    );
  }
}

class BoxShowText extends StatelessWidget {
  BoxShowText({
    Key key,
    @required this.text,
  }) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text),
    );
  }
}
