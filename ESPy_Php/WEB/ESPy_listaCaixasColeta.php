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
        <div class="btn-group dropend">
          <a class="btn btn-secondary href="../../../ESPy_Php/WEB/ESPy_requestSensoresHistorico.php?codigoCaixaColeta='. $campo["codigo"] .'>
            '.$campo['nome'].'
          </a>
          <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="visually-hidden">Toggle Dropright</span>
          </button>
          <ul class="dropdown-menu">
          <li><a type="button" class="dropdown-item" id="btnEditarCaixaColeta">Editar</a></li>
          <li><a class="dropdown-item" href=href="../../../../../ESPy_Php/WEB/ESPy_removerCaixaColeta.php?codigoCaixaColeta='. $campo["codigo"] .'>Excluir</a></li>
          <hr class="my-4">
          <li><a class="dropdown-item" href="#">Comparar</a></li>
          </ul>
        </div>';
        
    }
}

echo '
<script type="text/javascript"> 

$("#btnEditarCaixaColeta").click(function(){

});  
</script>
';

echo '<!-- Modal -->

<div class="modal fade" id="modalRecoverPass" tabindex="-1" aria-labelledby="modalRecoverPass" aria-hidden="true">

    <div class="modal-dialog ">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title" id="modalRecoverPass">Informe o email utilizado na criação da conta

                </h5>

            </div>

            <div class="modal-body">

                <form id="FormularioRecuperarSenha" method="POST" action="/ESPy_Php/WEB/ESPy_coletaDadosUsuario.php">

                    <!-- From email -->

                    <div class="form-group">

                        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Seu email cadastrado">

                    </div>

                    <!-- Botão Cadastre-se -->

                    <div class="mt-2" id="linkCadastroRecoverPass">

                        Não possui login? <a href="../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.html" id="linkCadastroRecoverPass">Cadastre-se</a>

                    </div>

            </div>

            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="BtnCancelarRecoverPass">Cancelar</button>

                <input type="submit" id="BtnRecoverPass" value="Recuperar">

            </div>

            </form>

        </div>

    </div>';
