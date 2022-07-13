import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/view/cart/guest_checkout.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({
    Key? key,
  }) : super(key: key);

  UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        //check if user is null
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
    );
  }
}
