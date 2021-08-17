import 'dart:convert';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Paginas/cadastroEmpresa_Page.dart';
import 'package:ESPy/Paginas/entrarEmpresa_Page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'dadosEmpresa_Page.dart';
import 'listaFuncionario_Page.dart';
import 'package:http/http.dart' as http;
import 'login_Page.dart';

class EmpresaPage extends StatefulWidget {
  @override
  _EmpresaPgeState createState() => _EmpresaPgeState();
}

class _EmpresaPgeState extends State<EmpresaPage> {
  var msgErro;

  void expulsaUsuarioEmpresa() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_expulsarFuncionarioEmpresa.php'),
      body: {"codigoUsuarioSelecionadoLista": user.codigo.toString()},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["StatusExpulsausuario"]) {
        this.setState(() {
          msgErro = jsondata["mensagemExpulsaUsuario"];
          showCaixaDialogoRapida(context, msgErro, 'login', 1);
        });
      } else {
        this.setState(() {
          msgErro = jsondata["mensagemExpulsaUsuario"];
          showCaixaDialogoSimples(context, msgErro);
        });
      }
    }
  }

  Widget ajustaAppBar() {
    if (user.usuario_empregado == 1) {
      return AppBar(
        title: Text("Minha Empresa"),
        actions: [
          IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              showCaixaDialogoAvancada(
                  context, "Deseja realmente deixar a empresa?");
            },
          )
        ],
        centerTitle: true,
      );
    } else {
      return AppBar(
        title: Text("Minha Empresa"),
        centerTitle: true,
      );
    }
  }

  @override
  void atualizarTela() {
    setState(() {
      print(emp.qtdFuncionarios);
    });
  }

//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ajustaAppBar(),
      body: Empresa(),
    );
  }

  @override
  void initState() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
    super.initState();
  }

  Widget Empresa() {
    return possuiEmpresa ? confereUsuarioChefeEmpregado() : showErroEmpresa();
  }

  Widget showErroEmpresa() {
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
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Align(
                          child: FlatButton(
                            focusColor: Palette.purple.shade50,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => cadastroEmpresaPage()));
                            },
                            child: Text(
                              "Cadastrar empresa",
                              style: TextStyle(color: Palette.purple),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Palette.purple),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Align(
                          child: FlatButton(
                            focusColor: Palette.purple.shade50,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => entrarEmpresaPage()));
                            },
                            child: Text(
                              "Entrar em uma empresa existente",
                              style: TextStyle(color: Palette.purple),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Palette.purple),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Widget confereUsuarioChefeEmpregado() {
    return user.usuario_empregado == 1
        ? showEmpresaFuncionario()
        : showEmpresa();
  }

  Widget showEmpresa() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Align(
        child: Container(
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  emp.nome,
                  style: TextStyle(fontFamily: 'Orbitron', fontSize: 40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: null,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => dadosEmpresaPage()));
                            },
                            icon: Icon(
                              Icons.info_outline,
                              color: Palette.purple,
                            ),
                            label: Text(
                              "Dados da empresa",
                              style: TextStyle(
                                  color: Palette.purple, fontSize: 15),
                            ))),
                    TextButton(
                        onPressed: null,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      listaFuncionariosPage()));
                            },
                            icon: Icon(
                              Icons.list_alt,
                              color: Palette.purple,
                            ),
                            label: Text(
                              "Funcionários",
                              style: TextStyle(
                                  color: Palette.purple, fontSize: 15),
                            ))),
                  ],
                ),
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
    );
  }

  Widget showEmpresaFuncionario() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Align(
        child: Container(
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpKMW8aqrxdeG_x6rbDAO5A8tHgQxyHVw37A&usqp=CAU',
                  width: 100.0,
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => dadosEmpresaPage()));
                            },
                            icon: Icon(
                              Icons.list_alt,
                              color: Palette.purple,
                            ),
                            label: Text(
                              "Dados da empresa",
                              style: TextStyle(
                                  color: Palette.purple, fontSize: 20),
                            ))),
                  ],
                ),
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
}
