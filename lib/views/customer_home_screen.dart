import 'package:flutter/material.dart';
import 'package:multi_vendor/views/cart_screen.dart';
import 'package:multi_vendor/views/category_screen.dart';
import 'package:multi_vendor/views/home_screen.dart';
import 'package:multi_vendor/views/profile_screen.dart';
import 'package:multi_vendor/views/store_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  static const String routeName = 'CustomerHomeScreen';
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedItem = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedItem,
          onTap: (index) {
            setState(() {
              _selectedItem = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Category'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Store'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ]),
      body: _pages[_selectedItem],
    );
  }
}
