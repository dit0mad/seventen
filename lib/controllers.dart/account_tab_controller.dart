import 'package:get/get.dart';

class AccountTabController extends GetxController {
  RxInt index = 1.obs;

  void changeIndex(int index) {
    this.index.value = index;
    print(index);
  }
}
