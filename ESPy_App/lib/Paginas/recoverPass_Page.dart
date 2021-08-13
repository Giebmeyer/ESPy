import 'dart:convert';
import 'package:ESPy/Funcoes/appValidator.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Paginas/login_Page.dart';
import 'package:ESPy/main.dart';
import 'package:http/http.dart' as http;
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';
import '../Funcoes/sendEmail.dart';

class recoverPassPage extends StatefulWidget {
  @override
  _recoverPassPageState createState() => _recoverPassPageState();
}

class _recoverPassPageState extends State<recoverPassPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
//==============================================================================
  TextEditingController _email = new TextEditingController();
  String msgErro = '';
  bool erro, showProgress;
//==============================================================================
  _ColetaDadosUsuario() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaDadosUsuario.php'),
      body: {
        "email": _email.text.toString().trim(),
      },
    );
    var jsondata = json.decode(response.body);

    if (response.statusCode == 200) {
      msgErro = jsondata["mensagemColetaUser"];
      user.codigo = jsondata['codigo'];
      user.nome = jsondata['nome'];
      print(user.nome);
      user.senha = jsondata['senha'];
      user.email = jsondata['email'];
      user.cpf = jsondata['cpf'];
      user.telefone = jsondata['telefone'];
      user.estado = jsondata['estado'];
      user.cidade = jsondata['cidade'];
      user.bairro = jsondata['bairro'];
      user.rua = jsondata['rua'];
      user.numero = jsondata['numero'];
      user.complemento = jsondata['complemento'];
      user.usuario_chefe = jsondata['usuario_chefe'];
      user.usuario_empregado = jsondata['usuario_empregado'];

      if (_email.text.toString().trim() == user.email.trim()) {
        mandaEmailRecuperacaoSenha(_email.text.toString().trim());
        showCaixaDialogoRapida(context, "Email enviado", 'login', 1);
      } else {
        showCaixaDialogoSimples(context, "Algo deu errado, tente novamente");
      }
    } else {
      setState(() {
        erro = true;
        msgErro = jsondata["mensagemColetaUser"];
        showCaixaDialogoSimples(context, msgErro);
      });
    }
  }

//==============================================================================
  @override
  void initState() {
    erro = false;
    showProgress = false;
    super.initState();
  }

//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recuperação de senha'),
          centerTitle: true,
        ),
        body: new Form(
          key: _key,
          autovalidate: _validate,
          child: Center(
            child: Container(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//==============================================================================
                  Divider(
                    indent: 30,
                    endIndent: 70,
                    color: Colors.black,
                  ),
                  Text(
                    "Informe o email utilizado na criação da conta",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),

                  Divider(
                    indent: 70,
                    endIndent: 30,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
//==============================================================================
                  TextFormField(
                      validator: validarEmail,
                      controller: _email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 10.0),
                  FlatButton(
                    focusColor: Palette.purple.shade50,
                    onPressed: () {
                      _sendForm();
                    },
                    child: const Text('Recuperar'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Palette.purple)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _sendForm() {
    if (_key.currentState.validate()) {
      // Sem erros na validação
      _key.currentState.save();
      print(_email.text.toString());
      _ColetaDadosUsuario();
    } else {
      // erro de validação
      setState(() {
        _validate = true;
        showProgress = false;
      });
    }
  }
}
