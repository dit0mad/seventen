import 'package:get/state_manager.dart';

class NavigationController extends GetxController {
  RxInt index = 0.obs;
  //RxInt accountTabindex = 0.obs;

  void changeTabIndex(int tabindex) {
    index.value = tabindex;
    update();
  }
}
