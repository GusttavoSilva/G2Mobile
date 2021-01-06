unit uFrmPedido;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.TabControl,
  FMX.Layouts,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Objects,
  FMX.Edit,
  FMX.StdCtrls,
  FMX.DateTimeCtrls,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.ListView,
  uClasseNovoPedido,
  System.DateUtils,
  uFrmUtilFormate,
  Form_Mensagem,
  FMX.Effects,
  uClasseClientes,
  uClasseFormaPagamento,
  uClasseProdutos,
  uClasseCamaraFria,
  FMX.ScrollBox,
  FMX.Memo,
  Loading,
  uInterfaceCamaraFria,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.VirtualKeyboard,
  FMX.Platform,
  FMX.ComboEdit,
  System.Sensors,
  System.Sensors.Components;

type
  TFrmPedidos = class(TForm)
    LayoutClientPesq: TLayout;
    TabControl1: TTabControl;
    tab_ListPedidos: TTabItem;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    list_Pedidos: TListView;
    lay_Pesquisa: TLayout;
    Rectangle16: TRectangle;
    Layout1: TLayout;
    GridPanel: TGridPanelLayout;
    Layout42: TLayout;
    cbx_BoxSituacao: TComboBox;
    Label38: TLabel;
    Layout43: TLayout;
    Label36: TLabel;
    dtInicial: TDateEdit;
    Layout44: TLayout;
    Label37: TLabel;
    Layout5: TLayout;
    Button2: TButton;
    rct_BtnFiltrerPedidos: TRectangle;
    Label23: TLabel;
    edt_Pesq: TEdit;
    SearchEditButton1: TSearchEditButton;
    img_Pendente: TImage;
    img_enviado: TImage;
    img_Reprovado: TImage;
    img_Aprovado: TImage;
    dtFinal: TDateEdit;
    tab_InfoPedido: TTabItem;
    Layout6: TLayout;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Button1: TButton;
    ShadowEffect1: TShadowEffect;
    Layout8: TLayout;
    tab_NovoPedido: TTabItem;
    tab_ItensNovoPedido: TTabItem;
    tab_PesqCliente: TTabItem;
    tab_PesqFormaPagamento: TTabItem;
    tab_PesqProdutos: TTabItem;
    tab_PesqCamaraFria: TTabItem;
    Layout9: TLayout;
    Layout11: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout15: TLayout;
    list_PesqCliente: TListView;
    ShadowEffect6: TShadowEffect;
    img_negativo: TImage;
    img_positivo: TImage;
    list_PesqProd: TListView;
    img_SemFoto: TImage;
    list_PesqPagamento: TListView;
    img_Money: TImage;
    Layout17: TLayout;
    Layout18: TLayout;
    Button4: TButton;
    Label2: TLabel;
    edt_PesqFormaPagamento: TEdit;
    SearchEditButton3: TSearchEditButton;
    Layout14: TLayout;
    Layout19: TLayout;
    Button5: TButton;
    Layout20: TLayout;
    Label4: TLabel;
    edt_PesqProd: TEdit;
    SearchEditButton4: TSearchEditButton;
    Layout16: TLayout;
    Layout21: TLayout;
    Button6: TButton;
    Layout22: TLayout;
    Label5: TLabel;
    edt_PesqCamaraFria: TEdit;
    SearchEditButton5: TSearchEditButton;
    list_PesqCamaraFria: TListView;
    img_armazem: TImage;
    Layout23: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect3: TShadowEffect;
    Label6: TLabel;
    Layout24: TLayout;
    Rectangle4: TRectangle;
    Rectangle10: TRectangle;
    Label7: TLabel;
    StyleBook1: TStyleBook;
    Rectangle17: TRectangle;
    memo_ObsPedido: TMemo;
    GridPanelLayout3: TGridPanelLayout;
    Layout25: TLayout;
    rctCancelar: TRectangle;
    lblCancelar: TLabel;
    Layout26: TLayout;
    rctAddItens: TRectangle;
    rct_IncluiItem: TLabel;
    Layout27: TLayout;
    rctFinalizar: TRectangle;
    lblFinalizar: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    Layout28: TLayout;
    Rectangle5: TRectangle;
    dt_Entrega: TDateEdit;
    Label10: TLabel;
    Layout29: TLayout;
    Label8: TLabel;
    Rectangle11: TRectangle;
    cbx_Comissao: TComboBox;
    Layout34: TLayout;
    Rectangle12: TRectangle;
    edt_LimiteDisp: TEdit;
    Label11: TLabel;
    GridPanelLayout5: TGridPanelLayout;
    Layout35: TLayout;
    rctangue: TRectangle;
    Label14: TLabel;
    Layout36: TLayout;
    Label15: TLabel;
    Rectangle14: TRectangle;
    Layout37: TLayout;
    Rectangle15: TRectangle;
    edt_VlrLiquido: TEdit;
    Label16: TLabel;
    edt_VlrDesconto: TEdit;
    edt_VlrBruto: TEdit;
    Layout40: TLayout;
    Rectangle6: TRectangle;
    Image4: TImage;
    btn_Novo: TCircle;
    ShadowEffect4: TShadowEffect;
    Layout10: TLayout;
    Layout46: TLayout;
    btn_VoltaNovoPedido: TButton;
    Layout47: TLayout;
    Label1: TLabel;
    edt_PesqPessoa: TEdit;
    SearchEditButton2: TSearchEditButton;
    Layout48: TLayout;
    rct_BtnClientes: TRectangle;
    Layout49: TLayout;
    edt_CodCliente: TEdit;
    Layout50: TLayout;
    edt_Cliente: TEdit;
    Image5: TImage;
    Label17: TLabel;
    Label12: TLabel;
    rct_BtnFormaPagamento: TRectangle;
    Layout30: TLayout;
    edt_CodFormaPagamento: TEdit;
    Layout31: TLayout;
    edt_FormaPagamento: TEdit;
    Image2: TImage;
    Layout38: TLayout;
    Label9: TLabel;
    rct_BtnCamaraFria: TRectangle;
    Layout41: TLayout;
    edt_CodCamaraFria: TEdit;
    Layout45: TLayout;
    edt_CamaraFria: TEdit;
    Image3: TImage;
    lay_Info: TLayout;
    Label13: TLabel;
    lbl_Cliente: TLabel;
    Label18: TLabel;
    lbl_Emissao: TLabel;
    Label20: TLabel;
    lbl_ValorPrevisto: TLabel;
    Label22: TLabel;
    lbl_CodRet: TLabel;
    Label25: TLabel;
    lbl_FormaPagamento: TLabel;
    Label27: TLabel;
    lbl_comissao: TLabel;
    Label29: TLabel;
    lbl_faturado: TLabel;
    Label33: TLabel;
    lbl_Situacao: TLabel;
    Label35: TLabel;
    lbl_CamaraFria: TLabel;
    Rectangle3: TRectangle;
    mem_InfoObsPedido: TMemo;
    Label19: TLabel;
    lay_Reprovado: TLayout;
    Rectangle7: TRectangle;
    mem_PedidoReprovado: TMemo;
    Label21: TLabel;
    strList_InfoPed: TStringGrid;
    cod_prod: TStringColumn;
    nome_prod: TStringColumn;
    unid_item: TStringColumn;
    qtd_prod: TStringColumn;
    valor_item: TStringColumn;
    desconto_item: TStringColumn;
    valortotal_item: TStringColumn;
    Layout7: TLayout;
    Layout32: TLayout;
    Layout33: TLayout;
    Button3: TButton;
    Layout39: TLayout;
    Label24: TLabel;
    Layout60: TLayout;
    Label31: TLabel;
    Layout63: TLayout;
    Rectangle19: TRectangle;
    Layout64: TLayout;
    edt_CodProd: TEdit;
    Layout65: TLayout;
    edt_Prod: TEdit;
    Image9: TImage;
    Label32: TLabel;
    Layout51: TLayout;
    Rectangle8: TRectangle;
    img_FotoProd: TImage;
    Label39: TLabel;
    Layout52: TLayout;
    Label34: TLabel;
    lbl_validade: TLabel;
    Label30: TLabel;
    lbl_VlrProd: TLabel;
    lbl_PesoText: TLabel;
    lbl_Peso: TLabel;
    Layout53: TLayout;
    Rectangle9: TRectangle;
    edt_VlrProd: TEdit;
    Label40: TLabel;
    Layout56: TLayout;
    Rectangle13: TRectangle;
    edt_VlrDesc: TEdit;
    Label41: TLabel;
    Layout59: TLayout;
    Rectangle18: TRectangle;
    edt_VlrTotal: TEdit;
    Label42: TLabel;
    Layout66: TLayout;
    Rectangle20: TRectangle;
    Layout67: TLayout;
    lbl_QntCaixa: TLabel;
    lbl_QntCaixaText: TLabel;
    lbl_GrupoComercial: TLabel;
    lbl_unid: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Layout68: TLayout;
    Rectangle21: TRectangle;
    edt_QntProd: TEdit;
    Label43: TLabel;
    lytAddItem: TLayout;
    rctAddItem: TRectangle;
    rct_AddItem: TLabel;
    Image1: TImage;
    Image6: TImage;
    lay_Teclado: TLayout;
    Rectangle22: TRectangle;
    Layout54: TLayout;
    Rectangle23: TRectangle;
    lbl_valor: TLabel;
    rct_AjustaValor: TRectangle;
    img_salvar: TImage;
    Rectangle24: TRectangle;
    layout_valor: TLayout;
    Layout55: TLayout;
    Rectangle25: TRectangle;
    lbl_tecla7: TLabel;
    Layout57: TLayout;
    Rectangle26: TRectangle;
    lbl_tecla8: TLabel;
    Layout58: TLayout;
    Rectangle27: TRectangle;
    lbl_tecla9: TLabel;
    lbl_tecla4: TLayout;
    Rectangle28: TRectangle;
    Label44: TLabel;
    Layout61: TLayout;
    Rectangle29: TRectangle;
    lbl_tecla5: TLabel;
    Layout62: TLayout;
    Rectangle30: TRectangle;
    lbl_tecla6: TLabel;
    Layout69: TLayout;
    Rectangle31: TRectangle;
    lbl_tecla1: TLabel;
    Layout70: TLayout;
    Rectangle33: TRectangle;
    lbl_tecla2: TLabel;
    Layout71: TLayout;
    Rectangle34: TRectangle;
    lbl_tecla3: TLabel;
    Layout72: TLayout;
    rct_ClickTeclado: TRectangle;
    lbl_tecla00: TLabel;
    Layout73: TLayout;
    Rectangle36: TRectangle;
    lbl_tecla0: TLabel;
    Layout74: TLayout;
    Rectangle37: TRectangle;
    img_backspace: TImage;
    Circle1: TCircle;
    Rectangle38: TRectangle;
    img_limpar: TImage;
    Rectangle39: TRectangle;
    Image7: TImage;
    strgrid_ProdutoPed: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    ValorBruto: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    Label45: TLabel;
    Layout75: TLayout;
    Rectangle32: TRectangle;
    Label46: TLabel;
    cbx_Und: TComboEdit;
    ToolBar2: TToolBar;
    Btn_Deletar: TButton;
    Button17: TButton;
    btn_Replicar: TButton;
    btn_Editar: TButton;
    lbl_chaveInfo: TLabel;
    lbl_ChavePedido: TLabel;
    Label47: TLabel;
    lbl_Data_Emb: TLabel;
    QTD_REAL: TStringColumn;
    PESO: TStringColumn;
    VRFATURADO: TStringColumn;
    procedure FormCreate(Sender: TObject);
    procedure rct_BtnFiltrerPedidosClick(Sender: TObject);
    procedure list_PedidosItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure rct_BtnFormaPagamentoClick(Sender: TObject);
    procedure rct_BtnCamaraFriaClick(Sender: TObject);
    procedure rct_BtnClientesClick(Sender: TObject);
    procedure rct_IncluiItemClick(Sender: TObject);
    procedure btn_NovoClick(Sender: TObject);
    procedure edt_PesqChangeTracking(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_VoltaNovoPedidoClick(Sender: TObject);
    procedure list_PesqClienteItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure list_PesqPagamentoItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure list_PesqProdItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure list_PesqCamaraFriaItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure lblCancelarClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure rct_AjustaValorClick(Sender: TObject);
    procedure lbl_tecla0Click(Sender: TObject);
    procedure Rectangle37Click(Sender: TObject);
    procedure Rectangle38Click(Sender: TObject);
    procedure Rectangle39Click(Sender: TObject);
    procedure Rectangle9Click(Sender: TObject);
    procedure edt_QntProdChangeTracking(Sender: TObject);
    procedure rct_AddItemClick(Sender: TObject);
    procedure strgrid_ProdutoPedCellDblClick(const Column: TColumn; const Row: Integer);
    procedure Button2Click(Sender: TObject);
    procedure edt_PesqProdChangeTracking(Sender: TObject);
    procedure edt_PesqPessoaChangeTracking(Sender: TObject);
    procedure lblFinalizarClick(Sender: TObject);
    procedure edt_CodFormaPagamentoChangeTracking(Sender: TObject);
    procedure edt_CodCamaraFriaChangeTracking(Sender: TObject);
    procedure edt_CodClienteChangeTracking(Sender: TObject);
    procedure btn_ReplicarClick(Sender: TObject);
    procedure btn_EditarClick(Sender: TObject);
    procedure Btn_DeletarClick(Sender: TObject);

  private
    procedure Tecla_Numero(lbl: TObject);
    procedure Tecla_Backspace();
  public
    { Public declarations }

    procedure CalcVlrProd;
    procedure SelecioneCliente;
    procedure AddProduto;
    procedure SelecionaProduto;
    procedure SomaItens;
    procedure PopulaCliente;
    procedure PopulaProduto;
    procedure FinalizaPedido;
    procedure EditaReplicaPedido;
    procedure DeletarPedido;
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

{$R *.fmx}

uses
  uClasseNovoPedidoItem,
  uClasseParametro,
  uFrmMain,
  uFrmInicio;

procedure TFrmPedidos.AddProduto;
begin

  TNovoPedidoItem.new.cod_prod(edt_CodProd.Text.ToInteger).NomeProd(edt_Prod.Text).Und(cbx_Und.ItemIndex)
    .Qnt(edt_QntProd.Text.ToInteger).VlrUnit(StrParaDouble(edt_VlrProd.Text))
    .VlrDesconto(StrParaDouble(edt_VlrDesc.Text)).VlrLiquido(StrParaDouble(edt_VlrTotal.Text))
    .AddProdlistPedido(strgrid_ProdutoPed);

  SomaItens;

  TabControl1.TabIndex := 2;
end;

procedure TFrmPedidos.btn_NovoClick(Sender: TObject);
begin
  ClearStringGrid(strgrid_ProdutoPed);
  edt_CodCliente.Text := EmptyStr;
  edt_Cliente.Text := EmptyStr;
  edt_CodFormaPagamento.Text := EmptyStr;
  edt_FormaPagamento.Text := EmptyStr;
  edt_CodCamaraFria.Text := EmptyStr;
  edt_CamaraFria.Text := EmptyStr;
  memo_ObsPedido.Lines.Clear;

  dt_Entrega.Date := DataHoje;
  // PopulaCliente;
  TCamaraFria.new.PopulaListView(list_PesqCamaraFria, img_armazem);
  // TProdutos.new.PopulaListView(list_PesqProd, img_SemFoto, edt_PesqProd.Text);
  PopulaProduto;
  edt_CodCamaraFria.Text := TCamaraFria.new.RetornaCamaraFriaVendedor(codUser);

  rct_BtnClientesClick(self);
end;

procedure TFrmPedidos.PopulaCliente;
begin
  TClientes.new.PopulaListView(list_PesqCliente, img_positivo, img_negativo, edt_PesqPessoa.Text);
end;

procedure TFrmPedidos.PopulaProduto;
begin
  TProdutos.new.PopulaListView(list_PesqProd, img_SemFoto, edt_PesqProd.Text);
end;

procedure TFrmPedidos.btn_VoltaNovoPedidoClick(Sender: TObject);
begin
  TabControl1.TabIndex := 2;
end;

procedure TFrmPedidos.btn_ReplicarClick(Sender: TObject);
begin
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Ativação', 'Deseja replicar esse pedido?', 'Sim', 'Não', $FFDF5447,
    $FFABABAB);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        lbl_ChavePedido.Text := EmptyStr;
        EditaReplicaPedido;
      end;
    end);
