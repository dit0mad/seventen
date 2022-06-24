import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seventen/components/mainscreenImages.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Mainscreenimages(),

          Positioned(
            top: 40,
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Text(
                "710CAPS",
                style: GoogleFonts.notoSerif(
                  textStyle: const TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          //this needs to be a carousel
        ],
      ),
    );
  }
}
