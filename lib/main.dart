import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/navigation_controller.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/services/database.dart';
import 'package:seventen/view/dashboard.dart';

import 'controllers.dart/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  Stripe.publishableKey = dotenv.env['stripeKey']!;
  Get.put(NavigationController());
  Get.put(Database());
  Get.lazyPut(() => ProductController());
  Get.lazyPut(() => UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.black54),
        backgroundColor: Colors.white38,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // background (button) color
            // foreground (text) color
          ),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
