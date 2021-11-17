<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	$return["erroCadastroEmpresa"] = false;
    $return["mensagemCadastroEmpresa"] = "";
    $return["sucessoCadastroEmpresa"] = false;
	
	
	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nomeEmpresa']);
		session_start();
	    $ceo  = $_SESSION['nome'];
	    $email_ceo  = $_SESSION['email'];
        $telefone = mysqli_real_escape_string ($conexao,$_POST['TelefoneEmpresa']);
 	    $cnpj = mysqli_real_escape_string ($conexao,$_POST['cnpj']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['UFEmpresa']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidadeEmpresa']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairroEmpresa']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['ruaEmpresa']);
	    $numero = (int)  mysqli_real_escape_string ($conexao,$_POST['numeroEmpresa']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complementoEmpresa']);
	    $codigoUsuario = (int) mysqli_real_escape_string ($conexao,$_SESSION['codigo']);  
		$chaveConvite = (int) rand(100000, 999999);

		$query  = "INSERT INTO empresas (`chaveConvite`, `nome`, `ceo`, `email_ceo`, `telefone`, `cnpj`, `estado`, `cidade`, `bairro`, `rua`, `numero`, `complemento`) VALUES ('$chaveConvite', '$nome', '$ceo', '$email_ceo', '$telefone', '$cnpj',  '$estado', '$cidade', '$bairro', '$rua', '$numero', '$complemento');";	 
        $query2 = "UPDATE usuarios SET usuario_chefe = 1 WHERE codigo = '$codigoUsuario';"; 
		$query3 = "SELECT * FROM empresas WHERE email_ceo = '$email_ceo';";


	    $resultado = mysqli_query($conexao, $query);

		if($resultado > 0){
			$resultado2 = mysqli_query($conexao, $query2); 

			if($resultado2 > 0){
				$resultado3 = mysqli_query($conexao, $query3);
				$numrows = mysqli_num_rows($resultado3);

				if($numrows>0){
					$obj2 = mysqli_fetch_object($resultado3);
					 
					if($email_ceo == $obj2->email_ceo){
						$codigoEmpresa = (int) $obj2->codigo;
						$query4 = "INSERT INTO usuarios_empresas (`codigo_usuario`, `codigo_empresa`) VALUES ('$codigoUsuario', '$codigoEmpresa');";
						$resultado4 = mysqli_query($conexao, $query4);

							$_SESSION["codigoEmpresa"] = (int) $obj2->codigo;
							$_SESSION["chaveConvite"] = (int) $obj2->chaveConvite;
							$_SESSION["nomeEmpresa"] = $obj2->nome;
							$_SESSION["ceoEmpresa"] = $obj2->ceo;
							$_SESSION["email_ceoEmpresa"] = $obj2->email_ceo;
							$_SESSION["telefoneEmpresa"] =  $obj2->telefone;
							$_SESSION["cnpjEmpresa"] =  $obj2->cnpj;
							$_SESSION["estadoEmpresa"] = $obj2->estado;
							$_SESSION["cidadeEmpresa"] = $obj2->cidade;
							$_SESSION["bairroEmpresa"] = $obj2->bairro;
							$_SESSION["ruaEmpresa"] = $obj2->rua;
							$_SESSION["numeroEmpresa"] = (int) $obj2->numero;
							$_SESSION["complementoEmpresa"] = $obj2->complemento;
							$_SESSION["usuario_chefe"] = 1;
							$_SESSION["usuario_empregado"] = 0;

					header('Location: ../../ESPy_Web/Paginas/Usuario/inicial_Page.php');


						if($resultado4 > 0){
							$return["mensagemCadastroEmpresa"] = 'Empresa cadastrada com sucesso!';
							$return["erroCadastroEmpresa"] = false;	
							$return["sucessoCadastroEmpresa"] = true;

						}else{
							$return["mensagemCadastroEmpresa"] = 'Erro ao inserir usuario_empresa.';
							$return["erroCadastroEmpresa"] = true;


						}
					}else{
						$return["mensagemCadastroEmpresa"] = 'Email nao é ceo.';
						$return["erroCadastroEmpresa"] = true;


					}
				}else{
					$return["erroCadastroEmpresa"] = true;
					$return["mensagemCadastroEmpresa"] = 'Email nao cadastrado.';


				}  
			}else{
				$return["erroCadastroEmpresa"] = true;
				$return["mensagemCadastroEmpresa"] = 'Erro no update usuario_chefe.';


			}
		}else{
			$return["erroCadastroEmpresa"] = true;
			$return["mensagemCadastroEmpresa"] = 'Erro ao cadastrar empresa.';


		}

		mysqli_close($conexao);
		echo json_encode($return);
