import 'package:flutter/material.dart';

class SellerStoreScreen extends StatelessWidget {
  const SellerStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'Your Store',
          style: TextStyle(
            color: Colors.black,
          ),
        ),),);
  }
}