end;

procedure TFrmPedidos.Btn_DeletarClick(Sender: TObject);
begin
  TNovoPedido.new.Chave(lbl_chaveInfo.Text).StatusPedido;
  // Mensagem de confirmacao...
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Ativação', 'Deseja deletar esse pedido?', 'Sim', 'Não', $FFDF5447,
    $FFABABAB);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        DeletarPedido;
        rct_BtnFiltrerPedidosClick(self);
        TabControl1.TabIndex := 0;
      end;
    end);
end;

procedure TFrmPedidos.btn_EditarClick(Sender: TObject);
begin
  TNovoPedido.new.Chave(lbl_chaveInfo.Text).StatusPedido;

  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Ativação', 'Deseja editar esse pedido?', 'Sim', 'Não', $FFDF5447, $FFABABAB);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        lbl_ChavePedido.Text := lbl_chaveInfo.Text;
        EditaReplicaPedido;
      end;
    end);

end;

procedure TFrmPedidos.Button1Click(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TFrmPedidos.Button2Click(Sender: TObject);
begin
  FrmMain.MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
end;

procedure TFrmPedidos.CalcVlrProd;
var
  List: TStringList;
begin
  try
    List := TStringList.Create;
    TNovoPedidoItem.new.cod_prod(edt_CodProd.Text.ToInteger).Qnt(edt_QntProd.Text.ToInteger)
      .VlrUnit(StrParaDouble(edt_VlrProd.Text)).CalcProduto(List);
    edt_VlrDesc.Text := formatFloat('#,##0.00', StrToFloat(List[0]));
    edt_VlrTotal.Text := formatFloat('#,##0.00', StrToFloat(List[1]));

  finally
    FreeAndNil(List);
  end;
end;

procedure TFrmPedidos.DeletarPedido;
begin
  TNovoPedido.new.Chave(lbl_chaveInfo.Text).DeletePedido;
  TNovoPedidoItem.new.Chave(lbl_chaveInfo.Text).DeleteItems;
end;

procedure TFrmPedidos.EditaReplicaPedido;
var
  List: TStringList;
begin
  ClearStringGrid(strgrid_ProdutoPed);
  memo_ObsPedido.Lines.Clear;
  try
    List := TStringList.Create;
    TNovoPedido.new.Chave(lbl_chaveInfo.Text).EditaReplicaPedido(List);
    edt_CodCliente.Text := formatFloat('0000', StrToFloat(List[0]));
    edt_CodFormaPagamento.Text := formatFloat('0000', StrToFloat(List[1]));
    edt_CodCamaraFria.Text := formatFloat('0000', StrToFloat(List[2]));
    cbx_Comissao.ItemIndex := StrToInt(List[3]);
    memo_ObsPedido.Lines.Add(List[4]);
    dt_Entrega.Date := StrToDate(List[5]);

    TNovoPedidoItem.new.Chave(lbl_chaveInfo.Text).EditaRecplicarItem(strgrid_ProdutoPed);
    SomaItens;
    TabControl1.TabIndex := 2;
  finally
    FreeAndNil(List);
  end;
end;

procedure TFrmPedidos.edt_CodCamaraFriaChangeTracking(Sender: TObject);
begin

  if edt_CodCamaraFria.Text <> '' then
    edt_CamaraFria.Text := TCamaraFria.new.BuscarCamaraFria(StrToInt(edt_CodCamaraFria.Text))
  else
    edt_CamaraFria.Text := EmptyStr;
  if edt_CamaraFria.Text = '' then
    edt_CodCamaraFria.Text := '0000';

end;

procedure TFrmPedidos.edt_CodClienteChangeTracking(Sender: TObject);
begin
  if edt_CodCliente.Text <> '' then
  begin
    edt_Cliente.Text := TClientes.new.BuscarCliente(edt_CodCliente.Text.ToInteger);
    edt_LimiteDisp.Text := TClientes.new.RetornaLimite(StrToInt(edt_CodCliente.Text));
  end
  else
    edt_Cliente.Text := EmptyStr;
  if edt_Cliente.Text = '' then
    edt_CodCliente.Text := '0000';
end;

procedure TFrmPedidos.edt_CodFormaPagamentoChangeTracking(Sender: TObject);
begin
  if edt_CodFormaPagamento.Text <> '' then
    edt_FormaPagamento.Text := TFormaPagamento.new.BuscarFormaPagamento(edt_CodFormaPagamento.Text.ToInteger)
  else
    edt_FormaPagamento.Text := EmptyStr;
  if edt_FormaPagamento.Text = '' then
    edt_CodFormaPagamento.Text := '0000';

  edt_FormaPagamento.Text := TFormaPagamento.new.BuscarFormaPagamento(edt_CodFormaPagamento.Text.ToInteger);
end;

procedure TFrmPedidos.edt_PesqChangeTracking(Sender: TObject);
begin
  sbList.Text := edt_Pesq.Text;
end;

procedure TFrmPedidos.edt_PesqPessoaChangeTracking(Sender: TObject);
begin
  PopulaCliente;
end;

procedure TFrmPedidos.edt_PesqProdChangeTracking(Sender: TObject);
begin
  PopulaProduto;
end;

procedure TFrmPedidos.edt_QntProdChangeTracking(Sender: TObject);
begin
  CalcVlrProd;
end;

procedure TFrmPedidos.FormCreate(Sender: TObject);
begin
  lay_Teclado.Visible := false;
  img_Pendente.Visible := false;
  img_enviado.Visible := false;
  img_Reprovado.Visible := false;
  img_Aprovado.Visible := false;
  dtInicial.Date := StartOfTheMonth(Date);
  dtFinal.Date := EndOfTheMonth(Date);
  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;

  // POPULA lISTVIEWPEDIDOS
  rct_BtnFiltrerPedidosClick(self);

end;

procedure TFrmPedidos.lbl_tecla0Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;
  Tecla_Numero(Sender);

end;

procedure TFrmPedidos.rct_IncluiItemClick(Sender: TObject);
begin

  TNovoPedido.new.CodCliente(edt_CodCliente.Text.ToInteger).CodCamara(edt_CodCamaraFria.Text.ToInteger)
    .DataEmb(dt_Entrega.Date).ValidaAddProd;

  TabControl1.TabIndex := 6;
  edt_PesqProd.SetFocus;
  img_SemFoto.Visible := false;
  PopulaProduto;

  // ListViewSearch(list_PesqProd);
end;

procedure TFrmPedidos.Rectangle37Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;
  Tecla_Backspace();

end;

procedure TFrmPedidos.Rectangle38Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;
  lbl_valor.Text := '0';

end;

procedure TFrmPedidos.Rectangle39Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;

  lay_Teclado.Visible := false;
end;

procedure TFrmPedidos.Rectangle9Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;

  lbl_valor.Text := edt_VlrProd.Text;
  lay_Teclado.Visible := True;
end;

procedure TFrmPedidos.lblCancelarClick(Sender: TObject);
begin
  // Mensagem de confirmacao...
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Ativação', 'Deseja cancelar esse pedido?', 'Sim', 'Não', $FFDF5447,
    $FFABABAB);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        TabControl1.TabIndex := 0;
      end;
    end);
