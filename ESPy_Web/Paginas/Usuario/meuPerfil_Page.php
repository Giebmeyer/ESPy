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

  <title>ESPy | Empresa</title>

  <link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
  <link href="../../css/style.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
  <script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <nav class="navbar navbar-light bg-light">
      <a class="navbar-brand" href="../Usuario/inicial_Page.php">
        <img src="../../assents/imagens/ic_launcher_foreground.png" width="50" height="50" alt="">
      </a>
    </nav>
    <a class="navbar-brand" href="../Usuario/inicial_Page.php">ESPy</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#conteudoNavbarSuportado" aria-controls="conteudoNavbarSuportado" aria-expanded="false" aria-label="Alterna navegação">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="conteudoNavbarSuportado">
      <ul class="navbar-nav mr-auto">
        <li class="nav-link disabled">|</li>
        <li class="nav-item active">
          <a class="nav-link" href="../Empresa/minhaEmpresa_Page.php">Minha Epresa</a>
        </li>

        <li class="nav-link disabled">|</li>
        <li class="nav-item active">
          <a class="nav-link" href="../Usuario/meuPerfil_Page.php">Meu Perfil</a>
        </li>

        <li class="nav-link disabled">|</li>
        <li class="nav-item">
          <a class="nav-link" href="../Usuario/inicial_Page.php">Principal</a>
        </li>

        <?php
        if ($_SESSION['usuario_chefe'] == 1 || $_SESSION['usuario_empregado'] == 1) {
          echo ('<li class="nav-link disabled">|</li>
                <li class="nav-item">
                    <a class="nav-link" href="../DashBoard/caixasColeta_Page.php">Caixas de Coleta</a>
                </li>');
        }
        ?>

        <li class="nav-link disabled">|</li>
        <li class="nav-item">
          <a class="nav-link" href="../../../ESPy_Php/WEB/ESPy_logoff.php?sair=true">Sair</a>
        </li>


      </ul>

    </div>
  </nav>

  <?php
echo '<div class="container col-4" id="ContainerMeuPerfilCentro">
<form method="POST" action="../../../ESPy_Php/WEB/atualizarCadastroUsuario.php" id="FormularioCadastro">

    <!-- From Nome -->
    <div class="form-group">
        <label for="nome">Seu nome</label>
        <input type="name" class="form-control" id="nome" name="nome" aria-describedby="name" placeholder='.$_SESSION['nome'].'
            title="Preencha este campo." required>
    </div>

    <!-- From email -->
    <div class="form-group mt-3">
        <label for="email">Endereço de email</label>
        <input type="email" class="form-control" id="email" name="email" placeholder='.$_SESSION['email'].'
            title="Preencha este campo." required disabled="">
    </div>

    <!-- From CPF -->
    <div class="form-group mt-3">
        <label for="CPF">CPF</label>
        <input type="text" class="form-control" id="cpf" name="cpf" placeholder='.$_SESSION['cpf'].'
            title="Preencha este campo." required maxlength="12" disabled="">
    </div>

    <!-- From Telefone -->
    <div class="form-group mt-3">
        <label for="Telefone">Telefone celular</label>
        <input type="text" class="form-control" id="telefone" name="telefone" placeholder='.$_SESSION['telefone'].'
            title="Preencha este campo." required maxlength="14">
    </div>

    <!-- From Estado/Cidade -->
    <div class="input-group mb-3 mt-3">
        <select id="UF" name="estado" title="Selecione um estado." required>
            <option value="Null">'.$_SESSION['estado'].'</option>
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
            <input type="text" class="form-control" id="cidade" name="cidade" placeholder='.$_SESSION['cidade'].'
                title="Preencha este campo." required>
        </div>
    </div>

    <!-- From Bairro -->
    <div class="form-group">
        <label for="bairro">Bairro</label>
        <input type="text" class="form-control" id="bairro" name="bairro" placeholder='.$_SESSION['bairro'].'
            title="Preencha este campo." required>
    </div>

    <!-- From Rua/Número -->
    <div class="input-group mb-3 mt-4" id="divRuaNumero">
        <div class="col m-1">
            <label for="rua">Rua</label>
            <input type="text" class="form-control" id="rua" name="rua" placeholder='.$_SESSION['rua'].'
                title="Preencha este campo." required>
        </div>
        <div class="col m-1">
            <label for="numero">Número</label>
            <input type="number" class="form-control" id="numero" name="numero" placeholder='.$_SESSION['numero'].'
                title="Preencha este campo." required>
        </div>
    </div>

    <!-- From Complemento -->
    <div class="form-group">
        <label for="complemento">Complemento</label>
        <input type="text" class="form-control" id="complemento" name="complemento" placeholder='.$_SESSION['complemento'].'>
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