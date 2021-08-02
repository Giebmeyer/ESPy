import 'dart:convert';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../main.dart';
import 'inicial_Page.dart';
import 'login_Page.dart';

class cadastroEmpresaPage extends StatefulWidget {
  @override
  _cadastroEmpresaState createState() => _cadastroEmpresaState();
}

class _cadastroEmpresaState extends State<cadastroEmpresaPage> {
//==============================================================================
  String msgErro = '';
  bool erroCadastroEmpresa, showProgress, sucesso;
//==============================================================================
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
//==============================================================================
  final maskCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##", filter: {"#": RegExp(r'[0-9]')});

  final maskCell = MaskTextInputFormatter(
      mask: "(##) ####-####", filter: {"#": RegExp(r'[0-9]')});
//==============================================================================
  void _cadastroEmpresa() async {
    var response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_cadastroEmpresa.php'),
      body: {
        "nome": _nome.text,
        "ceo": _ceo.text,
        "email_ceo": user.email,
        "telefone": _telefone.text,
        "cpf_cnpj": _cpf_cnpj.text,
        "estado": dropdownValueEstado,
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
      setState(() {
        showProgress = false;
        sucesso = false;
      });

      if (jsondata["erroCadastroEmpresa"]) {
        msgErro = jsondata["mensagemCadastroEmpresa"];
        showProgress = false;
        showCaixaDialogoSimples(context, msgErro);
      } else if (jsondata["sucessoCadastroEmpresa"]) {
        setState(() {
          msgErro = jsondata["mensagemCadastroEmpresa"];
          showProgress = false;
          sucesso = true;
          _AjustaDadosUsuario();
        });
      }
    }
  }

//==============================================================================
  void _coletaDadosEmpresa() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaDadosEmpresa.php'),
      body: {"codigoUsuario": user.codigo.toString()},
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["errorEmpresa"]) {
        setState(() {
          showProgress = false;
          erroCadastroEmpresa = true;
          msgErro = jsondata["messagemEmpresa"];
          showCaixaDialogoSimples(context, msgErro);
        });
      } else {
        if (jsondata["sucessoEmpresa"]) {
          emp.codigo = jsondata['codigo'];
          emp.chaveConvite = jsondata['chaveConvite'];
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
          setState(() {
            possuiEmpresa = true;
            erroCadastroEmpresa = false;
            showProgress = true;
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => inicialPage()),
                (Route<dynamic> route) => false);
          });

          Scaffold.of(context).showSnackBar(SnackBar(content: Text(msgErro)));
        } else {
          showProgress = false;
          erroCadastroEmpresa = true;
          msgErro = "Algo deu errado.";
          showCaixaDialogoSimples(context, msgErro);
        }
      }
    } else {
      setState(() {
        showProgress = false;
        erroCadastroEmpresa = true;
        msgErro = "Erro na conexão com o servidor.";
        showCaixaDialogoSimples(context, msgErro);
      });
    }
  }
//==============================================================================

  _AjustaDadosUsuario() async {
    user.usuario_empregado = 0;
    user.usuario_chefe = 1;

    _coletaDadosEmpresa();
  }

//==============================================================================
  void initState() {
    showProgress = false;
    erroCadastroEmpresa = false;
    sucesso = false;
    super.initState();
  }

//==============================================================================
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
              inputFormatters: [maskCNPJ],
              controller: _cpf_cnpj,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'CPF/CNPJ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              inputFormatters: [maskCell],
              controller: _telefone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
            SizedBox(height: 10),
//==============================================================================
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: dropDownEstados(),
                    ),
//==================
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextField(
                          controller: _cidade,
                          decoration: InputDecoration(
                              labelText: 'Cidade',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)))),
                    ),
                  ],
                ),
              ],
            ),
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            Align(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                child: FlatButton(
                  focusColor: Palette.purple.shade50,
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
              ),
            ),
            SizedBox(height: 10),
//==============================================================================
          ]),
        )));
  }

//==============================================================================
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
}
