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

  String baseUrl =
      'http://localhost:5001/seventen-ecd63/us-central1/seventen/products';

  Map<String, dynamic> _paymentIntent = {};
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  @override
  void onInit() {
    //getImages();
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

  Future<void> uploadUrl(String url) async {
    try {
      await _firestore.collection("mainimages").add({
        'url': url,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addProduct(ProductModel product) async {
    final url = Uri.parse('$baseUrl/add');

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
        Uri.parse(baseUrl),
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

    String amount = price.toString();
    final url = Uri.parse('$baseUrl/stripe');

    final response = await http.post(
      url,
      body: ({
        'amount': amount,
      }),
    );

    Map paymentIntent = json.decode(response.body);

   

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntent['paymentIntent'],
      style: ThemeMode.dark,
    ));

    displaySheet();
  }

  Future<void> displaySheet() async {
    await Stripe.instance.presentPaymentSheet().then((value) => print('done'));
  }
}

final Database database = Database();
