String validarNome(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o nome";
  } else if (!regExp.hasMatch(value)) {
    return "O nome deve conter caracteres de a-z ou A-Z";
  }
  return null;
}

String validarCelular(String value) {
  String patttern = r'(^[0-9() -]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o seu número de celular";
  } else if (value.length > 15) {
    return "O celular deve ter 15 dígitos";
  } else if (!regExp.hasMatch(value)) {
    return "O número do celular so deve conter dígitos";
  }
  return null;
}

String validarEmail(String value) {
  RegExp RE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value.length == 0) {
    return "Informe o seu email";
  } else if (!RE.hasMatch(value)) {
    return "Email inválido";
  } else {
    return null;
  }
}

String validarSenha(String value) {
  if (value.length == 0) {
    return "Informe a sua Senha";
  } else if (value.length < 6) {
    return "Minímo 6 digitos";
  } else {
    return null;
  }
}

String validarSenhaCadastro(String value) {
  if (value.length == 0) {
    return "Informe a sua Senha";
  } else if (value.length < 6) {
    return "Minímo 6 digitos";
  } else {
    return null;
  }
}

String validarCPF(String value) {
  String patttern = r'(^[0-9-.]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o CPF";
  } else if (value.length < 14) {
    return "CPF inválido";
  } else if (!regExp.hasMatch(value)) {
    return "O CPF deve conter apenas números";
  } else {
    return null;
  }
}

String validarCNPJ(String value) {
  String patttern = r'(^[0-9./-]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o CNPJ";
  } else if (value.length < 18) {
    return "CNPJ inválido";
  } else if (!regExp.hasMatch(value)) {
    return "O CNPJ deve conter apenas números";
  } else {
    return null;
  }
}

String validarTelefoneFixo(String value) {
  String patttern = r'(^[0-9() -]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o número de telefone fixo";
  } else if (value.length < 10) {
    return "Telefone inválido";
  } else if (!regExp.hasMatch(value)) {
    return "O número de telefone deve conter apenas números";
  } else {
    return null;
  }
}

String validarCidade(String value) {
  String patttern = r'(^[a-zA-Z ç]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o nome da sua cidade";
  } else if (!regExp.hasMatch(value)) {
    return "O nome deve conter caracteres de a-z ou A-Z";
  }
  return null;
}

String validarBairro(String value) {
  if (value.length == 0) {
    return "Informe o nome do seu bairro";
  } else {
    return null;
  }
}

String validarRua(String value) {
  if (value.length == 0) {
    return "Informe o nome da sua rua";
  } else {
    return null;
  }
}

String validarNumero(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Informe o número da sua residência";
  } else if (!regExp.hasMatch(value)) {
    return "Deve conter apenas números";
  } else {
    return null;
  }
}

String validarComplemento(String value) {
  if (value.length == 0) {
    return "Informe um complemento";
  } else {
    return null;
  }
  {}
}
