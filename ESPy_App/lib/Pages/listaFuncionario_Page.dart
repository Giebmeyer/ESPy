import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

import '../main.dart';

class listaFuncionariosPage extends StatefulWidget {
  @override
  _listaFuncionariosPageState createState() => _listaFuncionariosPageState();
}

bool confirmaExpulsao;

class _listaFuncionariosPageState extends State<listaFuncionariosPage> {
  @override
//==============================================================================
  bool erroEmpresa, erroRequestSensores, showProgress;
  String msgErro;
  List data;
  String codigoUsuarioSelecionadoLista;
//==============================================================================

  void coletaFuncionarios() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaFuncionarios.php'),
      body: {"codigoEmpresa": emp.codigo.toString()},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      this.setState(() {
        data = json.decode(response.body);
        showProgress = false;
      });
    }
  }

  void expulsaUsuarioEmpresa() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_expulsarFuncionarioEmpresa.php'),
      body: {
        "codigoUsuarioSelecionadoLista":
            codigoUsuarioSelecionadoLista.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["StatusExpulsausuario"]) {
        this.setState(() {
          msgErro = jsondata["mensagemExpulsaUsuario"];
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(msgErro)));
          showProgress = false;
        });
      } else {
        this.setState(() {
          msgErro = jsondata["mensagemExpulsaUsuario"];
          showCaixaDialogoSimples(context, msgErro);
          showProgress = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    showProgress = true;
    this.coletaFuncionarios();
  }

  @override
  void atualizarTela() {
    setState(() {
      showProgress = true;
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
        ? ApresentaProgressoUsuariosEmpresa()
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
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: IconButton(
                        onPressed: () {
                          codigoUsuarioSelecionadoLista = data[index]["codigo"];
                          showCaixaDialogoAvancada(context,
                              "Deseja realmente retirar esse funcionário da sua empresa?");
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                ),
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

  void confirmaExpulsaoFuncao() {
    if (confirmaExpulsao == true) {
      setState(() {
        atualizarTela();
      });
      expulsaUsuarioEmpresa();
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  void showCaixaDialogoAvancada(BuildContext context, String msg) {
    // configura o button

    Widget cancelaButton, confirmaButton;

    Widget linhaBotoes() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.15,
            shape: RoundedRectangleBorder(),
            child: Text(
              "Cancelar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              confirmaExpulsao = false;
              confirmaExpulsaoFuncao();
            },
          ),
          confirmaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.15,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Palette.purple)),
            child: Text(
              "Confirmar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Palette.purple),
            ),
            onPressed: () {
              confirmaExpulsao = true;
              confirmaExpulsaoFuncao();
            },
          ),
        ],
      );
    }

    AlertDialog alerta = AlertDialog(
        title: Text(msg, style: TextStyle(), textAlign: TextAlign.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        actions: [linhaBotoes()]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Widget ApresentaProgressoUsuariosEmpresa() {
    return showProgress
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: (Palette.purple.shade100),
                  valueColor: AlwaysStoppedAnimation<Color>(Palette.purple),
                ),
                Text("Carregando dados...",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          )
        : showErrorEmpresaSemFuncionarios();
  }
}
