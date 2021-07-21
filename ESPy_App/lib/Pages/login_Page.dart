import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Pages/cadastroUsuario_Page.dart';
import 'package:ESPy/Pages/recoverPass_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_Page.dart';
import 'package:http/http.dart' as http;

bool possuiEmpresa = false;

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

//==============================================================================
  @override
  void initState() {
    erroEmpresa = false;
    showProgress = false;
    jaCarregouDados = false;
    super.initState();
  }

//==============================================================================
  bool erroEmpresa, erroRequestSensores, jaCarregouDados;

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
            possuiEmpresa = true;
            erroEmpresa = false;
            showProgress = true;
          });
          emp.codigo = jsondata['codigo'];
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
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
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

  void _coletaDadosSensores() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_requestSensores.php'),
      body: {"codigoEmpresa": emp.codigo},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["erroRequestSensores"]) {
        setState(() {
          erroEmpresa = true;
          msgErro = jsondata["mensagemRequestSensores"];
        });
      } else {
        if (jsondata["sucessoRequestSensores"]) {
          setState(() {
            erroEmpresa = false;
          });
          sensor.sequencia = jsondata['sequencia'];
          sensor.Umidade_DHT11 = jsondata['Umidade_DHT11'];
          sensor.Temperatura_DHT11 = jsondata['Temperatura_DHT11'];
          sensor.Temperatura_BMP180 = jsondata['Temperatura_BMP180'];
          sensor.Pressao_BMP180 = jsondata['Pressao_BMP180'];
          sensor.Altitude_BMP180 = jsondata['Altitude_BMP180'];
          sensor.CO_MICS = jsondata['CO_MICS'];
          sensor.NO2_MICS = jsondata['NO2_MICS'];
          sensor.NH3_MICS = jsondata['NH3_MICS'];
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          erroEmpresa = true;
          msgErro = "Algo deu errado.";
          print(msgErro);
        }
      }
    } else {
      setState(() {
        erroEmpresa = true;
        msgErro = "Erro na conexão com o servidor.";
        print(msgErro);
      });
    }
  }

  _login() async {
    final response = await http.post(
      Uri.parse('http://192.168.66.109/ESPy/ESPy_MySql/ESPy_login.php'),
      body: {
        "email": email.text,
        "senha": senha.text,
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["erro"]) {
        setState(() {
          showProgress = false;
          erro = true;
          msgErro = jsondata["messagem"];
        });
      } else {
        if (jsondata["sucesso"]) {
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
          if (user.usuario_chefe == 1) {
            possuiEmpresa = true;
            _coletaDadosEmpresa();
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          }
        } else {
          showProgress = false;
          erro = true;
          msgErro = "Algo deu errado.";
        }
      }
    } else {
      setState(() {
        showProgress = false;
        erro = true;
        msgErro = "Erro na conexão com o servidor.";
      });
    }
  }

//==============================================================================
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.97,
            child: ListView(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.43,
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
                            borderRadius: BorderRadius.circular(15.0)))),
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
                      style: TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                  ),
                ),
//==============================================================================
                Align(
                  child: Container(
                    width: 200,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          showProgress = true;
                        });
                        _login();
                      },
                      child: ApresentaProgresso(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Palette.purple)),
                    ),
                  ),
                ),
//==============================================================================
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CadastroUserPage()));
                  },
                  child: Text(
                    "Não possui login? Cadastre-se",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                ),
//==============================================================================
              ],
            ),
          ),
        ));
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
            "Entrar",
            style: TextStyle(color: Palette.purple),
          );
  }
}
