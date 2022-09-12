import 'package:flutter/material.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.blueGrey.shade100,
                      child: Center(
                        child: Text(
                          'You Have not\n \nPicked any Images',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Text('Category here'),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Divider(
                    color: Colors.cyan,
                    thickness: 1.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Price is Required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                        hintText: 'Price',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        price = double.parse(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Quantity is Required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Add Quantity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        quantity = int.parse(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Product Name is Required';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 100,
                      // maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        hintText: 'Enter Product Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        productName = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Product Description is Required';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        hintText: 'Enter Product Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        productDescription = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.photo_library),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print(price);
              } else {
                return snackBar('Fill all fields', context);
              }
            },
            child: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
