import 'package:flutter/material.dart';

class GuestCheckout extends StatelessWidget {
  const GuestCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: const Text(
                  'PERSONAL DETAILS',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      // keyboardType: TextInputType.emailAddress,
                      validator: ((value) {
                        if (value!.contains('@')) {
                          return 'Please enter some text';
                        } else {
                          return null;
                        }
                      }),
                      decoration: const InputDecoration(
                        labelText: 'EMAIL',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'NAME',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'PASSWORD',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ADDRESS',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'APARTMENT, SUITE, BUILDING FLOOR',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'STATE',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'CITY',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'POSTAL CODE',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'CONTACT',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('LOG IN'),
                    ),
                  ],
                ),
                //height: height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
