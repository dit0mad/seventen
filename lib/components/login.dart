import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers.dart/user_controller.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final UserController controller = Get.find();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 10),
          child: const Text(
            'LOG IN',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: controller.email.value,
            decoration: const InputDecoration(
              labelText: 'EMAIL',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: controller.password.value,
            decoration: const InputDecoration(
              labelText: 'PASSWORD',
            ),
          ),
        ),
        Container(
          width: width,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.black,
              ),
            ),
            onPressed: () {
              controller.login();
            },
            child: const Text('LOG IN'),
          ),
        ),
      ],
    );
  }
}