end;

procedure TFrmPedidos.lblFinalizarClick(Sender: TObject);
var
  Valida: String;
begin
  if verificarStringGridVazia(strgrid_ProdutoPed) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'É necessario informar produtos para esse pedido!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  Valida := TNovoPedido.new.CodCliente(edt_CodCliente.Text.ToInteger).VerificaPedido(strgrid_ProdutoPed);

  if Valida <> '' then
  begin
    MessageDlg(Valida + sLineBreak + 'Deseja finalizar esse pedido?', System.UITypes.TMsgDlgType.mtConfirmation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYes:
            begin
              FinalizaPedido;
            end;
        end;
      end);
  end
  else
    FinalizaPedido;
end;

procedure TFrmPedidos.FinalizaPedido;
var
  Chave: String;
  acao: Integer;
begin

  if lbl_ChavePedido.Text.IsEmpty then
  begin
    Chave := GerarChave;
    acao := 0;
  end
  else
  begin
    acao := 1;
    Chave := lbl_ChavePedido.Text;
    TNovoPedidoItem.new.Chave(Chave).DeleteItems;
  end;

  TNovoPedido.new.acao(acao).Chave(Chave).FormaPagamento(edt_CodFormaPagamento.Text.ToInteger)
    .CodCamara(edt_CodCamaraFria.Text.ToInteger).codUser(codUser).CodVendedor(CodVend)
    .CodCliente(edt_CodCliente.Text.ToInteger).Emissao(now).DataEmb(dt_Entrega.Date)
    .Valor(StrParaDouble(edt_VlrLiquido.Text)).Desconto(StrParaDouble(edt_VlrDesconto.Text))
    .Total(StrParaDouble(edt_VlrLiquido.Text)).Comissao(cbx_Comissao.ItemIndex).Latitude(Lat).Longitude(Long)
    .Obs(memo_ObsPedido.Lines.Text).ValidaAddProd.InsertPedido;

  TNovoPedidoItem.new.Chave(Chave).InsertItens(strgrid_ProdutoPed);

  TabControl1.TabIndex := 0;
  rct_BtnFiltrerPedidosClick(self);

