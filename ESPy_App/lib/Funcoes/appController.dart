import 'package:ESPy/Pages/login_Page.dart';
import 'package:flutter/material.dart';

class botaoSair extends StatefulWidget {
  @override
  _botaoSairState createState() => _botaoSairState();
}

class _botaoSairState extends State<botaoSair> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(Icons.door_back),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }
}
