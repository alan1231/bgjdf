import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Image.asset("assets/images/splash.png", fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
