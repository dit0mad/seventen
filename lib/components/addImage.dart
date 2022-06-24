// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seventen/controllers.dart/imageController.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key, required this.ctx}) : super(key: key);

  final String ctx;
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final ImageController controller = Get.put(ImageController());

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages == null) return;
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      controller.imageFileList = selectedImages;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              selectImages();
            },
            child: const Text('Select Images'),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: imageFileList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(File(imageFileList![index].path));
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                imageFileList = [];
              });
            },
            child: const Text('Clear'),
          ),
          widget.ctx == 'product'
              ? const Text('')
              : SizedBox(
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (imageFileList!.isEmpty) {
                        return;
                      } else {
                        print(imageFileList!.length);
                        await controller.loadImages('imageKey');
                      }
                      //Database().loadImages(imageFileList!);
                    },
                    child: const Text('Upload Images'),
                  ),
                ),
        ],
      ),
    );
  }
}
