<?php
include("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");

$codigoEmpresa  = $_SESSION['codigoEmpresa'];

$queryResult = mysqli_query($conexao, "select cc.* from caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' and cc.excluida != 1 order by codigo desc;");
$qtdRow = mysqli_num_rows($queryResult);
$caixaSelecionada = '';
if($qtdRow == 0){
    echo 'Sua empresa ainda não possui nenhuma caixa de coleta cadastrada :(';
}else{
    while ($campo = mysqli_fetch_array($queryResult)) {
        echo '
        <div class="btn-group dropend" id="btnCaixaColetaSelecionarGeral">
          <a class="btn btn-secondary" href="../../../ESPy_Php/WEB/ESPy_requestSensoresHistorico.php?codigoCaixaColeta='.$campo["codigo"].'" id="btnCaixaColetaSelecionar">
            '.$campo['nome'].'
          </a>';
          if($_SESSION['usuario_chefe'] == 1){
            echo' <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false" id="btnCaixaColetaSelecionar">
            <span class="visually-hidden">Toggle Dropright</span>
          </button>
          <ul class="dropdown-menu">
          <li><a type="button" class="dropdown-item" value="Editar" id="btnEditarCaixaColeta" name="'.$campo["codigo"].'">Editar</a></li>
          <li><a class="dropdown-item" value="Excluir" id="btnExcluirCaixaColeta" name="'.$campo["codigo"].'">Excluir</a></li>
          <hr class="my-1">
          <li><a class="dropdown-item" href="#">Comparar</a></li>
          </ul></div>';
          }else{
              echo'</div>';
          };
          
        ;
        
    }
}