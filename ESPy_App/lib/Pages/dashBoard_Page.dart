import 'dart:convert';

import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as Charts;

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

//==============================================================================
  List<sensores> fromJson(String strJson) {
    final data = jsonDecode(strJson);
    return List<sensores>.from(data.map((i) => sensores.fromJson(i)));
  }

//==============================================================================
  List<sensores> dados = [];
  Future<List<sensores>> getData() async {
    List<sensores> list = [];

    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_requestSensores.php'),
      body: {"codigoEmpresa": '1'},
    );

    if (response.statusCode == 200) {
      list = fromJson(response.body);
    }
    return list;
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> dht11_Temperatura_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'dht11_Temperatura_barra',
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
          measureFn: (sensores sensor, _) => sensor.Pressao_BMP180,
          data: dados)
    ];
  }

//==============================================================================
  static List<Charts.Series<sensores, String>> bmp180_Temperatura_barra(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, String>(
          id: 'bmp180_Temperatura_barra',
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
          domainFn: (sensores sensor, _) => sensor.sequencia.toString(),
          measureFn: (sensores sensor, _) => sensor.MICS_NH3,
          data: dados)
    ];
  }

//==============================================================================
//==============================================================================
//==============================================================================

  static List<Charts.Series<sensores, int>> dht11_Temperatura_linha(
      List<sensores> dados) {
    return [
      Charts.Series<sensores, int>(
          id: 'dht11_Temperatura_linha',
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
          colorFn: (_, __) => Charts.MaterialPalette.purple.shadeDefault,
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
    getData().then((value) => dados = value);
    super.initState();
  }

//==============================================================================
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.restart_alt),
              onPressed: () {
                setState(() {
                  getData().then((value) => dados = value);
                });
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.insert_chart),
              ),
              Tab(
                icon: Icon(Icons.show_chart),
              ),
            ],
          ),
          title: const Text('DashBoard'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: <Widget>[graficosBarra(), graficosLinha()],
        ),
        floatingActionButton: botaoCalendario(),
      ),
    );
  }

  Widget graficosBarra() {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              dht11_Temperatura_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('DHT11: Temperatura')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              dht11_Umidade_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('DHT11: Umidade')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              bmp180_Altitude_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('DHT11: Altitude')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              bmp180_PressaoATM_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('BMP180: Pressão Atmosferica')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              bmp180_Temperatura_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('BMP180: Temperatura')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              MICS_CO_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('MICS: Monóxido de carbono')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              MICS_NH3_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('MICS: Hidróxido de amônia')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.BarChart(
              MICS_NO2_barra(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('MICS: Dióxido de nitrogênio')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
        ],
      ),
    );
  }

  Widget graficosLinha() {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              dht11_Temperatura_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('DHT11: Temperatura')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              dht11_Umidade_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('DHT11: Umidade')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              bmp180_Altitude_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('DHT11: Altitude')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              bmp180_PressaoATM_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('BMP180: Pressão Atmosferica')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              bmp180_Temperatura_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('BMP180: Temperatura')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              MICS_CO_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('MICS: Monóxido de carbono')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              MICS_NH3_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('MICS: Hidróxido de amônia')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Charts.LineChart(
              MICS_NO2_linha(dados),
              animate: true,
              behaviors: [Charts.ChartTitle('MICS: Dióxido de nitrogênio')],
            ),
            decoration: myBoxDecoration(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//==============================================================================
        ],
      ),
    );
  }
}
