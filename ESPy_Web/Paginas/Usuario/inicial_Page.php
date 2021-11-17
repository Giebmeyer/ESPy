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

    <title>ESPy</title>

    <link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <nav class="navbar navbar-light bg-light">
            <a class="navbar-brand" href="./inicial_Page.php">
                <img src="../../assents/imagens/ic_launcher_foreground.png" width="50" height="50" alt="">
            </a>
        </nav>
        <a class="navbar-brand" href="./inicial_Page.php">ESPy</a>
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
                    <a class="nav-link" href="meuPerfil_Page.php">Meu Perfil</a>
                </li>

                <li class="nav-link disabled">|</li>
                <li class="nav-item">
                    <a class="nav-link" href="./inicial_Page.php">Principal</a>
                </li>
                <?php
                if ($_SESSION['usuario_chefe'] == 1 || $_SESSION['usuario_empregado'] == 1 ) {
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

    <div id="divBemVindoUsuario" class="container-fluid">
        <?php
        echo "Bem-Vindo ", $_SESSION['nome'], "!";
        ?>

    </div>
</body>

</html>