import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:seventen/models/user.dart';
import '../models/product.dart';

class Database {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? stripeClientSecret;

  String baseUrl =
      'https://us-central1-seventen-ecd63.cloudfunctions.net/seventen';

  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  
  
  
  Future<dynamic> addImages(List<XFile> images, String key) async {
    final List<String> list = [];
    //if key is "imagekey", add to images path
    //then add each image url to database
    //return
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
      log(e.toString());
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
      log(e.toString());
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
      log(e.toString());
    }
    return;
  }

  Future<List> getImages() async {
    final QuerySnapshot<Map<String, dynamic>> reference =
        await _firestore.collection('mainimages').get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> doc =
        reference.docs.toList();

    return doc;

    //isloading.value = false;
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

  Future<Map<String, dynamic>> fetchPaymentIntentClientSecret(
      int price, String? customerID) async {
    // create payment intent
    // receive client secret
    // process payment

    String amount = '${price}00';
    final url = Uri.parse('$baseUrl/stripe');

    final response = await http.post(
      url,
      body: ({
        'amount': amount,
        'customerID': customerID,
      }),
    );

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> stripeClientResponse = json.decode(response.body);
        log(stripeClientResponse['paymentIntent']!);

        return stripeClientResponse;
      }
    } catch (e) {
      rethrow;
    }

    return {};
  }

  Future<void> updateCustomer(String userID, String? customerID) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .update({'stripeCustomerID': customerID});
    } catch (e) {
      log(e.toString());
    }
  }
}

final Database database = Database();
