import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/BD.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:ESPy/Pages/cadastroEmpresa_Page.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';

class minhaEmpresaPage extends StatefulWidget {
  @override
  _minhaEmpresaPgeState createState() => _minhaEmpresaPgeState();
}

class _minhaEmpresaPgeState extends State<minhaEmpresaPage> {
  List<empresa> _listaEmpresa = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha empresa"),
        centerTitle: true,
      ),
      body: listaEmpresas(),
      floatingActionButton: botaoAdicionarEmpresa(),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget listaEmpresas() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: emp.qtdDadosBD,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: ListTile(title: Text(apresentaEmpresas())),
              padding: const EdgeInsets.all(20.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Palette.purple)),
            ),
          ],
        );
      },
    );
  }

/*   Widget apresentaEmpresas() {
    coletaDadosEmpresa();
    for (var i = 0; i < emp.qtdDadosBD; i++) {
      return ListTile(title: Text(_listaEmpresa.toString()));
    }
  } */

  apresentaEmpresas() {
    var db = new Mysql();

    db.getConnection().then((conn) {
      conn.query("select * from empresa;").then(((results) {
        Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: ListTile(title: Text(results.toString())),
              padding: const EdgeInsets.all(20.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Palette.purple)),
            ),
          ],
        );
      }));
    });
  }

  Widget botaoAdicionarEmpresa() {
    return FloatingActionButton(
      backgroundColor: Palette.purple,
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => cadastroEmpresaPage()));
      },
      child: Icon(Icons.add),
    );
  }

  void showCadastroEmpresa() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => cadastroEmpresaPage()));
  }
}
