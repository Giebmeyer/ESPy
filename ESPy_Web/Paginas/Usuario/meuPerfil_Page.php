<!DOCTYPE html>
<html lang="pt-br">
<?php
include "../../../ESPy_Php/WEB/ESPy_validaSessao.php";
?>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="imagem/png" href="../../assents/imagens/Logo_.png" />

    <title>ESPy | Meu Perfil</title>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="/ESPy_Web/js/functons.js"></script>
</head>

<body onload="loading()">
<div id="load"></div>
    <?php
    include '../../../header.php';
    ?>

    <?php
    echo '<div class="container col-4 mt-3" id="ContainerMeuPerfilCentro">
<form method="POST" action="../../../../ESPy_Php/WEB/ESPy_atualizarCadastroUsuario.php" id="FormularioCadastro">

    <!-- From Nome -->
    <div class="form-group">
        <label for="nome">Seu nome</label>
        <input type="name" class="form-control" id="nome" name="nome" aria-describedby="name" placeholder="' . $_SESSION['nome'] . '">
    </div>

    <!-- From email -->
    <div class="form-group mt-3">
        <label for="email">Endereço de email</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="' . $_SESSION['email'] . '"
            title="Preencha este campo." required disabled="">
    </div>

    <!-- From CPF -->
    <div class="form-group mt-3">
        <label for="CPF">CPF</label>
        <input type="text" class="form-control" id="cpf" name="cpf" placeholder="' . $_SESSION['cpf'] . '"
            title="Preencha este campo." required maxlength="12" disabled="">
    </div>

    <!-- From Telefone -->
    <div class="form-group mt-3">
        <label for="Telefone">Telefone celular</label>
        <input type="text" class="form-control" id="telefone" name="telefone" maxlength="14" placeholder="' . $_SESSION['telefone'] . '" >
    </div>

    <!-- From Estado/Cidade -->
    <div class="input-group mb-3 mt-3">
        <select id="UF" name="estado">
            <option value="' . $_SESSION['estado'] . '">' . $_SESSION['estado'] . '</option>
            <option value="AC">AC</option>
            <option value="AL">AL</option>
            <option value="AP">AP</option>
            <option value="AM">AM</option>
            <option value="BA">BA</option>
            <option value="CE">CE</option>
            <option value="DF">DF</option>
            <option value="ES">ES</option>
            <option value="GO">GO</option>
            <option value="MA">MA</option>
            <option value="MS">MS</option>
            <option value="MT">MT</option>
            <option value="MG">MG</option>
            <option value="PA">PA</option>
            <option value="PB">PB</option>
            <option value="PR">PR</option>
            <option value="PE">PE</option>
            <option value="PI">PI</option>
            <option value="RJ">RJ</option>
            <option value="RN">RN</option>
            <option value="RS">RS</option>
            <option value="RO">RO</option>
            <option value="RR">RR</option>
            <option value="SC">SC</option>
            <option value="SP">SP</option>
            <option value="SE">SE</option>
            <option value="TO">TO</option>
        </select>
        <div class="col">
            <label for="cidade">Sua Cidade</label>
            <input type="text" class="form-control" id="cidade" name="cidade" placeholder="' . $_SESSION['cidade'] . '">
        </div>
    </div>

    <!-- From Bairro -->
    <div class="form-group">
        <label for="bairro">Bairro</label>
        <input type="text" class="form-control" id="bairro" name="bairro" placeholder="' . $_SESSION['bairro'] . '">
    </div>

    <!-- From Rua/Número -->
    <div class="input-group mb-3 mt-4" id="divRuaNumero">
        <div class="col m-1">
            <label for="rua">Rua</label>
            <input type="text" class="form-control" id="rua" name="rua" placeholder="' . $_SESSION['rua'] . '">
        </div>
        <div class="col m-1">
            <label for="numero">Número</label>
            <input type="number" class="form-control" id="numero" name="numero" placeholder="' . $_SESSION['numero'] . '">
        </div>
    </div>

    <!-- From Complemento -->
    <div class="form-group">
        <label for="complemento">Complemento</label>
        <input type="text" class="form-control" id="complemento" name="complemento" placeholder="' . $_SESSION['complemento'] . '">
    </div>

    <!-- Botão Cadastro -->
    <div class="container mt-4">
        <div class="row justify-content-md-center">
            <div class="col-md-auto ">
                <button type="submit" class="btn btn-primary" id="BtnLogin">Atualizar Cadastro</button>
            </div>
        </div>
    </div>

</form>
</div>';
    ?>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>
    <script type="text/javascript">
        $("#telefone").mask("(00) 0 0000-0000");
        $("#cpf").mask("000.000.000-00");
    </script>
</body>

</html>