import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future coletaDadosSensores() async {
      var response = await http.post(
        Uri.parse(
            'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_requestSensores.php'),
        body: {"codigoEmpresa": emp.codigo.toString()},
      );

      var jsondata = json.decode(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Painel de controle'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: coletaDadosSensores(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return ListTile(
                                title: Text(list[index]['sequencia']),
                              );
                            })
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                )),
          );
        },
      ),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

//==============================================================================]

}
