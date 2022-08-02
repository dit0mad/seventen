import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seventen/components/login.dart';

import 'package:seventen/controllers.dart/account_tab_controller.dart';
import 'package:seventen/controllers.dart/user_controller.dart';
import 'package:seventen/view/account/profile.dart';
import 'package:seventen/view/account/purchases.dart';
import 'package:seventen/view/account/returns.dart';
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
            child: controller.user!.email == null
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
                      const Login(),
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
                                Get.to(SignUp());
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
                        SizedBox(
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
                                    accountTabController.changeIndex(0);
                                  },
                                  onHover: (value) {},
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
                                    accountTabController.changeIndex(1);
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
                                    accountTabController.changeIndex(2);
                                  },
                                  child: const Text('PROFILE'),
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
                        Container(
                          height: height * 0.55,
                          width: width,
                          color: Colors.black12,
                          child: IndexedStack(
                              index: accountTabController.index.value,
                              
                              children: const [
                                Purchases(),
                                Returns(),
                                Profile(),
                              ]),
                          //show screen according to index
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
                      ],
                    ),
                  )),
          ),
        ));
  }
}
