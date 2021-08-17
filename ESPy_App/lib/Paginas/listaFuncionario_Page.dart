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
//================================================================lum==============

  void _coletaFuncionarios() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaFuncionarios.php'),
      body: {"codigoEmpresa": emp.codigo.toString()},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      this.setState(() {
        data = json.decode(response.body);
        emp.qtdFuncionarios = data.length;
        setState(() {
          showProgress = false;
        });
      });
    } else {
      print("Nao foi possivel conectar-se.");
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
          showCaixaDialogoSimples(context, msgErro);
          _coletaFuncionarios();
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
    this._coletaFuncionarios();
  }

  @override
  void atualizarTela() {
    setState(() {
      print(emp.qtdFuncionarios);
      showProgress = true;
      this._coletaFuncionarios();
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
    if (emp.qtdFuncionarios == 0 || data == null) {
      return ApresentaProgressoUsuariosEmpresa();
    } else {
      return showEmpresaUsuarios();
    }
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
    return Container(
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
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            padding: const EdgeInsets.only(top: 50.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(115.0),
                topRight: const Radius.circular(115.0),
              ),
            ),
            child: new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  color: Colors.grey.shade200,
                  margin: EdgeInsetsDirectional.fromSTEB(35.0, 30.0, 35.0, 00),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(data[index]["email"]),
                          Text(data[index]["telefone"]),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: FlatButton(
                                onPressed: () {
                                  codigoUsuarioSelecionadoLista =
                                      data[index]["codigo"];
                                  showCaixaDialogoAvancada(context,
                                      "Deseja realmente retirar esse funcionário da sua empresa?");
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Palette.purple.shade500,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget showErrorEmpresaSemFuncionarios() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
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
                      "Sua empresa ainda não possui funcionários vinculados.\ncompartilhe a chave de convite da sua empresa a seus funcionários: ",
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
                topLeft: const Radius.circular(115.0),
                topRight: const Radius.circular(115.0),
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
