import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seventen/components/login.dart';
import 'package:seventen/view/account/sign_up.dart';
import 'package:seventen/view/cart/guest_checkout.dart';

class UserCheck extends StatelessWidget {
  const UserCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 25, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: const Text(
                '710CAPS',
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
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
                        builder: (context) => const GuestCheckout()),
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
            const Login(),
            buildForgotPassword(),
            const SizedBox(
              height: 10,
            ),
            buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Padding buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          const Text(
            'DON\'T HAVE AN ACCOUNT?  ',
            style: TextStyle(fontSize: 12, color: Colors.black87),
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
    );
  }

  GestureDetector buildForgotPassword() {
    return GestureDetector(
      onTap: (() {
        Get.snackbar('s', 's');
      }),
      child: const Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          'FORGOT YOUR PASSWORD?',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ),
    );
  }
}
