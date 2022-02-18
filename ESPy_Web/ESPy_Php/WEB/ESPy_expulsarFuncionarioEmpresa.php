<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

        $codigoUsuarioSelecionadoLista = mysqli_real_escape_string ($conexao,$_GET['codigoUsuarioSelecionadoLista']);

		$query = "UPDATE `usuarios_empresas` SET `saiuEmpresa` = 'E' WHERE `codigo_usuario` = $codigoUsuarioSelecionadoLista";	 
		$query2 = "UPDATE `usuarios` SET usuario_empregado = 0 WHERE `codigo` = $codigoUsuarioSelecionadoLista";
	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
			$resultado2 = mysqli_query($conexao, $query2);	

			if($resultado2){
				    header('Location: ../../ESPy_Web/Paginas/Empresa/funcionarios_Page.php');
			}else{
				    header('Location: ../../ESPy_Web/Paginas/Empresa/funcionarios_Page.php');
			}
    		
		}else{
			header('Location: ../../ESPy_Web/Paginas/Empresa/funcionarios_Page.php');
		}

  echo json_encode($return);    
  mysqli_close($conexao);


	?>