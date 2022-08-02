import 'package:cached_network_image/cached_network_image.dart';
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
            Searchbar(controller: controller),
            ProductGridView(controller: controller),
          ],
        ),
      ),
    );
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      title: const Text('710CAPS', style: TextStyle(fontSize: 35)),
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 90),
            child: Obx(() => TextField(
                  onChanged: (value) => controller.searchProduct(value),
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.searchhController.value,
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
                        controller.searchProduct('');
                        controller.searchhController.value.clear();
                      },
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onHorizontalDragCancel: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: Obx(
            () => GridView.builder(
              padding: const EdgeInsets.only(
                  bottom: 10, left: 10, right: 10, top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    child: ProductCard(product: controller.product[index]!));
              },
            ),
          ),
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
        SizedBox(
          height: 280,
          width: 280,
          child: CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: product.urls![0],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            product.artist!.toUpperCase(),
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            '${product.price.toString()} USD',
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
