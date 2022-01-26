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

      </div><button class="btn btn-primary disabled" type="submit" id="btnCaixasColetaFiltroAdiciona">Adicionar</button>';
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

  <div class="container p-5" id="divFiltrosComparacao">
    <div>
      O que você deseja comparar?

    </div>
    <form>
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="compare_Datas">
        <label class="form-check-label" for="inlineRadio1">Periodos</label>
      </div>
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="compare_Sensores">
        <label class="form-check-label" for="inlineRadio2">Sensores</label>
      </div>
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="compare_Caixas">
        <label class="form-check-label" for="inlineRadio3">Caixas</label>
      </div>

      <div id="filtroData">
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio4" value="compare_Datas_1periodo">
          <label class="form-check-label" for="inlineRadio4">1 Periodo</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio5" value="compare_Datas_2periodo">
          <label class="form-check-label" for="inlineRadio5">2 periodos</label>

        </div>

      </div>

      <div class="mt-2" id="periodo1Div">
        <label for="dataInicial">Data inicial: </label>
        <input id="dataInicial" type="date">
        <label for="dataFinal">Data final: </label>
        <input id="dataFinal" type="date">
      </div>
      <div class="mt-2" id="periodo2Div">
        <div>
          <label for="dataInicial_Periodo1">Data inicial: </label>
          <input id="dataInicial_Periodo1" type="date">
          <label for="dataFinal_Periodo1">Data final: </label>
          <input id="dataFinal_Periodo1" type="date">
        </div>
        <div class="mt-1">
          <label for="dataInicial_Periodo2">Data inicial: </label>
          <input id="dataInicial_Periodo2" type="date">
          <label for="dataFinal_Periodo2">Data Final: </label>
          <input id="dataFinal_Periodo2" type="date">
        </div>
      </div>

      <div id="filtroSensores">
        Voce vai filtrar SENSORES.
      </div>
      <div id="filtroCaixas">
        Voce vai filtrar CAIXAS.
      </div>

    </form>
    <div class="mt-4">
      </br>
      <button class="btn btn-primary" id="BtnLogin">Cancelar</button>
      <button class="btn btn-primary" id="BtnComparar">Comparar</button>
    </div>
  </div>

  <script>
    $(function() {

      $("#buscaUser").keyup(function() {

        var texto = $(this).val();

        $(".btnCaixaColetaSelecionarGeral").each(function() {
          var resultado = $(this).text().toUpperCase().indexOf(' ' + texto.toUpperCase());

          if (resultado < 0) {
            $(this).fadeOut();
          } else {
            $(this).fadeIn();
          }
        });

      });
    });

    $('#divFiltrosComparacao').hide();

    function Comparar(codigoCaixa) {
      var agora = new Date();
      var dia = ("0" + agora.getDate()).slice(-2);
      var mes = ("0" + (agora.getMonth() + 1)).slice(-2);
      var dataHoje = agora.getFullYear() + "-" + (mes) + "-" + (dia);

      var qtdPeriodo = 0;

      $('#dataInicial').val(dataHoje);
      $('#dataFinal').val(dataHoje);
      $('#dataInicial_Periodo1').val(dataHoje);
      $('#dataFinal_Periodo1').val(dataHoje);
      $('#dataInicial_Periodo2').val(dataHoje);
      $('#dataFinal_Periodo2').val(dataHoje);

      $('#divFiltrosComparacao').show();
      $('#filtroSensores').hide();
      $('#filtroData').hide();
      $('#filtroCaixas').hide();

      $('#periodo1Div').hide();
      $('#periodo2Div').hide();

      $('#BtnComparar').hide();

      document.getElementById('BtnLogin').addEventListener('click', function() {
        $('#divFiltrosComparacao').hide();
      })

      document.getElementById('inlineRadio1').addEventListener('change', function() {
        $('#filtroSensores').hide();
        $('#filtroData').show();
        $('#filtroCaixas').hide();


        document.getElementById('inlineRadio4').addEventListener('change', function() {
          qtdPeriodo = 1;
          $('#periodo1Div').show();
          $('#periodo2Div').hide();
          $('#BtnComparar').show();
        });

        document.getElementById('inlineRadio5').addEventListener('change', function() {
          qtdPeriodo = 2;
          $('#periodo2Div').show();
          $('#periodo1Div').hide();
          $('#BtnComparar').show();
        });

      });
      document.getElementById('inlineRadio2').addEventListener('change', function() {
        $('#periodo1Div').hide();
        $('#periodo2Div').hide();
        $('#BtnComparar').show();

        $('#filtroSensores').show();
        $('#filtroData').hide();
        $('#filtroCaixas').hide();


      });
      document.getElementById('inlineRadio3').addEventListener('change', function() {
        $('#periodo1Div').hide();
        $('#periodo2Div').hide();
        $('#BtnComparar').show();

        $('#filtroSensores').hide();
        $('#filtroData').hide();
        $('#filtroCaixas').show();

      });


      document.getElementById('BtnComparar').addEventListener('click', function() {
        console.log(qtdPeriodo);
        
        if (qtdPeriodo == 1) {

          var dataInicial = document.getElementById('dataInicial').value;
          var dataFinal = document.getElementById('dataFinal').value;

          javascript: location.href = "../../../ESPy_Php/WEB/ESPy_comparaSensoresPeriodo.php?codigoCaixaColeta= " + codigoCaixa + "&qtdPeriodo=" + qtdPeriodo + "&dataInicial=" + dataInicial + "&dataFinal=" + dataFinal;
        }

        if (qtdPeriodo == 2) {

          var dataInicialp1 = document.getElementById('dataInicial_Periodo1').value;
          var dataFinalp1 = document.getElementById('dataFinal_Periodo1').value;
          var dataInicialp2 = document.getElementById('dataInicial_Periodo2').value;
          var dataFinalp2 = document.getElementById('dataFinal_Periodo2').value;

          javascript: location.href = "../../../ESPy_Php/WEB/ESPy_comparaSensoresPeriodo.php?codigoCaixaColeta= " + codigoCaixa + "&qtdPeriodo=" + qtdPeriodo + "&dataInicialp1=" + dataInicialp1 + "&dataFinalp1=" + dataFinalp1 + "&dataInicialp2=" + dataInicialp2 + "&dataFinalp2=" + dataFinalp2;
        }
      });
    }
  </script>
</body>

</html>