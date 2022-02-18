<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nome']);
 	    $senha = mysqli_real_escape_string ($conexao,$_POST['senha']);
		$ConfirmaSenha = mysqli_real_escape_string ($conexao,$_POST['ConfirmarSenha']);
		echo "confirma senha $confirmaSenha\n";
		echo "Senha $senha\n";
	    $email  = mysqli_real_escape_string ($conexao,$_POST['email']);
 	    $cpf = mysqli_real_escape_string ($conexao,$_POST['cpf']);
	    $telefone = mysqli_real_escape_string ($conexao,$_POST['telefone']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['estado']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidade']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairro']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['rua']);
	    $numero = (int) mysqli_real_escape_string ($conexao,$_POST['numero']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complemento']); 

		$query = "INSERT INTO usuarios (nome, senha , email, cpf, telefone, estado, cidade, bairro, rua, numero, complemento) VALUES ('$nome', HEX('$senha'),'$email', '$cpf', '$telefone', '$estado', '$cidade', '$bairro', '$rua', '$numero', '$complemento');";	 

	 
		session_start();	
		$_SESSION["mensagemCadastroUser"] = '';
        if(trim($senha) != trim($confirmaSenha)){
			$_SESSION["mensagemCadastroUser"] = "senhasDiferentes";
		//	header('Location: ../../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.php');
		}else{
		//	$resultado = mysqli_query($conexao, $query);
			if($resultado > 0){
				$_SESSION["mensagemCadastroUser"] = "sucessorCadastroUsuario";
		//		header('Location: /index.php');
			}else{
				$_SESSION["mensagemCadastroUser"] = "erroCadastro";
		//	header('Location: ../../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.php');
			}
		}

		echo $_SESSION["mensagemCadastroUser"];
		

		mysqli_close($conexao);
