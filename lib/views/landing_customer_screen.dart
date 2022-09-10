import 'package:flutter/material.dart';

class LandingCustomerScreen extends StatelessWidget {
  const LandingCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 50,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.purple,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Landing page')
          ],
        ),
      ),
    );
  }
}
