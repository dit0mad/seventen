// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/image_controller.dart';

class Mainscreenimages extends GetView<ImageController> {
  const Mainscreenimages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isloading.value == true) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        ));
      } else {
        return CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            height: height,
            autoPlay: true,
            scrollDirection: Axis.vertical,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 5),
          ),
          items: controller.images.map((element) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                    child: CachedNetworkImage(
                  imageUrl: element,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  alignment: Alignment.center,
                  placeholder: (context, element) =>
                      const Center(child: CircularProgressIndicator()),
                ));
              },
            );
          }).toList(),
        );
      }
    });
  }
}
