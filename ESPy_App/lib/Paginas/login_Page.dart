import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';

import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Paginas/cadastroUsuario_Page.dart';
import 'package:ESPy/Paginas/inicial_Page.dart';
import 'package:ESPy/Paginas/recoverPass_Page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

bool possuiEmpresa;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController senha = new TextEditingController();

//==============================================================================
  String msgErro = '';
  bool erro, showProgress;
  List data;
//==============================================================================
  @override
  void initState() {
    erro = false;
    showProgress = false;
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
    super.initState();
  }

//==============================================================================
  void _coletaFuncionarios() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaFuncionarios.php'),
      body: {"codigoEmpresa": emp.codigo.toString()},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      this.setState(() {
        data = json.decode(response.body);
        emp.qtdFuncionarios = data.length;
      });
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
          erro = true;
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
          print(emp.cnpj);
          emp.estado = jsondata['estado'];
          emp.cidade = jsondata['cidade'];
          emp.bairro = jsondata['bairro'];
          emp.rua = jsondata['rua'];
          emp.numero = jsondata['numero'];
          emp.complemento = jsondata['complemento'];
          emp.qtdFuncionarios = jsondata['qtdFuncionarios'];
          _coletaFuncionarios();
          setState(() {
            possuiEmpresa = true;
            erro = false;
            showProgress = true;
          });
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => inicialPage()));
        } else {
          showProgress = false;
          erro = true;
          msgErro = "Algo deu errado.";
          showCaixaDialogoSimples(context, msgErro);
        }
      }
    } else {
      setState(() {
        showProgress = false;
        erro = true;
        msgErro = "Erro na conexão com o servidor.";
        showCaixaDialogoSimples(context, msgErro);
      });
    }
  }

//==============================================================================

  _login() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_login.php'),
      body: {
        "email": email.text,
        "senha": senha.text,
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["errorLogin"]) {
        setState(() {
          showProgress = false;
          erro = true;
          msgErro = jsondata["mensagemLogin"];
          showCaixaDialogoSimples(context, msgErro);
        });
      } else {
        if (jsondata["sucessoLogin"]) {
          setState(() {
            erro = false;
            showProgress = false;
          });
          user.codigo = jsondata['codigo'];
          user.nome = jsondata['nome'];
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
          if (user.usuario_chefe == 1 || user.usuario_empregado == 1) {
            possuiEmpresa = true;
            _coletaDadosEmpresa();
          } else {
            possuiEmpresa = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => inicialPage()));
          }
        } else {
          setState(() {
            showProgress = false;
            erro = true;
          });
          msgErro = jsondata["errorLogin"];
          showCaixaDialogoSimples(context, msgErro);
        }
      }
    } else {
      msgErro = 'Erro ao conectar no servidor';
      showCaixaDialogoSimples(context, msgErro);
      setState(() {
        showProgress = false;
        erro = true;
      });
    }
  }

//==============================================================================
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao '),
        centerTitle: true,
      ),
      body: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Palette.purple.shade900,
            Palette.purple.shade50,
          ],
        )),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(115.0),
                    topRight: const Radius.circular(115.0),
                  ),
                ),
                child: Align(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.40,
                            alignment: Alignment.center,
                            child: Image.asset('assents/imagens/Logo.png'),
                          ),
                        ),
//==============================================================================
                        TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(height: 10),
//==============================================================================
                        TextFormField(
                            controller: senha,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)))),
//==============================================================================
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => recoverPassPage()));
                            },
                            child: Text(
                              "Esqueci minha senha",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13.0),
                            ),
                          ),
                        ),
//==============================================================================
                        Align(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                _login();
                              },
                              child: ApresentaProgressoLogin(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Palette.purple)),
                            ),
                          ),
                        ),
//==============================================================================
                        FlatButton(
                          focusColor: Palette.purple.shade50,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CadastroUserPage()));
                          },
                          child: Text(
                            "Não possui login? Cadastre-se",
                            textAlign: TextAlign.right,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 13.0),
                          ),
                        ),
//==============================================================================
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

//==============================================================================
  Widget ApresentaProgressoLogin() {
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
            "Entrar",
            style: TextStyle(color: Palette.purple),
          );
  }

//==============================================================================
}
