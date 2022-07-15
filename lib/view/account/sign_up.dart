import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/components/user_check.dart';
import 'package:seventen/view/cart/guest_checkout.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({
    Key? key,
  }) : super(key: key);

  final UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        //check if user is null
        child: SingleChildScrollView(
          child: Column(
            children: [
              controller.user == null
                  ? SignUpWidget()
                  : Container(
                      child: Text('Signed in'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
