import 'package:amit_project/Opening/OpenPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.blue,
      seconds: 3,
      navigateAfterSeconds: OpenPage(),
      useLoader: true,
      title: Text(
        "Souq.",
        style: GoogleFonts.quicksand(
            fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      loaderColor: Colors.white,

    );
  }
}
