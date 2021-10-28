<?php 
	include "../ESPy_MySql/ESPy_MySqlCredenciais.php";

	$return["statusCadastroCaixa"] = false;
	$return["mensagemCadastraCaixa"] = "";

	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nome']);
	    $codigoEmpresa  = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "INSERT INTO caixas_coleta (nome, excluida, codigo_empresa) VALUES ('$nome', '0', '$codigoEmpresa');";	  
		$query2 = "SELECT codigo FROM caixas_coleta WHERE codigo_empresa = '$codigoEmpresa' ORDER BY codigo DESC";	 
			

	    $resultado = mysqli_query($conexao, $query);


        if($resultado > 0){
			
			$return["statusCadastroCaixa"] = true;
    		$return["mensagemCadastraCaixa"] = "Caixa inserida com sucesso!";

			$resultado2 = mysqli_query($conexao, $query2);
			$numrows = mysqli_num_rows($resultado2);
			if($numrows > 0){

				$obj = mysqli_fetch_object($resultado2);
				 
                $codigoCaixaCadastrada = (int) $obj->codigo;

				$return["statusCadastroCaixa"] = true;
    			$return["mensagemCadastraCaixa"] = "Caixa selecionada com sucesso!";

				$query3 = "INSERT INTO configuracao (codigo_caixa, codigo_empresa, tempo_coleta) VALUES ('$codigoCaixaCadastrada', '$codigoEmpresa', '15');";
				$resultado3 = mysqli_query($conexao, $query3);

				if($resultado3 > 0){
					$return["statusCadastroCaixa"] = true;
					$return["mensagemCadastraCaixa"] = "Configuração salva com sucesso!";
				}else{
					$return["statusCadastroCaixa"] = false;
					$return["mensagemCadastraCaixa"] = "Erro ao cadastrar configuração";
				}

			}else{
				$return["statusCadastroCaixa"] = false;
				$return["mensagemCadastraCaixa"] = "Erro ao selecionar caixa cadastrada";	
			}

		}else{
			
			$return["statusCadastroCaixa"] = false;
			$return["mensagemCadastraCaixa"] = "Erro ao cadastrar caixa de coleta.";
			
		}

		mysqli_close($conexao);
		echo json_encode($return);

	    ?>