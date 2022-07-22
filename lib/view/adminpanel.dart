import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/components/addImage.dart';
import 'package:seventen/components/addproduct.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const identifier = 'adminpanel';
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 60,
        ),
        GestureDetector(
          onTap: (() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddImage(
                  ctx: identifier,
                ),
              ),
            );
          }),
          child: Container(
            height: 150,
            width: 150,
            color: Colors.green[200],
            child: const Text('Select files for main screen'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: (() {
            Get.to(
              () => const AddProduct(),
            );
          }),
          child: Container(
            height: 150,
            width: 150,
            color: Colors.green[200],
            child: const Text('Add a product'),
          ),
        ),
      ],
    ));
  }
}
