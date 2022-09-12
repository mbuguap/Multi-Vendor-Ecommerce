import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/utils/category_list.dart';
import 'package:path/path.dart' as path;

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  String mainCategoryValue = 'select main category';
  String subCategoryValue = 'subcategory';

  List<String> subCategoryList = [];

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;

  List<XFile>? imageList = [];
  List<String> imageUrlList = [];

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 100);

      setState(() {
        imageList = pickedImages!;
      });
    } catch (e) {}
  }

  Widget displayImage() {
    if (imageList!.isNotEmpty) {
      return InkWell(
        onTap: () {
          setState(() {
            imageList = null;
          });
        },
        child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            itemCount: imageList!.length,
            itemBuilder: (context, index) {
              return Image.file(File(imageList![index].path));
            }),
      );
    } else {
      return Center(
        child: Text(
          'You Have not\n \nPicked any Images',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      );
    }
  }

  void selectMainCategory(String? value) {
    if (value == 'men') {
      subCategoryList = men;
    } else if (value == 'women') {
      subCategoryList = women;
    } else if (value == 'electronics') {
      subCategoryList = electronics;
    } else if (value == 'shoes') {
      subCategoryList = shoes;
    } else if (value == 'accessories') {
      subCategoryList = accessories;
    } else if (value == 'home & garden') {
      subCategoryList = homeandgarden;
    } else if (value == 'beauty') {
      subCategoryList = beauty;
    } else if (value == 'bags') {
      subCategoryList = bags;
    } else if (value == 'kids') {
      subCategoryList = kids;
    }

    setState(() {
      mainCategoryValue = value!;
      subCategoryValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategoryValue != 'select main category' &&
        subCategoryValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imageList!.isNotEmpty) {
          try {
            for (var image in imageList!) {
              Reference ref =
                  _firebaseStorage.ref('products/${path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          return snackBar('Please Pick Images', context);
        }
      } else {
        return snackBar('Fill all fields', context);
      }
    } else {
      return snackBar('Please Select Category', context);
    }
  }

  void uploadData() async {
    if (imageUrlList.isNotEmpty) {
      CollectionReference productRef = _firestore.collection('products');

      await productRef.doc().set({
        'mainCategory': mainCategoryValue,
        'subCategory': subCategoryValue,
        'price': price,
        'instock': quantity,
        'productName': productName,
        'productDescription': productDescription,
        'sellerUid': FirebaseAuth.instance.currentUser!.uid,
        'productImage': imageUrlList,
        'discount': 0
      }).whenComplete(() {
        setState(() {
          imageList = [];
          subCategoryList = [];
          mainCategoryValue = 'select main category';
        });
        _formKey.currentState!.reset();
      });
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
  }

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
                        child: imageList != null
                            ? displayImage()
                            : Text(
                                'You Have not\n \nPicked any Images',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Select Main Category',
                          ),
                          DropdownButton(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              value: mainCategoryValue,
                              items: mainCategory
                                  .map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                selectMainCategory(value);
                              }),
                          Text(
                            'Select Sub Category',
                          ),
                          DropdownButton(
                              value: subCategoryValue,
                              items: subCategoryList
                                  .map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  subCategoryValue = value!;
                                });
                              }),
                        ],
                      ),
                    ),
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
                      onSaved: (value) {
                        price = double.parse(value!);
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
                      onSaved: (value) {
                        quantity = int.parse(value!);
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
                      onSaved: (value) {
                        productName = value!;
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
                      onSaved: (value) {
                        productDescription = value!;
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
              backgroundColor: Colors.cyan,
              onPressed: () {
                pickProductImages();
              },
              child: Icon(Icons.photo_library),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.cyan,
            onPressed: () {
              uploadProduct();
            },
            child: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
