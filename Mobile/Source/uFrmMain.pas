unit uFrmMain;

interface

uses
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Math,
  System.Actions,
  System.UIConsts,
  System.IniFiles,
  System.IOUtils,
  System.Permissions,
  System.Sensors,
  System.Sensors.Components,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Ani,
  FMX.StdCtrls,
  FMX.MultiView,
  FMX.Objects,
  FMX.Edit,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.Colors,
  FMX.TabControl,
  FMX.Layouts,
  FMX.ActnList,
  FMX.Menus,
  FMX.ListBox,
  FMX.VirtualKeyBoard,
  FMX.PlatForm,
  FMX.DialogService,

  uDmDados,
  uConfiguracao,
  uFrmInforSistema,

  uDWJSONObject,

{$IF DEFINED (ANDROID)}
  Androidapi.JNI.Media,
  Androidapi.Helpers,
  Androidapi.JNI.App,
  Androidapi.JNI.Support,
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.FileProvider,
  // FMX.Helpers.android,
  // FMX.Platform.android,
  // FGX.Toasts,
  // FGX.Graphics,
  FMX.Helpers.Android,

  Androidapi.JNI.Telephony,
  Androidapi.JNI.Provider,
//  MultiDetailAppearanceU,

{$ENDIF}
  FireDAC.Comp.Client,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.EditBox,
  FMX.NumberBox,
  MobilePermissions.Model.Signature,
  MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard,
  uLibraryAndroid,
  Form_Mensagem;
// , ksTypes, ksVirtualListView;

