<?php 
	include "ESPy_mySqlConfig.php";

	$return["erroCadastroEmpresa"] = false;
    $return["mensagemCadastroEmpresa"] = "";
    $return["sucessoCadastroEmpresa"] = false;
	
	
	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nome']);
 	    $ceo = mysqli_real_escape_string ($conexao,$_POST['ceo']);
	    $email_ceo  = mysqli_real_escape_string ($conexao,$_POST['email_ceo']);
        $telefone = (int)  mysqli_real_escape_string ($conexao,$_POST['telefone']);
 	    $cpf_cnpj = (int) mysqli_real_escape_string ($conexao,$_POST['cpf_cnpj']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['estado']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidade']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairro']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['rua']);
	    $numero = (int)  mysqli_real_escape_string ($conexao,$_POST['numero']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complemento']); 
	    $codigoUsuario = (int) mysqli_real_escape_string ($conexao,$_POST['codigoUsuario']);  

		$query  = "INSERT INTO empresa (`nome`, `ceo`, `email_ceo`, `telefone`, `cpf_cnpj`, `estado`, `cidade`, `bairro`, `rua`, `numero`, `complemento`) VALUES ('$nome', '$ceo', '$email_ceo', '$telefone', '$cpf_cnpj',  '$estado', '$cidade', '$bairro', '$rua', '$numero', '$complemento');";	 
        $query2 = "UPDATE usuarios SET usuario_chefe = 1 WHERE codigo = '$codigoUsuario';"; 
		$query3 = "SELECT * FROM empresa WHERE email_ceo = '$email_ceo';";


	    $resultado = mysqli_query($conexao, $query);


		if($resultado > 0){
			$resultado2 = mysqli_query($conexao, $query2); 

			if($resultado2 > 0){
				$resultado3 = mysqli_query($conexao, $query3);

				if($resultado3>0){
					$obj = mysqli_fetch_object($resultado3);
					 
					if($email_ceo == $obj->email_ceo){
						$codigoEmpresa = (int) $obj->codigo;
						$query4 = "INSERT INTO usuarios_empresa (`codigo_usuario`, `codigo_empresa`) VALUES ('$codigoUsuario', '$codigoEmpresa');";
						$resultado4 = mysqli_query($conexao, $query4);

						if($resultado4 > 0){
							$return["erroCadastroEmpresa"] = false;	
							$return["sucessoCadastroEmpresa"] = true;

						}else{
							$return["mensagem"] = 'Erro ao inserir usuario_empresa.';
							$return["erroCadastroEmpresa"] = true;

						}
					}else{
						$return["mensagem"] = 'Email nao é ceo.';
						$return["erroCadastroEmpresa"] = true;

					}
				}else{
					$return["erroCadastroEmpresa"] = true;
					$return["mensagem"] = 'Email nao cadastrado.';

				}  
			}else{
				$return["erroCadastroEmpresa"] = true;
				$return["mensagem"] = 'Erro no update usuario_chefe.';

			}
		}else{
			$return["erroCadastroEmpresa"] = true;
			$return["mensagem"] = 'Erro ao cadastrar empresa.';

		}

	    ?>
