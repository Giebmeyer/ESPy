import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';

class dadosEmpresaPage extends StatefulWidget {
  @override
  _dadosEmpresaPageState createState() => _dadosEmpresaPageState();
}

class _dadosEmpresaPageState extends State<dadosEmpresaPage> {
  double _tamanhoFonte = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: showBodyDados(),
      floatingActionButton: botaoEditarEmpresa(),
    );
  }

  Widget showBodyDados() {
    return Container(
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
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
              padding: const EdgeInsets.only(top: 32.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(115.0),
                  topRight: const Radius.circular(115.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          emp.nome,
                          style:
                              TextStyle(fontSize: 30, fontFamily: 'Orbitron'),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(" "),
                              Text(
                                "CEO: " + emp.CEO,
                                style: TextStyle(fontSize: _tamanhoFonte),
                              ),
                              Text("CNPJ: " + emp.cnpj),
                              Text("Telefone: " + emp.telefone),
                              Divider(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text("Estado: " + emp.estado),
                                  Text(" | Cidade: " + emp.cidade)
                                ],
                              ),
                              Text("Bairro: " + emp.bairro),
                              Text("Complemento: " + emp.complemento),
                              Row(
                                children: [
                                  Text("Rua: " + emp.rua),
                                  Text(" | nº " + emp.numero.toString()),
                                ],
                              ),
                              if (user.usuario_chefe == 1)
                                Text("Chave de Convite: " +
                                    emp.chaveConvite.toString()),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget botaoEditarEmpresa() {
    return SizedBox(
      width: 45,
      height: 45,
      child: FloatingActionButton(
        heroTag: "Editar Empresa",
        backgroundColor: Palette.purple,
        onPressed: () {
          showCaixaDialogoSimples(context,
              "Para realizar a edição dos dados da sua empresa é necessário alterar atraves do site do ESPy");
        },
        child: Icon(Icons.warning),
      ),
    );
  }
}
