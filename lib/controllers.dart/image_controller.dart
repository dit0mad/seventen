import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';

class ImageController extends GetxController {
  List<XFile>? imageFileList = [];

  Future<dynamic> loadImages(String key) async {
    //if var url is a list return
    var url = await database.addImages(imageFileList!, key);
    return url;
  }


  
}
