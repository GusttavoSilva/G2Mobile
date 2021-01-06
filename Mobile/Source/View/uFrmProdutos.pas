unit uFrmProdutos;

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
  FMX.ListView,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Layouts,
  uClasseProdutos,
  FMX.Objects,
  FMX.Effects;

type
  TFrmProdutos = class(TForm)
    LayoutClientPesq: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    Button1: TButton;
    ListView1: TListView;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    lbl_Produto: TLabel;
    Label2: TLabel;
    lbl_unid: TLabel;
    lbl_validade: TLabel;
    Label4: TLabel;
    lbl_QntCaixa: TLabel;
    lbl_QntCaixaText: TLabel;
    lbl_Peso: TLabel;
    lbl_PesoText: TLabel;
    lbl_GrupoComercial: TLabel;
    Label9: TLabel;
    lbl_VlrProd: TLabel;
    Label11: TLabel;
    Layout5: TLayout;
    img_Foto: TImage;
    Label3: TLabel;
    Button2: TButton;
    Rectangle1: TRectangle;
    Label5: TLabel;
    edtPesq: TEdit;
    SearchEditButton1: TSearchEditButton;
    ShadowEffect1: TShadowEffect;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    Rectangle3: TRectangle;
    img_SemFoto: TImage;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Button2Click(Sender: TObject);
    procedure edtPesqChangeTracking(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.fmx}

uses
  uFrmUtilFormate,
  uFrmInicio,
  uFrmMain;

procedure TFrmProdutos.Button1Click(Sender: TObject);
begin
  FrmMain.MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
end;

procedure TFrmProdutos.Button2Click(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TFrmProdutos.edtPesqChangeTracking(Sender: TObject);
begin
  sbList.Text := edtPesq.Text;
end;

procedure TFrmProdutos.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;

  img_SemFoto.Visible := false;
  ListViewSearch(ListView1);
  TProdutos.new.PopulaListView(ListView1, img_SemFoto, edtPesq.Text);
end;

procedure TFrmProdutos.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  List: TStringList;
  txt: TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('cod_prod'));
    try
      List := TStringList.Create;
      TProdutos.new.RetornaFoto(txt.TagString.ToInteger, img_SemFoto, img_Foto);
      TProdutos.new.PopulaCampos(txt.TagString.ToInteger, List);

      lbl_Produto.Text := FormatFloat('0000', StrToFloat(List[0])) + ' - ' + List[1];
      lbl_validade.Text := List[2];
      lbl_GrupoComercial.Text := List[3];
      lbl_unid.Text := List[4];
      lbl_VlrProd.Text := FormatFloat('R$#,##0.00', StrToFloat(List[5]));
      lbl_QntCaixa.Text := List[6];
      lbl_Peso.Text := List[7];

    finally
      FreeAndNil(List);
    end;

    TabControl1.TabIndex := 1;

  end

end;

end.
