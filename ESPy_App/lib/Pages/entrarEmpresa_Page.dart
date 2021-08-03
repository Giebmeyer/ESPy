import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'inicial_Page.dart';
import 'login_Page.dart';

class entrarEmpresaPage extends StatefulWidget {
  @override
  _entrarEmpresaPageState createState() => _entrarEmpresaPageState();
}

class _entrarEmpresaPageState extends State<entrarEmpresaPage> {
//==============================================================================
  String msgErro = '';
  bool erro, showProgress;

//==============================================================================
  bool erroEmpresa, erroRequestSensores, jaCarregouDados;

  var numero_1 = FocusNode();
  var numero_2 = FocusNode();
  var numero_3 = FocusNode();
  var numero_4 = FocusNode();
  var numero_5 = FocusNode();
  var numero_6 = FocusNode();
  var next_botao = FocusNode();
  var chaveConvite = '';
  var n1 = '';
  var n2 = '';
  var n3 = '';
  var n4 = '';
  var n5 = '';
  var n6 = '';

//==============================================================================

  @override
  void initState() {
    erroEmpresa = false;
    showProgress = false;
    jaCarregouDados = false;
    super.initState();
  }

//==============================================================================
  void _coletaDadosEmpresa() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaDadosEmpresa.php'),
      body: {"codigoUsuario": user.codigo.toString()},
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["errorEmpresa"]) {
        setState(() {
          showProgress = false;
          erroEmpresa = true;
          msgErro = jsondata["messagemEmpresa"];
          showCaixaDialogoSimples(context, msgErro);
        });
      } else {
        if (jsondata["sucessoEmpresa"]) {
          emp.codigo = jsondata['codigo'];
          emp.chaveConvite = jsondata['chaveConvite'];
          emp.nome = jsondata['nome'];
          emp.CEO = jsondata['ceo'];
          emp.email_ceo = jsondata['email_ceo'];
          emp.telefone = jsondata['telefone'];
          emp.cnpj = jsondata['cnpj'];
          emp.estado = jsondata['estado'];
          emp.cidade = jsondata['cidade'];
          emp.bairro = jsondata['bairro'];
          emp.rua = jsondata['rua'];
          emp.numero = jsondata['numero'];
          emp.complemento = jsondata['complemento'];
          emp.qtdFuncionarios = jsondata['qtdFuncionarios'];
          setState(() {
            possuiEmpresa = true;
            erroEmpresa = false;
            showProgress = true;
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => inicialPage()),
                (Route<dynamic> route) => false);
          });

          showCaixaDialogoSimples(context, msgErro);
        } else {
          showProgress = false;
          erroEmpresa = true;
          msgErro = "Algo deu errado.";
          showCaixaDialogoSimples(context, msgErro);
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
//==============================================================================

  _AjustaDadosUsuario() async {
    user.usuario_empregado = 1;
    user.usuario_chefe = 0;

    _coletaDadosEmpresa();
  }

//==============================================================================
  void _entrarEmpresa() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_entrarEmpresa.php'),
      body: {
        "chaveConvite": chaveConvite,
        "codigoUsuario": user.codigo.toString(),
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
            msgErro = jsondata["mensagemEntrarEmpresa"];
            _AjustaDadosUsuario();
          });
        } else {
          showProgress = false;
          erroEmpresa = true;
          msgErro = "Algo deu errado.";
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

//==============================================================================
  _focusNodeChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

//==============================================================================
  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: TextFormField(
                          focusNode: numero_1,
                          autofocus: true,
                          showCursor: false,
                          onChanged: (numero1) {
                            n1 = numero1;
                            _focusNodeChange(context, numero_1, numero_2);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
//==============================================================================
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: TextFormField(
                          showCursor: false,
                          focusNode: numero_2,
                          onChanged: (numero2) {
                            n2 = numero2;

                            _focusNodeChange(context, numero_2, numero_3);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
//==============================================================================
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: TextFormField(
                          showCursor: false,
                          focusNode: numero_3,
                          onChanged: (numero3) {
                            n3 = numero3;

                            _focusNodeChange(context, numero_3, numero_4);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
//==============================================================================
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: TextFormField(
                          showCursor: false,
                          focusNode: numero_4,
                          onChanged: (numero4) {
                            n4 = numero4;

                            _focusNodeChange(context, numero_4, numero_5);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
//==============================================================================
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: TextFormField(
                          showCursor: false,
                          focusNode: numero_5,
                          onChanged: (numero5) {
                            n5 = numero5;

                            _focusNodeChange(context, numero_5, numero_6);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
//==============================================================================
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: TextFormField(
                          showCursor: false,
                          onChanged: (numero6) {
                            n6 = numero6;
                            _focusNodeChange(context, numero_6, next_botao);
                          },
                          focusNode: numero_6,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
//==============================================================================
                Align(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FlatButton(
                      focusNode: next_botao,
                      focusColor: Palette.purple.shade50,
                      onPressed: () {
                        chaveConvite = n1 + n2 + n3 + n4 + n5 + n6;
                        _entrarEmpresa();
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
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
