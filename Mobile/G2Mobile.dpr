program G2Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_Mensagem in 'Source\Form_Mensagem.pas' {Frm_Mensagem},
  uDmDados in 'Source\uDmDados.pas' {DmDados: TDataModule},
  uFraAnimacao in 'Source\uFraAnimacao.pas' {FraAnimacao: TFrame},
  uFrmBase in 'Source\uFrmBase.pas' {FrmBase},
  uFrmInforSistema in 'Source\uFrmInforSistema.pas' {FrmInforSistema},
  uFrmInicio in 'Source\uFrmInicio.pas' {FrmInicio},
  uFrmMain in 'Source\uFrmMain.pas' {FrmMain},
  uSincronizacao in 'Source\uSincronizacao.pas' {FrmSinc},
  FMX.Consts in 'Source\Core\FMX.Consts.pas',
  Loading in 'Source\Core\Loading.pas',
  uAguarde in 'Source\Core\uAguarde.pas',
  uChart in 'Source\Core\uChart.pas',
  uConfiguracao in 'Source\Core\uConfiguracao.pas',
  uDataBase in 'Source\Core\uDataBase.pas',
  uFrmUtilFormate in 'Source\Core\uFrmUtilFormate.pas',
  UntLib in 'Source\Core\UntLib.pas',
  uClasseCamaraFria in 'Source\Model\CamaraFria\uClasseCamaraFria.pas',
  uInterfaceCamaraFria in 'Source\Model\CamaraFria\uInterfaceCamaraFria.pas',
  uClasseFormaPagamento in 'Source\Model\FormasDePagamentos\uClasseFormaPagamento.pas',
  uInterfaceFormaPagamento in 'Source\Model\FormasDePagamentos\uInterfaceFormaPagamento.pas',
  uClasseParametro in 'Source\Model\Parametros\uClasseParametro.pas',
  uInterfaceParametro in 'Source\Model\Parametros\uInterfaceParametro.pas',
  uClasseExportarPedidos in 'Source\Model\Pedidos\ExportarPedidos\uClasseExportarPedidos.pas',
  uInterfaceExportarPedidos in 'Source\Model\Pedidos\ExportarPedidos\uInterfaceExportarPedidos.pas',
  uClasseProdutos in 'Source\Model\Produtos\uClasseProdutos.pas',
  uInterfaceProdutos in 'Source\Model\Produtos\uInterfaceProdutos.pas',
  uClasseResumoVendedorClientes in 'Source\Model\ResumoVendedor\Clientes\uClasseResumoVendedorClientes.pas',
  uInterfaceResumoVendedorClientes in 'Source\Model\ResumoVendedor\Clientes\uInterfaceResumoVendedorClientes.pas',
  uClasseResumoVendedorItens in 'Source\Model\ResumoVendedor\Itens\uClasseResumoVendedorItens.pas',
  uInterfaceResumoVendedorItens in 'Source\Model\ResumoVendedor\Itens\uInterfaceResumoVendedorItens.pas',
  uClasseUsuarios in 'Source\Model\Usuarios\uClasseUsuarios.pas',
  uInterfaceUsuarios in 'Source\Model\Usuarios\uInterfaceUsuarios.pas',
  FMX.ZDeviceInfo in 'Util\FMX.ZDeviceInfo.pas',
  uClasseNovoPedido in 'Source\Model\Pedidos\NovoPedido\Pedido\uClasseNovoPedido.pas',
  uInterfaceNovoPedido in 'Source\Model\Pedidos\NovoPedido\Pedido\uInterfaceNovoPedido.pas',
  uInterfaceNovoPedidoItem in 'Source\Model\Pedidos\NovoPedido\Pedido Item\uInterfaceNovoPedidoItem.pas',
  uClasseNovoPedidoItem in 'Source\Model\Pedidos\NovoPedido\Pedido Item\uClasseNovoPedidoItem.pas',
  uFrmClientes in 'Source\View\uFrmClientes.pas' {FrmClientes},
  uFrmPedido in 'Source\View\uFrmPedido.pas' {FrmPedidos},
  uFrmProdutos in 'Source\View\uFrmProdutos.pas' {FrmProdutos},
  uFrmResumoVendedor in 'Source\View\uFrmResumoVendedor.pas' {FrmResumoVend},
  uClasseTitulosCliente in 'Source\Model\TitulosCliente\uClasseTitulosCliente.pas',
  uInterfaceTitulosCliente in 'Source\Model\TitulosCliente\uInterfaceTitulosCliente.pas',
  uClasseClientes in 'Source\Model\Clientes\Clientes\uClasseClientes.pas',
  uInterfaceClientes in 'Source\Model\Clientes\Clientes\uInterfaceClientes.pas',
  uClassePreCadClientes in 'Source\Model\Clientes\PreCadClientes\uClassePreCadClientes.pas',
  uInterfacePreCadClientes in 'Source\Model\Clientes\PreCadClientes\uInterfacePreCadClientes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmDados, DmDados);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);
  Application.Run;
end.
