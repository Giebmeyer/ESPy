import 'dart:convert';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appController.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

var primeiroNome;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          botaoSair(),
        ],
        title: Text('ESPy'),
        centerTitle: true,
      ),
      body: showBody(),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget showBody() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Container(
        decoration: new BoxDecoration(
            color: Palette.purple,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            )),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: textoCentralHomePage(),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(150.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textoCentralHomePage() {
    separaPrimeiroNome();
    return Container(
      child: Text(
        "Bem vindo, " + primeiroNome + "!",
        style: TextStyle(
            fontSize: 35.0,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Palette.purple
              ..invertColors = false),
        textAlign: TextAlign.center,
      ),
    );
  }

  void separaPrimeiroNome() {
    var aux = user.nome.split(" ");
    for (int i = 0; i < aux.length; i++) {
      primeiroNome = aux[0];
    }
  }
}
