import 'dart:convert';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appController.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var primeiroNome;
bool showProgress;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
//==============================================================================
  @override
  void initState() {
    erroEmpresa = false;
    showProgress = false;
    jaCarregouDados = false;
    _coletaDadosEmpresa();
    super.initState();
  }

//==============================================================================
  String msgErro = '';
  bool erroEmpresa, jaCarregouDados;

  void _coletaDadosEmpresa() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_coletaDadosEmpresa.php'),
      body: {"emailUsuario": user.email},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["errorEmpresa"]) {
        setState(() {
          showProgress = false;
          erroEmpresa = true;
          msgErro = jsondata["messagemEmpresa"];
        });
      } else {
        if (jsondata["sucessoEmpresa"]) {
          setState(() {
            erroEmpresa = false;
            showProgress = true;
          });
          emp.codigo = jsondata['codigo'];
          print(emp.codigo);
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
        print(msgErro);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          botaoSair(),
        ],
        title: Text('ESPy'),
        centerTitle: true,
      ),
      body: showBody(),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  Widget showBody() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Container(
        decoration: new BoxDecoration(
            color: Palette.purple,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            )),
        child: Container(
/*           child: textoCentralHomePage(), */
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(150.0),
              )),
        ),
      ),
    );
  }

  Widget textoCentralHomePage() {
    separaPrimeiroNome();
    return Container(
      child: Text(
        "Bem vindo, " + primeiroNome + "!",
        style: TextStyle(
            fontSize: 35.0,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Palette.purple
              ..invertColors = false),
        textAlign: TextAlign.center,
      ),
    );
  }

  void separaPrimeiroNome() {
    var aux = user.nome.split(" ");
    for (int i = 0; i < aux.length; i++) {
      primeiroNome = aux[0];
    }
  }
}
