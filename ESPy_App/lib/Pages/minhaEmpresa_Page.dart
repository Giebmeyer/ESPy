import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Pages/cadastroEmpresa_Page.dart';
import 'package:ESPy/Pages/entrarEmpresa_Page.dart';
import 'package:flutter/material.dart';
import 'login_Page.dart';

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
        title: Text(possuiEmpresa ? emp.nome : "Minha Empresa"),
        centerTitle: true,
      ),
      body: Empresa(),
      /* floatingActionButton: botaoAdicionarEmpresa(), */
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget Empresa() {
    return possuiEmpresa ? showEmpresa() : showErroEmpresa();
  }

  Widget showErroEmpresa() {
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
                      Container(
                        child: Align(
                          child: FlatButton(
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

  Widget showEmpresa() {
    return Container(
      /* padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), */
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
        decoration: new BoxDecoration(),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(emp.CEO),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(300.0),
              ),
            ),
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
