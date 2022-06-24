import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';

class ImageController extends GetxController {
  List<XFile>? imageFileList = [];

  Future loadImages(String key) async {
    var url = await database.loadImages(imageFileList!, key);
    return url;
  }
}
