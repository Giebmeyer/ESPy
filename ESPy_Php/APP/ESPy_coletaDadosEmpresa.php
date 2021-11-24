<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $return["errorEmpresa"] = false;
    $return["mensagemEmpresa"] = "";
    $return["sucessoEmpresa"] = false;

        $codigoUsuario = mysqli_real_escape_string ($conexao,$_POST['codigoUsuario']);

		$query = "SELECT e.* FROM empresas e JOIN usuarios_empresas ue ON ue.codigo_empresa = e.codigo WHERE ue.codigo_usuario = '$codigoUsuario'";	 

	    $resultado = mysqli_query($conexao, $query);

        $numrows = mysqli_num_rows($resultado);
        $obj = mysqli_fetch_object($resultado);          
        if($numrows > 0){
            $return["errorEmpresa"] = false;
            $return["sucessoEmpresa"] = true;
            $return["mensagemEmpresa"] = "Empresa encontrada.";
            $return["codigo"] = (int) $obj->codigo;
            $return["chaveConvite"] = (int) $obj ->chaveConvite;
            $return["nome"] = $obj->nome;
            $return["ceo"] = $obj->ceo;
            $return["email_ceo"] = $obj->email_ceo;
            $return["telefone"] =  $obj->telefone;
            $return["cnpj"] =  $obj->cnpj;
            $return["estado"] = $obj->estado;
            $return["cidade"] = $obj->cidade;
            $return["bairro"] = $obj->bairro;
            $return["rua"] = $obj->rua;
            $return["numero"] = (int) $obj->numero;
            $return["complemento"] = $obj->complemento;
        }else{
            $return["sucessoEmpresa"] = 'false';
            $return["errorEmpresa"] = 'true';
            $return["mensagemEmpresa"] = "Nao existe empresa para esse codigo de usuário.";
        }
    echo json_encode($return);
    mysqli_close($conexao);

	?>