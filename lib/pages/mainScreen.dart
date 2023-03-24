import 'package:flutter/material.dart';
import 'package:flutter_app/pages/AccountCustomer.dart';
import 'package:flutter_app/pages/CaloriesCount.dart';
import 'package:flutter_app/pages/FoodHistory.dart';
import 'package:flutter_app/pages/HomePage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  var screen = [
    HomePage(),
    CaloriesCount(),
    History(),
    AccountCustomer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'Calory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFFfd5352),
        onTap: _onItemTapped,
      ),
    );
  }
}
