import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:ESPy/Pages/cadastroEmpresa_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_Page.dart';

class minhaEmpresaPage extends StatefulWidget {
  @override
  _minhaEmpresaPgeState createState() => _minhaEmpresaPgeState();
}

class _minhaEmpresaPgeState extends State<minhaEmpresaPage> {
//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showProgress ? emp.nome : "Minha Empresa"),
        centerTitle: true,
      ),
      body: Empresa(),
      floatingActionButton: botaoAdicionarEmpresa(),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget Empresa() {
    return Container(
      child: showProgress ? showEmpresa() : showErroEmpresa(),
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
    );
  }

  Widget showErroEmpresa() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.purple, width: 1),
        ),
        child: Text(
          "Você não possui uma empresa cadastrada.",
          style: TextStyle(
              fontSize: 35.0,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Palette.purple
                ..invertColors = false),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget showEmpresa() {
    return Center(
      child: Container(
        child: Container(
          decoration: new BoxDecoration(
              color: Palette.purple,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0),
              )),
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(150.0),
                )),
          ),
        ),
      ),
    );
  }

  Widget botaoAdicionarEmpresa() {
    if (user.usuario_chefe == 1) {
      return null;
    } else {
      return FloatingActionButton(
        heroTag: "Cadastrar Empresa",
        backgroundColor: Palette.purple,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => cadastroEmpresaPage()));
        },
        child: Icon(Icons.add),
      );
    }
  }
}
