<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	    $nome  = mysqli_real_escape_string ($conexao,$_POST['nome']);
	    $telefone = mysqli_real_escape_string ($conexao,$_POST['telefone']);
	    $estado =  mysqli_real_escape_string ($conexao,$_POST['estado']);
	    $cidade =  mysqli_real_escape_string ($conexao,$_POST['cidade']);
	    $bairro =  mysqli_real_escape_string ($conexao,$_POST['bairro']);
	    $rua =  mysqli_real_escape_string ($conexao,$_POST['rua']);
	    $numero = (int) mysqli_real_escape_string ($conexao,$_POST['numero']);
	    $complemento =  mysqli_real_escape_string ($conexao,$_POST['complemento']); 
        session_start();
        $codigoUser = $_SESSION['codigo'];

		$query = "UPDATE usuarios SET nome = '$nome' , telefone = '$telefone' , estado = '$estado' , cidade = '$cidade' , bairro = '$bairro' , rua = '$rua' , numero = '$numero' , complemento = '$complemento' where codigo = '$codigoUser'";	 

	    $resultado = mysqli_query($conexao, $query);

        if($resultado > 0){

        $resultado2 = mysqli_query($conexao, "SELECT * FROM usuarios WHERE codigo = '$codigoUser'");
        $numrows2 = mysqli_num_rows($resultado2);
        if ($numrows2 > 0) {
        $obj2 = mysqli_fetch_object($resultado2);
        $_SESSION['codigo'] = (int) $obj2->codigo;
        $_SESSION['nome'] = $obj2->nome;
        $_SESSION['senha'] = $obj2->senha;
        $_SESSION['email'] = $obj2->email;
        $_SESSION['cpf'] = $obj2->cpf;
        $_SESSION['telefone'] = $obj2->telefone;
        $_SESSION['estado'] = $obj2->estado;
        $_SESSION['cidade'] = $obj2->cidade;
        $_SESSION['bairro'] = $obj2->bairro;
        $_SESSION['rua'] = $obj2->rua;
        $_SESSION['numero'] = (int) $obj2->numero;
        $_SESSION['complemento'] = $obj2->complemento;
        $_SESSION['usuario_chefe'] = (int) $obj2->usuario_chefe;
        $_SESSION['usuario_empregado'] = (int) $obj2->usuario_empregado;

			header('Location: ../../ESPy_Web/Paginas/Usuario/meuPerfil_Page.php');
        }
		}else{
			header('Location: ../../ESPy_Web/Paginas/Usuario/meuPerfil_Page.php');
		}
		mysqli_close($conexao);
?>