import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seventen/controllers.dart/cart_controller.dart';

import 'package:seventen/models/product.dart';
import 'package:http/http.dart' as http;

class DatabaseMock extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  test('add product to cart', () {
    //Assert product controller
    final controller = CartController();

    //act- add a product
    controller.addToCart(
        ProductModel('benjamin', 20, 'spinner', '25mm handcarved', ['urls']));

    //expect
    expect(controller.onCart.length, 1);

    controller.addToCart(
        ProductModel('benjamin', 20, 'spinner', '25mm handcarved', ['urls']));

    expect(controller.onCart.length, 2);
  });

  test('total after adding of product', () {
    //asert
    final controller = CartController();

    var product =
        ProductModel('benjamin', 20, 'spinner', '25mm handcarved', ['urls']);

    controller.addToCart(product);

    var productTwo =
        ProductModel('benjamin', 30, 'spinner', '25mm handcarved', ['urls']);
    controller.addToCart(productTwo);

    controller.calculateTotal();

    expect(50, controller.totalPrice);
  });

  test('get products succesfully', () async {
    http.Client mockDatabase = DatabaseMock();

    when(
      mockDatabase.get(
        Uri.parse(
            'http://localhost:5001/seventen-ecd63/us-central1/seventen/products'),
      ),
    );
  });
}
