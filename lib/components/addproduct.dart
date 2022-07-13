import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seventen/components/addImage.dart';
import 'package:seventen/controllers.dart/productController.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const identifier = 'product';

    final controller = Get.put(ProductController());
    //final imageController = Get.put(ImageController());

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white54,
            height: height,
            width: 400,
            child: Column(
              children: const [
                SizedBox(
                  height: 450,
                  width: 400,
                  child: AddImage(
                    ctx: identifier,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close_rounded, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.grey[100],
              height: height * 0.45,
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      hint: const Text('Pick a catergory'),
                      value: selectedValue,
                      elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        'Spinner',
                        'Bubble Cap',
                        'Marble',
                      ].map<DropdownMenuItem<String>>((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        controller.catergory.value = value!;
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                    TextWidget(
                      controller: controller.artist.value,
                      text: 'Artist',
                    ),
                    TextWidget(
                      controller: controller.price.value,
                      text: 'Price',
                    ),
                    TextWidget(
                      controller: controller.description.value,
                      text: 'Description',
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.uploadProduct('productKey');

                        //upload pics wait for download url list
                        //parse url list to product json
                        //call add product
                      },
                      child: const Text('Add product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.controller,
    required this.text,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.notoSerif(
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
      ),
      decoration: InputDecoration(labelText: text),
      controller: controller,
    );
  }
}
