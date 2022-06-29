import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/navigation_controller.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/services/database.dart';
import 'package:seventen/view/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(NavigationController());
  Get.put(Database());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
      ),
      home: const DashboardScreen(),
    );
  }
}
