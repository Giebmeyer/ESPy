<?php
	include "../../../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $codigoEmpresa  = $_SESSION['codigoEmpresa'];

$query = "select cc.nome from caixas_coleta cc where cc.codigo_empresa = $codigoEmpresa;";
$queryResult = mysqli_query($conexao, $query);
while ($queryRow = $queryResult->fetch_row()) {

    for($i = 0; $i < $queryResult->field_count; $i++){
        echo '<button id="btnCaixaColeta">'.$queryRow[$i].'</button>';
    }
        
}
