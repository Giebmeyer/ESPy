import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Pages/cadastroEmpresa_Page.dart';
import 'package:ESPy/Pages/entrarEmpresa_Page.dart';
import 'package:flutter/material.dart';
import 'dadosEmpresa_Page.dart';
import 'home_Page.dart';
import 'listaFuncionario_Page.dart';
import 'login_Page.dart';

class EmpresaPage extends StatefulWidget {
  @override
  _EmpresaPgeState createState() => _EmpresaPgeState();
}

class _EmpresaPgeState extends State<EmpresaPage> {
//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Empresa"),
        centerTitle: true,
      ),
      body: Empresa(),
    );
  }

  Widget Empresa() {
    return possuiEmpresa ? confereUsuarioChefeEmpregado() : showErroEmpresa();
  }

  Widget showErroEmpresa() {
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
                topLeft: const Radius.circular(300.0),
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
      /* padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), */
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
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
              topLeft: const Radius.circular(300.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget showEmpresaFuncionario() {
    return Container(
      /* padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), */
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
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
                  'https://image.flaticon.com/icons/png/512/181/181548.png',
                  width: 100.0,
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            icon: Icon(
                              Icons.list_alt,
                              color: Palette.purple,
                            ),
                            label: Text(
                              "Dados da empresa",
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
              topLeft: const Radius.circular(300.0),
            ),
          ),
        ),
      ),
    );
  }
}
