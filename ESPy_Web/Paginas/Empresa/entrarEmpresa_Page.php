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
        <div class="container-fluid">
            <a class="navbar-brand" href="./inicial_Page.php">
                <img src="../../assents/imagens/ic_launcher_foreground.png" width="50" height="50" alt="">
            </a>
        
        <a class="navbar-brand" href="./inicial_Page.php">ESPy</a>
<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">

                <li class="nav-link disabled">|</li>
                
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Minha Empresa
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
          <?php
                if ($_SESSION['usuario_chefe'] == 1 || $_SESSION['usuario_empregado'] == 1) {
                    echo ('<li><a class="dropdown-item" href="../Empresa/funcionarios_Page.php">Funcionários</a></li>');
                }
                ?>
                <li><a class="dropdown-item" href="../Empresa/minhaEmpresa_Page.php">Cadastro</a></li>
          </ul>
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

    <div id="divCamposEntrarEmpresa" class="container-fluid mt-3">
        <form id="FormularioEntrarEmpresa" method="POST" action="../../../ESPy_Php/WEB/ESPy_entrarEmpresa.php">
            <h4 id="txtEntrarEmpresa" class="display-4"> Digite o código de convite da sua empresa:</h4>
            <div class="form-group">
                <div class="container px-4 mt-3">
                    <div class="row gx-5">
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa1" name="n1_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa2" name="n2_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa3" name="n3_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa4" name="n4_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa5" name="n5_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa6" name="n6_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                    </div>
                </div>
            </div>
           
        </form>
    </div>
     <div id="divBtnEntrarEmpresa"> <button type="submit" class="btn btn-primary mb-4" id="BtnLogin">Entrar</button></div>
        <script>
	document.getElementById('txtCodigoEntrarEmpresa1').addEventListener('input', limitaTotal)
	document.getElementById('txtCodigoEntrarEmpresa1').focus();
	document.getElementById('txtCodigoEntrarEmpresa2').addEventListener('input', limitaTotal)
	document.getElementById('txtCodigoEntrarEmpresa3').addEventListener('input', limitaTotal)
	document.getElementById('txtCodigoEntrarEmpresa4').addEventListener('input', limitaTotal)
	document.getElementById('txtCodigoEntrarEmpresa5').addEventListener('input', limitaTotal)
	document.getElementById('txtCodigoEntrarEmpresa6').addEventListener('input', limitaTotal)

function limitaTotal (evt) {
    var input = evt.target;
    var value = input.value;

    if (value.length <= 1) {
        return;
    }

    input.value = input.value.substr(0, 1); 
}
    </script>
    
</body>
</html>