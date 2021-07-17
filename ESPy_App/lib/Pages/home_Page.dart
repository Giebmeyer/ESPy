import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appController.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ESPy/Funcoes/appWidget.dart';

var primeiroNome;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* drawer: IconButton(
        icon: Icon(Icons.door_back),
        iconSize: 50,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ), */

      appBar: AppBar(
        actions: [
          botaoSair(),
        ],
        title: Text('ESPy'),
        centerTitle: true,
      ),
      body: Center(
        child: textoCentralHomePage(),
      ),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget textoCentralHomePage() {
    separaPrimeiroNome();
    return Text(
      "Bem vindo, " + primeiroNome + "!",
      style: TextStyle(
          fontSize: 35.0,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Palette.purple
            ..invertColors = false),
    );
  }

  void separaPrimeiroNome() {
    var aux = user.nome.split(" ");
    for (int i = 0; i < aux.length; i++) {
      primeiroNome = aux[0];
    }
  }
}
