import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/models/user.dart' as user_model;
import 'package:seventen/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final Rx<user_model.User> _userModel = user_model.User().obs;

  late UserCredential _authResult;

  user_model.User? get user => _userModel.value;

  @override
  void onInit() {
    checkUserSession();
    super.onInit();
  }

  void setUserSession(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  void checkUserSession() async {
     //id user session is set, retrieve credentials and login, else do nothing. 


    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    try {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');

      if (email!.isNotEmpty) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password!);
        _userModel.value = await database.getUser(_authResult.user!.uid);
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<bool> createUser() async {
    //create user model
    //pass credentials and create user on firebaseAuth
    //retrieve authId
    //upload user object to firebase with authId
    user_model.Address addressInfo = user_model.Address(
      addressLine2: addressLine2.value.text,
      city: city.value.text,
      country: country.value.text,
      phoneNumber: int.parse(phoneNumber.value.text),
      postalCode: int.parse(postalCode.value.text),
      state: state?.value.text,
      street: addressLine.value.text,
    );

    _userModel.value = user_model.User(
        email: email.value.text,
        name: name.value.text,
        password: password.value.text,
        address: addressInfo,
        stripeCustomerID: null);

    try {
      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.value.text.trim(), password: password.value.text);
      _userModel.value.id = _authResult.user!.uid;

      await database.createNewUser(_userModel.value);
      setUserSession(_userModel.value.email!, _userModel.value.password!);
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
    //check for user logged in. if true break
    //else login in with

    try {
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email.value.text.trim(), password: password.value.text);
      _userModel.value = await database.getUser(_authResult.user!.uid);
      setUserSession(email.value.text, password.value.text);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void signOut() {
    _auth.signOut();
    _userModel.value = user_model.User();
    clearUserSession();
  }

  void clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
