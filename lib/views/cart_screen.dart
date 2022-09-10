import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete_forever, color: Colors.black))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     height: 40,
            //     width: MediaQuery.of(context).size.width - 30,
            //     decoration: BoxDecoration(
            //         color: Colors.cyan,
            //         borderRadius: BorderRadius.circular(15)),
            //     child: Center(
            //         child: Text(
            //       'Continue Shopping',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 17,
            //       ),
            //     )),
            //   ),
            // )
            Material(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(
                15,
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {},
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$",
              style: TextStyle(
                // color: Colors.white,
                fontSize: 17,
              ),
            ),
            Text(
              '00.00',
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                letterSpacing: 3,
              ),
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  "CHECK OUT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
