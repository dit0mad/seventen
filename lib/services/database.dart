import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:seventen/models/user.dart';
import '../models/product.dart';

class Database extends GetxController {
  late final RxList _imageUrls = [].obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isloading = false.obs;
  RxList get images => _imageUrls;
  RxBool get loading => isloading;

  String? stripeClientSecret;

  String baseUrl =
      'https://us-central1-seventen-ecd63.cloudfunctions.net/seventen';

  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  @override
  void onInit() {
    getImages();
    super.onInit();
  }

  Future<dynamic> addImages(List<XFile> images, String key) async {
    final List<String> list = [];
    //if key is "imagekey", add to images path
    //then add each image url to database
    if (key == 'imageKey') {
      for (var element in images) {
        var uploadTask = await _storage
            .ref('images')
            .child(element.path.split('/').last)
            .putFile(File(element.path));

        if (uploadTask.state == TaskState.success) {
          final String downloadUrl = await uploadTask.ref.getDownloadURL();
          uploadUrl(downloadUrl);
        }
      }
      return;

      // else add to product path
      //return iamge url list
    } else {
      for (var element in images) {
        var uploadTask = await _storage
            .ref('product')
            .child(element.path.split('/').last)
            .putFile(File(element.path));

        if (uploadTask.state == TaskState.success) {
          final String downloadUrl = await uploadTask.ref.getDownloadURL();
          list.add(downloadUrl);
        }
      }
      return list;
    }
  }

  void uploadUrl(String url) async {
    try {
      await _firestore.collection("mainimages").add({
        'url': url,
      });
    } catch (e) {
      print(e);
    }
  }

  void addProduct(ProductModel product) async {
    final url = Uri.parse('$baseUrl/products/add');

    await http.post(
      url,
      headers: customHeaders,
      body: jsonEncode(product),
    );
  }

  Future<bool> createNewUser(User user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "id": user.id,
        "address": user.address!.toJson(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
      );

      List<dynamic> decodedBody = jsonDecode(response.body);

      List<ProductModel> products = [];

      for (var product in decodedBody) {
        products.add(ProductModel.fromJson(product));
      }

      return products;
    } catch (e) {
      print(e);
    }
    return;
  }

  Future<void> getImages() async {
    isloading.value = true;
    final QuerySnapshot<Map<String, dynamic>> reference =
        await _firestore.collection('mainimages').get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> doc =
        reference.docs.toList();

    for (var element in doc) {
      _imageUrls.add(element.data()['url']);
    }
    isloading.value = false;
  }

  Future<User> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();

      return User.fromDocumentSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> makePayment(int price) async {
    // create payment intent
    // receive client secret
    // process payment

    String amount = '${price}00';
    final url = Uri.parse('$baseUrl/stripe');

    final response = await http.post(
      url,
      body: ({
        'amount': amount,
      }),
    );

    try {
      if (response.statusCode == 200) {
        String stripeClientSecret = json.decode(response.body);

        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: stripeClientSecret,
          style: ThemeMode.dark,
        ));

        displaySheet();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> displaySheet() async {
    await Stripe.instance.presentPaymentSheet();
    Get.snackbar('Success', 'Payment succesfully completed');
    

    // Stripe.instance.confirmPayment(stripeClientSecret!, )
  }
}

final Database database = Database();
