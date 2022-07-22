import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/productController.dart';
import 'package:seventen/view/cart/payment.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ProductController controller = Get.find();

    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Expanded(
                flex: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 100,
                  color: Colors.white38,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 15, bottom: 20),
                    child: Text(
                      'SHOPPING CART (${controller.onCart.length})',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
            const Divider(
              height: 10,
              thickness: 1,
              color: Colors.black,
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: controller.onCart.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(2),
                              height: 200,
                              child: const Text('YOUR CART IS EMPTY')),
                        ],
                      )
                    : SizedBox(
                        height: 550,
                        child: ListView.builder(
                          itemCount: controller.onCart.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 10, right: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Text(
                                      '${controller.onCart[index].description}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 30),
                                    // width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 290,
                                          width: 212,
                                          child: Image.network(
                                            controller.onCart[index].urls![0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          //color: Colors.grey,
                                          height: 290,
                                          width: 161,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '${controller.onCart[index].description}'),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      '${controller.onCart[index].price}'),
                                                ),
                                                Expanded(
                                                  flex: -1,
                                                  child: SizedBox(
                                                    width: width,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          Colors.black,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        controller
                                                            .deleteItem(index);
                                                      },
                                                      child:
                                                          const Text('DELETE'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black,
            ),
            Container(
              color: Colors.white,
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    //color: Colors.amberAccent,
                    width: 165,
                    margin: const EdgeInsets.only(bottom: 80, left: 20),
                    //padding: EdgeInsets.only(bottom: 2),
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                      ),
                      onPressed: () {
                        if (controller.onCart.isEmpty) {
                          Get.snackbar(
                              'Empty Cart', 'Go browse our collection');
                        } else {
                          
                          Get.to(() => const PaymentScreen());
                        }
                      },
                      child: const Text('CONTINUE'),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 165,
                    margin:
                        const EdgeInsets.only(bottom: 80, left: 20, right: 20),
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 20, top: 15),
                    height: 50,
                    child: Text('TOTAL   ${controller.totalPrice} USD\$'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
