import 'package:get/get.dart';

class AccountTabController extends GetxController {
  RxInt index = 0.obs;

  void changeIndex(int index) {
    this.index.value = index;
  }
}
