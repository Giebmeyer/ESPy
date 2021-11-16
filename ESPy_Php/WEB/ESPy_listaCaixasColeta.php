<?php
include("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");

$codigoEmpresa  = $_SESSION['codigoEmpresa'];
$nomeCaixa = "";

if (empty($_POST['nomeCaixa']) == 1) {
    $nomeCaixa = "";
} else {
    $nomeCaixa = mysqli_real_escape_string($conexao, $_POST['nomeCaixa']);
}

$queryResult = mysqli_query($conexao, "select cc.* from caixas_coleta cc where cc.codigo_empresa = 108 and nome like IFNULL(('%$nomeCaixa%'), ('%%'));");

while ($campo = mysqli_fetch_array($queryResult)) {
    echo '<a class="btn btn-outline-primary" id="btnCaixaColeta" href="../../../ESPy_Php/WEB/ESPy_requestSensoresHistorico.php?codigoCaixaColeta='. $campo["codigo"] .'">' . $campo["nome"] . '</a>';
}


