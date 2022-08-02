import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/cart_controller.dart';
import 'package:seventen/controllers.dart/navigation_controller.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/view/dashboard.dart';

import 'controllers.dart/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  Stripe.publishableKey = dotenv.env['stripeKey']!;
  Get.put(NavigationController());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black54),
        backgroundColor: Colors.white38,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black87 // background (button) color
              // foreground (text) color
              ),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
          bodyText2: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
