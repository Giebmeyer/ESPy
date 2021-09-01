import 'package:flutter/material.dart';

class meuPerfil extends StatefulWidget {
  const meuPerfil({Key key}) : super(key: key);

  @override
  _meuPerfilState createState() => _meuPerfilState();
}

class _meuPerfilState extends State<meuPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        centerTitle: true,
      ),
    );
  }
}
