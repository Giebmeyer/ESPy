import 'dart:convert';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/main.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

var tipoGraficoSelecionado = 1; //1 tempo real; 2 historico; 3 filtrado

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  //==============================================================================
  TextEditingController dataSelecionadaAtual = TextEditingController();
  TextEditingController dataSelecionadaAnterior = TextEditingController();

  var dataInicial = DateFormat("y-MM-d", "pt_BR").format(DateTime.now());
  var dataFinal = DateFormat("y-MM-d", "pt_BR").format(DateTime.now());

  String _titulo = 'Dashboard | ' + sensor.nomeCaixa;

  bool showProgress = false;
  botaoAtualizar botaoAtt;

//==============================================================================
  List<sensores> fromJson(String strJson) {
    final data = jsonDecode(strJson);
    return List<sensores>.from(data.map((i) => sensores.fromJson(i)));
  }

//==============================================================================
  List<sensores> dados = [];
  Future<List<sensores>> getData_Filtrada() async {
    List<sensores> list = [];

    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_requestSensoresFiltro.php'),
      body: {
        "codigoEmpresa": emp.codigo.toString(),
        "codigoCaixa": sensor.codigoCaixa.toString(),
        "dataInicial": dataInicial.toString(),
        "dataFinal": dataFinal.toString()
      },
    );

    if (response.statusCode == 200) {
      list = fromJson(response.body);
      setState(() {
        print(emp.codigo.toString());
        showProgress = false;
      });
    } else {
      showProgress = true;
    }
    return list;
  }

  Future<List<sensores>> getData_TempoReal() async {
    List<sensores> list = [];

    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_requestSensoresTempoReal.php'),
      body: {
        "codigoEmpresa": emp.codigo.toString(),
        "codigoCaixa": sensor.codigoCaixa.toString(),
      },
    );

    if (response.statusCode == 200) {
      list = fromJson(response.body);
      sensor.qtdDados = list.length;

      if (list.length == 0) {
        print("Sem dados...");
      }

      setState(() {
        showProgress = false;
      });
    } else {
      showProgress = true;
    }
    return list;
  }

  Future<List<sensores>> getData_Historico() async {
    List<sensores> list = [];

    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_requestSensoresHistorico.php'),
      body: {
        "codigoEmpresa": emp.codigo.toString(),
        "codigoCaixa": sensor.codigoCaixa.toString(),
      },
    );

    if (response.statusCode == 200) {
      list = fromJson(response.body);
      setState(() {
        showProgress = false;
      });
    } else {
      showProgress = true;
    }
    return list;
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> IDK_barra(List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'IDK_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.IDK,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> dht11_Temperatura_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'dht11_Temperatura_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.Temperatura_DHT11,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> dht11_Umidade_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'dht11_Umidade_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.Umidade_DHT11,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> bmp180_Altitude_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'bmp180_Altitude_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.Altitude_BMP180,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> bmp180_PressaoATM_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'bmp180_PressaoATM_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.Pressao_BMP180,
          data: dados),
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> bmp180_Temperatura_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'bmp180_Temperatura_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.Temperatura_BMP180,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> MICS_CO_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'MICS_CO_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.MICS_CO,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> MICS_NO2_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'MICS_NO2_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.MICS_NO2,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> MICS_NH3_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'MICS_NH3_barra',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.data,
          measureFn: (sensores sensor, _) => sensor.MICS_NH3,
          data: dados)
    ];
  }

//==============================================================================
//==============================================================================
//==============================================================================

  static List<Charts.Series<sensores, int>> IDK_linha(List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'IDK_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.IDK,
          data: dados)
    ];
  }

//==============================================================================

  static List<Charts.Series<sensores, int>> dht11_Temperatura_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'dht11_Temperatura_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.Temperatura_DHT11,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> dht11_Umidade_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'dht11_Umidade_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.Umidade_DHT11,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> bmp180_Altitude_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'bmp180_Altitude_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.Altitude_BMP180,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> bmp180_PressaoATM_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'bmp180_PressaoATM_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.Pressao_BMP180,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> bmp180_Temperatura_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'bmp180_Temperatura_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.Temperatura_BMP180,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> MICS_CO_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'MICS_CO_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.MICS_CO,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> MICS_NO2_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'MICS_NO2_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.MICS_NO2,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, int>> MICS_NH3_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'MICS_NH3_linha',
          colorFn: (_, __) => Charts.ColorUtil.fromDartColor(Palette.purple),
          domainFn: (sensores sensor, _) => sensor.sequencia,
          measureFn: (sensores sensor, _) => sensor.MICS_NH3,
          data: dados)
    ];
  }

