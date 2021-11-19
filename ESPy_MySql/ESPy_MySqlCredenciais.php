<?php

ini_set('default_charset', 'utf-8');
date_default_timezone_set ("America/Sao_Paulo");

$MySql_user="confor35_Guib";
$MySql_pass="brother29"; 
$MySql_host="confort-espy.com";
$MySql_dbName="confor35_espy"; 

$conexao = mysqli_connect($MySql_host,$MySql_user,$MySql_pass,$MySql_dbName);

if($conexao == false){
    header("Location: ../../ESPy_Web/errorConexao.html");
}