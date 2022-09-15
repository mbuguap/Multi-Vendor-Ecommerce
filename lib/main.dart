import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor/views/auth/customer_login_screen.dart';
import 'package:multi_vendor/views/auth/landing_customer_screen.dart';
import 'package:multi_vendor/views/auth/landing_seller_screen.dart';
import 'package:multi_vendor/views/auth/seller_login_screen.dart';
import 'package:multi_vendor/views/customer_home_screen.dart';
import 'package:multi_vendor/views/seller_home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {});
  runApp(MultiProvider(
    providers: [],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Roboto-Bold",
      ),
      initialRoute: SellerLoginScreen.routeName,
      routes: {
        CustomerHomeScreen.routeName: (context) => CustomerHomeScreen(),
        LandingCustomerScreen.routeName: (context) => LandingCustomerScreen(),
        LandingSellerScreen.routeName: (context) => LandingSellerScreen(),
        SellerLoginScreen.routeName: (context) => SellerLoginScreen(),
        SellerHomeScreen.routeName: (context) => SellerHomeScreen(),
      },
    );
  }
}
