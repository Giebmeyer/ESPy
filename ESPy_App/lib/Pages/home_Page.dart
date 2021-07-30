import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
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
    );
  }

  Widget showBody() {
    return Container(
      /* padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), */
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Container(
        decoration: new BoxDecoration(),
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
                topRight: const Radius.circular(300.0),
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
              ..strokeWidth = 2
              ..color = Palette.purple.shade200
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
