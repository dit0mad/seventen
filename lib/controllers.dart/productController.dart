import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/image_controller.dart';
import 'package:seventen/models/product.dart';
import 'package:seventen/services/database.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> artist = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  RxString catergory = ''.obs;

  final ImageController controller = Get.put(ImageController());

  final RxList<ProductModel> _products = <ProductModel>[].obs;
  final RxList<ProductModel> _onCart = <ProductModel>[].obs;

  List<ProductModel?> get product => _products;
  List<ProductModel> get onCart => _onCart;

  RxInt total = 0.obs;

  @override
  void onInit() {
    super.onInit();

    getProducts();
  }

  void uploadProduct(String key) async {
    var imageUrls = await controller.loadImages(key);

    ProductModel product = ProductModel(
      artist.value.text,
      int.parse(
        price.value.text,
      ),
      description.value.text,
      catergory.value,
      imageUrls,
    );

    await database.addProduct(product);
  }

  Future<void> getProducts() async {
    try {
      _products.value = await database.getProducts();
    } catch (e) {
      Get.snackbar('It\'s not you', 'Something went wrong, Please refresh');
    }
  }

  void addToCart(ProductModel model) {
    //if cart contains item, avoid adding.
    if (_onCart.contains(model)) {
      // Get.showSnackbar(const GetSnackBar(
      //   message: 'ITEM ALREADY ADDED',
      //   duration: Duration(seconds: 2),
      // ));
      return;
    } else {
      _onCart.add(model);
      calculateTotal(model);
      // Get.showSnackbar(const GetSnackBar(
      //   message: 'ADDED TO CART',
      //   duration: Duration(seconds: 2),
      // ));
    }
  }

  void calculateTotal(ProductModel model) {
    total = total + model.price!;
  }
}
