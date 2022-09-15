import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/views/widgets/product_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class VisitStoreScreen extends StatelessWidget {
  final sellerUid;
  const VisitStoreScreen({super.key, required this.sellerUid});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sellerUid', isEqualTo: sellerUid)
        .snapshots();

    CollectionReference seller =
        FirebaseFirestore.instance.collection('sellers');

    return FutureBuilder<DocumentSnapshot>(
      future: seller.doc(sellerUid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              toolbarHeight: 100,
              title: Text(
                data['storeName'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
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
                      'No Items in this store',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    crossAxisCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductModel(
                        products: snapshot.data!.docs[index],
                      );
                    },
                    staggeredTileBuilder: (context) => StaggeredTile.fit(1));
              },
            ),
          );
        }

        return Material(
          child: Center(child: CircularProgressIndicator(color: Colors.cyan)),
        );
      },
    );
  }
}
