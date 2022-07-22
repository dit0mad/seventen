import 'package:flutter/widgets.dart';
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
  final RxList<ProductModel> _onCart = <ProductModel>[].obs;

  List<ProductModel?> get product => _searchList;
  List<ProductModel> get onCart => _onCart;

  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void uploadProduct(String key) async {
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

  void addToCart(ProductModel model) {
    //if cart contains item, avoid adding
    //else add and calculate total
    if (_onCart.contains(model)) {
      Get.showSnackbar(const GetSnackBar(
        message: 'ITEM ALREADY ADDED',
        duration: Duration(seconds: 2),
      ));
      return;
    } else {
      _onCart.add(model);
      calculateTotal();
      Get.showSnackbar(const GetSnackBar(
        message: 'ADDED TO CART',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void calculateTotal() {
    double sum = 0;
    sum = onCart.fold(sum,
        (previousValue, element) => previousValue + element.price!.toInt());

    totalPrice.value = sum.toInt();
  }

  void searchProduct(String value) {
    _searchList.value =
        _products.where((element) => element.artist!.contains(value)).toList();

    //sort product by searchvalue's string.
  }

  void deleteItem(int index) {
    _onCart.removeAt(index);
    calculateTotal();
  }

  void checkOut() {
    //create payment intent and display payment sheet
    database.makePayment(totalPrice.value);
  }
}
