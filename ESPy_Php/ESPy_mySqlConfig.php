<?php

	include ("../ESPy_MySql/ESPy_MySqlCredenciais.php");
	ini_set('default_charset', 'utf-8');
	date_default_timezone_set ("America/Sao_Paulo");

	$db_user = $MySql_user;
	$db_pass = $MySql_pass; 
	$host = $MySql_host;
	$db_name = $MySql_dbName; 
	
	$conexao = mysqli_connect($host,$db_user,$db_pass,$db_name);

	?>