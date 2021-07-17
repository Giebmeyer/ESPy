import 'package:ESPy/Funcoes/BD.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Funcoes/variaveis.dart';
import 'package:flutter/cupertino.dart';

class usuario {
  int codigo;
  String nome = '';
  String senha = '';
  String email = '';
  String cpf = '';
  int telefone;
  String estado = '';
  String cidade = '';
  String bairro = '';
  String rua = '';
  int numero;
  String complemento = '';
  int usuario_chefe;

  usuario(
      {this.codigo,
      this.nome,
      this.senha,
      this.email,
      this.cpf,
      this.telefone,
      this.estado,
      this.cidade,
      this.bairro,
      this.rua,
      this.numero,
      this.complemento,
      this.usuario_chefe});

  String get auxEmail => email;
  int get codigoX => user.codigo;
}

void coletaDadosUsuario(String _auxEmail) {
  var db = new Mysql();

  db.getConnection().then((conn) {
    conn
        .query("select * from usuarios where email = " + "'$_auxEmail'" + ";")
        .then(((results) {
      print("select * from usuarios where email = " + "'$_auxEmail'" + ";");
      for (var collum in results) {
        user.codigo = (collum[0]);
        print(user.codigo);
        user.nome = (collum[1]);
        print(user.nome);
        user.senha = (collum[2]);
        print(user.senha);
        user.email = (collum[3]);
        print(user.email);
        user.cpf = (collum[4]);
        print(user.cpf);
        user.telefone = (collum[5]);
        print(user.telefone);
        user.estado = (collum[6]);
        print(user.estado);
        user.cidade = (collum[7]);
        print(user.cidade);
        user.bairro = (collum[8]);
        print(user.bairro);
        user.rua = (collum[9]);
        print(user.rua);
        user.numero = (collum[10]);
        print(user.numero);
        user.complemento = (collum[11]);
        print(user.complemento);
        user.usuario_chefe = (collum[12]);
        print(user.usuario_chefe);
      }
      conn.close();
    }));
  });
}

void cadastroUsuario(
    String _nome,
    String _email,
    String _senha,
    String _confirmacaoSenha,
    int _cpf,
    int _telefone,
    String _estado,
    String _cidade,
    String _bairro,
    String _rua,
    int _numero,
    String _complemento) {
  var db = new Mysql();

  if (_senha == _confirmacaoSenha) {
    db.getConnection().then((conn) {
      conn.query(
          'INSERT INTO usuarios VALUES (NULL, "$_nome", "$_senha", "$_email", "$_cpf", "$_telefone", "$_estado", "$_cidade", "$_bairro", "$_rua", "$_numero", "$_complemento", 0);');
    });
  } else {}
}

Widget barraDeNavegacaoInferior_Retorno() {
  if (user.usuario_chefe == 0) {
    return barraDeNavegacaoInferior();
  } else {
    return barraDeNavegacaoChefeInferior();
  }
}

usuario user = new usuario();
