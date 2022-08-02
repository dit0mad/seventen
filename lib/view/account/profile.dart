import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    TextEditingController updateEmail = TextEditingController();
    TextEditingController updatePassword = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.user!.name!.toUpperCase()),
                Text(controller.user!.email!),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BuildProfileButtons(
            title: 'Change Email',
            func: () => Get.bottomSheet(
              BuildBottomSheet(
                  initialValue: controller.user!.email!,
                  controller: updateEmail),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BuildProfileButtons(
            title: 'Change Password',
            func: () => Get.bottomSheet(
              BuildBottomSheet(
                initialValue: controller.user!.id!,
                controller: updatePassword,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BuildProfileButtons(
              title: 'Change Address',
              func: () => BuildBottomSheet(
                  initialValue: 'controller.user.address.',
                  controller: updatePassword)),
          const SizedBox(
            height: 15,
          ),
          BuildProfileButtons(
            title: 'Wallet',
            func: () => Get.defaultDialog(),
          ),
        ],
      ),
    );
  }
}

class BuildBottomSheet extends StatelessWidget {
  const BuildBottomSheet({
    Key? key,
    required this.initialValue,
    required this.controller,
  }) : super(key: key);

  final String initialValue;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
              initialValue: initialValue,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildProfileButtons extends StatelessWidget {
  final String title;
  final VoidCallback func;

  const BuildProfileButtons({
    Key? key,
    required this.title,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
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
