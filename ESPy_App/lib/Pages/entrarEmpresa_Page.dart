import 'dart:convert';

import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class entrarEmpresaPage extends StatefulWidget {
  @override
  _entrarEmpresaPageState createState() => _entrarEmpresaPageState();
}

class _entrarEmpresaPageState extends State<entrarEmpresaPage> {
  TextEditingController chaveConvite = new TextEditingController();
//==============================================================================
  String msgErro = '';
  bool erroEntrarEmpresa, showProgress;

//==============================================================================
  @override
  void initState() {
    erroEntrarEmpresa = false;
    showProgress = false;
    super.initState();
  }

//==============================================================================
  bool erroEmpresa, erroRequestSensores, jaCarregouDados;

  void _entrarEmpresa() async {
    final response = await http.post(
      Uri.parse('http://192.168.66.109/ESPy/ESPy_MySql/ESPy_entrarEmpresa.php'),
      body: {
        "chaveConvite": chaveConvite,
        "codigoUsuario": user.codigo,
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["erroEntrarEmpresa"]) {
        setState(() {
          showProgress = false;
          erroEmpresa = true;
          msgErro = jsondata["mensagemEntrarEmpresa"];
          showCaixaDialogoSimples(context, msgErro);
        });
      } else {
        if (jsondata["sucessoEntrarEmpresa"]) {
          setState(() {
            erroEmpresa = false;
            showProgress = true;
          });
          msgErro = jsondata["mensagemEntrarEmpresa"];
          showCaixaDialogoSimples(context, msgErro);
        } else {
          showProgress = false;
          erroEmpresa = true;
          msgErro = "Algo deu errado.";
          print(msgErro);
        }
      }
    } else {
      setState(() {
        showProgress = false;
        erroEmpresa = true;
        msgErro = "Erro na conexão com o servidor.";
        showCaixaDialogoSimples(context, msgErro);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Junta-se a uma empresa'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.97,
            child: ListView(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.40,
                    alignment: Alignment.center,
                    child: Image.asset('assents/imagens/Logo.png'),
                  ),
                ),
//==============================================================================
                TextFormField(
                  controller: chaveConvite,
                  decoration: InputDecoration(
                      labelText: 'Chave da empresa',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
//==============================================================================
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: FlatButton(
                    onPressed: () {
                      _entrarEmpresa;
                      print(chaveConvite);
                    },
                    child: Text(
                      "Entrar",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Palette.purple, fontSize: 13.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Palette.purple),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
