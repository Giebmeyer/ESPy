<?php 
	include "../../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nomeNovaCaixa']);
	    $codigoEmpresa  = 108/* mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']) */;

		$query = "INSERT INTO caixas_coleta (nome, excluida, codigo_empresa) VALUES ('$nome', '0', '$codigoEmpresa');";	  
		
			

	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
			
				echo "Sucesso";

		}else{
			
			echo "Falha";
			
		}
?>