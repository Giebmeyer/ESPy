<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nomeEmpresa']);
	    $telefone = mysqli_real_escape_string ($conexao,$_POST['telefoneEmpresa']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['estadoEmpresa']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidadeEmpresa']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairro']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['ruaEmpresa']);
	    $numero = (int) mysqli_real_escape_string ($conexao,$_POST['numeroEmpresa']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complementoEmpresa']); 
	    
        session_start();
        $codigoUser = $_SESSION['codigo'];
        $codigoEmp = $_SESSION["codigoEmpresa"];
   
        if($nome == "" || $nome == NULL){
            $nome = $_SESSION['nomeEmpresa'];
        }
        if($telefone == "" || $telefone == NULL){
            $telefone = $_SESSION['telefoneEmpresa'];
        }
        if($estado == "" || $estado == NULL){
            $estado = $_SESSION['estadoEmpresa'];
        }
        if($cidade == "" || $cidade == NULL){
            $cidade = $_SESSION['cidadeEmpresa'];
        }  
        if($bairro == "" || $bairro == NULL){
            $bairro = $_SESSION['bairroEmpresa'];
        }
        if($rua == "" || $rua == NULL){
            $rua = $_SESSION['ruaEmpresa'];
        }
        if($numero == "" || $numero == NULL){
            $numero = $_SESSION['numeroEmpresa'];
        }
        if($complemento == "" || $complemento == NULL){
            $complemento = $_SESSION['complementoEmpresa'];
        }
        

	$query = "UPDATE empresas SET nome = '$nome' , telefone = '$telefone' , estado = '$estado' , cidade = '$cidade' , bairro = '$bairro' , rua = '$rua' , numero = '$numero' , complemento = '$complemento' where codigo = '$codigoEmp'";	 

	    $resultado = mysqli_query($conexao, $query);

        if($resultado > 0){

        $resultado2 = mysqli_query($conexao, "SELECT e.* FROM empresas e where e.codigo = '$codigoEmp'");
        $numrows2 = mysqli_num_rows($resultado2);
        if ($numrows2 > 0) {
        $obj2 = mysqli_fetch_object($resultado2);
        
        $_SESSION['nomeEmpresa'] = $obj2->nome;
        $_SESSION['telefoneEmpresa'] = $obj2->telefone;
        $_SESSION['estadoEmpresa'] = $obj2->estado;
        $_SESSION['cidadeEmpresa'] = $obj2->cidade;
        $_SESSION['bairroEmpresa'] = $obj2->bairro;
        $_SESSION['ruaEmpresa'] = $obj2->rua;
        $_SESSION['numeroEmpresa'] = (int) $obj2->numero;
        $_SESSION['complementoEmpresa'] = $obj2->complemento;


			header('Location: ../../ESPy_Web/Paginas/Empresa/minhaEmpresa_Page.php');
        }
		}else{
			header('Location: ../../ESPy_Web/Paginas/Empresa/minhaEmpresa_Page.php');
		}
		mysqli_close($conexao);
?>