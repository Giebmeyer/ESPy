class empresa {
  int codigo = 0;
  int chaveConvite = 0;
  String nome = '';
  String CEO = '';
  String email_ceo = '';
  int telefone = 0;
  int cnpj = 0;
  String estado = '';
  String cidade = '';
  String bairro = '';
  String rua = '';
  int numero = 0;
  String complemento = '';
  List<dynamic> dadosEmpresa = [];
  var qtdDadosBD = 1;

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
}

empresa emp = new empresa();
