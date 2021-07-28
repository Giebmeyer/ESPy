import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/usuario.dart';
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
      floatingActionButton: botaoEditarEmpresa(),
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