type
  TFrmMain = class(TForm)
    ActionList1: TActionList;
    actTab01: TChangeTabAction;
    actTab02: TChangeTabAction;
    actLogin: TChangeTabAction;
    Image8: TImage;
    imgCliente: TImage;
    ImgConfiguracoes: TImage;
    ImgProdutos: TImage;
    imgHome: TImage;
    ImgInformacoes: TImage;
    imgLogoff: TImage;
    ImgSair: TImage;
    ImgGraficos: TImage;
    LayoutClientPesq56: TLayout;
    TabControlGeral: TTabControl;
    tab01: TTabItem;
    ColorBoxBarraTopo: TColorBox;
    lblEmpresa: TLabel;
    spbMENU: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    spbMAIS: TSpeedButton;
    LayoutContainerPesq: TLayout;
    tab02: TTabItem;
    MultiViewGeral: TMultiView;
    Layout1: TLayout;
    ColorBoxTopo: TColorBox;
    ColorBox2: TColorBox;
    Layout5: TLayout;
    ListBoxClientes: TListBox;
    ShadowEffect2: TShadowEffect;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    MainMenu1: TMainMenu;
    TabItem1: TTabItem;
    Label4: TLabel;
    LayoutLogin: TLayout;
    Image2: TImage;
    Layout9: TLayout;
    Rectangle2: TRectangle;
    edtusuario: TEdit;
    Rectangle3: TRectangle;
    edtSenha: TEdit;
    lay_login: TLayout;
    rct_login: TRectangle;
    lblLogin: TLabel;
    StyleBook1: TStyleBook;
    lay_config: TLayout;
    rct_config: TRectangle;
    lbl_Config: TLabel;
    imgContorno: TImage;
    Image1: TImage;
    Layout2: TLayout;
    Image3: TImage;
    Image4: TImage;
    Label2: TLabel;
    lblUsuario: TLabel;
    LayoutClientPesq: TLayout;
    Rectangle5: TRectangle;
    ToolBar1: TToolBar;
    Label3: TLabel;
    Button2: TButton;
    actTab03: TChangeTabAction;
    ActionList2: TActionList;
    actPedido: TChangeTabAction;
    actPedido1: TChangeTabAction;
    actPedido2: TChangeTabAction;
    actPedido3: TChangeTabAction;
    actPedido4: TChangeTabAction;
    actPedido5: TChangeTabAction;
    actPedido6: TChangeTabAction;
    Action1: TAction;
    actTeste: TChangeTabAction;
    imgPositivacao: TImage;
    Label5: TLabel;
    lytVersion: TLayout;
    lblVersion: TLabel;
    RectAnimation1: TRectAnimation;
    vtsScrollAble: TVertScrollBox;
    lytBackground: TLayout;
    actCliente: TChangeTabAction;
    actCliente1: TChangeTabAction;
    actProduto: TChangeTabAction;
    actProduto1: TChangeTabAction;
    actPositivacao1: TChangeTabAction;
    actPositivacao2: TChangeTabAction;
    actPositivacao3: TChangeTabAction;
    actPositivacao4: TChangeTabAction;
    actConsulta1: TChangeTabAction;
    actConsulta2: TChangeTabAction;
    actConsulta3: TChangeTabAction;
    actConsulta4: TChangeTabAction;
    actConsulta5: TChangeTabAction;
    actClientesConsultar: TAction;
    Line1: TLine;
    Line2: TLine;
    Rectangle7: TRectangle;
    LocationSensor1: TLocationSensor;
    img_sinc: TImage;
    img_pedido: TImage;
    Rectangle1: TRectangle;
    img_g2sistemas: TImage;
    lytConfig: TLayout;
    lytConfigurarIpServidor: TLayout;
    Rectangle8: TRectangle;
    edtIp: TEdit;
    Line3: TLine;
    edtPorta: TEdit;
    Line4: TLine;
    RectAnimation2: TRectAnimation;
    Layout4: TLayout;
    Image5: TImage;
    Layout3: TLayout;
    rct_configu: TRectangle;
    Label6: TLabel;
    Layout6: TLayout;
    tabCadDispo: TTabItem;
    Layout7: TLayout;
    ToolBar2: TToolBar;
    Label7: TLabel;
    Button1: TButton;
    Layout8: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Layout12: TLayout;
    edt_empresa: TEdit;
    Line5: TLine;
    ed_DeviceId: TEdit;
    Line6: TLine;
    edt_NomeVendedor: TEdit;
    Line9: TLine;
    rct_enviaDisp: TRectangle;
    Label1: TLabel;
    Rectangle4: TRectangle;
    rct: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Rectangle14: TRectangle;
    Image6: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Image7: TImage;
    Label11: TLabel;
    Image9: TImage;
    Image10: TImage;
    Label12: TLabel;
    Rectangle6: TRectangle;
    Image11: TImage;
    Label13: TLabel;
    Rectangle9: TRectangle;
    Image12: TImage;
    Label14: TLabel;
    Rectangle16: TRectangle;
    Image14: TImage;
    Label16: TLabel;
    Rectangle17: TRectangle;
    Image15: TImage;
    Label17: TLabel;
    Rectangle18: TRectangle;
    Image16: TImage;
    Label18: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    // procedure ksVirtualListView1ItemClick(Sender: TObject; AItem: TksVListItem);
    procedure spbMENUClick(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure lbl_ConfigClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtusuarioKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure actClientesConsultarExecute(Sender: TObject);
    procedure edtIpKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure img_EnvDeviceIdClick(Sender: TObject);
    procedure rctClick(Sender: TObject);
    procedure rct_configuClick(Sender: TObject);
    procedure Rectangle14Click(Sender: TObject);
    procedure Rectangle13Click(Sender: TObject);
    procedure Rectangle12Click(Sender: TObject);
    procedure Rectangle10Click(Sender: TObject);
    procedure Rectangle18Click(Sender: TObject);
    procedure Rectangle17Click(Sender: TObject);
    procedure Rectangle9Click(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure Rectangle16Click(Sender: TObject);
  private
    FNomeUsuarioAtual: string;
    FIdVendaAtual: integer;
    FCodVendedor: integer;
    FNomeFormAtual: string;
    FTabPedidos: integer;
    // ScrollAble
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    FTabClientes: integer;
    FTabProdutos: integer;
    FTabPositivacao: integer;
    FTabTabConsultas: integer;
    // **ScrollAble

    procedure SetNomeUsuarioAtual(const Value: string);
    procedure SetIdVendaAtual(const Value: integer);
    procedure SetCodVendedor(const Value: integer);
    procedure SetNomeFormAtual(const Value: string);
    procedure SetTabPedidos(const Value: integer);

    // ScrollAble
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
    procedure SetTabClientes(const Value: integer);
    procedure SetTabProdutos(const Value: integer);
    procedure SetTabPositivacao(const Value: integer);
    procedure SetTabTabConsultas(const Value: integer);

    { Private declarations }
  public
    FActiveForm: TForm;

    Location: TLocationCoord2D;
    FGeocoder: TGeocoder;

    procedure FormOpen(aForm: TComponentClass);
    // procedure GerarMenus;
    procedure EfetuarLogoff;
    procedure MudarCabecalho(ACabecalho: String);
    property NomeUsuarioAtual: string read FNomeUsuarioAtual write SetNomeUsuarioAtual;
    property IdVendaAtual: integer read FIdVendaAtual write SetIdVendaAtual;
    property CodVendedor: integer read FCodVendedor write SetCodVendedor;
    property NomeFormAtual: string read FNomeFormAtual write SetNomeFormAtual;
    property TabPedidos: integer read FTabPedidos write SetTabPedidos;
    property TabClientes: integer read FTabClientes write SetTabClientes;
    property TabProdutos: integer read FTabProdutos write SetTabProdutos;
    property TabPositivacao: integer read FTabPositivacao write SetTabPositivacao;
    property TabConsultas: integer read FTabTabConsultas write SetTabTabConsultas;
    procedure TratarTabControl(TabControl: TTabControl);
    procedure ChamarMetodoPessoas;

    { Public declarations }
  protected

    procedure DoShow; override;
    procedure AniInd;

    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  Lat, Long: string;
  URLString: String;
  LDecSeparator: String;
  Access_Fine_Location, Access_Coarse_Location, lPermissaoPhoneState: string;
  ArquivoINI: TIniFile;
  ipfinal, portafinal: String;
  StatusConexao: string;
{$IFDEF ANDROID}
  // Toast: TfgToast;
{$ENDIF}

implementation

{$R *.fmx}

uses
  uFrmClientes,
  System.JSON,
  uLibrary,
  uAguarde,
  uSincronizacao,
  System.Threading,
  uDataBase,
  Data.DB,
  uFrmProdutos,
  FMX.ZDeviceInfo,
  uFrmUtilFormate,
  System.DateUtils,
  System.SysUtils,
  uFrmInicio,
  uClasseUsuarios,
  uClasseParametro,
  uFrmPedido,
  uFrmResumoVendedor;

{ TFrmMain }

procedure TFrmMain.actClientesConsultarExecute(Sender: TObject);
begin
  // if Assigned(FrmClientes) then
  // begin
  // ShowMessage('action');
  // FrmClientes.SearchEditButton1Click(self);
  // end;
end;

procedure TFrmMain.AniInd;
begin
  //
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  FrmMain.EfetuarLogoff;
end;

procedure TFrmMain.Button3Click(Sender: TObject);
var
  ip: string;
  porta: string;
  ArquivoINI: TIniFile;
  usuarios: integer;
  MyThread: TThread;
  aTask: array [0 .. 1] of ITask;
begin
  inherited;
  ip := edtIp.Text;
  porta := edtPorta.Text;
  try
    if (ip.Equals(EmptyStr) and (porta.Equals(EmptyStr))) then
    begin
      ShowMessage('Digite o ip e a porta!');
      if edtIp.Canfocus then
        edtIp.SetFocus;
      abort
    end
    else
    begin
      ArquivoINI := TIniFile.Create(System.IOUtils.TPath.GetDocumentsPath + PathDelim + 'ConfiguracaoINI.ini');
      ArquivoINI.WriteString('Servidor', 'ip', ip);
      ArquivoINI.WriteString('Servidor', 'porta', porta);
      ArquivoINI.Free;

      DmDados.RESTDWDataBase1.PoolerService := ip;
      DmDados.RESTClientPooler1.Host := ip;
      DmDados.RESTDWDataBase1.PoolerPort := porta.ToInteger;
      DmDados.RESTClientPooler1.Port := porta.ToInteger;

      if usuarios = 0 then
      begin

{$IFDEF ANDROID}
        Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não foi retornado nenhuma informação do servidor!' + sLineBreak +
          ' Verifique se a conexão está correta ou se há dados no servidor!', 'OK', '', $FFDF5447, $FFDF5447);
        Frm_Mensagem.Show;
{$ENDIF}
        FrmMain.EfetuarLogoff;
        if (not FrmMain.spbMENU.Visible) then
          FrmMain.spbMENU.Visible := True;
      end
      else
      begin
{$IFDEF ANDROID}
        Exibir_Mensagem('SUCESSO', 'SUCESSO', 'SUCESSO', 'Foi estabelecido conexão com o servidor!', 'OK', '',
          $FFDF5447, $FFDF5447);
        Frm_Mensagem.Show;
{$ENDIF}
        FrmMain.EfetuarLogoff;
        FrmMain.spbMENU.Visible := True;
      end;
    end;
  finally
    edtIp.Text := EmptyStr;
    edtPorta.Text := EmptyStr;
  end;
end;

procedure TFrmMain.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFrmMain.ChamarMetodoPessoas;
begin
  // FrmClientes.GerarGradeClientes;
end;

procedure TFrmMain.DoShow;
begin
  inherited;
  // Timer1.Enabled := True;
end;

procedure TFrmMain.edtIpKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin // Next
    // Algum outro componente esta impedindo de mudar de foco
    // Entao foi necessario fazer manual
    Key := 0;
    if edtPorta.Canfocus then
      edtPorta.SetFocus;
  end;

end;

procedure TFrmMain.edtSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin // Next
    lblLoginClick(Sender);
    Key := 0;
  end;
end;

procedure TFrmMain.edtusuarioKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin // Next
    // Algum outro componente esta impedindo de mudar de foco
    // Entao foi necessario fazer manual
    Key := 0;
    edtSenha.SetFocus;
  end;
end;

procedure TFrmMain.EfetuarLogoff;
begin
  FreeAndNil(FrmInicio);
  edtusuario.Text := '';
  edtSenha.Text := '';
  MultiViewGeral.Enabled := True;
  MultiViewGeral.Visible := True;
  actTab02.ExecuteTarget(self);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

  ed_DeviceId.Text := GetIMEI;

  Tparametros.new.RetornaLogo(Image2);

  PermissaoAparelho;

  LocationSensor1.Active := True;

  VKAutoShowMode := TVKAutoShowMode.DefinedBySystem;
  vtsScrollAble.OnCalcContentBounds := CalcContentBoundsProc;
  TabControlGeral.TabPosition := TTabPosition.None;
  LayoutLogin.Visible := True;
  TabControlGeral.ActiveTab := tab02;

  MultiViewGeral.Visible := False;
  MultiViewGeral.Enabled := False;

end;

procedure TFrmMain.FormFocusChanged(Sender: TObject);
begin

  UpdateKBBounds;

end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
//{$IFDEF ANDROID}
//var
//  FService: IFMXVirtualKeyboardService;
//{$ENDIF}
begin
//{$IFDEF ANDROID}
//  if (Key = vkReturn) then
//  begin
//  end
//  else if (Key = vkHardwareBack) then
//  begin
//    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
//
//    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.virtualkeyBoardState) then
//    begin
//    end
//    else
//    begin
//      if NomeFormAtual.Equals('INICIO') then
//      begin
//        EfetuarLogoff;
//        Key := 0;
//      end
//      else if NomeFormAtual.Equals('PESSOAS') then
//      begin
//        if not Assigned(FrmClientes) then
//          FrmClientes := TFrmClientes.Create(self);
//        if TabClientes = 1 then
//        begin
//          actCliente.ExecuteTarget(self);
//          // FrmClientes.actRotasClientes.ExecuteTarget(self);
//          FrmClientes.TabControl1.TabIndex := 0;
//          TabClientes := 0;
//        end
//        else
//        begin
//          FrmMain.MudarCabecalho('Início');
//          FrmMain.FormOpen(TFrmInicio);
//        end;
//        Key := 0;
//      end
//      else if NomeFormAtual.Equals('PRODUTOS') then
//      begin
//        if not Assigned(FrmProdutos) then
//          FrmProdutos := TFrmProdutos.Create(self);
//        if TabProdutos = 1 then
//        begin
//          actProduto.ExecuteTarget(self);
//          // FrmProdutos.actProdutos.ExecuteTarget(self);
//          FrmProdutos.TabControl1.TabIndex := 0;
//          TabProdutos := 0;
//        end
//        else
//        begin
//          FrmMain.MudarCabecalho('Início');
//          FrmMain.FormOpen(TFrmInicio);
//        end;
//        Key := 0;
//      end
//      else if NomeFormAtual.Equals('PEDIDOS') then
//      begin
//        if not Assigned(FrmPedido) then
//          FrmPedido := TFrmPedido.Create(self);
//        if TabPedidos = 1 then
//        begin
//          actPedido.ExecuteTarget(self);
//          FrmPedido.actPedido.ExecuteTarget(self);
//          FrmPedido.TabControlPedido.TabIndex := 0;
//          TabPedidos := 0;
//        end
//        else if TabPedidos = 2 then
//        begin
//          actPedido.ExecuteTarget(self);
//          FrmPedido.actPedido.ExecuteTarget(self);
//          FrmPedido.TabControlPedido.TabIndex := 0;
//          TabPedidos := 0;
//        end
//        else if TabPedidos = 3 then
//        begin
//          actPedido2.ExecuteTarget(self);
//          FrmPedido.actPedido2.ExecuteTarget(self);
//          FrmPedido.TabControlPedido.TabIndex := 2;
//          TabPedidos := 2;
//        end
//        else if TabPedidos = 4 then
//        begin
//          actPedido2.ExecuteTarget(self);
//          FrmPedido.actPedido2.ExecuteTarget(self);
//          FrmPedido.TabControlPedido.TabIndex := 2;
//          TabPedidos := 2;
//        end
//        else if TabPedidos = 5 then
//        begin
//          actPedido2.ExecuteTarget(self);
//          FrmPedido.actPedido2.ExecuteTarget(self);
//          FrmPedido.TabControlPedido.TabIndex := 2;
//          TabPedidos := 2;
//        end
//        else if TabPedidos = 6 then
//        begin
//          actPedido2.ExecuteTarget(self);
//          FrmPedido.actPedido2.ExecuteTarget(self);
//          FrmPedido.TabControlPedido.TabIndex := 2;
//          TabPedidos := 2;
//        end
//        else
//        begin
//          FrmMain.MudarCabecalho('Início');
//          FrmMain.FormOpen(TFrmInicio);
//        end;
//        Key := 0;
//      end
//      else if NomeFormAtual.Equals('SINCRONIZACAO') then
//      begin
//        FrmMain.MudarCabecalho('Início');
//        FrmMain.FormOpen(TFrmInicio);
//        Key := 0;
//      end
//      else if NomeFormAtual.Equals('CONFIG') then
//      begin
//        EfetuarLogoff;
//        Key := 0;
//      end
//      else if NomeFormAtual.Equals('POSITIVACAO') then
//      begin
//        if not Assigned(FrmPositivacao) then
//          FrmPositivacao := TFrmPositivacao.Create(self);
//        if TabPositivacao = 2 then
//        begin
//          actPositivacao1.ExecuteTarget(self);
//          FrmPositivacao.actTab1.ExecuteTarget(self);
//          FrmPositivacao.TabControl1.TabIndex := 0;
//          TabPositivacao := 0;
//        end
//        else if TabPositivacao = 3 then
//        begin
//          actPositivacao1.ExecuteTarget(self);
//          FrmPositivacao.actTab1.ExecuteTarget(self);
//          FrmPositivacao.TabControl1.TabIndex := 0;
//          TabPositivacao := 0;
//        end
//        else if TabPositivacao = 4 then
//        begin
//          actPositivacao1.ExecuteTarget(self);
//          FrmPositivacao.actTab1.ExecuteTarget(self);
//          FrmPositivacao.TabControl1.TabIndex := 0;
//          TabPositivacao := 0;
//        end
//        else
//        begin
//          FrmMain.MudarCabecalho('Início');
//          FrmMain.FormOpen(TFrmInicio);
//        end;
//        Key := 0;
//      end
//    end;
//  end;
//{$ENDIF}
end;

procedure TFrmMain.FormOpen(aForm: TComponentClass);
var
  I: integer;

begin

  if (FActiveForm = nil) or (Assigned(FActiveForm) and (FActiveForm.ClassName <> aForm.ClassName)) then
  begin

    for I := LayoutContainerPesq.ControlsCount - 1 downto 0 do
      LayoutContainerPesq.RemoveObject(LayoutContainerPesq.Controls[I]);

    FActiveForm.Free;
    FActiveForm := nil;

    Application.CreateForm(aForm, FActiveForm);

    LayoutContainerPesq.AddObject(TLayout(FActiveForm.FindComponent('LayoutClientPesq')));

  end;
end;

procedure TFrmMain.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFrmMain.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TFrmMain.lbl_ConfigClick(Sender: TObject);
begin
  NomeFormAtual := 'CONFIG';
  MudarCabecalho('Configurações');
  ArquivoINI := TIniFile.Create(System.IOUtils.TPath.GetDocumentsPath + PathDelim + 'ConfiguracaoINI.ini');
  ipfinal := ArquivoINI.ReadString('Servidor', 'ip', '');
  portafinal := ArquivoINI.ReadString('Servidor', 'porta', '');
  ArquivoINI.Free;
  if ipfinal.Equals('0') and portafinal.Equals('0') then
  begin
    edtIp.Text := '';
    edtPorta.Text := '';
  end
  else
  begin
    LeArqIni;
    edtIp.Text := IpSrv;
    edtPorta.Text := PortaSrv;
  end;
  actTab03.ExecuteTarget(self);
end;

procedure TFrmMain.rct_configuClick(Sender: TObject);
var
  DataSet: TFDMemTable;
begin

  GravarConfiguracao(edtIp.Text, edtPorta.Text);

  if verificaConexao then
  begin

    DataSet := TFDMemTable.Create(self);
    try
      TUsuarios.new.LimpaTabelaUser.BuscaUserServidor(DataSet).PopulaUserSqLite(DataSet);

      Tparametros.new.LimpaTabelaParametros.BuscaParametrosServidor(GetIMEI, DataSet).PopulaParametrosSqLite(DataSet);

    finally
      FreeAndNil(DataSet);
    end;

    Tparametros.new.RetornaLogo(Image2);

{$IFDEF ANDROID}
    Exibir_Mensagem('SUCESSO', 'SUCESSO', 'SUCESSO', 'Foi estabelecido conexão com o servidor!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
{$ENDIF}
    FrmMain.EfetuarLogoff;
    if (not FrmMain.spbMENU.Visible) then
      FrmMain.spbMENU.Visible := True;
  end
  else
  begin
{$IFDEF ANDROID}
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não foi retornado nenhuma informação do servidor!' + sLineBreak +
      ' Verifique se a conexão está correta ou se há dados no servidor!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
{$ENDIF}
  end;

end;

procedure TFrmMain.lblLoginClick(Sender: TObject);
begin
  if testarnet then
  begin
    if (IpSrv.IsEmpty) and (PortaSrv.IsEmpty) then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro',
        'Informe o IP e a PORTA para conexão com o servidor no menu CONFIGURAÇÕES!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;
  end;

  if Tparametros.new.VerificaTablet then
  begin
    TUsuarios.new.Usuario(edtusuario.Text).Senha(edtSenha.Text).ValidaLogin;

    NomeFormAtual := 'INICIO';
    FormOpen(TFrmInicio);
    MudarCabecalho('Início');

    MultiViewGeral.Enabled := True;
    MultiViewGeral.Visible := False;
    actTab01.ExecuteTarget(self);
  end
  else
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Dispositivo Bloqueado, procure seu supervisor!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

procedure TFrmMain.LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
begin
  FormatSettings.DecimalSeparator := '.';
  Lat := Format('%2.6f', [NewLocation.Latitude]);
  Long := Format('%2.6f', [NewLocation.Longitude]);
  FormatSettings.DecimalSeparator := ',';
end;

procedure TFrmMain.MudarCabecalho(ACabecalho: String);
begin
  lblEmpresa.Text := ACabecalho;
end;

procedure TFrmMain.rctClick(Sender: TObject);
begin
  TabControlGeral.ActiveTab := tabCadDispo;
end;

procedure TFrmMain.Rectangle10Click(Sender: TObject);
begin
    FrmMain.NomeFormAtual := 'PRODUTOS';
  FrmMain.MudarCabecalho('Produtos');
  FormOpen(TFrmProdutos);
  MultiViewGeral.HideMaster;
end;

procedure TFrmMain.Rectangle12Click(Sender: TObject);
begin
  Sistema.FormAtual := 'Clientes';
  MudarCabecalho('Clientes');
  FormOpen(TFrmClientes);
  MultiViewGeral.HideMaster;
end;

procedure TFrmMain.Rectangle13Click(Sender: TObject);
begin
  FrmMain.NomeFormAtual := 'PEDIDOS';
  FrmMain.MudarCabecalho('Pedidos');
  FrmMain.FormOpen(TFrmPedidos);
  MultiViewGeral.HideMaster;

end;

procedure TFrmMain.Rectangle14Click(Sender: TObject);
begin
  Sistema.FormAtual := 'Início';
  MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
  MultiViewGeral.HideMaster;
end;

procedure TFrmMain.Rectangle16Click(Sender: TObject);
begin
 FrmMain.NomeFormAtual := 'VERSAO';
  FrmMain.MudarCabecalho('Informação do Sistema');
  FormOpen(TFrmInforSistema);
  MultiViewGeral.HideMaster;
end;

procedure TFrmMain.Rectangle17Click(Sender: TObject);
begin
   FrmMain.NomeFormAtual := 'SINCRONIZACAO';
  FrmMain.MudarCabecalho('Sincronização');
  FormOpen(TFrmSinc);
  MultiViewGeral.HideMaster;
end;

procedure TFrmMain.Rectangle18Click(Sender: TObject);
begin
   FrmMain.NomeFormAtual := 'RESUMO';
  FrmMain.MudarCabecalho('Resumo');
  FormOpen(TFrmResumoVend);
 MultiViewGeral.HideMaster;
end;

procedure TFrmMain.Rectangle1Click(Sender: TObject);
begin
  MultiViewGeral.Enabled := True;
  MultiViewGeral.Visible := True;
  spbMENU.Visible := False;
  actTab01.ExecuteTarget(self);
end;

procedure TFrmMain.Rectangle6Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.Rectangle9Click(Sender: TObject);
begin
  EfetuarLogoff;
  MultiViewGeral.HideMaster;
end;

procedure TFrmMain.RestorePosition;
begin
  vtsScrollAble.ViewportPosition := PointF(vtsScrollAble.ViewportPosition.X, 0);
  LayoutClientPesq56.Align := TAlignLayout.Client;
  vtsScrollAble.RealignContent;
end;

procedure TFrmMain.SetCodVendedor(const Value: integer);
begin
  FCodVendedor := Value;
end;

procedure TFrmMain.SetIdVendaAtual(const Value: integer);
begin
  FIdVendaAtual := Value;
end;

procedure TFrmMain.SetNomeFormAtual(const Value: string);
begin
  FNomeFormAtual := Value;
end;

procedure TFrmMain.SetNomeUsuarioAtual(const Value: string);
begin
  FNomeUsuarioAtual := Value;
end;

procedure TFrmMain.SetTabClientes(const Value: integer);
begin
  FTabClientes := Value;
end;

procedure TFrmMain.SetTabPedidos(const Value: integer);
begin
  FTabPedidos := Value;
end;

procedure TFrmMain.SetTabPositivacao(const Value: integer);
begin
  FTabPositivacao := Value;
end;

procedure TFrmMain.SetTabProdutos(const Value: integer);
begin
  FTabProdutos := Value;
end;

procedure TFrmMain.SetTabTabConsultas(const Value: integer);
begin
  FTabTabConsultas := Value;
end;

procedure TFrmMain.spbMENUClick(Sender: TObject);
begin
  Sistema.FormAtual := 'Formulario Inicial';
end;


procedure TFrmMain.img_EnvDeviceIdClick(Sender: TObject);
var
  Destinatario: string;
{$IF DEFINED (ANDROID)}
  Intent: JIntent;
  Destinatarios: TJavaObjectArray<JString>;
{$ENDIF}
begin

  if edt_NomeVendedor.Text = EmptyStr then
    raise Exception.Create('Digite o nome do vendedor que ira usar essa disposivo!');

  if edt_empresa.Text = EmptyStr then
    raise Exception.Create('Digite o nome da empresa que ira usar essa disposivo!');

{$IF DEFINED (ANDROID)}
  Destinatario := 'suporte@g2sistemas.com.br';
  Destinatarios := TJavaObjectArray<JString>.Create(1);

  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
  Destinatarios.Items[0] := StringToJString(Destinatario);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, Destinatarios);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString('LIBERAÇÃO DE TABLET'));
  Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString('EMPRESA: ' + edt_empresa.Text + sLineBreak +
    'VENDEDOR: ' + edt_NomeVendedor.Text + sLineBreak + 'Device_ID: ' + GetIMEI));
  Intent.setType(StringToJString('plain/text'));
  SharedActivity.startActivity(TJIntent.JavaClass.createChooser(Intent,
    StrToJCharSequence('Qual aplicativo deseja usar?')));

{$ENDIF}
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  // GerarMenus;
end;

procedure TFrmMain.TratarTabControl(TabControl: TTabControl);
begin
  if TabPedidos = 1 then
  begin
    TabControl.TabIndex := 0;
  end
  else if TabPedidos = 2 then
  begin
    TabControl.TabIndex := 0;
  end
  else if TabPedidos = 3 then
  begin
    TabControl.TabIndex := 2;
  end
  else if TabPedidos = 4 then
  begin
    TabControl.TabIndex := 2;
  end
  else if TabPedidos = 5 then
  begin
    TabControl.TabIndex := 6;
  end
  else if TabPedidos = 6 then
  begin
    TabControl.TabIndex := 2;
  end;
end;

procedure TFrmMain.UpdateKBBounds;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;

  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vtsScrollAble.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      LayoutClientPesq56.Align := TAlignLayout.Horizontal;
      vtsScrollAble.RealignContent;
      Application.ProcessMessages;
      vtsScrollAble.ViewportPosition := PointF(vtsScrollAble.ViewportPosition.X, LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;

  if not FNeedOffset then
    RestorePosition;

end;

end.