//==============================================================================
//==============================================================================
//==============================================================================

  @override
  void initState() {
    showProgress = true;
    attTelaGrafico();
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
    ApresentaProgressoDashBoard();

    super.initState();
  }

//==============================================================================
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          title: Text(_titulo),
          centerTitle: true,
          backgroundColor: Palette.purple,
          actions: [
            IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.restart_alt),
              onPressed: () {
                setState(() {
                  attTelaGrafico();
                });
              },
            ),
          ],
          bottom: TabBar(
            indicator: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple]),
                borderRadius: BorderRadius.circular(20)),
            tabs: [
              Tab(
                child: Icon(Icons.bar_chart),
              ),
              Tab(
                child: Icon(Icons.show_chart),
              ),
            ],
          ),
        ),
        body: ApresentaProgressoDashBoard(),
        floatingActionButton: buildSpeedDial(),
      ),
    );
  }

  Widget bodyGraficos() {
    return TabBarView(
      children: <Widget>[graficosBarra(), graficosLinha()],
    );
  }

  Widget graficosBarra() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                IDK_barra(dados),
                animate: true,
                behaviors: [
                  new Charts.ChartTitle('??ndice de qualidade'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'IDK',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                  new Charts.ChartTitle(' ',
                      behaviorPosition: Charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          Charts.OutsideJustification.middleDrawArea),
                  new Charts.RangeAnnotation([
                    new Charts.RangeAnnotationSegment(
                      0,
                      55,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Estresse devido ao frio',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade200,
                    ),
                    new Charts.RangeAnnotationSegment(
                      55,
                      60,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Desconforto devido ao frio',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade300,
                    ),
                    new Charts.RangeAnnotationSegment(
                      60,
                      75,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Confort??vel',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade500,
                    ),
                    new Charts.RangeAnnotationSegment(
                      75,
                      80,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Desconforto devido ao calor',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade300,
                    ),
                    new Charts.RangeAnnotationSegment(
                      80,
                      100,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Estresse devido ao calor',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade200,
                    ),
                  ])
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                dht11_Temperatura_barra(dados),
                animate: true,
                behaviors: [
                  new Charts.ChartTitle('DHT11: Temperatura'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    '??C',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                  new Charts.ChartTitle(' ',
                      behaviorPosition: Charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          Charts.OutsideJustification.middleDrawArea),
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                dht11_Umidade_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('DHT11: Umidade'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    '%',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                  new Charts.ChartTitle(' ',
                      behaviorPosition: Charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          Charts.OutsideJustification.middleDrawArea),
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                bmp180_Altitude_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('DHT11: Altitude'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                  new Charts.ChartTitle(' ',
                      behaviorPosition: Charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          Charts.OutsideJustification.middleDrawArea),
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                bmp180_PressaoATM_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('BMP180: Press??o Atmosferica'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ATM',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                bmp180_Temperatura_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('BMP180: Temperatura'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    '??C',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                MICS_CO_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('MICS: Mon??xido de carbono'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ppm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                MICS_NH3_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('MICS: Hidr??xido de am??nia'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ppm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.BarChart(
                MICS_NO2_barra(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('MICS: Di??xido de nitrog??nio'),
                  new Charts.SlidingViewport(),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ppm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          ],
        ),
      ),
    );
  }

  Widget graficosLinha() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                IDK_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('??ndice de qualidade'),
                  /*   new Charts.SlidingViewport(), */
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'IDK',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  ),
                  new Charts.RangeAnnotation([
                    new Charts.RangeAnnotationSegment(
                      0,
                      55,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Estresse devido ao frio',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade200,
                    ),
                    new Charts.RangeAnnotationSegment(
                      55,
                      60,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Desconforto devido ao frio',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade300,
                    ),
                    new Charts.RangeAnnotationSegment(
                      60,
                      75,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Confort??vel',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade400,
                    ),
                    new Charts.RangeAnnotationSegment(
                      75,
                      80,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Desconforto devido ao calor',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade300,
                    ),
                    new Charts.RangeAnnotationSegment(
                      80,
                      100,
                      Charts.RangeAnnotationAxisType.measure,
                      middleLabel: 'Estresse devido ao calor',
                      labelAnchor: Charts.AnnotationLabelAnchor.end,
                      color: Charts.MaterialPalette.gray.shade200,
                    ),
                  ])
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                dht11_Temperatura_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('DHT11: Temperatura'),
                  /*   new Charts.SlidingViewport(), */
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    '??C',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                dht11_Umidade_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('DHT11: Umidade'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    '%',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                bmp180_Altitude_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('BMP180: Altitude'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                bmp180_PressaoATM_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('BMP180: Press??o Atmosferica'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ATM',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                bmp180_Temperatura_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('BMP180: Temperatura'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    '??C',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                MICS_CO_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('MICS: Mon??xido de carbono'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ppm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                MICS_NH3_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('MICS: Hidr??xido de am??nia'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ppm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Charts.LineChart(
                MICS_NO2_linha(dados),
                animate: true,
                behaviors: [
                  Charts.ChartTitle('MICS: Di??xido de nitrog??nio'),
                  new Charts.PanAndZoomBehavior(),
                  new Charts.ChartTitle(
                    'ppm',
                    behaviorPosition: Charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        Charts.OutsideJustification.middleDrawArea,
                  )
                ],
              ),
              decoration: myBoxDecoration(1.0, 10.0, Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          ],
        ),
      ),
    );
  }

  Widget ApresentaProgressoDashBoard() {
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
        : bodyGraficos();
  }

  Future<Null> selectcDate(BuildContext context) async {
    DateTime date = DateTime.now();
    DateTime dataFinalEscolhida;

    final DateTime dataInicialEscolhida = await showDatePicker(
      cancelText: "Cancelar",
      confirmText: "Pr??ximo",
      helpText: "Data inicial",
      context: context,
      initialDate: date,
      firstDate: DateTime(1990),
      lastDate: date,
    );

    if (dataInicialEscolhida != null) {
      dataFinalEscolhida = await showDatePicker(
        cancelText: "Cancelar",
        confirmText: "Filtrar",
        helpText: "Data final",
        context: context,
        initialDate: date,
        firstDate: dataInicialEscolhida,
        lastDate: date,
      );
    }

    if (dataFinalEscolhida != null && dataInicialEscolhida != null) {
      setState(() {
        showProgress = true;
        tipoGraficoSelecionado = 3;
        dataInicial =
            DateFormat("y-MM-d", "pt_BR").format(dataInicialEscolhida);
        dataFinal = DateFormat("y-MM-d", "pt_BR").format(dataFinalEscolhida);
        getData_Filtrada().then((value) => dados = value);
      });
    }
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: Palette.purple,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(CupertinoIcons.eye_fill, color: Colors.white),
          backgroundColor: Palette.purple.shade900,
          onTap: () {
            setState(() {
              tipoGraficoSelecionado = 1;
              showProgress = true;
              getData_TempoReal().then((value) => dados = value);
            });
          },
          label: 'Tempo Real',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        SpeedDialChild(
          child: Icon(Icons.history, color: Colors.white),
          backgroundColor: Palette.purple.shade700,
          onTap: () {
            setState(() {
              tipoGraficoSelecionado = 2;
              showProgress = true;
              getData_Historico().then((value) => dados = value);
            });
          },
          label: 'Hist??rico',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        SpeedDialChild(
          child: Icon(Icons.calendar_today, color: Colors.white),
          backgroundColor: Palette.purple.shade500,
          onTap: () {
            setState(() {
              FocusScope.of(context).requestFocus(new FocusNode());
              selectcDate(context);
            });
          },
          label: 'Filtro',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }

  void attTelaGrafico() {
    if (tipoGraficoSelecionado == 1) {
      getData_TempoReal().then((value) => dados = value);
    } else if (tipoGraficoSelecionado == 2) {
      getData_Historico().then((value) => dados = value);
    } else if (tipoGraficoSelecionado == 3) {
      getData_Filtrada().then((value) => dados = value);
    } else {}
  }
}
