import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

class listaFuncionariosPage extends StatefulWidget {
  @override
  _listaFuncionariosPageState createState() => _listaFuncionariosPageState();
}

class _listaFuncionariosPageState extends State<listaFuncionariosPage> {
  @override
//==============================================================================
  bool erroEmpresa, erroRequestSensores, jaCarregouDados;
  List data;
//==============================================================================

  coletaFuncionarios() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_coletaFuncionarios.php'),
      body: {"codigoEmpresa": emp.codigo.toString()},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      this.setState(() {
        data = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.coletaFuncionarios();
  }

  @override
  void atualizarTela() {
    setState(() {
      this.coletaFuncionarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Integrantes"),
        centerTitle: true,
        actions: [botaoAtualizar()],
      ),
      body: funcionarios(),
    );
  }

  Widget funcionarios() {
    return data == null
        ? showErrorEmpresaSemFuncionarios()
        : showEmpresaUsuarios();
  }

  Widget imagemUsuarioLetra(String nome, String imagem) {
    RandomColor _randomColor = RandomColor();
    Color _color =
        _randomColor.randomColor(colorBrightness: ColorBrightness.light);

    var nomeInicial = nome[0].toUpperCase();
    double tamanho = 25.0;
    return CircleAvatar(
      backgroundColor: _color,
      foregroundColor: Colors.black,
      backgroundImage: NetworkImage(imagem),
      radius: tamanho,
      child: Text(nomeInicial,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: tamanho)),
    );
  }

  Widget showEmpresaUsuarios() {
    return new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          margin: EdgeInsetsDirectional.all(5),
          child: new Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Column(
                children: [
                  imagemUsuarioLetra(data[index]["nome"], ""),
                ],
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index]["nome"],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(data[index]["email"]),
                  Text(data[index]["telefone"]),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget showErrorEmpresaSemFuncionarios() {
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
        decoration: new BoxDecoration(),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Sua empresa ainda não possui funcionários vinculados.\ncompartilhe a chave de convite da sua empresa: ",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                  Text(
                    emp.chaveConvite.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(300.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget botaoAtualizar() {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(Icons.restart_alt),
      onPressed: () {
        setState(() {
          atualizarTela();
        });
      },
    );
  }
}
