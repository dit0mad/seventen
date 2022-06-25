import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:seventen/models/product.dart';
import 'package:seventen/services/database.dart';

class ProductDetails extends GetView<Database> {
  ProductDetails({required this.model, Key? key}) : super(key: key);
  ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              expandedHeight: 600,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(background: Obx(() {
                if (controller.isloading.value == true) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                } else {
                  return CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 7,
                      height: 700,
                      autoPlay: true,
                      scrollDirection: Axis.horizontal,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
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
                  );
                }
              })),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(color: Colors.red, height: 600),
                ],
              ),
            ),
          ],
        ));
  }
}
