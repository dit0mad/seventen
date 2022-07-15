import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/view/products/product_detail.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getProducts();
        },
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              title: const Text('710CAPS', style: TextStyle(fontSize: 35)),
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: Container(
                    margin: const EdgeInsets.only(top: 90),
                    child: Obx(() => TextField(
                          onChanged: (value) => controller.searchProduct(value),
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.controller.value,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            prefixIconConstraints: const BoxConstraints(
                              minHeight: 90,
                              minWidth: 36,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            hintText: "Search an artist",
                            suffixIconConstraints: const BoxConstraints(
                              minHeight: 36,
                              minWidth: 36,
                            ),
                            suffixIcon: IconButton(
                              constraints: const BoxConstraints(
                                minHeight: 36,
                                minWidth: 36,
                              ),
                              splashRadius: 24,
                              icon: const Icon(
                                Icons.clear,
                              ),
                              onPressed: () {
                                controller.controller.value.clear();
                              },
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: Obx(
                  () => GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 2,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.product.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: (() => Get.to(() => ProductDetails(
                                model: controller.product[index]!,
                              ))),
                          child:
                              ProductCard(product: controller.product[index]!));
                    },
                  ),
                ),
              ),
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
        Container(
          color: Colors.green,
          height: 280,
          width: 280,
          child: Image.network(
            product.urls![0],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            product.type!,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
