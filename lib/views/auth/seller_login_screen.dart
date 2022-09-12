import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/controllers/auth_controller.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/views/auth/landing_customer_screen.dart';
import 'package:multi_vendor/views/auth/landing_seller_screen.dart';
import 'package:multi_vendor/views/customer_home_screen.dart';
import 'package:multi_vendor/views/seller_home_screen.dart';

class SellerLoginScreen extends StatefulWidget {
  static const String routeName = 'SellerLoginScreen';
  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisable = true;

  bool isLoading = false;

  late String email;
  late String password;

  loginSeller() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(() {
          isLoading = false;
        });
        return Navigator.of(context).pushNamedAndRemoveUntil(
            SellerHomeScreen.routeName, (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        return snackBar('Password and Email Required', context);
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
                        "Seller Login",
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
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
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
                          loginSeller();
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
                                    'Login',
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
                      Text(
                        'Or',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create Seller Account?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return LandingSellerScreen();
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