end;

procedure TFrmPedidos.list_PedidosItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
  List: TStringList;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('chave'));
    try
      List := TStringList.Create;
      lbl_chaveInfo.Text := txt.TagString;
      TNovoPedido.new.InfoPedido(txt.TagString, List);
      if List[0] <> '' then
      begin
        lay_Reprovado.Visible := True;
        mem_PedidoReprovado.Lines.Add(List[0]);
        lay_Info.Height := 390;
      end
      else
      begin
        lay_Info.Height := 315;
        lay_Reprovado.Visible := false;
        mem_PedidoReprovado.Lines.Clear;
      end;

      lbl_FormaPagamento.Text := List[1];
      lbl_CodRet.Text := List[2];
      lbl_Data_Emb.Text := List[3];
      lbl_Cliente.Text := List[4];
      lbl_Emissao.Text := List[5];
      lbl_CamaraFria.Text := List[6];
      lbl_comissao.Text := List[7];
      lbl_Situacao.Text := List[8];
      lbl_ValorPrevisto.Text := formatFloat('R$#,##0.00', StrToFloat(List[9]));
      lbl_faturado.Text := formatFloat('R$#,##0.00', StrToFloat(List[10]));
      mem_InfoObsPedido.Lines.Clear;
      mem_InfoObsPedido.Lines.Add(List[11]);

      ClearStringGrid(strList_InfoPed);
      TNovoPedidoItem.new.PopulaProdInfoStringGrid(txt.TagString, strList_InfoPed);

    finally
      FreeAndNil(List);
    end;

    TabControl1.TabIndex := 1;
  end

