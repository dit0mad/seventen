import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                '710CAPS',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Text("MENU"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: const Text("MENU"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: const Text("MENU"),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Colors.green,
              margin: const EdgeInsets.all(5),
              child: Obx(() => GridView.builder(
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 9,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 2,
                    ),
                    itemCount: controller.product.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: controller.product[index]!);
                      // return Column(
                      //   children: [
                      //     // Text(controller.product[index]!.artist!),
                      //     // Text(controller.product[index]!.price!),
                      //     // Text(controller.product[index]!.description!),
                      //     // Text(controller.product[index]!.type!),
                      //     // Image.network(controller.product[index]!.urls![0])
                      //   ],
                      // );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(product.artist!),
        // Text(product.price!),
        // Text(product.description!),
        // Text(product.type!),
        Container(
          color: Colors.green,
          height: 280,
          width: 280,
          child: Image.network(
            product.urls![0],
            fit: BoxFit.cover,
          ),
        ),
        Text(
          product.type!,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
