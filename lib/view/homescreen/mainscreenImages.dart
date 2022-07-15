// ignore: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/services/database.dart';

class Mainscreenimages extends GetView<Database> {
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
            autoPlayInterval: const Duration(seconds: 8),
            //autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
          ),
          items: controller.images.map((element) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  element,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  alignment: Alignment.center,
                );
              },
            );
          }).toList(),
        );
      }
    });
  }
}
