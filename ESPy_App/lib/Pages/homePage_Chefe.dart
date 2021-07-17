import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ESPy/Funcoes/appWidget.dart';

import 'login_Page.dart';

class HomePage_Chefe extends StatefulWidget {
  @override
  State<HomePage_Chefe> createState() {
    return _HomePage_ChefeState();
  }
}

class _HomePage_ChefeState extends State<HomePage_Chefe> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IconButton(
        icon: Icon(Icons.door_back),
        iconSize: 50,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
      appBar: AppBar(
        actions: [
          botaoSair(),
        ],
        title: Text('ESPy'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: textoCentralHomePage(),
        ),
      ),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget textoCentralHomePage() {
    return Text(
      "Bem vindo, " + user.nome + "!",
      style: TextStyle(
          fontSize: 35.0,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.black),
    );
  }
}
