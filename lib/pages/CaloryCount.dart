import 'package:flutter/material.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/pages/SignInPage.dart';
import 'package:flutter_app/themes/constant.dart';
import 'package:flutter_app/widgets/BestFoodWidget.dart';
import 'package:flutter_app/widgets/BottomNavBarWidget.dart';
import 'package:flutter_app/widgets/MenuWidget.dart';
import 'package:flutter_app/widgets/PopularFoodsWidget.dart';
import 'package:flutter_app/widgets/SearchWidget.dart';

class CaloryCount extends StatefulWidget {
  @override
  _CaloryCountState createState() => _CaloryCountState();
}

List<String> eventSelect = [
  "ไม่ออกกำลังกายหรือนั่งทำงานตลอดวัน",
  "ออกกำลังกาย 1-2 ครั้ง/สัปดาห์",
  "ออกกำลังกาย 3-5 ครั้ง/สัปดาห์",
  "ออกกำลังกาย 6-7 ครั้ง/สัปดาห์",
  "ออกกำลังกายทุกวัน วันละ 2 ครั้ง",
];

class _CaloryCountState extends State<CaloryCount> {
  String currentEvent = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxShowCalory(title: "ค่าดัชนีมวลกาย (BMI)", value: "19.5"),
                BoxShowCalory(
                    title: "ปริมาณแคลอรี่ที่ต้องการต่อวัน (BMR)",
                    value: "1282"),
                Text("ค่าพลังงานที่ร่ายกายต้องการใช้ในการทำกิจกรรม"),
                currentEvent != ""
                    ? BoxShowText(
                        text: "${currentEvent} = 1987",
                      )
                    : Column(
                        children: [
                          Text("เลือก 1 กิจกรรม"),
                          ListTile(
                            title: const Text(
                                'ไม่ออกกำลังกายหรือนั่งทำงานตลอดวัน'),
                            leading: Radio(
                              value: eventSelect[0],
                              groupValue: currentEvent,
                              onChanged: (value) {
                                setState(() {
                                  currentEvent = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('ออกกำลังกาย 1-2 ครั้ง/สัปดาห์'),
                            leading: Radio(
                              value: eventSelect[1],
                              groupValue: currentEvent,
                              onChanged: (value) {
                                setState(() {
                                  currentEvent = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('ออกกำลังกาย 3-5 ครั้ง/สัปดาห์'),
                            leading: Radio(
                              value: eventSelect[2],
                              groupValue: currentEvent,
                              onChanged: (value) {
                                setState(() {
                                  currentEvent = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('ออกกำลังกาย 6-7 ครั้ง/สัปดาห์'),
                            leading: Radio(
                              value: eventSelect[3],
                              groupValue: currentEvent,
                              onChanged: (value) {
                                setState(() {
                                  currentEvent = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title:
                                const Text('ออกกำลังกายทุกวัน วันละ 2 ครั้ง'),
                            leading: Radio(
                              value: eventSelect[4],
                              groupValue: currentEvent,
                              onChanged: (value) {
                                setState(() {
                                  currentEvent = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                currentEvent != ""
                    ? GridView.builder(
                        padding: const EdgeInsets.all(20.0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
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
                                  Image.asset("assets/images/menus/pho.png"),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Food Name : ",
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
                                    "Calories : ",
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
                                    "Price : ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontFamily: defaultFontFamily,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    // Container(
                    //     alignment: Alignment.topCenter,
                    //     color: Colors.black,
                    //     height: 300,
                    //     child: GridView.builder(

                    //       physics: NeverScrollableScrollPhysics(),
                    //       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    //         maxCrossAxisExtent: 200,
                    //         childAspectRatio: 3 / 3.7,
                    //         crossAxisSpacing: 20,
                    //         mainAxisSpacing: 20,
                    //       ),
                    //       itemCount: 4,
                    //       itemBuilder: (context, index) {
                    //         return BoxItemFood(idFood: index);
                    //       },
                    //     ),
                    //   )
                    : SizedBox()
                // SearchWidget(),
                // PopularFoodsWidget(),
                // BestFoodWidget(),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}

class BoxShowCalory extends StatelessWidget {
  BoxShowCalory({
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
