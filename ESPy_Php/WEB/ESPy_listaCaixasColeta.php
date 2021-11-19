<?php
include("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");

$codigoEmpresa  = $_SESSION['codigoEmpresa'];

$queryResult = mysqli_query($conexao, "select cc.* from caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' order by codigo desc;");
$qtdRow = mysqli_num_rows($queryResult);

if($qtdRow == 0){
    echo 'Sua empresa ainda não possui nenhuma caixa de coleta cadastrada :(';
}else{
    while ($campo = mysqli_fetch_array($queryResult)) {
        echo '<a class="btn btn-outline-primary" id="btnCaixaColeta" href="../../../ESPy_Php/WEB/ESPy_requestSensoresHistorico.php?codigoCaixaColeta='. $campo["codigo"] .'">' . $campo["nome"] . '</a>';
    }
}

