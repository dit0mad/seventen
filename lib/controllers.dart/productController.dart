import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/imageController.dart';
import 'package:seventen/models/product.dart';
import 'package:seventen/services/database.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> artist = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  RxString catergory = ''.obs;

  final ImageController controller = Get.put(ImageController());

  final RxList<ProductModel?> _products = <ProductModel>[].obs;

  List<ProductModel?> get product => _products;

  @override
  void onInit() {
    super.onInit();
    print('product controller callign');
    getProducts();
  }

  void addProduct(String key) async {
    var imageUrls = await controller.loadImages(key);

    print('product controller printing + $imageUrls');

    ProductModel product = ProductModel(
      artist.value.text,
      price.value.text,
      description.value.text,
      catergory.value,
      imageUrls,
    );

    database.callfunc(product);
  }

  Future<void> getProducts() async {
    print('calling get');
    _products.value = await database.getProducts();
  }
}
