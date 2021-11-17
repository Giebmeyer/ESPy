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
          <a class="nav-link" href="">Minha Epresa</a>
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
    if ($_SESSION['usuario_chefe'] == 0 && $_SESSION['usuario_empregado'] == 0) {
      echo ' <div id="divBemVindoUsuario" class="container-fluid">
      <a class="btn btn-outline-primary" id="btnCadastrarEmpresa" href="../Empresa/cadastroEmpresa_Page.php"> Cadastrar Empresa </a>
       <a class="btn btn-outline-primary" id="btnJuntarSeEmpresa" href="../Empresa/entrarEmpresa_Page.php"> Juntar-se a uma empresa </a>
       </div>';
    } else {
      echo '
      
          <div class="container col-4 mt-5" id="ContainerMinhaEmpresaCentro">
              <form method="POST" action="/ESPy_Php/WEB/atualizarCadastroEmpresa.php" id="FormularioCadastro">
      
                  <!-- From Nome -->
                  <div class="form-group">
                      <label for="nome">Nome da empresa</label>
                      <input type="name" class="form-control" id="nomeEmpresa" name="nomeEmpresa" placeholder='.$_SESSION['nomeEmpresa'].'>
                  </div>

                  <div class="form-group mt-3">
                      <label for="nome">CEO da empresa</label>
                      <input type="name" class="form-control" id="CEOEmpresa" name="ceo" placeholder='.$_SESSION['ceoEmpresa'].' disabled="">
                  </div>

                  <div class="form-group mt-3">
                      <label for="nome">Email</label>
                      <input type="name" class="form-control" id="EmailCEOEmpresa" name="emailCeo" placeholder='.$_SESSION['email_ceoEmpresa'].' disabled="">
                  </div>
      
                  <!-- From CNPJ -->
                  <div class="form-group mt-3">
                      <label for="CPF">CNPJ</label>
                      <input type="text" class="form-control" id="cnpj" name="cnpj" placeholder='.$_SESSION['cnpjEmpresa'].' disabled="">
                  </div>
      
                  <!-- From Telefone -->
                  <div class="form-group mt-3">
                      <label for="Telefone">Telefone</label>
                      <input type="text" class="form-control" id="TelefoneEmpresa" name="TelefoneEmpresa" placeholder='.$_SESSION['telefoneEmpresa'].'>
                  </div>
      
                  <!-- From Estado/Cidade -->
                  <div class="input-group mb-3 mt-3">
                      <select id="UF" name="UF">
                          <option value="Null">'.$_SESSION['estadoEmpresa'].'</option>
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
                          <label for="cidade">Cidade</label>
                          <input type="text" class="form-control" id="cidade" name="cidadeEmpresa" placeholder='.$_SESSION['cidadeEmpresa'].'>
                      </div>
                  </div>
      
                  <!-- From Bairro -->
                  <div class="form-group">
                      <label for="bairro">Bairro</label>
                      <input type="text" class="form-control" id="bairroEmpresa" name="bairroEmpresa" placeholder='.$_SESSION['bairroEmpresa'].'>
                  </div>
      
                  <!-- From Rua/Número -->
                  <div class="input-group mb-3 mt-4" id="divRuaNumeroCadastroEmpresa">
                      <div class="col m-1">
                          <label for="rua">Rua</label>
                          <input type="text" class="form-control" id="ruaEmpresa" name="ruaEmpresa" placeholder='.$_SESSION['ruaEmpresa'].'>
                      </div>
                      <div class="col m-1">
                          <label for="numero">Número</label>
                          <input type="number" class="form-control" id="numeroEmpresa" name="numeroEmpresa" placeholder='.$_SESSION['numeroEmpresa'].'>
                      </div>
                  </div>
      
                  <!-- From Complemento -->
                  <div class="form-group">
                      <label for="complemento">Complemento</label>
                      <input type="text" class="form-control" id="complementoEmpresa" name="complementoEmpresa" placeholder='.$_SESSION['complementoEmpresa'].'>
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
          </div>
      
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>
          <script type="text/javascript">
              $("#TelefoneEmpresa").mask("(00) 0000-0000");
              $("#cnpj").mask("000.000.000/0000-00");
          </script>
    ';
    }
    ?>
  
</body>

</html>