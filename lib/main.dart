import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/navigation_controller.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/services/database.dart';
import 'package:seventen/view/dashboard.dart';

import 'controllers.dart/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        backgroundColor: Colors.black,
      ),
      home: const DashboardScreen(),
    );
  }
}
