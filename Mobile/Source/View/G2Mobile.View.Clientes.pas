unit G2Mobile.View.Clientes;

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
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.ListView,
  FMX.Effects,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.Layouts,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.ScrollBox;

type
  TFrmClientes = class(TForm)
    LayoutClientPesq: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    Button1: TButton;
    edtPesq: TEdit;
    SearchEditButton1: TSearchEditButton;
    ShadowEffect2: TShadowEffect;
    ListView1: TListView;
    TabItem2: TTabItem;
    ShadowEffect3: TShadowEffect;
    Rectangle4: TRectangle;
    img_negativo: TImage;
    img_positivo: TImage;
    TabControl2: TTabControl;
    TabItem3: TTabItem;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Button2: TButton;
    ShadowEffect1: TShadowEffect;
    Rectangle1: TRectangle;
    VertScrollBox1: TVertScrollBox;
    lay_EnderecoCliente: TLayout;
    Rectangle5: TRectangle;
    lbl_Cidade: TLabel;
    lbl_Endereco: TLabel;
    lbl_Bairro: TLabel;
    Layout4: TLayout;
    Image2: TImage;
    Label10: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lay_FinanceiroCliente: TLayout;
    Rectangle7: TRectangle;
    lbl_vlrAberto: TLabel;
    Label14: TLabel;
    lbl_CredDisponivel: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lbl_Credito: TLabel;
    Layout6: TLayout;
    Image1: TImage;
    lay_InfoCliente: TLayout;
    Rectangle6: TRectangle;
    Label1: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    lbl_Email: TLabel;
    lbl_Telefone: TLabel;
    lbl_PesoText: TLabel;
    lbl_Codigo: TLabel;
    lbl_UltimaVisita: TLabel;
    lbl_QntCaixaText: TLabel;
    lbl_CpfCnpj: TLabel;
    lbl_NomeRazao: TLabel;
    lbl_NomeFantasia: TLabel;
    Layout5: TLayout;
    Image3: TImage;
    Rectangle8: TRectangle;
    Label6: TLabel;
    Image4: TImage;
    TabItem4: TTabItem;
    Label8: TLabel;
    Button3: TButton;
    ListView2: TListView;
    ShadowEffect4: TShadowEffect;
    img_aberto: TImage;
    img_vencido: TImage;
    lay_ItensTitulo: TLayout;
    Layout8: TLayout;
    Label12: TLabel;
    Rectangle9: TRectangle;
    Image5: TImage;
    strList_TituloCliente: TStringGrid;
    cod_prod: TStringColumn;
    nome_prod: TStringColumn;
    unid_item: TStringColumn;
    qtd_prod: TStringColumn;
    QTD_REAL: TStringColumn;
    PESO: TStringColumn;
    valor_item: TStringColumn;
    valortotal_item: TStringColumn;
    procedure FormCreate(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtPesqChangeTracking(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
    procedure ListView2ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Image5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClientes: TFrmClientes;

implementation

{$R *.fmx}

uses
  G2Mobile.Model.Clientes,
  uFrmUtilFormate,
  G2Mobile.Model.TitulosCliente,
  Form_Mensagem,
  G2Mobile.View.Inicio,
  G2Mobile.View.Main;

procedure TFrmClientes.Button1Click(Sender: TObject);
begin
  FrmMain.MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
end;

procedure TFrmClientes.Button2Click(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TFrmClientes.Button3Click(Sender: TObject);
begin
  TabControl2.TabIndex := 0;
end;

procedure TFrmClientes.edtPesqChangeTracking(Sender: TObject);
begin
  sbList.Text := edtPesq.Text;
end;

procedure TFrmClientes.FormCreate(Sender: TObject);
begin
  img_positivo.Visible := false;
  img_negativo.Visible := false;
  img_aberto.Visible := false;
  img_vencido.Visible := false;

  ListViewSearch(ListView1);
  TabControl1.TabPosition := TTabPosition.None;
  TabControl2.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;
  TModelClientes.new.PopulaListView(ListView1, img_positivo, img_negativo, edtPesq.Text);
end;

procedure TFrmClientes.Image5Click(Sender: TObject);
begin
  lay_ItensTitulo.Visible := false;
end;

procedure TFrmClientes.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  List: TStringList;
  txt : TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('cod_cliente'));
    try
      List := TStringList.Create;

      TModelClientes.new.PopulaCampos(txt.TagString.ToInteger, List);

      lbl_Codigo.Text := FormatFloat('0000', StrToFloat(List[0]));
      lbl_NomeFantasia.Text := List[1];
      lbl_NomeRazao.Text := List[2];
      lbl_CpfCnpj.Text := FormataDoc(List[3]);
      lbl_Telefone.Text := formatelefone(List[4]);
      lbl_UltimaVisita.Text := List[5];
      lbl_Email.Text := List[6];

      lbl_Endereco.Text := List[7];
      lbl_Bairro.Text := List[8];
      lbl_Cidade.Text := List[9];

      lbl_Credito.Text := FormatFloat('R$ #,##0.00', StrToFloat(List[10]));
      lbl_CredDisponivel.Text := FormatFloat('R$ #,##0.00', StrToFloat(List[11]));
      lbl_vlrAberto.Text := FormatFloat('R$ #,##0.00', StrToFloat(List[12]));

      if StrToFloat(List[11]) < 0 then
        lbl_CredDisponivel.TextSettings.FontColor := $FFF60000
      else
        lbl_CredDisponivel.TextSettings.FontColor := $FF0C76C1;

    finally
      FreeAndNil(List);
    end;
    TabControl2.TabIndex := 0;
    TabControl1.TabIndex := 1;

  end
end;

procedure TFrmClientes.ListView2ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  List: TStringList;
  txt : TListItemText;
begin
  with AItem do
  begin
    lay_ItensTitulo.Visible := true;
    txt := TListItemText(Objects.FindDrawable('codped'));
    ClearStringGrid(strList_TituloCliente);
    TModelTitulosCliente.new.CodPedcar(txt.TagString.ToInteger).PopulaItemTituloStringGrid(strList_TituloCliente);

  end
end;

procedure TFrmClientes.Rectangle8Click(Sender: TObject);
begin

  lay_ItensTitulo.Visible := false;
  TModelTitulosCliente.new.CodCliente(lbl_Codigo.Text.ToInteger).PopulaListView(ListView2, img_aberto, img_vencido);
  if ListView2.Items.Count = 0 then
  begin
    Exibir_Mensagem('SUCESSO', 'ALERTA', 'Parabéns!', 'Cliente não possui titulos abertos!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;
  TabControl2.TabIndex := 1;
end;

end.
