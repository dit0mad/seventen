import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/user_controller.dart';
import 'package:seventen/models/product.dart';
import 'package:seventen/services/database.dart';

class CartController extends GetxController {
  RxInt totalPrice = 0.obs;

  final RxList<ProductModel> _onCart = <ProductModel>[].obs;

  List<ProductModel> get onCart => _onCart;

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

  void deleteItem(int index) {
    _onCart.removeAt(index);
    calculateTotal();
  }

  void calculateTotal() {
    double sum = 0;
    sum = onCart.fold(sum,
        (previousValue, element) => previousValue + element.price!.toInt());

    totalPrice.value = sum.toInt();
  }

  Future<bool> checkOut() async {
    var user = Get.find<UserController>().user!;
    //create payment intent and display payment sheet
    //if current user's stripeId is null update db with new ID
    //else pass init paymentsheet

    Map<String, dynamic> response =
        await database.fetchPaymentIntentClientSecret(
            totalPrice.value, user.stripeCustomerID);

    if (user.stripeCustomerID == 'null') {
      return await database.updateCustomer(user.id!, response['customer']).then(
            (value) => initPaymentSheet(response),
          );
    } else {
      return initPaymentSheet(response);
    }
  }

  Future<bool> initPaymentSheet(Map response) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      customerId: response['customer'],
      paymentIntentClientSecret: response['paymentIntent'],
      customerEphemeralKeySecret: response['ephemeralKey'],
      style: ThemeMode.dark,
    ));
    return displaySheet();
  }

  Future<bool> displaySheet() async {
    await Stripe.instance
        .presentPaymentSheet()
        .onError((error, stackTrace) => false);

    clearCartContent();

    
    //add order to db
    return true;
  }

  void clearCartContent() {
    _onCart.clear();
    totalPrice.value = 0;
  }
}
