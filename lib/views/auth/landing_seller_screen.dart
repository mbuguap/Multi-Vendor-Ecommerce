import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor/controllers/auth_controller.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/views/auth/customer_login_screen.dart';
import 'package:multi_vendor/views/auth/landing_customer_screen.dart';
import 'package:multi_vendor/views/auth/seller_login_screen.dart';

class LandingSellerScreen extends StatefulWidget {
  static const String routeName = 'LandingSellerScreen';
  @override
  State<LandingSellerScreen> createState() => _LandingSellerScreenState();
}

class _LandingSellerScreenState extends State<LandingSellerScreen> {
  final AuthController _authController = AuthController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String fullName;
  late String email;
  late String password;
  bool passwordVisable = true;

  bool isLoading = false;
  Uint8List? _image;

  pickImageFromGallery() async {
    Uint8List im = await _authController.pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  pickImageFromCamera() async {
    Uint8List im = await _authController.pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  _uploadImageToStorage(Uint8List? image) async {
    Reference ref = _firebaseStorage.ref().child('profiles').child(fullName);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        if (_image != null) {
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          String downloadUrl = await _uploadImageToStorage(_image);
          await _firestore
              .collection('sellers')
              .doc(_firebaseAuth.currentUser!.uid)
              .set({
            'sellerUid': _firebaseAuth.currentUser!.uid,
            'storeName': fullName,
            'email': email,
            'address': '',
            'image': downloadUrl
          }).whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });

          _formKey.currentState!.reset();
          setState(() {
            _image = null;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          return snackBar('Please Pick Image', context);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        return snackBar('All fields must be filled', context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      return snackBar(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Create Seller Account",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Roboto-Regular",
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.cyan,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.cyan,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.cyan,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: IconButton(
                                onPressed: () {
                                  pickImageFromCamera();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: IconButton(
                                onPressed: () {
                                  pickImageFromGallery();
                                },
                                icon: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Full Name is Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Enter your full name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onChanged: (String value) {
                          fullName = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is Required';
                          } else {
                            return null;
                          }
                        },
                        obscureText: passwordVisable,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisable = !passwordVisable;
                                });
                              },
                              icon: passwordVisable
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                          labelText: "Password",
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onChanged: (String value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return CustomerLoginScreen();
                                // }));
                                Navigator.pushNamed(
                                    context, SellerLoginScreen.routeName);
                              },
                              child: Text('Login'))
                        ],
                      ),
                      Text(
                        'Or',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create Customer Account?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return LandingCustomerScreen();
                                }));
                              },
                              child: Text('Sign up'))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
