<?php

include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";
session_start();
$codigoEmpresa  = $_SESSION['codigoEmpresa'];
$nome  = mysqli_real_escape_string($conexao, $_POST['nomeNovaCaixa']);

$resultado = mysqli_query($conexao, "INSERT INTO caixas_coleta (nome, excluida, codigo_empresa) VALUES ('$nome', '0', '$codigoEmpresa');");

if ($resultado > 0) {
	header('Location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php');
} else {
	echo "Falha";
}
