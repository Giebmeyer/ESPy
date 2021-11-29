<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $return["mensagemRecuperaCaixa"] = "";
    $return["StatusRecuperaCaixa"] = false;

        $codigoCaixaSelecionadaLista = mysqli_real_escape_string ($conexao,$_POST['codigoCaixaSelecionadaLista']);
        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "UPDATE `caixas_coleta` SET `excluida` = '0' WHERE `codigo_empresa` = '$codigoEmpresa' AND `codigo` = '$codigoCaixaSelecionadaLista'";	 
	    $resultado = mysqli_query($conexao, $query);

        if($resultado > 0){

				$return["mensagemRecuperaCaixa"] = "Sucesso ao realizar ação!";
				$return["StatusRecuperaCaixa"] = true;	
    		
		}else{
			
			$return["mensagemRecuperaCaixa"] = "Ocorreu um erro inesperado, tente novamente";
			$return["StatusRecuperaCaixa"] = false;
		}

  echo json_encode($return);    
  mysqli_close($conexao);


	?>