import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'WishList',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<WishListProvider>().clearWish();
              },
              icon: Icon(Icons.delete_forever, color: Colors.black))
        ],
      ),
      body: context.watch<WishListProvider>().getWishItems.isNotEmpty
          ? Consumer<WishListProvider>(
              builder: (context, wishProvider, child) {
                return ListView.builder(
                    itemCount: wishProvider.count,
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Image.network(wishProvider
                                    .getWishItems[index].imagesUrl[0]
                                    .toString()),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      wishProvider.getWishItems[index].name,
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
                                          wishProvider.getWishItems[index].price
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
                                                onPressed: () {
                                                  Provider.of<WishListProvider>(
                                                          context,
                                                          listen: false)
                                                      .removeWishItem(
                                                          wishProvider
                                                                  .getWishItems[
                                                              index]);
                                                  // context
                                                  //     .read<WishListProvider>()
                                                  //     .removeWishItem(
                                                  //         wishProvider
                                                  //                 .getWishItems[
                                                  //             index]);
                                                },
                                                icon: Icon(FontAwesomeIcons
                                                    .trashArrowUp),
                                                color: Colors.cyan,
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
                    'Wishlist is empty',
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
    );
  }
}
