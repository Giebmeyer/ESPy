<?php 
	include "ESPy_mySqlConfig.php";

    $return["mensagemEditaCaixa"] = "";
    $return["statusEditaCaixa"] = false;

        $codigoCaixaSelecionadaLista = mysqli_real_escape_string ($conexao,$_POST['codigoCaixaSelecionadaLista']);
        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);
        $novoNome = mysqli_real_escape_string ($conexao,$_POST['novoNome']);
		$agora = date('Y-m-d H:i:s');

		$query = "UPDATE `caixas_coleta` SET `nome` = '$novoNome', `data_hora_alteracao` = '$agora' WHERE `codigo_empresa` = $codigoEmpresa AND `codigo` = $codigoCaixaSelecionadaLista";	 
	    $resultado = mysqli_query($conexao, $query);

        if($resultado > 0){

				$return["mensagemEditaCaixa"] = "Sucesso ao realizar ação!";
				$return["statusEditaCaixa"] = true;	
    		
		}else{
			
			$return["mensagemEditaCaixa"] = "Ocorreu um erro inesperado, tente novamente";
			$return["statusEditaCaixa"] = false;
		}

  echo json_encode($return);    
  mysqli_close($conexao);


	?>