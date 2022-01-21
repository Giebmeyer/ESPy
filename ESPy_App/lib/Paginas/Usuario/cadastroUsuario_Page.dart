import 'dart:convert';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/EnviaEmail.dart';
import 'package:ESPy/Funcoes/appValidator.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _cadastroUserPageState();
  }
}

class _cadastroUserPageState extends State<CadastroUserPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  void initState() {
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

  final maskCell = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

//==============================================================================
  String msgErro = '';
  bool erroCadastro, showProgress;
//==============================================================================

  Future<List> _cadastraUsuario() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_cadastroUsuario.php'),
      body: {
        "nome": nome.text.trim(),
        "senha": senha.text.trim(),
        "email": email.text.trim(),
        "cpf": cpf.text.trim(),
        "telefone": telefone.text.trim(),
        "estado": dropdownValueEstado.trim(),
        "cidade": cidade.text.trim(),
        "bairro": bairro.text.trim(),
        "rua": rua.text.trim(),
        "numero": numero.text.trim(),
        "complemento": complemento.text.trim(),
      },
    );
    if (response.statusCode == 200) {
      print(telefone.toString());
      var jsondata = json.decode(response.body);
      if (jsondata["sucessoCadastroUser"]) {
        mandaEmailCadastroUsuario(
            email.toString().trim(), nome.toString().trim());
        setState(() {
          erroCadastro = false;
          msgErro = jsondata["mensagemCadastroUser"];
          showCaixaDialogoRapida(context, msgErro, 'login', 2);
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
      body: new Form(
        key: _key,
        child: _formUI(),
      ),
    );
  }

  Widget _formUI() {
    return Container(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.97,
          child: ListView(
            children: [
              SizedBox(height: 20),
//==============================================================================
              TextFormField(
                  validator: validarNome,
                  controller: nome,
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
              SizedBox(height: 10),
//==============================================================================
              TextFormField(
                  validator: validarEmail,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
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
                        child: TextFormField(
                            validator: validarSenhaCadastro,
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
                        child: TextFormField(
                            validator: validarSenhaCadastro,
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
              TextFormField(
                  validator: validarCPF,
                  inputFormatters: [maskCpf],
                  controller: cpf,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'CPF',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
              SizedBox(height: 10),
//==============================================================================
              TextFormField(
                  validator: validarCelular,
                  inputFormatters: [maskCell],
                  controller: telefone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Telefone celular',
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
                        child: TextFormField(
                            validator: validarCidade,
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
              TextFormField(
                  validator: validarBairro,
                  controller: bairro,
                  decoration: InputDecoration(
                      labelText: 'Bairro',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
              SizedBox(height: 10),
//==============================================================================
              TextFormField(
                  validator: validarRua,
                  controller: rua,
                  decoration: InputDecoration(
                      labelText: 'Rua',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
              SizedBox(height: 10),
//==============================================================================
              TextFormField(
                  validator: validarNumero,
                  controller: numero,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Número',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
              SizedBox(height: 10),
//==============================================================================
              TextFormField(
                  validator: validarComplemento,
                  controller: complemento,
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
                    onPressed: _sendForm,
                    child: const Text('Enviar'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Palette.purple)),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  _sendForm() {
    if (_key.currentState.validate()) {
      // Sem erros na validação
      _key.currentState.save();
      _cadastraUsuario();
    } else {
      // erro de validação
      setState(() {
        _validate = true;
        showProgress = false;
      });
    }
  }
}
