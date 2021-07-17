<?php

	$username="Guib";
	$password="Nkysd3m8tg"; 
	$host="192.168.66.109";
	$db_name="espy"; 

	$connect=mysqli_connect($host,$username,$password,$db_name);
	

	if(!$connect)
	{
		echo json_encode("Falha na conexão");
	}else{
	echo "Sucesso na conexão";
	}
	

	?>