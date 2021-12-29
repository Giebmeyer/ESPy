(function() {
    'use strict';
    window.addEventListener('load', function() {
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function(form) {
            form.addEventListener('submit', function(event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();

function editar(codCaixa) {
    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success m-2',
        cancelButton: 'btn btn-outline-dark m-2'
      },
      buttonsStyling: false
    })

    swalWithBootstrapButtons.fire({
      title: 'Digite o novo nome para essa caixa de coleta: ',
      input: 'text',
      inputAttributes: {
        autocapitalize: 'off'
      },
      showCancelButton: true,
      confirmButtonText: 'Confirmar',
      cancelButtonText: 'Cancelar',
      preConfirm: (novoNomeCaixaColeta) => {
        javascript: location.href = "../../../ESPy_Php/WEB/ESPy_editarCaixaColeta.php?codigoCaixaSelecionadaLista=" + codCaixa + "&novoNome=" + novoNomeCaixaColeta;
      },
    })
  }

  function excluir(codCaixa) {
    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-success m-2',
        cancelButton: 'btn btn-outline-dark m-2'
      },
      buttonsStyling: false
    })

    swalWithBootstrapButtons.fire({
      title: 'Você realmente gostaria de apagar essa caixa de coleta?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Confirmar',
      cancelButtonText: 'Cancelar',
    }).then((result) => {
      if (result.isConfirmed) {
        javascript: location.href = "../../../ESPy_Php/WEB/ESPy_removerCaixaColeta.php?codigoCaixaColeta=" + codCaixa;
      }
    })
  }

  document.getElementById('txtCodigoEntrarEmpresa1').addEventListener('input', limitaTotal)
  document.getElementById('txtCodigoEntrarEmpresa1').focus();
  document.getElementById('txtCodigoEntrarEmpresa2').addEventListener('input', limitaTotal)
  document.getElementById('txtCodigoEntrarEmpresa3').addEventListener('input', limitaTotal)
  document.getElementById('txtCodigoEntrarEmpresa4').addEventListener('input', limitaTotal)
  document.getElementById('txtCodigoEntrarEmpresa5').addEventListener('input', limitaTotal)
  document.getElementById('txtCodigoEntrarEmpresa6').addEventListener('input', limitaTotal)

  function limitaTotal(evt) {
      var input = evt.target;
      var value = input.value;

      if (value.length <= 1) {
          return;
      }

      input.value = input.value.substr(0, 1);
  }

  function expulsar(codEmpregado) {
    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-outline-success m-2',
        cancelButton: 'btn btn-outline-dark m-2'
      },
      buttonsStyling: false
    })

    swalWithBootstrapButtons.fire({
      title: 'Você realmente gostaria de expulsar esse empregado?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Confirmar',
      cancelButtonText: 'Cancelar',
    }).then((result) => {
      if (result.isConfirmed) {
        javascript: location.href = "../../../ESPy_Php/WEB/ESPy_expulsarFuncionarioEmpresa.php?codigoUsuarioSelecionadoLista=" + codEmpregado;
      }
    })
  }

  $("#buscaUser").on("keyup", function() {
    let value = $(this).val().toLowerCase();
    $("#divCaixasColeta div").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

  function loading(){
    $('#load').css('display','none');
}