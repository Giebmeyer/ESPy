<?php 
	include "ESPy_mySqlConfig.php";

	$return["mensagemConfiguracao"] = "";
	$return["sucessoConfiguracao"] = false;	

        $codigoEmpresa =mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']) ;
	    $tempoColeta  =  mysqli_real_escape_string ($conexao,$_POST['tempoColeta']) ;
	    $idCaixa  =  mysqli_real_escape_string ($conexao,$_POST['idCaixa']) ;
        $agora = date('Y-m-d H:i:s');

		$query = "UPDATE `configuracao` SET `tempo_coleta`='$tempoColeta',`data_hora_alteracao`='$agora'  WHERE `codigo_empresa` = '$codigoEmpresa' and codigo_caixa = '$idCaixa'";	 

	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
		
    		$return["mensagemConfiguracao"] = "Dados salvos com sucesso!";
   	   		$return["sucessoConfiguracao"] = true;	

		}else{

			$return["mensagemConfiguracao"] = "Erro ao atualizar configuração";
			$return["sucessoConfiguracao"] = false;
			
		}

		mysqli_close($conexao);
		echo json_encode($return);

	    ?>