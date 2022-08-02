import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/models/product.dart';

import '../../controllers.dart/cart_controller.dart';

class ProductDetails extends GetView<CartController> {
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
                // enlargeCenterPage: true,
              ),
              items: model.urls!
                  .map((e) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: e,
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
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('\$${model.price!.toString()}',
                          style: Theme.of(context).textTheme.bodyText1),
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
                        style: Theme.of(context).textTheme.bodyText2,
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
