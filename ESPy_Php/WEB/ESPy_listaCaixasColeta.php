<?php
include("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");
setlocale(LC_ALL, 'pt_BR.utf-8');
$codigoEmpresa  = $_SESSION['codigoEmpresa'];

$queryResult = mysqli_query($conexao, "select cc.* from caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' and cc.excluida != 1 order by codigo desc;");
$qtdRow = mysqli_num_rows($queryResult);
$caixaSelecionada = '';
if($qtdRow == 0){
    echo '<div class="alert alert-info container p-2 " role="alert">
  Sem caixa de coleta cadastradas :(
</div>';
}else{
    while ($campo = mysqli_fetch_array($queryResult)) {
        echo '
        <div class="btn-group dropend m-1 btnCaixaColetaSelecionarGeral" id="'.$campo['nome'].'">
          <a class="btn btn-secondary" href="../../../ESPy_Php/WEB/ESPy_requestSensoresHistorico.php?codigoCaixaColeta='.$campo["codigo"].'" id="btnCaixaColetaSelecionar">
            '.$campo['nome'].'
          </a>';
          if($_SESSION['usuario_chefe'] == 1){
            echo' <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false" id="btnCaixaColetaSelecionar">
            <span class="visually-hidden">Toggle Dropright</span>
          </button>
          <ul class="dropdown-menu">
          <li><a type="button" class="dropdown-item" value="Editar" id="btnEditarCaixaColeta" name="'.$campo["codigo"].'"  onclick="editar('.$campo["codigo"].')">Editar</a></li>
          <li><a class="dropdown-item" value="Excluir" id="btnExcluirCaixaColeta" name="'.$campo["codigo"].'" onclick="excluir('.$campo["codigo"].')">Excluir</a></li>
          <hr class="my-1">
          <li><a class="dropdown-item" value="Comparar" id="btnCompararCaixaColeta" onclick="Comparar()">Comparar</a></li>
          </ul></div>';
          }else{
              echo'</div>';
          };
          
        
        
    }
}