end;

procedure TFrmPedidos.list_PesqCamaraFriaItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('codigo'));
    edt_CodCamaraFria.Text := formatFloat('0000', StrToFloat(txt.TagString));
    edt_CamaraFria.Text := TCamaraFria.new.BuscarCamaraFria(StrToInt(edt_CodCamaraFria.Text));
    TabControl1.TabIndex := 2;
  end

end;

procedure TFrmPedidos.list_PesqClienteItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('cod_cliente'));
    edt_CodCliente.Text := formatFloat('0000', StrToFloat(txt.TagString));

    case TClientes.new.ValidaCliente(StrToInt(edt_CodCliente.Text)) of
      1:
        begin
          // Mensagem de confirmacao...
          Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'PERGUNTA', 'Cliente com pendências ativas!' + sLineBreak +
            'Deseja realizar uma venda para este cliente?', 'Sim', 'Não', $FFDF5447, $FFABABAB);
          Frm_Mensagem.ShowModal(
            procedure(ModalResult: TModalResult)
            begin
              if Frm_Mensagem.retorno = '1' then
              begin
                SelecioneCliente;
              end;
            end);
        end;
      2:
        begin
          Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Cliente com pendências ativas!', 'OK', '', $FFDF5447, $FFDF5447);
          Frm_Mensagem.Show;
          abort;
        end;
      3:
        SelecioneCliente;
    end;

  end

