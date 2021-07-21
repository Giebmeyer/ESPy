import 'dart:convert';

import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class cadastroEmpresaPage extends StatefulWidget {
  @override
  _cadastroEmpresaState createState() => _cadastroEmpresaState();
}

class _cadastroEmpresaState extends State<cadastroEmpresaPage> {
  String msgErro = '';
  bool erroCadastroEmpresa, showProgress, sucesso;

  TextEditingController _nome = new TextEditingController();
  TextEditingController _ceo = new TextEditingController();
  TextEditingController _telefone = new TextEditingController();
  TextEditingController _cpf_cnpj = new TextEditingController();
  TextEditingController _estado = new TextEditingController();
  TextEditingController _cidade = new TextEditingController();
  TextEditingController _bairro = new TextEditingController();
  TextEditingController _rua = new TextEditingController();
  TextEditingController _numero = new TextEditingController();
  TextEditingController _complemento = new TextEditingController();

  _cadastroEmpresa() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_cadastroEmpresa.php'),
      body: {
        "nome": _nome.text,
        "ceo": _ceo.text,
        "email_ceo": user.email,
        "telefone": _telefone.text,
        "cpf_cnpj": _cpf_cnpj.text,
        "estado": _estado.text,
        "cidade": _cidade.text,
        "bairro": _bairro.text,
        "rua": _rua.text,
        "numero": _numero.text,
        "complemento": _complemento.text,
        "codigoUsuario": user.codigo.toString(),
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["erroCadastroEmpresa"]) {
        msgErro = jsondata["mensagemCadastroEmpresa"];
        showProgress = false;
      } else if (jsondata["sucessoCadastroEmpresa"]) {
        showProgress = false;
        sucesso = true;
      }
    }
  }

  void initState() {
    showProgress = false;
    erroCadastroEmpresa = false;
    sucesso = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de empresa'),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          width: 400,
          child: ListView(children: [
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: _nome,
                decoration: InputDecoration(
                    labelText: 'Nome da empresa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: _ceo,
                decoration: InputDecoration(
                    labelText: 'Nome do CEO da empresa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              controller: _cpf_cnpj,
              decoration: InputDecoration(
                  labelText: 'CPF/CNPJ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              controller: _telefone,
              decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: _estado,
                decoration: InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: _cidade,
                decoration: InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: _bairro,
                decoration: InputDecoration(
                    labelText: 'Bairro',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: _rua,
                decoration: InputDecoration(
                    labelText: 'Rua',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              controller: _numero,
              decoration: InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
//==============================================================================
            TextField(
                controller: _complemento,
                decoration: InputDecoration(
                    labelText: 'Complemento',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 20),
//==============================================================================
            FlatButton(
              onPressed: () {
                setState(() {
                  showProgress = true;
                });
                _cadastroEmpresa();
              },
              child: ApresentaProgresso(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Palette.purple)),
            ),
            SizedBox(height: 50),
//==============================================================================
          ]),
        )));
  }

  Widget ApresentaProgresso() {
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
            "Enviar",
            style: TextStyle(color: Palette.purple),
          );
  }

  showAlertDialog1(BuildContext context, String msgErro) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        return null;
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(msgErro),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
