import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor/controllers/auth_controller.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/views/auth/customer_login_screen.dart';

class LandingCustomerScreen extends StatefulWidget {
  static const String routeName = 'LandingCustomerScreen';
  @override
  State<LandingCustomerScreen> createState() => _LandingCustomerScreenState();
}

class _LandingCustomerScreenState extends State<LandingCustomerScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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

  signUp() async {
    setState(() {
      isLoading = true;
    });
    String res = await _authController.signUpUsers(_fullNameController.text,
        _emailController.text, _passwordController.text, _image!);

    setState(() {
      isLoading = false;
    });

    if (res != 'success') {
      return snackBar(res, context);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return CustomerLoginScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create Customer's Account",
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
                      controller: _fullNameController,
                      decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Enter your full name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
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
                              borderRadius: BorderRadius.circular(25))),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CustomerLoginScreen();
                              }));
                            },
                            child: Text('Login'))
                      ],
                    ),
                    Text(
                      'Or',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create a seller's Account?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        TextButton(onPressed: () {}, child: Text('Sign up'))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
