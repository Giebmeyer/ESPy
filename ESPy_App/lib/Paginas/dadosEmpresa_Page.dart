import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';

class dadosEmpresaPage extends StatefulWidget {
  @override
  _dadosEmpresaPageState createState() => _dadosEmpresaPageState();
}

class _dadosEmpresaPageState extends State<dadosEmpresaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: showBodyDados(),
      floatingActionButton: botaoEditarEmpresa(),
    );
  }

  Widget showBodyDados() {
    return Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(115.0),
                  topRight: const Radius.circular(115.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      emp.nome,
                      style: TextStyle(fontSize: 30, fontFamily: 'Orbitron'),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget botaoEditarEmpresa() {
    return FloatingActionButton(
      heroTag: "Editar Empresa",
      backgroundColor: Palette.purple,
      onPressed: () {},
      child: Icon(Icons.edit),
    );
  }
}
