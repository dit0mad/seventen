import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/view/cart/guest_checkout.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class UserCheck extends StatelessWidget {
  const UserCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final UserController controller = Get.find();
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: controller.user == null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: const Text(
                            '710CAPS',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GuestCheckout()),
                              );
                            },
                            child: const Text('CONTINUE AS A GUEST'),
                          ),
                        ),
                        Row(children: const <Widget>[
                          Expanded(
                              child: Divider(
                            height: 20,
                            thickness: 0.3,
                            color: Colors.black,
                          )),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                              right: 6,
                            ),
                            child: Text(
                              "OR",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            height: 20,
                            thickness: 0.3,
                            color: Colors.black,
                            endIndent: 6,
                          )),
                        ]),
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 10),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            controller: controller.email.value,
                            decoration: const InputDecoration(
                              labelText: 'EMAIL',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            controller: controller.password.value,
                            decoration: const InputDecoration(
                              labelText: 'PASSWORD',
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserCheck()),
                              );
                            },
                            child: const Text('LOG IN'),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Get.snackbar('s', 's');
                          }),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'FORGOT YOUR PASSWORD?',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              const Text(
                                'DON\'T HAVE AN ACCOUNT?  ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  print('signup');
                                }),
                                child: const Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: Text("user loaded")),
          ),
        ),
      ),
    );
  }
}
