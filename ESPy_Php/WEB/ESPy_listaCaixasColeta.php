<?php
include_once("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");


$codigoEmpresa  = $_SESSION['codigoEmpresa'];
$nomeCaixa = "";

if (empty($_POST['nomeCaixa']) == 1) {
    $nomeCaixa = "";
} else {
    $nomeCaixa = mysqli_real_escape_string($conexao, $_POST['nomeCaixa']);
}

$queryResult = mysqli_query($conexao, "select cc.nome from caixas_coleta cc where cc.codigo_empresa = 108 and nome like IFNULL(('%$nomeCaixa%'), ('%%'));");

while ($queryRow = $queryResult->fetch_row()) {
    for ($i = 0; $i < $queryResult->field_count; $i++) {
        echo '<button class="btn btn-outline-primary" id="btnCaixaColeta">' . $queryRow[$i] . '</button>';
    }
}


