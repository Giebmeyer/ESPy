<?php
include("../../../ESPy_MySql/ESPy_MySqlCredenciais.php");

$codigoEmpresa  = $_SESSION['codigoEmpresa'];

$queryResult = mysqli_query($conexao, "SELECT u.* FROM usuarios u JOIN usuarios_empresas ue ON u.codigo = ue.codigo_usuario JOIN empresas e ON e.codigo = ue.codigo_empresa WHERE ue.codigo_empresa = '$codigoEmpresa' AND u.usuario_chefe != 1 AND ue.saiuEmpresa = 'A' ORDER BY `data_hora_cadastro` desc");
$qtdRow = mysqli_num_rows($queryResult);

if($qtdRow == 0){
    echo '<div class="alert alert-info container p-2" role="alert">
  Nenhum empregado vinculado :(
</div>';
}else{
    while ($campo = mysqli_fetch_array($queryResult)) {
               echo '
        <div class="btn-group dropend m-1" id="btnCaixaColetaSelecionarGeral">
          <a class="btn btn-secondary" id="btnCaixaColetaSelecionar">
            '.$campo['nome'].'
          </a>';
          if($_SESSION['usuario_chefe'] == 1){
            echo' <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false" id="btnCaixaColetaSelecionar">
            <span class="visually-hidden">Toggle Dropright</span>
          </button>
          <ul class="dropdown-menu">
          <li><a class="dropdown-item" value="Expulsar" id="btnExcluirCaixaColeta" name='.$campo["codigo"].' onclick="expulsar('.$campo["codigo"].')">Expulsar</a></li>
          </ul></div>';
          }else{
              echo'</div>';
          };
    }
}

