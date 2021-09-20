import 'dart:convert';
import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Funcoes/appValidator.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:ESPy/Paginas/DashBoard/caixaColeta_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

import '../../main.dart';
import 'dashBoard_Page.dart';

class caixasColeta extends StatefulWidget {
  @override
  _listaCaixasColetaPageState createState() => _listaCaixasColetaPageState();
}

bool confirmaExpulsao;

class _listaCaixasColetaPageState extends State<caixasColeta> {
  @override
//==============================================================================
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool showProgress;
  String msgErro;
  List data;
  String _codigoCaixaSelecionadaLista;
  TextEditingController _nomeCaixaCadastro = new TextEditingController();
  TextEditingController _novoNome = new TextEditingController();
  var sendFormCOD = 0;
//==============================================================================

  void _coletaCaixasColeta() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaCaixasColeta.php'),
      body: {"codigoEmpresa": emp.codigo.toString()},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      this.setState(() {
        data = json.decode(response.body);
        setState(() {
          showProgress = false;
        });
      });
    } else {
      print("Nao foi possivel conectar-se.");
    }
  }

  void _deletaCaixaColeta() async {
    print(_codigoCaixaSelecionadaLista.toString());
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_removerCaixaColeta.php'),
      body: {
        "codigoCaixaSelecionadaLista": sensor.codigoCaixa.toString(),
        "codigoEmpresa": emp.codigo.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["StatusDeletaCaixa"]) {
        this.setState(() {
          msgErro = jsondata["mensagemDeletaCaixa"];
          _coletaCaixasColeta();
          showProgress = false;
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: const Text(
              'Caixa excluida!',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Desfazer',
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _RecuperaCaixaAposExcluir();
                });
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        this.setState(() {
          msgErro = jsondata["mensagemDeletaCaixa"];
          ScaffoldMessenger.of(context).showSnackBar(falhaRealizarAcao);
          showProgress = false;
        });
      }
    }
  }

  void _cadastraCaixaColeta() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_cadastroCaixasColeta.php'),
      body: {
        "nome": _nomeCaixaCadastro.text.trim(),
        "codigoEmpresa": emp.codigo.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["statusCadastroCaixa"]) {
        this.setState(() {
          msgErro = jsondata["mensagemCadastraCaixa"];
          _coletaCaixasColeta();
          _nomeCaixaCadastro.clear();
          ScaffoldMessenger.of(context).showSnackBar(sucessRealizarAcao);
        });
      } else {
        this.setState(() {
          msgErro = jsondata["mensagemCadastraCaixa"];
          ScaffoldMessenger.of(context).showSnackBar(falhaRealizarAcao);
          showProgress = false;
        });
      }
    }
  }

  void _editaCaixaColeta() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_editarCaixaColeta.php'),
      body: {
        "codigoCaixaSelecionadaLista": sensor.codigoCaixa.toString(),
        "codigoEmpresa": emp.codigo.toString(),
        "novoNome": _novoNome.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["statusEditaCaixa"]) {
        this.setState(() {
          msgErro = jsondata["mensagemEditaCaixa"];
          _coletaCaixasColeta();
          _novoNome.clear();
          ScaffoldMessenger.of(context).showSnackBar(sucessRealizarAcao);
        });
      } else {
        this.setState(() {
          msgErro = jsondata["mensagemEditaCaixa"];
          ScaffoldMessenger.of(context).showSnackBar(falhaRealizarAcao);
          _novoNome.clear();
        });
      }
    }
  }

  void _RecuperaCaixaAposExcluir() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_recuperaCaixaColeta.php'),
      body: {
        "codigoCaixaSelecionadaLista": sensor.codigoCaixa.toString(),
        "codigoEmpresa": emp.codigo.toString(),
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata["StatusRecuperaCaixa"]) {
        this.setState(() {
          msgErro = jsondata["mensagemRecuperaCaixa"];
          _coletaCaixasColeta();
          atualizarTela();
          showProgress = false;
          ScaffoldMessenger.of(context).showSnackBar(sucessRealizarAcao);
        });
      } else {
        this.setState(() {
          msgErro = jsondata["mensagemRecuperaCaixa"];
          showProgress = false;
          ScaffoldMessenger.of(context).showSnackBar(falhaRealizarAcao);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    showProgress = true;
    this._coletaCaixasColeta();
  }

  @override
  void atualizarTela() {
    setState(() {
      showProgress = true;
      this._coletaCaixasColeta();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Caixa de Coleta"),
        centerTitle: true,
        actions: [botaoAtualizar()],
      ),
      body: caixas(),
      floatingActionButton: botaoCadastrarCaixas(),
    );
  }

  Widget caixas() {
    if (data == null || data.length == 0) {
      return ApresentaProgressoCaixasColeta();
    } else {
      return showCaixasColeta();
    }
  }

  Widget showCaixasColeta() {
    return Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            padding: const EdgeInsets.only(top: 50.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(115.0),
                topRight: const Radius.circular(115.0),
              ),
            ),
            child: new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  color: Colors.grey.shade200,
                  margin: EdgeInsetsDirectional.fromSTEB(35.0, 30.0, 35.0, 00),
                  child: new InkWell(
                    onTap: () {
                      sensor.codigoCaixa = int.parse(data[index]["codigo"]);
                      sensor.nomeCaixa = data[index]["nome"];
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CaixaColetaPage()));
                    },
                    child: Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 85,
                                child: Text(
                                  sensor.nomeCaixa = data[index]["nome"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                FlatButton(
                                  onPressed: () {
                                    sensor.nomeCaixa = data[index]["nome"];
                                    sensor.codigoCaixa =
                                        int.parse(data[index]["codigo"]);
                                    _CaixaDialogoEditaCaixa(context);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Palette.purple.shade700,
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    sensor.nomeCaixa = data[index]["nome"];
                                    sensor.codigoCaixa =
                                        int.parse(data[index]["codigo"]);
                                    _showDialogoDeletaCaixa(context,
                                        "Deseja realmente remover essa caixa de coleta?");
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Palette.purple.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget showErrorEmpresaSemCaixas() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Container(
        decoration: new BoxDecoration(),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Sua empresa ainda não possui nenhuma caixa de coleta cadastrada.",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(115.0),
                topRight: const Radius.circular(115.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget botaoAtualizar() {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(Icons.restart_alt),
      onPressed: () {
        setState(() {
          atualizarTela();
        });
      },
    );
  }

  void _showDialogoDeletaCaixa(BuildContext context, String msg) {
    // configura o button

    Widget cancelaButton, confirmaButton;

    Widget linhaBotoes() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.15,
            shape: RoundedRectangleBorder(),
            child: Text(
              "Cancelar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          confirmaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.15,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Palette.purple)),
            child: Text(
              "Confirmar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Palette.purple),
            ),
            onPressed: () {
              setState(() {
                _deletaCaixaColeta();
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }

    AlertDialog alerta = AlertDialog(
        title: Text(msg, style: TextStyle(), textAlign: TextAlign.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        actions: [linhaBotoes()]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Widget ApresentaProgressoCaixasColeta() {
    return showProgress
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: (Palette.purple.shade100),
                  valueColor: AlwaysStoppedAnimation<Color>(Palette.purple),
                ),
                Text("Carregando dados...",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          )
        : showErrorEmpresaSemCaixas();
  }

  Widget botaoCadastrarCaixas() {
    return SizedBox(
      width: 45,
      height: 45,
      child: FloatingActionButton(
        heroTag: "Cadastrar Caixa",
        backgroundColor: Palette.purple,
        onPressed: () {
          setState(() {
            _CaixaDialogoCadastraCaixa(context);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _CaixaDialogoCadastraCaixa(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            title: Text('Nova Caixa', textAlign: TextAlign.center),
            content: Form(
              key: _key,
              child: TextFormField(
                validator: validarNomeCaixaColeta,
                controller: _nomeCaixaCadastro,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.name,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                minWidth: MediaQuery.of(context).size.width * 0.25,
                shape: RoundedRectangleBorder(),
                child: Text(
                  "Cancelar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width * 0.25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Palette.purple)),
                child: Text(
                  "Salvar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Palette.purple),
                ),
                onPressed: () {
                  setState(() {
                    sendFormCOD = 1;
                  });
                  _sendForm();
                },
              ),
            ],
          );
        });
  }

  Future<void> _CaixaDialogoEditaCaixa(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            title:
                Text(sensor.nomeCaixa.toString(), textAlign: TextAlign.center),
            content: Form(
              key: _key,
              child: TextFormField(
                validator: validarNome,
                controller: _novoNome,
                decoration: InputDecoration(
                    labelText: 'Novo nome',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.name,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                minWidth: MediaQuery.of(context).size.width * 0.25,
                shape: RoundedRectangleBorder(),
                child: Text(
                  "Cancelar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width * 0.25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Palette.purple)),
                child: Text(
                  "Salvar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Palette.purple),
                ),
                onPressed: () {
                  setState(() {
                    sendFormCOD = 2;
                  });
                  _sendForm();
                },
              ),
            ],
          );
        });
  }

  _sendForm() {
    if (_key.currentState.validate()) {
      // Sem erros na validação
      _key.currentState.save();
      if (sendFormCOD == 1) {
        _cadastraCaixaColeta();
        Navigator.of(context).pop();
      }
      if (sendFormCOD == 2) {
        _editaCaixaColeta();
        Navigator.of(context).pop();
      }
    } else {
      // erro de validação
      setState(() {
        _validate = true;
        showProgress = false;
      });
    }
  }
}
