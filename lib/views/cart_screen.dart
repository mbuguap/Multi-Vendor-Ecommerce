import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor/provider/cart_provider.dart';
import 'package:provider/provider.dart';

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
              onPressed: () {
                context.read<CartProvider>().clearCart();
              },
              icon: Icon(Icons.delete_forever, color: Colors.black))
        ],
      ),
      body: context.watch<CartProvider>().getItems.isNotEmpty
          ? Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ListView.builder(
                    itemCount: cartProvider.count,
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Image.network(cartProvider
                                    .getItems[index].imagesUrl[0]
                                    .toString()),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cartProvider.getItems[index].name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        // color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartProvider.getItems[index].price
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: cartProvider
                                                            .getItems[index]
                                                            .quantity ==
                                                        1
                                                    ? null
                                                    : () {
                                                        cartProvider.decrement(
                                                            cartProvider
                                                                    .getItems[
                                                                index]);
                                                      },
                                                icon: Icon(
                                                  FontAwesomeIcons.minus,
                                                ),
                                              ),
                                              Text(cartProvider
                                                  .getItems[index].quantity
                                                  .toString()),
                                              IconButton(
                                                onPressed: cartProvider
                                                            .getItems[index]
                                                            .quantity ==
                                                        cartProvider
                                                            .getItems[index]
                                                            .instock
                                                    ? null
                                                    : () {
                                                        cartProvider.increment(
                                                            cartProvider
                                                                    .getItems[
                                                                index]);
                                                      },
                                                icon: Icon(
                                                  FontAwesomeIcons.plus,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            )
          : Center(
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
              Provider.of<CartProvider>(context, listen: true)
                  .totalPrice
                  .toStringAsFixed(2),
              // context.read<CartProvider>().totalPrice.toStringAsFixed(2),
              // context.watch<CartProvider>().totalPrice.toStringAsFixed(2),

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
                color: Colors.cyan,
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
