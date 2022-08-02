import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/image_controller.dart';
import 'package:seventen/models/product.dart';
import 'package:seventen/services/database.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> artist = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> searchhController = TextEditingController().obs;
  RxString catergory = ''.obs;

  final ImageController imageController = Get.put(ImageController());

  final RxList<ProductModel> _products = <ProductModel>[].obs;
  final RxList<ProductModel> _searchList = <ProductModel>[].obs;

  List<ProductModel?> get product => _searchList;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void uploadProduct(
    String key,
  ) async {
    //receive uploaded image urls then add product
    var imageUrls = await imageController.loadImages(key);

    ProductModel product = ProductModel(
      artist.value.text,
      int.parse(
        price.value.text,
      ),
      description.value.text,
      catergory.value,
      imageUrls,
    );

    database.addProduct(product);
  }

  Future<void> getProducts() async {
    try {
      _products.value = await database.getProducts();
      _searchList.value = _products;
    } catch (e) {
      Get.snackbar('It\'s not you', 'Something went wrong, Please refresh');
    }
  }

//sort product by searchvalue's string.
  void searchProduct(String value) {
    _searchList.value =
        _products.where((element) => element.artist!.contains(value)).toList();
  }
}
