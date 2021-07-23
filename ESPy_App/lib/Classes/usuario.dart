import 'package:ESPy/Funcoes/appWidget.dart';
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
  int usuario_empregado;

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
      this.usuario_chefe,
      this.usuario_empregado});

  factory usuario.fromJson(Map<String, dynamic> json) {
    return usuario(
      codigo: json['codigo'],
      nome: json['nome'],
      senha: json['senha'],
      email: json['email'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      estado: json['estado'],
      cidade: json['cidade'],
      bairro: json['bairro'],
      rua: json['rua'],
      numero: json['numero'],
      complemento: json['complemento'],
      usuario_chefe: json['usuario_chefe'],
      usuario_empregado: json['usuario_empregado'],
    );
  }

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nome': nome,
        'senha': senha,
        'email': email,
        'cpf': cpf,
        'telefone': telefone,
        'estado': estado,
        'cidade': cidade,
        'rua': rua,
        'numero': numero,
        'complemento': complemento,
        'usuario_chefe': usuario_chefe,
        'usuario_empregado': usuario_empregado
      };
}

Widget barraDeNavegacaoInferior_Retorno() {
  if (user.usuario_chefe == 0 && user.usuario_empregado == 0) {
    return barraDeNavegacaoInferior();
  } else if (user.usuario_chefe == 0 && user.usuario_empregado == 1) {
    return barraDeNavegacaoInferiorEmpregado();
  } else {
    return barraDeNavegacaoChefeInferior();
  }
}

usuario user = new usuario();
