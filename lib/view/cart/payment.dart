import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/components/user_check.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find();
    final UserController userController = Get.find();

    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(),
        ),
        body: userController.user!.email == null
            ? const UserCheck()
            : PaymentWidget(
                userController: userController, controller: controller),
      ),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    Key? key,
    required this.userController,
    required this.controller,
  }) : super(key: key);

  final UserController userController;
  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20),
              child: Text(
                "Shipping to: ${userController.user!.address!.street}"
                    .toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text('Items'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.onCart.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        //color: Colors.green,
                        height: 120,
                        width: 100,

                        child: Image.network(
                          controller.onCart[index].urls![0],
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),
            ),
            Text("Total \$${controller.totalPrice.toString()}"),
            Text("Tax \$${controller.totalPrice.toString()}"),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 20),
              child: Container(
                width: 165,
                margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
                //padding: EdgeInsets.only(bottom: 2),
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                  ),
                  onPressed: () {
                    controller.checkOut();
                  },
                  child: const Text('CONTINUE'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
