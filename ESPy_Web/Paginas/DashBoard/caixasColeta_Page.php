<!DOCTYPE html>
<html lang="pt-br">
<?php
session_start();

if ((!isset($_SESSION['email']) == true) and (!isset($_SESSION['senha']) == true)) {
  header('location: ../../index.html');
}
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
        <li class="nav-item">
          <a class="nav-link" href="../Usuario/inicial_Page.php">Principal</a>
        </li>
        <li class="nav-link disabled">|</li>
        <li class="nav-item">
          <a class="nav-link" href="">Caixas de Coleta</a>
        </li>
    </div>
    </ul>
    </div>
  </nav>

  <div class="container p-5">
    <div class="input-group mb-3 mt-3">
      
      <div class="col">
        <label for="cidade">Filtrar Caixa de Coleta</label>
        <input type="text" class="form-control" id="filtroCaixasColeta" name="filtroCaixasColeta" placeholder="Nome da caixa de coleta">
      </div>
      <button type="submit"  id="BtnFiltrarCaixasColeta">Filtrar</button>
    </div>
  </div>

  <div class="container-fluid p-5">
    <?php
    include "../../../ESPy_Php/WEB/ESPy_listaCaixasColeta.php";
    ?>
  </div>

  <div id="CaixaColeta">
    <div id="txtCaixaColeta">Adicione uma nova caixa de coleta!</div>

    <div id="ModalNovaCaixa">
      <button id="btnModalNovaCaixa" class="nav-link" data-bs-toggle="modal" data-bs-target="#modalNovaCaixa">Adicionar Nova Caixa</button>
    </div>

  </div>

  <!-- Modal -->
  <div class="modal fade" id="modalNovaCaixa" tabindex="-1" aria-labelledby="modalNovaCaixa" aria-hidden="true">
    <div class="modal-dialog ">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalNovaCaixa">Informe o nome da nova caixa
          </h5>
        </div>

        <form action="../../../ESPy_Php/WEB/ESPy_cadastroCaixasColeta.php" method="POST">
          <div class="modal-body">
            <!-- From Nova Caixa -->
            <div class="form-group">
              <input type="name" class="form-control" id="nomeNovaCaixa" name="nomeNovaCaixa" placeholder="Nova Caixa">
            </div>
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="BtnCancelarRecoverPass">Cancelar</button>
            <input type="submit" id="btnCaixaColeta" value="Cadastrar">
          </div>
        </form>
      </div>
    </div>
  </div>

</body>

</html>