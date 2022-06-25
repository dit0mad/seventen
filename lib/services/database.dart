import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class Database extends GetxController {
  late final RxList _imageUrls = [].obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isloading = false.obs;
  RxList get images => _imageUrls;
  RxBool get loading => isloading;

  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  @override
  void onInit() {
    print("call onInit");

    //getImages();

    super.onInit();
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

  Future<dynamic> loadImages(List<XFile> images, String key) async {
    final List<String> list = [];

    if (key == 'imageKey') {
      for (var element in images) {
        var uploadTask = await _storage
            .ref('images')
            .child(element.path.split('/').last)
            .putFile(File(element.path));

        if (uploadTask.state == TaskState.success) {
          final String downloadUrl = await uploadTask.ref.getDownloadURL();
          addUrl(downloadUrl);
        }
      }
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

  Future<void> addUrl(String url) async {
    try {
      await _firestore.collection("mainimages").add({
        'url': url,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> callfunc(ProductModel product) async {
    final url = Uri.parse(
        'http://localhost:5001/seventen-ecd63/us-central1/seventen/products/add');

    final response = await http.post(
      url,
      headers: customHeaders,
      body: jsonEncode(product),
    );

    print(response.body);
  }

  Future getProducts() async {
    final url = Uri.parse(
        'http://localhost:5001/seventen-ecd63/us-central1/seventen/products');

    final response = await http.get(
      url,
    );

    List<dynamic> parse = jsonDecode(response.body);

    List<ProductModel> products = [];

    for (var v in parse) {
      products.add(ProductModel.fromJson(v));
    }

    return products;
  }

  // Future<void> updateProductIamges(List urls) async {
  //   try {
  //     await _firestore.collection("product").add({
  //       'url': urls,
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}

final Database database = Database();
