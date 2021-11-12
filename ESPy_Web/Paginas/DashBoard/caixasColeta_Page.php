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

  <title>ESPy | DashBoard</title>

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

        <li class="nav-link disabled">|</li>
        <li class="nav-item">
          <a class="nav-link" href="">Caixas de Coleta</a>
        </li>

        <li class="nav-link disabled">|</li>
        <li class="nav-item">
          <a class="nav-link" href="../../index.html">Sair</a>
        </li>

    </div>
    </ul>
    </div>
  </nav>

  <div class="container p-5" id="divFiltroCadastroCaixasColeta">

    <div class="input-group mb-3 mt-3">
      <div class="col">
        <form id="FormularioFiltraCaixas" method="POST" action="../../../ESPy_Php/WEB/ESPy_listaCaixasColeta.php">
          <input type="text" class="form-control" id="txtAdicionarFiltrarCaixaColeta" name="filtroCaixasColeta" placeholder="Nome da caixa de coleta">
      </div>
      <button class="btn btn-primary" type="submit" id="btnCaixasColetaFiltoAdiciona">Filtrar</button>
      </form>
    </div>

    <div class="input-group mb-3 mt-3">
      <div class="col">
        <form id="FormularioFiltraCaixas" method="POST" action="../../../ESPy_Php/WEB/ESPy_cadastroCaixasColeta.php">
          <input type="text" class="form-control" id="txtAdicionarFiltrarCaixaColeta" name="nomeNovaCaixa" placeholder="Nome da nova caixa de coleta" title="Preencha o campo antes de adicionar uma nova caixa!" required/>
      </div>
      <button class="btn btn-primary" type="submit" id="btnCaixasColetaFiltoAdiciona">Adicionar</button>
      </form>
    </div>

  </div>

  <div class="container-fluid p-5" id="divCaixasColeta">
    <?php
    include "../../../ESPy_Php/WEB/ESPy_listaCaixasColeta.php";
    ?>
  </div>

</body>

</html>