<?php 
	include "ESPy_mySqlConfig.php";

	
	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nome']);
 	    $senha = mysqli_real_escape_string ($conexao,$_POST['senha']);
	    $email  = mysqli_real_escape_string ($conexao,$_POST['email']);
 	    $cpf = (int) mysqli_real_escape_string ($conexao,$_POST['cpf']);
	    $telefone = (int)  mysqli_real_escape_string ($conexao,$_POST['telefone']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['estado']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidade']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairro']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['rua']);
	    $numero = (int)  mysqli_real_escape_string ($conexao,$_POST['numero']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complemento']); 

		$query = "INSERT INTO usuarios (nome, senha , email, cpf, telefone, estado, cidade, bairro, rua, numero, complemento) VALUES ('$nome', '$senha','$email', '$cpf', '$telefone', '$estado', '$cidade', '$bairro', '$rua', '$numero', '$complemento');";	 

	    $rasultado = mysqli_query($conexao, $query);


	    if($rasultado>0)
	    {
	        echo "\nUsuario adicionado com sucesso!";
			return
	    }else{
			echo "\nErro ao gravar dados do usuario.";
		} 
	    ?>