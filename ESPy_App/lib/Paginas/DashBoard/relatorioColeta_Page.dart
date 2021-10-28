import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../main.dart';

class relatorioColeta extends StatefulWidget {
  @override
  _listaRelatorioPageState createState() => _listaRelatorioPageState();
}

bool confirmaExpulsao;

class _listaRelatorioPageState extends State<relatorioColeta> {
  @override
//==============================================================================
  bool showProgress;
  String msgErro;
  List data;
  var sendFormCOD = 0;
//==============================================================================

  void _coletaRelatorioColetas() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_requestSensoresRelatorio.php'),
      body: {
        "codigoEmpresa": emp.codigo.toString(),
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      this.setState(() {
        data = json.decode(response.body);
        setState(() {
          showProgress = false;
        });
      });
    } else {
      showCaixaDialogoSimples(context, "Nao foi possivel conectar-se.");
    }
  }

  @override
  void initState() {
    super.initState();
    showProgress = true;
    this._coletaRelatorioColetas();
  }

  @override
  void atualizarTela() {
    setState(() {
      showProgress = true;
      this._coletaRelatorioColetas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Relatório de Coletas"),
        centerTitle: true,
        actions: [botaoAtualizar()],
      ),
      body: caixas(),
    );
  }

  Widget caixas() {
    if (data == null || data.length == 0) {
      return ApresentaProgressoRelatorioColeta();
    } else {
      return showRelatorioColeta();
    }
  }

  Widget showRelatorioColeta() {
    return Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            padding: const EdgeInsets.only(
              top: 32.0,
            ),
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
                String _dataColeta = data[index]["Data_Hora"];
                String _dataFomartada =
                    DateFormat(" d/MM/y \n hh:mm:ss", "pt_BR")
                        .format(DateTime.parse(_dataColeta));
                return new Card(
                  color: Colors.grey.shade200,
                  margin: EdgeInsetsDirectional.fromSTEB(35.0, 30.0, 35.0, 00),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 170,
                            child: Text(
                              "Caixa: " + data[index]["nome"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Container(
                            width: 170,
                            child: Text(
                              "ID #" + data[index]["codigo"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 170,
                            child: Text(
                              "IDK: " + data[index]["IDK"],
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 85,
                        child: Text(
                          _dataFomartada,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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

  Widget showErrorEmpresaSemDados() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sua empresa ainda não possui nenhum dado coletado.",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
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

  Widget ApresentaProgressoRelatorioColeta() {
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
        : showErrorEmpresaSemDados();
  }
}
