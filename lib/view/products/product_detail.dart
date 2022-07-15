import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/models/product.dart';

class ProductDetails extends GetView<ProductController> {
  const ProductDetails({required this.model, Key? key}) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          expandedHeight: 590,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            background: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 7,
                height: 700,
                autoPlay: true,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 10),
                enlargeCenterPage: true,
              ),
              items: model.urls!
                  .map((e) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.white,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        model.type!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '\$${model.price!.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: (() {
                          controller.addToCart(model);
                        }),
                        child: const Text(
                          "ADD TO BAG",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "${model.description} cap by ${model.artist}. Hand blown and made with love ",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
