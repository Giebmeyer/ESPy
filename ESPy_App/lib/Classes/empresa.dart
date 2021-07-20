import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/usuario_empresa.dart';
import 'package:ESPy/Funcoes/BD.dart';

class empresa {
  int codigo = 0;
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

void cadastroEmpresa(
    String _nome,
    String _CEO,
    String _email_ceo,
    String _telefone,
    String _cnpj,
    String _estado,
    String _cidade,
    String _bairro,
    String _rua,
    String _numero,
    String _complemento) {
  var db = new Mysql();

  db.getConnection().then((conn) {
    conn.query(
        'INSERT INTO empresa (`nome`, `ceo`,`email_ceo`, `telefone`, `cpf_cnpj`, `estado`, `cidade`, `bairro`, `rua`, `numero`, `complemento`) VALUES ("$_nome", "$_CEO", "$_email_ceo", "$_telefone", "$_cnpj", "$_estado", "$_cidade", "$_bairro", "$_rua", "$_numero", "$_complemento");');
  });
  insertUsuario_Empresa(user.codigo, emp.codigo);
}

empresa emp = new empresa();
