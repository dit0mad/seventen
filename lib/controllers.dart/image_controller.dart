import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';

class ImageController extends GetxController {
  late final RxList _imageUrls = [].obs;
  List<XFile>? imageFileList = [];

  RxBool isloading = false.obs;
  RxList get images => _imageUrls;

  @override
  void onInit() {
    getImages();
    super.onInit();
  }

  Future<dynamic> loadImages(String key) async {
    //var can be empty or list of url.
    //key defines which path the images should be add to.
    var url = await database.addImages(imageFileList!, key);
    return url;
  }

  Future<void> getImages() async {
    isloading.value = true;
    List images = await database.getImages();

    for (var image in images) {
      _imageUrls.add(image.data()['url']);
    }
    isloading.value = false;
  }
}
