import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.green,
            child: Column(
              children: [
                Text(controller.user!.email!),
                Text(controller.user!.email!),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const BuildProfileButtons(
            title: 'Email',
          ),
          const SizedBox(
            height: 15,
          ),
          const BuildProfileButtons(
            title: 'Password',
          ),
          const SizedBox(
            height: 15,
          ),
          const BuildProfileButtons(
            title: 'Address',
          ),
          const SizedBox(
            height: 15,
          ),
          const BuildProfileButtons(
            title: 'Wallet',
          ),
        ],
      ),
    );
  }
}

class BuildProfileButtons extends StatelessWidget {
  final String title;

  const BuildProfileButtons({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {}),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(title),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 1.0),
            child: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
