import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/provider/wishlist_provider.dart';
import 'package:multi_vendor/views/detail/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProductModel extends StatelessWidget {
  final dynamic products;
  const ProductModel({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(productList: products);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Container(
                      constraints:
                          BoxConstraints(minHeight: 100, maxHeight: 250),
                      child: Image.network(products['productImage'][0]),
                    ),
                  ),
                  Text(products['productName']),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          products['price'].toString(),
                          style: TextStyle(
                            color: Colors.cyan,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<WishListProvider>(context,
                                            listen: false)
                                        .getWishItems
                                        .firstWhereOrNull((cart) =>
                                            cart.documentId ==
                                            products['productId']) !=
                                    null
                                ? context
                                    .read<WishListProvider>()
                                    .removeWish(products['productId'])
                                : Provider.of<WishListProvider>(context,
                                        listen: false)
                                    .addWishItem(
                                        products['productName'],
                                        products['price'],
                                        1,
                                        products['productImage'],
                                        products['instock'],
                                        products['productId'],
                                        products['sellerUid']);
                          },
                          icon: context
                                      .watch<WishListProvider>()
                                      .getWishItems
                                      .firstWhereOrNull((wish) =>
                                          wish.documentId ==
                                          products['productId']) !=
                                  null
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Badge(
                toAnimate: true,
                shape: BadgeShape.square,
                badgeColor: Colors.cyan,
                borderRadius: BorderRadius.circular(8),
                badgeContent:
                    Text('New Arrivals', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
