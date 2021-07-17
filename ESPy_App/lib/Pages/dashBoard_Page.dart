import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';

import 'package:ESPy/Funcoes/BD.dart';
import 'package:flutter/material.dart';

import 'package:mysql1/mysql1.dart';
import 'package:fl_chart/fl_chart.dart';

Results quantidadeResultados;
var DHT11_Temperatura = [];
var data = [0.0, 0.1, 0.2, 0.3, 0.4];

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          new Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Sensor DHT11: Temperatura",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(spots: [
                                FlSpot(data[1], 1),
                                FlSpot(data[2], 2),
                                FlSpot(data[3], 3),
                              ])
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    ));
  }

//==============================================================================]

  requestDHT11_Temperatura() {
    var db = new Mysql();

    db.getConnection().then((conn) {
      conn.query("select Temperatura_DHT11 from dados;").then(((results) {
        for (var row in results) {
          int ii = row.length;
          for (int i = 0; i < ii; i++) {
            DHT11_Temperatura[i] = row.values;
          }
        }
        conn.close();
      }));
    });
  }
}
