import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/provider/cart_provider.dart';
import 'package:multi_vendor/views/customer_home_screen.dart';
import 'package:multi_vendor/views/minor_screens/payment_screen.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedItem = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String orderId;
  void showProgress() {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
      max: 100,
      msg: 'Placing Order ...',
      barrierColor: Colors.cyan,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = Provider.of<CartProvider>(context).totalPrice;
    double totalPaid = Provider.of<CartProvider>(context).totalPrice + 10;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference customer =
        FirebaseFirestore.instance.collection('customers');
    return FutureBuilder(
        future: customer.doc(_auth.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('something went wrong'));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Center(child: Text('Data does not exists'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                  title: Text(
                    'Payment',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        // width: double.infinity,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    totalPrice.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Paid',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    totalPaid.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Cost',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text('Cash on Delivery'),
                                subtitle: Text('Pay when delivered'),
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text('Pay with Card'),
                              ),
                              RadioListTile(
                                value: 3,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text('Payment with Stripe'),
                              ),
                              RadioListTile(
                                value: 4,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text('Pay with MPESA'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (selectedItem == 1) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Payment from anywhere',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            decoration: BoxDecoration(
                                              color: Colors.cyan,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () async {
                                                showProgress();
                                                for (var item in context
                                                    .read<CartProvider>()
                                                    .getItems) {
                                                  CollectionReference orderRef =
                                                      _firestore
                                                          .collection('orders');

                                                  orderId = Uuid().v4();
                                                  await orderRef
                                                      .doc(orderId)
                                                      .set({
                                                    'cid': data['cid'],
                                                    'customerName':
                                                        data['fullName'],
                                                    'email': data['email'],
                                                    'address': data['address'],
                                                    'phone': data['phone'],
                                                    'profileImage':
                                                        data['image'],
                                                    'sellerUid': item.sellerUid,
                                                    'productId':
                                                        item.documentId,
                                                    'orderId': orderId,
                                                    'orderImage':
                                                        item.imagesUrl.first,
                                                    'orderQuantity':
                                                        item.quantity,
                                                    'orderPrice':
                                                        item.quantity *
                                                            item.price,
                                                    'deliveryStatus':
                                                        'preparing',
                                                    'deliveryDate': '',
                                                    'orderDate': DateTime.now(),
                                                    'paymentStatus':
                                                        'Cash on Delivery',
                                                    'orderReview': false,
                                                  }).whenComplete(() {
                                                    context
                                                        .read<CartProvider>()
                                                        .clearCart();
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            CustomerHomeScreen
                                                                .routeName,
                                                            (route) => false);
                                                  });
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Pay ${totalPaid.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   return PaymentScreen();
                            // }));
                          },
                          child: Center(
                            child: Text(
                              'Confirm ${totalPaid.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            ),
          );
        });
  }
}
