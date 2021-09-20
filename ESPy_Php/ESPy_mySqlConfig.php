<?php

	$db_user="Guib";
	$db_pass="Nkysd3m8tg"; 
	$host="localhost";
	$db_name="espy"; 

	ini_set('default_charset', 'utf-8');
	date_default_timezone_set ("America/Sao_Paulo");
	
	$conexao = mysqli_connect($host,$db_user,$db_pass,$db_name);

	?>