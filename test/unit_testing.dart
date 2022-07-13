// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seventen/controllers.dart/productController.dart';

import 'package:seventen/main.dart';
import 'package:seventen/models/product.dart';

void main() {
  test('add product to cart', () {
    //Assert product controller
    final controller = ProductController();

    //act- add a product
    controller.addToCart(
        ProductModel('benjamin', 20, 'spinner', '25mm handcarved', ['urls']));
    controller.addToCart(
        ProductModel('benjamin', 20, 'spinner', '25mm handcarved', ['urls']));

    //expect
    expect(controller.onCart.length, 1);
  });

 // test('calculate total', () {});
}