end;

procedure TFrmPedidos.SelecioneCliente;
begin
  // edt_Cliente.Text := TClientes.new.BuscarCliente(StrToInt(edt_CodCliente.Text));
  TFormaPagamento.new.PopulaListView(StrToInt(edt_CodCliente.Text), list_PesqPagamento, img_Money);

  edt_CodFormaPagamento.Text := TFormaPagamento.new.BuscaUltimaFormaDePagamentoCliente(StrToInt(edt_CodCliente.Text));
  // edt_FormaPagamento.Text := TFormaPagamento.new.BuscarFormaPagamento(StrToInt(edt_CodFormaPagamento.Text));

  TabControl1.TabIndex := 2;
end;

procedure TFrmPedidos.SomaItens;
var
  List: TStringList;
begin
  try
    List := TStringList.Create;
    TNovoPedidoItem.new.SomaStringGrid(List, strgrid_ProdutoPed);

    edt_VlrBruto.Text := List[0];
    edt_VlrDesconto.Text := List[1];
    edt_VlrLiquido.Text := List[2];

    edt_LimiteDisp.Text := formatFloat('#,##0.00', StrParaDouble(edt_LimiteDisp.Text) -
      StrParaDouble(edt_VlrLiquido.Text));

  finally
    FreeAndNil(List);
  end;

