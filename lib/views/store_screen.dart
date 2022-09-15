import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/views/minor_screens/visit_store_screen.dart';

class StoreScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Store',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('sellers').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VisitStoreScreen(
                            sellerUid: snapshot.data!.docs[index]['sellerUid'],
                          );
                        }));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                snapshot.data!.docs[index]['image'],
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data!.docs[index]['storeName'],
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              // color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Center(
              child: Text('No Stores'),
            );
          },
        ),
      ),
    );
  }
}
