class empresa {
  int codigo = 0;
  int chaveConvite = 0;
  String nome = '';
  String CEO = '';
  String email_ceo = '';
  String telefone = '';
  String cnpj = '';
  String estado = '';
  String cidade = '';
  String bairro = '';
  String rua = '';
  int numero = 0;
  String complemento = '';
  int qtdFuncionarios = 0;

  empresa(
      {this.codigo,
      this.chaveConvite,
      this.nome,
      this.CEO,
      this.email_ceo,
      this.cnpj,
      this.telefone,
      this.estado,
      this.cidade,
      this.bairro,
      this.rua,
      this.numero,
      this.complemento});

  factory empresa.fromJson(Map<String, dynamic> json) {
    return empresa(
      codigo: json['codigo'],
      chaveConvite: json['chaveConvite'],
      nome: json['nome'],
      CEO: json['ceo'],
      email_ceo: json['email_ceo'],
      telefone: json['telefone'],
      cnpj: json['cnpj'],
      estado: json['estado'],
      cidade: json['cidade'],
      bairro: json['bairro'],
      rua: json['rua'],
      numero: json['numero'],
      complemento: json['complemento'],
    );
  }

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'chaveConvite': nome,
        'nome': nome,
        'ceo': CEO,
        'email_ceo': email_ceo,
        'telefone': telefone,
        'cnpj': cnpj,
        'estado': estado,
        'cidade': cidade,
        'rua': rua,
        'numero': numero,
        'complemento': complemento,
      };
}

empresa emp = new empresa();
