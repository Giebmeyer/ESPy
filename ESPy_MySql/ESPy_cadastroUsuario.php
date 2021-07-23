<?php 
	include "ESPy_mySqlConfig.php";

	$return["erroCadastroUser"] = false;
	$return["mensagemCadastroUser"] = "";
	$return["sucessoCadastroUser"] = false;	

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

	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
			
			$return["erroCadastroUser"] = false;
    		$return["mensagemCadastroUser"] = "Cadastro realizado com sucesso!";
   	   		$return["sucessoCadastroUser"] = true;	
		}else{
			
			$return["erroCadastroUser"] = true;
			$return["mensagemCadastroUser"] = "Erro ao cadastrar usuário.";
			$return["sucessoCadastroUser"] = false;
			
		}

		mysqli_close($conexao);
		echo json_encode($return);

	    ?>