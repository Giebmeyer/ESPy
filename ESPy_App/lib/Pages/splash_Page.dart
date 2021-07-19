import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Palette.purple.shade500,
          valueColor: AlwaysStoppedAnimation<Color>(Palette.purple),
        ),
      ),
    );
  }
}
