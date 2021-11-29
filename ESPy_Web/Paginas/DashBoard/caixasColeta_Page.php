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


  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link href="../../css/style.css" rel="stylesheet" type="text/css" />
  


</head>



<body>


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

      </div><button class="btn btn-primary" type="submit" id="btnCaixasColetaFiltoAdiciona">Adicionar</button>';
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

  <input type="text" class="form-control" id="buscaUser" name="buscauser" placeholder="Filtrar Caixa de coleta" />



  </div>

  <div class="container-fluid p-5" id="divCaixasColeta">

    <?php

    include "../../../ESPy_Php/WEB/ESPy_listaCaixasColeta.php";

    ?>

  </div>






  </div>

  <script type="text/javascript">
var btnEditar = window.document.getElementById("btnEditarCaixaColeta");
var btnExcluir = window.document.getElementById("btnExcluirCaixaColeta");

btnEditar.addEventListener("click", editar);
btnExcluir.addEventListener("click", excluir);

	function editar(){
	        var novoNomeCaixaColeta = window.prompt("Digite o novo nome para a caixa de coleta:");

       while(novoNomeCaixaColeta.length == 0) {
            novoNomeCaixaColeta = window.prompt("Digite o novo nome para a caixa de coleta:");
            if(novoNomeCaixaColeta == null){
                return;
            }
        }

		if(novoNomeCaixaColeta.length > 0){
		    javascript: location.href="../../../ESPy_Php/WEB/ESPy_editarCaixaColeta.php?codigoCaixaSelecionadaLista="+btnEditar.name+"&novoNome="+novoNomeCaixaColeta;
		}
		
	}
	
	function excluir(){
			var confirma = confirm("Deseja realmente excluir essa caixa de coleta?");
		if(confirma){
			javascript: location.href="../../../ESPy_Php/WEB/ESPy_removerCaixaColeta.php?codigoCaixaColeta="+btnExcluir.name;
		}
	}




    $("#buscaUser").on("keyup", function() {

      let value = $(this).val().toLowerCase();

      $("#divCaixasColeta a").filter(function() {

        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)

      });

    });
  </script>

</body>

</html>