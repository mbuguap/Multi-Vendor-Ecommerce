import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/views/auth/seller_login_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/balance_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/edit_profile_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/manage_products_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/seller_order_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/seller_store_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/statistics_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> pages = [
    SellerStoreScreen(),
    SellerOrderScreen(),
    EditProfileScreen(),
    ManageProductsScreen(),
    BalanceScreen(),
    StatisticsScreen(),
  ];

  List<String> title = [
    'My Store',
    'Orders',
    'Edit Profile',
    'Manage Products',
    'Balance',
    'Statistics'
  ];

  List<IconData> icon = [
    Icons.store,
    Icons.shop_2_outlined,
    Icons.edit,
    Icons.settings,
    Icons.attach_money,
    Icons.show_chart,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SellerLoginScreen();
                }));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.cyan,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                elevation: 15,
                color: Colors.blueGrey.withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icon[index],
                      size: 40,
                      color: Colors.cyan,
                    ),
                    Text(
                      title[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
