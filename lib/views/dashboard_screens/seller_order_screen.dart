import 'package:flutter/material.dart';
import 'package:multi_vendor/views/dashboard_screens/delivered.dart';
import 'package:multi_vendor/views/dashboard_screens/preparing_screen.dart';
import 'package:multi_vendor/views/dashboard_screens/shipping_screen.dart';

class SellerOrderScreen extends StatelessWidget {
  const SellerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            'Store Orders',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Preparing',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Shipping',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Delivered',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PreparingScreen(),
            ShippingScreen(),
            DeliveredScreen(),
          ],
        ),
      ),
    );
  }
}
