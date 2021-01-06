unit uFrmInicio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects,
  System.IniFiles, System.IOUtils, FMX.Effects, FMX.Filter.Effects,
  FMX.Colors, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit,
  uRESTDWPoolerDB,
  uRESTDWBase, uDWAbout, uDWConsts, uRESTDWServerEvents,
  uDWJSONObject, IPPeerClient, REST.Client, REST.Authenticator.Basic,

  Data.Bind.Components, Data.Bind.ObjectScope, REST.Response.Adapter,
  uDWConstsData,
{$IF DEFINED (ANDROID)}
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  FMX.Helpers.Android,
  Androidapi.Helpers,
{$ENDIF}
  Data.DB,

  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.ScrollBox, FMX.Memo;

type
  TFrmInicio = class(TFrmBase)
    layout_tabs: TLayout;
    TabPedido: TLayout;
    lbl_tab_pedido: TLabel;
    img_tab_pedido: TImage;
    TabCliente: TLayout;
    lbl_tab_cliente: TLabel;
    img_tab_cliente: TImage;
    TabNotificacao: TLayout;
    img_tab_notificacao: TImage;
    lbl_tab_notificacao: TLabel;
    circle_notificacao: TCircle;
    lbl_qtd_notif: TLabel;
    TabMais: TLayout;
    lbl_tab_mais: TLabel;
    img_tab_mais: TImage;
    tab_mais: TLayout;
    lay_menu1: TLayout;
    Layout3: TLayout;
    img_sincronizar: TImage;
    lbl_Graficos: TLabel;
    Layout5: TLayout;
    tab_cliente: TLayout;
    Rectangle1: TRectangle;
    Label3: TLabel;
    img_cad_cliente: TImage;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    edt_busca_cliente: TEdit;
    img_busca_cliente: TImage;
    lv_cliente: TListView;
    img_no_cliente: TImage;
    Layout2: TLayout;
    img_cad_produto: TImage;
    lbl_cad_produto: TLabel;
    Image6: TImage;
    lbl_Pedidos: TLabel;
    imgPositivacao: TImage;
    Label1: TLabel;
    Image3: TImage;
    lbl_Clientes: TLabel;
    Image2: TImage;
    lbl_Sincronizar: TLabel;
    rcClientes: TRectangle;
    rcProdutos: TRectangle;
    rcGraficos: TRectangle;
    rcPedidos: TRectangle;
    rcSincronizar: TRectangle;
    rcPositivacao: TRectangle;
    Rectangle4: TRectangle;
    Layout6: TLayout;
    rcSair: TRectangle;
    img_logout: TImage;
    lbl_Sair: TLabel;
    lblQtProdutos: TLabel;
    lblQtClientes: TLabel;
    lblQtVendas: TLabel;
    Rectangle2: TRectangle;
    IdHTTP1: TIdHTTP;
    Layout1: TLayout;
    lay_Menu: TLayout;
    lay_NovoPedido: TLayout;
    Rectangle5: TRectangle;
    lay_centernvpedido: TLayout;
    Label6: TLabel;
    Image1: TImage;
    ShadowEffect1: TShadowEffect;
    GridPanelLayout1: TGridPanelLayout;
    Layout8: TLayout;
    Rectangle11: TRectangle;
    Label11: TLabel;
    Image9: TImage;
    ShadowEffect6: TShadowEffect;
    Layout9: TLayout;
    Rectangle12: TRectangle;
    Label12: TLabel;
    Image10: TImage;
    ShadowEffect7: TShadowEffect;
    Layout10: TLayout;
    ShadowEffect8: TShadowEffect;
    Rectangle13: TRectangle;
    Label13: TLabel;
    Image11: TImage;
    Layout7: TLayout;
    ShadowEffect2: TShadowEffect;
    rct_Resumo: TRectangle;
    Label7: TLabel;
    Image4: TImage;
    Layout11: TLayout;
    Rectangle14: TRectangle;
    Label14: TLabel;
    Image12: TImage;
    ShadowEffect9: TShadowEffect;
    procedure ImgPessoasClick(Sender: TObject);
    procedure ImgInformacoesClick(Sender: TObject);
    procedure ImgProdutosClick(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);
    procedure ImgSincClick(Sender: TObject);
    procedure ImgPedidoClick(Sender: TObject);
    procedure rct_ResumoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInicio: TFrmInicio;

implementation

{$R *.fmx}

uses
//{$IF DEFINED (ANDROID)}
//  Androidapi.JNI.Network,
//{$ENDIF}
  uFrmMain,
  uFrmClientes,
  uFrmInforSistema,
  uSincronizacao,
//  uFrmPedidos,
//  uFrmPositivacao,
  uDmDados, uFrmProdutos, FireDAC.Comp.Client, uFrmUtilFormate, uFrmResumoVendedor, uFrmPedido;



procedure TFrmInicio.ImgInformacoesClick(Sender: TObject);
begin
  inherited;
  FrmMain.NomeFormAtual := 'INFO';
  FrmMain.MudarCabecalho('Informações');
  FrmMain.FormOpen(TFrmInforSistema);
end;

procedure TFrmInicio.ImgPedidoClick(Sender: TObject);
begin
  inherited;
  FrmMain.NomeFormAtual := 'PEDIDOS';
  FrmMain.MudarCabecalho('Pedidos');
  FrmMain.FormOpen(TFrmPedidos);
end;

procedure TFrmInicio.ImgPessoasClick(Sender: TObject);
begin
  inherited;
  FrmMain.NomeFormAtual := 'PESSOAS';
  FrmMain.MudarCabecalho('Pessoas');
  FrmMain.FormOpen(TFrmClientes);
end;

procedure TFrmInicio.ImgProdutosClick(Sender: TObject);
begin
  inherited;
  FrmMain.NomeFormAtual := 'PRODUTOS';
  FrmMain.MudarCabecalho('Produtos');
  FrmMain.FormOpen(TFrmProdutos);

end;

procedure TFrmInicio.ImgSincClick(Sender: TObject);
begin
  inherited;
  FrmMain.NomeFormAtual := 'SINCRONIZACAO';
  FrmMain.MudarCabecalho('Sincronização');
  FrmMain.FormOpen(TFrmSinc);
end;

procedure TFrmInicio.rct_ResumoClick(Sender: TObject);
begin
  inherited;

  FrmMain.NomeFormAtual := 'RESUMO';
  FrmMain.MudarCabecalho('Resumo');
  FrmMain.FormOpen(TFrmResumoVend);
end;

procedure TFrmInicio.ImgSairClick(Sender: TObject);
begin
  inherited;
  FrmMain.EfetuarLogoff;
  FreeAndNil(FrmInicio);
end;

end.
