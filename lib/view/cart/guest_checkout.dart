import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seventen/controllers.dart/user_controller.dart';

class GuestCheckout extends StatelessWidget {
  const GuestCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final formKey = GlobalKey<FormState>();

    // UserController controller = Get.find();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'PERSONAL DETAILS',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SignUpWidget(),
          ],
        ),
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  SignUpWidget({
    Key? key,
    // required this.formKey,
    // required this.controller,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        //height: MediaQuery.of(context).size.height,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: ((value) {
                  if (value!.contains('@gmail') || value.contains('@yahoo')) {
                    return null;
                  } else {
                    return 'Please enter a valid email';
                  }
                }),
                decoration: const InputDecoration(
                  labelText: 'EMAIL',
                ),
                controller: controller.email.value,
              ),
              TextFormField(
                controller: controller.name.value,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Cannot be empty";
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'NAME',
                ),
              ),
              TextFormField(
                controller: controller.password.value,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Cannot be empty";
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'PASSWORD',
                ),
              ),
              TextFormField(
                controller: controller.addressLine.value,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Cannot be empty";
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'ADDRESS',
                ),
              ),
              TextFormField(
                controller: controller.addressLine2.value,
                decoration: const InputDecoration(
                  labelText: 'APARTMENT, SUITE, BUILDING FLOOR',
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 14),
              //   child: BuildCity(
              //     controller: controller,
              //   ),
              // ),
              TextFormField(
                controller: controller.postalCode.value,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Cannot be empty";
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'POSTAL CODE',
                ),
              ),
              TextFormField(
                controller: controller.phoneNumber.value,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  // for version 2 and greater youcan also use this
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    if (await controller.createUser()) {
                      Navigator.pop(context);
                    } else {
                      //Get.to(Mainscreenimages());
                    }

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                  }
                },
                child: const Text('CONTINUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildCity extends StatelessWidget {
  final UserController controller;

  const BuildCity({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      ///Enable disable state dropdown [OPTIONAL PARAMETER]
      showStates: true,

      /// Enable disable city drop down [OPTIONAL PARAMETER]
      showCities: true,

      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
      flagState: CountryFlag.DISABLE,

      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
      dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1)),

      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
      disabledDropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300, width: 1)),

      ///placeholders for dropdown search field
      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",

      ///labels for dropdown
      countryDropdownLabel: "*Country",
      stateDropdownLabel: "*State",
      cityDropdownLabel: "*City",

      ///Default Country
      defaultCountry: DefaultCountry.United_States,

      ///Disable country dropdown (Note: use it with default country)
      disableCountry: true,

      ///selected item style [OPTIONAL PARAMETER]
      selectedItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),

      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
      dropdownHeadingStyle: const TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

      ///DropdownDialog Item style [OPTIONAL PARAMETER]
      dropdownItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),

      ///Dialog box radius [OPTIONAL PARAMETER]
      dropdownDialogRadius: 10.0,

      ///Search bar radius [OPTIONAL PARAMETER]
      searchBarRadius: 10.0,

      ///triggers once country selected in dropdown
      onCountryChanged: (value) {
        controller.country.value;
      },

      ///triggers once state selected in dropdown
      onStateChanged: (value) {
        controller.state.value;
      },

      ///triggers once city selected in dropdown
      onCityChanged: (value) {
        controller.city.value;
      },
    );
  }
}
