<?php

include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";
session_start();
$codigoEmpresa  = $_SESSION['codigoEmpresa'];
$nome  = mysqli_real_escape_string($conexao, $_POST['nomeNovaCaixa']);

$resultado = mysqli_query($conexao, "INSERT INTO caixas_coleta (nome, excluida, codigo_empresa) VALUES ('$nome', '0', '$codigoEmpresa');");

if ($resultado > 0) {

	$resultado2 = mysqli_query($conexao, "SELECT codigo FROM caixas_coleta WHERE codigo_empresa = '$codigoEmpresa' ORDER BY codigo DESC limit 1");
	$numrows = mysqli_num_rows($resultado2);
	if($numrows > 0){
		$obj = mysqli_fetch_object($resultado2);
		$codigoCaixaCadastrada = (int) $obj->codigo;
		$resultado3 = mysqli_query($conexao, "INSERT INTO configuracao (codigo_caixa, codigo_empresa, tempo_coleta) VALUES ('$codigoCaixaCadastrada', '$codigoEmpresa', '15');");
		if($resultado3 > 0){
			header('Location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php');
		}
		echo "Falha 3";
	}

	echo "Falha 2";

} else {
	echo "Falha";
}
