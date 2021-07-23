import 'dart:convert';

import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Pages/login_Page.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _cadastroUserPageState();
  }
}

class _cadastroUserPageState extends State<CadastroUserPage> {
  void initState() {
    dropdownValueEstado = 'PR';
    super.initState();
  }

//==============================================================================
  TextEditingController nome = new TextEditingController();
  TextEditingController senha = new TextEditingController();
  TextEditingController confirmacaoSenha = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController cpf = new TextEditingController();
  TextEditingController telefone = new TextEditingController();
  TextEditingController estado = new TextEditingController();
  TextEditingController cidade = new TextEditingController();
  TextEditingController bairro = new TextEditingController();
  TextEditingController rua = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController complemento = new TextEditingController();

  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

//==============================================================================
  String msgErro = '';
  bool erroCadastro, showProgress;
//==============================================================================

  Future<List> _cadastraUsuario() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_cadastroUsuario.php'),
      body: {
        "nome": nome.text,
        "senha": senha.text,
        "email": email.text,
        "cpf": cpf.text,
        "telefone": telefone.text,
        "estado": dropdownValueEstado,
        "cidade": cidade.text,
        "bairro": bairro.text,
        "rua": rua.text,
        "numero": numero.text,
        "complemento": complemento.text,
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["sucessoCadastroUser"]) {
        setState(() {
          erroCadastro = false;
          msgErro = jsondata["mensagemCadastroUser"];
          showCaixaDialogoSimples(context, msgErro);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        });
      } else {
        setState(() {
          erroCadastro = false;
          msgErro = jsondata["mensagemCadastroUser"];
          showCaixaDialogoSimples(context, msgErro);
        });
      }
    }
  }

//==============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de usuário'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.97,
            child: ListView(
              children: [
                SizedBox(height: 50),
//==============================================================================
                TextField(
                    controller: nome,
                    decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 10),
//==============================================================================
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: TextField(
                              controller: senha,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Senha',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)))),
                        ),
//==================
                        Container(
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: TextField(
                              controller: confirmacaoSenha,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Confirmar senha',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)))),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    inputFormatters: [maskCpf],
                    controller: cpf,
                    decoration: InputDecoration(
                        labelText: 'CPF',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    controller: telefone,
                    decoration: InputDecoration(
                        labelText: 'Telefone',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
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
                              controller: cidade,
                              decoration: InputDecoration(
                                  labelText: 'Cidade',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)))),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    controller: bairro,
                    decoration: InputDecoration(
                        labelText: 'Bairro',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    controller: rua,
                    decoration: InputDecoration(
                        labelText: 'Rua',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    controller: numero,
                    decoration: InputDecoration(
                        labelText: 'Número',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 10),
//==============================================================================
                TextField(
                    controller: complemento,
                    decoration: InputDecoration(
                        labelText: 'Complemento',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
                SizedBox(height: 20),
//==============================================================================
                Align(
                  child: Container(
                    width: 200,
                    child: FlatButton(
                      onPressed: _cadastraUsuario,
                      child: const Text('Enviar'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Palette.purple)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
