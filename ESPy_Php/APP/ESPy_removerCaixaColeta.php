<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $return["mensagemDeletaCaixa"] = "";
    $return["StatusDeletaCaixa"] = false;

        $codigoCaixaSelecionadaLista = mysqli_real_escape_string ($conexao,$_POST['codigoCaixaSelecionadaLista']);
        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "UPDATE `caixas_coleta` SET `excluida` = '1' WHERE `codigo_empresa` = '$codigoEmpresa' AND `codigo` = '$codigoCaixaSelecionadaLista'";	 
	    $resultado = mysqli_query($conexao, $query);

        if($resultado > 0){

				$return["mensagemDeletaCaixa"] = "Sucesso ao realizar ação!";
				$return["StatusDeletaCaixa"] = true;	
    		
		}else{
			
			$return["mensagemDeletaCaixa"] = "Ocorreu um erro inesperado, tente novamente";
			$return["StatusDeletaCaixa"] = false;
		}

  echo json_encode($return);    
  mysqli_close($conexao);


	?>