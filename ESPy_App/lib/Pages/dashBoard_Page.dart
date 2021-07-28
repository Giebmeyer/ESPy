import 'dart:convert';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  List _dados = [1, 2, 3, 4, 5];

  void coletaDadosSensores() async {
    print('sensor.sequencia');
    var response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_requestSensores.php'),
      body: {"codigoEmpresa": '1'},
    );

    /* var _dados = json.decode(response.body); */
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

/*       sensor.sequencia = jsondata['sequencia'];
      sensor.Umidade_DHT11 = jsondata['Umidade_DHT11'];
      sensor.Temperatura_DHT11 = jsondata['Temperatura_DHT11'];
      sensor.Temperatura_BMP180 = jsondata['Temperatura_BMP180'];
      sensor.Pressao_BMP180 = jsondata['Pressao_BMP180'];
      sensor.Altitude_BMP180 = jsondata['Altitude_BMP180'];
      sensor.CO_MICS = jsondata['CO_MICS'];
      sensor.NO2_MICS = jsondata['NO2_MICS'];
      sensor.NH3_MICS = jsondata['NH3_MICS']; */
    }
  }

  @override
  void initState() {
    super.initState();
    coletaDadosSensores();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//==============================================================================]
