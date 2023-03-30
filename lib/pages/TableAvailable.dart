import 'package:flutter/material.dart';
import 'package:flutter_app/models/response/table_response.dart';
import 'package:flutter_app/services/table_services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../animation/ScaleRoute.dart';
import 'BookTable.dart';

class TableAvailable extends StatefulWidget {
  @override
  _TableAvailableState createState() => _TableAvailableState();
}

class _TableAvailableState extends State<TableAvailable> {
  String nameTable = "";
  TextEditingController amount = new TextEditingController();
  TextEditingController timeValue = new TextEditingController();
  TimeOfDay pickedTime = TimeOfDay.now();

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        TableAvailableTitle(),
        Column(
          children: [
            FutureBuilder<List<TableResponse>>(
              future: TablesService.getTables(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<TableResponse> carouselCard = snapshot.data;
                  carouselCard.sort((a, b) => a.id.compareTo(b.id));
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
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
                                  Navigator.push(
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
          ],
        ),
      ]),
    );
  }
}

class BookTableTiles extends StatelessWidget {
  String name;
  bool status;
  Function() func;

  BookTableTiles({
    Key key,
    @required this.name,
    @required this.status,
    @required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  status
                      ? 'assets/images/Table/table.png'
                      : 'assets/images/Table/untable.png',
                  height: 70,
                ),
                Text(name,
                    style: TextStyle(
                        color: Color(0xFF6e6e71),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

// InkWell(
//       onTap: func,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 1),
//             // decoration: new BoxDecoration(boxShadow: [
//             //   new BoxShadow(
//             //     color: Color(0xFFfae3e2),
//             //     blurRadius: 25.0,
//             //     offset: Offset(0.0, 0.75),
//             //   ),
//             // ]),
//             child: Card(
//                 color: Colors.white,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(3.0),
//                   ),
//                 ),
//                 child: Container(
//                   width: 60,
//                   height: 60,
//                   child: Center(
//                       child: Image.asset(
//                     'assets/images/Table/' + imageUrl + ".png",
//                     width: 50,
//                     height: 50,
//                   )),
//                 )),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 20,
//               right: 5,
//             ),
//             child: Text(name,
//                 style: TextStyle(
//                     color: Color(0xFF6e6e71),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400)),
//           ),
//         ],
//       ),
//     );

class TableAvailableTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Table Status for Booking",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
