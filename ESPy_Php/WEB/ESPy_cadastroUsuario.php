<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nome']);
 	    $senha = mysqli_real_escape_string ($conexao,$_POST['senha']);
	    $email  = mysqli_real_escape_string ($conexao,$_POST['email']);
 	    $cpf = mysqli_real_escape_string ($conexao,$_POST['cpf']);
	    $telefone = mysqli_real_escape_string ($conexao,$_POST['telefone']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['estado']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidade']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairro']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['rua']);
	    $numero = (int) mysqli_real_escape_string ($conexao,$_POST['numero']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complemento']); 

		$query = "INSERT INTO usuarios (nome, senha , email, cpf, telefone, estado, cidade, bairro, rua, numero, complemento) VALUES ('$nome', MD5('$senha'),'$email', '$cpf', '$telefone', '$estado', '$cidade', '$bairro', '$rua', '$numero', '$complemento');";	 

	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
			header('Location: /index.php');
		}else{
			$return["mensagemCadastroUser"] = "Erro ao cadastrar usuário.";
		}

		mysqli_close($conexao);
		echo json_encode($return);
