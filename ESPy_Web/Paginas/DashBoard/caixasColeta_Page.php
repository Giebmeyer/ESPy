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

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link href="../../css/style.css" rel="stylesheet" type="text/css" />
  <script src="../../js/functons.js"></script>


</head>



<body onload="loading()">
<div id="load"></div>

  <?php
  include '../../../header.php';
  ?>

  <div class="container p-5" id="divFiltroCadastroCaixasColeta">

    <?php

    if ($_SESSION['usuario_chefe'] == 1) {

      echo '<div class="input-group mb-3 mt-3">

      <div class="col">

        <form id="FormularioFiltraCaixas" method="POST" action="../../../ESPy_Php/WEB/ESPy_cadastroCaixasColeta.php">

          <input type="text" class="form-control" id="txtAdicionarFiltrarCaixaColeta" name="nomeNovaCaixa" placeholder="Nome da nova caixa de coleta" title="Preencha o campo antes de adicionar uma nova caixa!" required />

      </div><button class="btn btn-primary" type="submit" id="btnCaixasColetaFiltroAdiciona" onclick="loading()">Adicionar</button>';
    } else {

      echo '<div class="input-group mb-3 mt-3">

      <div class="col">

        <form id="FormularioFiltraCaixas" method="POST" action="../../../ESPy_Php/WEB/ESPy_cadastroCaixasColeta.php">

          <input type="text" disabled="" class="form-control" id="txtAdicionarFiltrarCaixaColeta" name="nomeNovaCaixa" placeholder="Você não possui permissão para utilizar esse campo." title="Preencha o campo antes de adicionar uma nova caixa!" required />

      </div><button class="btn btn-primary disabled" type="submit" id="btnCaixasColetaFiltoAdiciona">Adicionar</button>';
    }

    ?>



    </form>

  </div>
    <input type="text" class="form-control" id="buscaUser" name="buscaUser" placeholder="Filtrar Caixa de coleta" />
  </div>

  <div class="container-fluid p-5" id="divCaixasColeta">

    <?php

    include "../../../ESPy_Php/WEB/ESPy_listaCaixasColeta.php";

    if ($_SESSION['caixaColetaSemDados'] == "NaoPertence") {
      echo '<script>
        Swal.fire({
    icon: "question",
      title: "Ops...",
       text: "Essa caixa de coleta não pertence a você!"
    })
        </script>';
    }

    if ($_SESSION['caixaColetaSemDados'] == "SemDados") {
      echo '<script>
        Swal.fire({
    icon: "error",
      title: "Ops...",
       text: "Essa caixa de coleta ainda não possui nenhum dado coletado!"
    })
        </script>';
    }
    $_SESSION['caixaColetaSemDados'] = "SemErro";
    ?>

  </div>

  </div>
<script>
      $(function(){ 

  $("#buscaUser").keyup(function(){
    console.log($(this).val());
      var texto = $(this).val();
        
        $(".btnCaixaColetaSelecionarGeral").each(function(){
          console.log("Chegou aqui");
          var resultado = $(this).text().toUpperCase().indexOf(' '+texto.toUpperCase());
          
          if(resultado < 0) {
            $(this).fadeOut();
          }else {
            $(this).fadeIn();
          }
        }); 
    
      });
});
</script>
</body>

</html>