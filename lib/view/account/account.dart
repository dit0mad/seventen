import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:seventen/view/cart/guest_checkout.dart';
import 'package:seventen/components/user_check.dart';
import 'package:seventen/controllers.dart/account_tab_controller.dart';
import 'package:seventen/controllers.dart/user_controller.dart';
import 'package:seventen/view/account/sign_up.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    UserController controller = Get.find();
    AccountTabController accountTabController = Get.put(AccountTabController());

    return Obx(() => Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: controller.user == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30, top: 50),
                        child: const Text(
                          '710CAPS',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
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
                      SizedBox(
                        width: width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {
                            controller.login();
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
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87),
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
                                Get.to(() => SignUp());
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
                  )
                : Scaffold(
                    body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const Text(
                            '710CAPS',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: width,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent,
                                    ),
                                  ),
                                  onPressed: () {
                                    accountTabController.changeIndex(2);
                                  },
                                  child: const Text('PURCHASES'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    // controller.signOut();
                                  },
                                  child: const Text('RETURNS'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    // controller.signOut();
                                  },
                                  child: const Text('HELP'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    // controller.signOut();
                                  },
                                  child: const Text('PROFILE'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        DefaultTabController(
                          length: 3,
                          child: TabBar(
                            tabs: [
                              const Tab(icon: Icon(Icons.directions_car)),
                              const Tab(icon: Icon(Icons.directions_transit)),
                              const Tab(icon: Icon(Icons.directions_bike)),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.55,
                          width: width,
                          color: Colors.red,
                          //show screen according to index
                          child: TabBarView(
                            children: [
                              Icon(Icons.directions_car),
                              Icon(Icons.directions_transit),
                              Icon(Icons.directions_bike),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                            ),
                            onPressed: () {
                              controller.signOut();
                            },
                            child: const Text('LOG out'),
                          ),
                        ),
                        const Text("user loaded"),
                      ],
                    ),
                  )),
          ),
        ));
  }
}
