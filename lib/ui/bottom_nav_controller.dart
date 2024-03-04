import 'package:flutter/material.dart';
import 'package:newecommarce/const/AppColors.dart';
import 'package:newecommarce/ui/bottom_nav_pages/cart.dart';
import 'package:newecommarce/ui/bottom_nav_pages/favourite.dart';
import 'package:newecommarce/ui/bottom_nav_pages/home.dart';
import 'package:newecommarce/ui/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});


  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    Home(),
    Favourite(),
    Cart(),
    Profile(),
  ];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favourite"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
                    label: "Person",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print('CurrentIndex: ${_currentIndex}');
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
