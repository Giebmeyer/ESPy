<?php
include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

session_start();

$codigoCaixaSelecionadaLista = mysqli_real_escape_string($conexao, $_GET['codigoCaixaColeta']);
$codigoEmpresa = $_SESSION['codigoEmpresa'];
$codigoUsuario = $_SESSION['codigo'];
$agora = date('Y-m-d H:i:s');
$query = "UPDATE `caixas_coleta` SET `excluida` = '1', `data_hora_alteracao` = '$agora' WHERE `codigo_empresa` = '$codigoEmpresa' AND `codigo` = '$codigoCaixaSelecionadaLista'";
$query2 = "select cc.* from caixas_coleta cc
join empresas e on e.codigo = cc.codigo_empresa
join usuarios_empresas ue on ue.codigo_empresa = e.codigo
join usuarios u on u.codigo = ue.codigo_usuario
where u.usuario_chefe = 1 and e.codigo = $codigoEmpresa and cc.codigo = $codigoCaixaSelecionadaLista and u.codigo = $codigoUsuario";

$resultado2 = mysqli_query($conexao, $query2);
$numrows = mysqli_num_rows($resultado2);

if ($numrows > 0) {
	$resultado = mysqli_query($conexao, $query);
	if ($resultado > 0) {
		header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
	} else {
		$return["mensagemDeletaCaixa"] = "Ocorreu um erro inesperado, tente novamente";
		$return["StatusDeletaCaixa"] = false;
	}
} else {
	header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
}




echo json_encode($return);
mysqli_close($conexao);
