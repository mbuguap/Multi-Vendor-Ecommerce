import 'package:flutter/material.dart';

class SellerOrderScreen extends StatelessWidget {
  const SellerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( backgroundColor: Colors.white,
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
        ),),);
  }
}