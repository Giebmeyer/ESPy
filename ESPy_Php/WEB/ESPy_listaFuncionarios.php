<?php
include("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");

$codigoEmpresa  = $_SESSION['codigoEmpresa'];

$queryResult = mysqli_query($conexao, "SELECT u.* FROM usuarios u JOIN usuarios_empresas ue ON u.codigo = ue.codigo_usuario JOIN empresas e ON e.codigo = ue.codigo_empresa WHERE ue.codigo_empresa = '$codigoEmpresa' AND u.usuario_chefe != 1 AND ue.saiuEmpresa = 'A' ORDER BY `data_hora_cadastro` desc");
$qtdRow = mysqli_num_rows($queryResult);

if($qtdRow == 0){
    echo 'Sua empresa ainda não possui empregados :(';
}else{
    while ($campo = mysqli_fetch_array($queryResult)) {
        echo '<a class="btn btn-outline-primary btnCaixaColeta" id=' . $campo["codigo"] . '> ' . $campo["nome"] . '</a>';
    }
}

