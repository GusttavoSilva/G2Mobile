program G2Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Consts in 'Source\Core\FMX.Consts.pas',
  Loading in 'Source\Core\Loading.pas',
  uAguarde in 'Source\Core\uAguarde.pas',
  uChart in 'Source\Core\uChart.pas',
  uConfiguracao in 'Source\Core\uConfiguracao.pas',
  uDataBase in 'Source\Core\uDataBase.pas',
  uFrmUtilFormate in 'Source\Core\uFrmUtilFormate.pas',
  UntLib in 'Source\Core\UntLib.pas',
  Form_Mensagem in 'Source\View\Form_Mensagem.pas' {Frm_Mensagem},
  uFraAnimacao in 'Source\View\uFraAnimacao.pas' {FraAnimacao: TFrame},
  G2Mobile.View.FormBase in 'Source\View\G2Mobile.View.FormBase.pas' {FrmBase},
  G2Mobile.View.Clientes in 'Source\View\G2Mobile.View.Clientes.pas' {FrmClientes},
  G2Mobile.View.InforSistema in 'Source\View\G2Mobile.View.InforSistema.pas' {FrmInforSistema},
  G2Mobile.View.Inicio in 'Source\View\G2Mobile.View.Inicio.pas' {FrmInicio},
  G2Mobile.View.Main in 'Source\View\G2Mobile.View.Main.pas' {FrmMain},
  uFrmPedido in 'Source\View\uFrmPedido.pas' {FrmPedidos},
  uFrmProdutos in 'Source\View\uFrmProdutos.pas' {FrmProdutos},
  uDmDados in 'Source\Componente\uDmDados.pas' {DmDados: TDataModule},
  FMX.ZDeviceInfo in 'Source\Util\FMX.ZDeviceInfo.pas',
  uLibraryAndroid in 'Source\Core\uLibraryAndroid.pas',
  G2Mobile.Controller.CamaraFria in 'Source\Controller\G2Mobile.Controller.CamaraFria.pas',
  G2Mobile.Model.CamaraFria in 'Source\Model\G2Mobile.Model.CamaraFria.pas',
  G2Mobile.Controller.Clientes in 'Source\Controller\G2Mobile.Controller.Clientes.pas',
  G2Mobile.Model.Clientes in 'Source\Model\G2Mobile.Model.Clientes.pas',
  G2Mobile.Model.PreCadClientes in 'Source\Model\G2Mobile.Model.PreCadClientes.pas',
  G2Mobile.Controller.FormaPagamento in 'Source\Controller\G2Mobile.Controller.FormaPagamento.pas',
  G2Mobile.Model.FormaPagamento in 'Source\Model\G2Mobile.Model.FormaPagamento.pas',
  G2Mobile.Controller.Parametro in 'Source\Controller\G2Mobile.Controller.Parametro.pas',
  G2Mobile.Model.Parametro in 'Source\Model\G2Mobile.Model.Parametro.pas',
  G2Mobile.Controller.Usuarios in 'Source\Controller\G2Mobile.Controller.Usuarios.pas',
  G2Mobile.Model.Usuarios in 'Source\Model\G2Mobile.Model.Usuarios.pas',
  G2Mobile.Model.TitulosCliente in 'Source\Model\G2Mobile.Model.TitulosCliente.pas',
  G2Mobile.Controller.ResumoVendedor in 'Source\Controller\G2Mobile.Controller.ResumoVendedor.pas',
  G2Mobile.Model.ResumoVendedorClientes in 'Source\Model\G2Mobile.Model.ResumoVendedorClientes.pas',
  G2Mobile.Model.ResumoVendedorItens in 'Source\Model\G2Mobile.Model.ResumoVendedorItens.pas',
  G2Mobile.Model.Produtos in 'Source\Model\G2Mobile.Model.Produtos.pas',
  G2Mobile.Controller.Produtos in 'Source\Controller\G2Mobile.Controller.Produtos.pas',
  G2Mobile.Controller.Pedidos in 'Source\Controller\G2Mobile.Controller.Pedidos.pas',
  G2Mobile.Model.ExportarPedidos in 'Source\Model\G2Mobile.Model.ExportarPedidos.pas',
  G2Mobile.Model.NovoPedido in 'Source\Model\G2Mobile.Model.NovoPedido.pas',
  G2Mobile.Model.NovoPedidoItem in 'Source\Model\G2Mobile.Model.NovoPedidoItem.pas',
  G2Mobile.View.Sincronizacao in 'Source\View\G2Mobile.View.Sincronizacao.pas' {FrmSinc},
  G2Mobile.View.ResumoVendedor in 'Source\View\G2Mobile.View.ResumoVendedor.pas' {FrmResumoVend};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmDados, DmDados);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);
  Application.CreateForm(TFrmSinc, FrmSinc);
  Application.CreateForm(TFrmResumoVend, FrmResumoVend);
  Application.Run;

end.
