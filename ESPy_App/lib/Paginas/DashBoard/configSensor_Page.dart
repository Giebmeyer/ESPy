import 'dart:convert';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class configSensor extends StatefulWidget {
  @override
  _configSensorState createState() => _configSensorState();
}

class _configSensorState extends State<configSensor> {
  TextEditingController tempoColeta = new TextEditingController();

//==============================================================================
  String msgErro = '';
  bool erro, showProgress, confirmaAlteracoes;
  List data;
//==============================================================================
  @override
  void initState() {
    erro = false;
    showProgress = false;
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
    super.initState();
  }

//==============================================================================
  void _enviaConfiguracoes() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_configuracoesSensores.php'),
      body: {
        "codigoEmpresa": emp.codigo.toString(),
        "tempoColeta": tempoColeta.text,
        "idCaixa": sensor.codigoCaixa.toString(),
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["sucessoConfiguracao"]) {
        setState(() {
          showProgress = false;
          erro = true;
          msgErro = jsondata["mensagemConfiguracao"];
          showCaixaDialogoRapida(context, msgErro, 'dashBoard', 1);
        });
      } else {
        setState(() {
          showProgress = false;
          erro = true;
        });
        msgErro = jsondata["mensagemConfiguracao"];
        ScaffoldMessenger.of(context).showSnackBar(falhaRealizarAcao);
      }
    } else {
      msgErro = 'Erro ao conectar no servidor';
      showCaixaDialogoSimples(context, msgErro);
      setState(() {
        showProgress = false;
        erro = true;
      });
    }
  }

//==============================================================================
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações dos sensores'),
        centerTitle: true,
      ),
      body: Container(
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
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(115.0),
                    topRight: const Radius.circular(115.0),
                  ),
                ),
                child: Align(
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
                            controller: tempoColeta,
                            decoration: InputDecoration(
                                labelText:
                                    'Tempo entre as coletas (em minutos)',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                            keyboardType: TextInputType.number),
                        SizedBox(height: 10),

//==============================================================================

                        Align(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: FlatButton(
                              onPressed: () {
                                print(tempoColeta.toString());
                                setState(() {
                                  showProgress = true;
                                });
                                showCaixaDialogoAvancada(
                                    context, "Deseja salvar as alterações?");
                              },
                              child: ApresentaProgressoConfig(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Palette.purple)),
                            ),
                          ),
                        ),
//==============================================================================
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
      floatingActionButton: botaoEditarAvisoSensores(),
    );
  }

//==============================================================================
  Widget ApresentaProgressoConfig() {
    return showProgress
        ? SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              backgroundColor: (Palette.purple.shade100),
              valueColor: AlwaysStoppedAnimation<Color>(Palette.purple),
            ),
          )
        : Text(
            "Salvar",
            style: TextStyle(color: Palette.purple),
          );
  }

  Widget botaoEditarAvisoSensores() {
    return SizedBox(
      width: 45,
      height: 45,
      child: FloatingActionButton(
        heroTag: "Editar Empresa",
        backgroundColor: Palette.purple,
        onPressed: () {
          showCaixaDialogoSimples(context,
              "As edições enviadas só serão aplicadas após a proxima coleta realizada");
        },
        child: Icon(Icons.warning),
      ),
    );
  }

  void confirmaExpulsaoFuncao() {
    if (confirmaAlteracoes == true) {
      _enviaConfiguracoes();
      Navigator.of(context).pop();
    } else {
      setState(() {
        showProgress = false;
      });
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
              confirmaAlteracoes = false;
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
              confirmaAlteracoes = true;
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

//==============================================================================