end;

procedure TFrmPedidos.strgrid_ProdutoPedCellDblClick(const Column: TColumn; const Row: Integer);
begin

  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'PERGUNTA', 'Deseja deletar esse produto?', 'Sim', 'Não', $FFDF5447,
    $FFABABAB);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        DeleteRow(Row, strgrid_ProdutoPed);
        SomaItens;
      end;
    end);

end;

procedure TFrmPedidos.list_PesqPagamentoItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('codigo'));
    edt_CodFormaPagamento.Text := formatFloat('0000', StrToFloat(txt.TagString));
    edt_FormaPagamento.Text := TFormaPagamento.new.BuscarFormaPagamento(StrToInt(txt.TagString));
    TabControl1.TabIndex := 2;
  end

end;

procedure TFrmPedidos.list_PesqProdItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
begin

  edt_QntProd.Text := '1';
  edt_VlrDesc.Text := '0';
  edt_VlrTotal.Text := '0';
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('cod_prod'));
    edt_CodProd.Text := formatFloat('0000', StrToFloat(txt.TagString));

    if TNovoPedidoItem.new.cod_prod(edt_CodProd.Text.ToInteger).VerificaItemIncluidos(strgrid_ProdutoPed) = 1 then
    begin
      // Mensagem de confirmacao...
      Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'PERGUNTA', 'Produto já incluido!' + sLineBreak +
        'Deseja incluir novamente?', 'Sim', 'Não', $FFDF5447, $FFABABAB);
      Frm_Mensagem.ShowModal(
        procedure(ModalResult: TModalResult)
        begin
          if Frm_Mensagem.retorno = '1' then
          begin
            SelecionaProduto;
          end;
        end);
    end
    else
      SelecionaProduto;
  end;

end;

procedure TFrmPedidos.SelecionaProduto;
var
  List: TStringList;
begin
  try
  edt_QntProd.Text := '1';
    List := TStringList.Create;
    TProdutos.new.RetornaFoto(edt_CodProd.Text.ToInteger, img_SemFoto, img_FotoProd);
    TProdutos.new.PopulaCampos(edt_CodProd.Text.ToInteger, List);

    edt_CodProd.Text := formatFloat('0000', StrToFloat(List[0]));
    edt_Prod.Text := List[1];
    lbl_validade.Text := List[2];
    lbl_GrupoComercial.Text := List[3];
    lbl_unid.Text := List[4];
    lbl_VlrProd.Text := formatFloat('R$#,##0.00', StrToFloat(List[5]));
    lbl_QntCaixa.Text := List[6];
    lbl_Peso.Text := List[7];

    edt_VlrProd.Text := formatFloat('#,##0.00', StrToFloat(List[5]));

    case TParametros.new.Parametro('unid_med') of
      0:
        begin
          cbx_Und.ItemIndex := 0;
          cbx_Und.Enabled := false;
        end;
      1:
        begin
          cbx_Und.ItemIndex := 1;
          cbx_Und.Enabled := false;
        end;
      2:
        begin
          cbx_Und.ItemIndex := 0;
          cbx_Und.Enabled := True;
        end;
    end;

    TabControl1.TabIndex := 3;
  finally
    FreeAndNil(List);
  end;

