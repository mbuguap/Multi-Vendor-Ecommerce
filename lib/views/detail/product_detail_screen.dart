import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/provider/cart_provider.dart';
import 'package:multi_vendor/views/cart_screen.dart';
import 'package:multi_vendor/views/minor_screens/visit_store_screen.dart';
import 'package:multi_vendor/views/widgets/full_image_screen.dart';
import 'package:multi_vendor/views/widgets/product_model.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:collection/collection.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic productList;

  const ProductDetailScreen({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> images = productList['productImage'];
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('mainCategory', isEqualTo: productList['mainCategory'])
        .where('subCategory', isEqualTo: productList['subCategory'])
        .snapshots();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FullImageScreen(
                        imageList: images,
                      );
                    }));
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Swiper(
                      itemCount: images.length,
                      pagination:
                          SwiperPagination(builder: SwiperPagination.fraction),
                      itemBuilder: (context, index) {
                        return Image.network(images[index]);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ],
            ),
            Text(
              productList['productName'],
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Colors.grey.shade600),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'USD',
                        style: TextStyle(fontSize: 18, color: Colors.cyan),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        productList['price'].toString(),
                        style: TextStyle(fontSize: 18, color: Colors.cyan),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 30,
                      ))
                ],
              ),
            ),
            Text(
              '${productList['instock']} pieces available in stock',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Text(
                  ' Item Description ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.cyan),
                ),
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                productList['productDescription'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Text(
                  ' Similar Items ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.cyan),
                ),
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              child: StreamBuilder<QuerySnapshot>(
                stream: _productsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                      ),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Items in this category',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductModel(
                            products: snapshot.data!.docs[index],
                          );
                        },
                        staggeredTileBuilder: (context) =>
                            StaggeredTile.fit(1)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VisitStoreScreen(
                    sellerUid: productList['sellerUid'],
                  );
                }));
              },
              icon: Icon(Icons.store),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartScreen();
                }));
              },
              icon: Badge(
                showBadge: Provider.of<CartProvider>(context).getItems.isEmpty
                    ? false
                    : true,
                badgeColor: Colors.cyan,
                badgeContent: Text(
                  Provider.of<CartProvider>(context).getItems.length.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                child: Icon(Icons.shopping_cart),
              ),
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: MaterialButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                              .getItems
                              .firstWhereOrNull((cart) =>
                                  cart.documentId ==
                                  productList['productId']) !=
                          null
                      ? snackBar('Item Already in Cart', context)
                      : Provider.of<CartProvider>(context, listen: false)
                          .addItem(
                              productList['productName'],
                              productList['price'],
                              1,
                              productList['productImage'],
                              productList['instock'],
                              productList['productId'],
                              productList['sellerUid']);
                },
                child: Text(
                  "ADD TO CART",
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
