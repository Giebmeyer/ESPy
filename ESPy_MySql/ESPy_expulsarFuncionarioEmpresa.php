<?php 
	include "ESPy_mySqlConfig.php";

    $return["mensagemExpulsaUsuario"] = "";
    $return["StatusExpulsausuario"] = false;

        $codigoUsuarioSelecionadoLista = mysqli_real_escape_string ($conexao,$_POST['codigoUsuarioSelecionadoLista']);

		$query = "DELETE FROM `usuarios_empresa` WHERE `codigo_usuario` = $codigoUsuarioSelecionadoLista";	 
		$query2 = "UPDATE usuarios SET usuario_empregado = 0 WHERE `codigo` = $codigoUsuarioSelecionadoLista";
	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
			$resultado2 = mysqli_query($conexao, $query2);	

			if($resultado2){
				$return["mensagemExpulsaUsuario"] = "Funcionário removido com sucesso!";
				$return["StatusExpulsausuario"] = true;	
			}else{
				$return["mensagemExpulsaUsuario"] = "Erro ao remover funcionário.";
				$return["StatusExpulsausuario"] = false;
			}
    		
		}else{
			
			$return["mensagemExpulsaUsuario"] = "Erro ao remover funcionário.";
			$return["StatusExpulsausuario"] = false;
		}

  echo json_encode($return);    
  mysqli_close($conexao);


	?>