end;

procedure TFrmPedidos.rct_BtnFiltrerPedidosClick(Sender: TObject);
begin
  ListViewSearch(list_Pedidos);
  TNovoPedido.new.CodVendedor(CodVend).PSituacao(cbx_BoxSituacao.ItemIndex).PDataIni(dtInicial.Date).PDatafim(dtFinal.Date)
    .Filter.PopulaListPedidos(list_Pedidos, img_enviado, img_Pendente, img_Aprovado, img_Reprovado);
end;

procedure TFrmPedidos.rct_BtnFormaPagamentoClick(Sender: TObject);
begin
  TabControl1.TabIndex := 5;
  img_Money.Visible := false;
  ListViewSearch(list_PesqPagamento);
end;

procedure TFrmPedidos.rct_AddItemClick(Sender: TObject);
begin

  case TNovoPedidoItem.new.cod_prod(edt_CodProd.Text.ToInteger).VlrUnit(StrParaDouble(edt_VlrProd.Text))
    .ValidaPrecoMinino of
    0:
      begin
        Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Valor do produto inferior ao mínimo!', 'OK', '', $FFDF5447,
          $FFDF5447);
        Frm_Mensagem.Show;
        abort;
      end;
    1:
      begin
        // Mensagem de confirmacao...
        Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Ativação', 'Valor do produto inferior ao mínimo!' + sLineBreak +
          'Deseja incluir esse produto?', 'Sim', 'Não', $FFDF5447, $FFABABAB);
        Frm_Mensagem.ShowModal(
          procedure(ModalResult: TModalResult)
          begin
            if Frm_Mensagem.retorno = '1' then
            begin
              AddProduto;
            end;
          end);
      end;
    2:
      begin
        AddProduto;
      end;
  end;
end;

procedure TFrmPedidos.rct_AjustaValorClick(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;

  edt_VlrProd.Text := lbl_valor.Text;
  lay_Teclado.Visible := false;
end;

procedure TFrmPedidos.rct_BtnCamaraFriaClick(Sender: TObject);
begin
  TabControl1.TabIndex := 7;
  img_armazem.Visible := false;
  ListViewSearch(list_PesqCamaraFria);
end;

procedure TFrmPedidos.rct_BtnClientesClick(Sender: TObject);
begin

  TabControl1.TabIndex := 4;
  edt_PesqPessoa.Text := EmptyStr;
  edt_PesqPessoa.SetFocus;
  PopulaCliente;
  img_positivo.Visible := false;
  img_negativo.Visible := false;
  // ListViewSearch(list_PesqCliente);
end;

procedure TFrmPedidos.Image1Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;
  edt_QntProd.Text := IntToStr(edt_QntProd.Text.ToInteger + 1);
end;

procedure TFrmPedidos.Image6Click(Sender: TObject);
var
  KeyboardService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(KeyboardService)) then
    KeyboardService.HideVirtualKeyboard;
  if edt_QntProd.Text.ToInteger > 1 then
    edt_QntProd.Text := IntToStr(edt_QntProd.Text.ToInteger - 1);
end;

procedure TFrmPedidos.Tecla_Backspace();
var
  Valor: string;
begin
  Valor := lbl_valor.Text;
  Valor := StringReplace(Valor, '.', '', [rfReplaceAll]);
  Valor := StringReplace(Valor, ',', '', [rfReplaceAll]);

  if Length(Valor) > 1 then
    Valor := copy(Valor, 1, Length(Valor) - 1)
  else
    Valor := '0';

  lbl_valor.Text := FormataValor(floattostr(StrToFloat(Valor) / 100));

end;

procedure TFrmPedidos.Tecla_Numero(lbl: TObject);
var
  Valor: string;
begin
  Valor := lbl_valor.Text;
  Valor := StringReplace(Valor, '.', '', [rfReplaceAll]);
  Valor := StringReplace(Valor, ',', '', [rfReplaceAll]);

  Valor := Valor + TLabel(lbl).Text;

  lbl_valor.Text := FormataValor(floattostr(StrToFloat(Valor) / 100));

end;

end.
