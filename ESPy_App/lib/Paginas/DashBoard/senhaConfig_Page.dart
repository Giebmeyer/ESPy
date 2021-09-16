import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:ESPy/Paginas/DashBoard/configSensor_Page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

var primeiroNome;

class senhaConfig extends StatefulWidget {
  @override
  State<senhaConfig> createState() {
    return _senhaConfigState();
  }
}

class _senhaConfigState extends State<senhaConfig> {
  var numero_1 = FocusNode();
  var numero_2 = FocusNode();
  var numero_3 = FocusNode();
  var numero_4 = FocusNode();
  var numero_5 = FocusNode();
  var numero_6 = FocusNode();
  var next_botao = FocusNode();
  var senha = '';
  var n1 = '';
  var n2 = '';
  var n3 = '';
  var n4 = '';
  var n5 = '';
  var n6 = '';

  _focusNodeChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digite a senha'),
        centerTitle: true,
      ),
      body: showBody(),
      floatingActionButton: botaoAviso(),
    );
  }

  Widget showBody() {
    return Center(
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
                      textAlign: TextAlign.center,
                      focusNode: numero_1,
                      autofocus: false,
                      showCursor: false,
                      onChanged: (numero1) {
                        n1 = numero1;
                        _focusNodeChange(context, numero_1, numero_2);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
//==============================================================================
                  Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      showCursor: false,
                      focusNode: numero_2,
                      onChanged: (numero2) {
                        n2 = numero2;

                        _focusNodeChange(context, numero_2, numero_3);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
//==============================================================================
                  Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      showCursor: false,
                      focusNode: numero_3,
                      onChanged: (numero3) {
                        n3 = numero3;

                        _focusNodeChange(context, numero_3, numero_4);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
//==============================================================================
                  Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      showCursor: false,
                      focusNode: numero_4,
                      onChanged: (numero4) {
                        n4 = numero4;

                        _focusNodeChange(context, numero_4, numero_5);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
//==============================================================================
                  Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      showCursor: false,
                      focusNode: numero_5,
                      onChanged: (numero5) {
                        n5 = numero5;

                        _focusNodeChange(context, numero_5, numero_6);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
//==============================================================================
                  Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      showCursor: false,
                      onChanged: (numero6) {
                        n6 = numero6;
                        _focusNodeChange(context, numero_6, next_botao);
                      },
                      focusNode: numero_6,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
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
                    senha = n1 + n2 + n3 + n4 + n5 + n6;
                    confereSenha();
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
    );
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Palette.purple.shade200, Palette.purple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  void confereSenha() {
    if (senha == emp.chaveConvite.toString()) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => configSensor()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(erroSenha);
    }
  }

  Widget botaoAviso() {
    return SizedBox(
      width: 45,
      height: 45,
      child: FloatingActionButton(
        heroTag: "Aviso de senha",
        backgroundColor: Palette.purple,
        onPressed: () {
          showCaixaDialogoSimples(context,
              "A senha de acesso as configurações é a chave de convite da sua empresa");
        },
        child: Icon(Icons.warning),
      ),
    );
  }
}
