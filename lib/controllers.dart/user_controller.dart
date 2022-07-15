import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/models/user.dart' as userModel;
import 'package:seventen/services/database.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> addressLine = TextEditingController().obs;
  Rx<TextEditingController> addressLine2 = TextEditingController().obs;
  Rx<TextEditingController> postalCode = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController>? state = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;

  final Rx<userModel.User> _userMod = userModel.User().obs;

  late UserCredential _authResult;

  String? get user => _userMod.value.email;

  //crete User object
  //pass credentials and create user
  //retrieve authId
  //upload user object to firebase with authId
  Future<bool> createUser() async {
    userModel.Address addressInfo = userModel.Address(
      addressLine2: addressLine2.value.text,
      city: city.value.text,
      country: country.value.text,
      phoneNumber: int.parse(phoneNumber.value.text),
      postalCode: int.parse(postalCode.value.text),
      state: state?.value.text,
      street: addressLine.value.text,
    );

    _userMod.value = userModel.User(
      email: email.value.text,
      name: name.value.text,
      password: password.value.text,
      address: addressInfo,
    );

    try {
      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.value.text.trim(), password: password.value.text);
      _userMod.value.id = _authResult.user!.uid;

      await database.createNewUser(_userMod.value);
      return true;
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        '$e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  void login() async {
    try {
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email.value.text.trim(), password: password.value.text);
      _userMod.value = await database.getUser(_authResult.user!.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() {
    _auth.signOut();
    _userMod.value = userModel.User();
  }
}
