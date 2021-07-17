<?php 
	include "mySqlConfig.php";

	
	    $nome = mysqli_real_escape_string($connect, $_POST['nome']);
	    $senha = mysqli_real_escape_string($connect, $_POST['senha']);
	    $email = mysqli_real_escape_string($connect, $_POST['email']);
	    $cpf = mysqli_real_escape_string($connect, $_POST['cpf']);
	    $telefone = mysqli_real_escape_string($connect, $_POST['telefone']);
	    $estado = mysqli_real_escape_string($connect, $_POST['estado']);
	    $cidade = mysqli_real_escape_string($connect, $_POST['cidade']);
	    $bairro = mysqli_real_escape_string($connect, $_POST['bairro']);
	    $rua = mysqli_real_escape_string($connect, $_POST['rua']);
	    $numero = mysqli_real_escape_string($connect, $_POST['numero']);
	    $complemento = mysqli_real_escape_string($connect, $_POST['complemento']);

	        $query = "INSERT INTO usuarios (nome, senha, email, cpf, telefone, estado, cidade, bairo, rua, numero, complemento)
	  			  VALUES('$nome', '$senha','$email','$cpf','$telefone','$estado','$cidade','$bairro','$rua','$numero','$complemento')";

	    $results = mysqli_query($connect, $query);

	    if($results>0)
	    {
	        echo "\nUsuario adicionado com sucesso!";
	    }else{
			echo "\nErro ao gravar dados do usuario.";
		}
	    

	    ?>