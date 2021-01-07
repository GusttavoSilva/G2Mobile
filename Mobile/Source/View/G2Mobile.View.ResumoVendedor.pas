unit G2Mobile.View.ResumoVendedor;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects,
  FMX.TabControl,
  FMX.Gestures,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.DateTimeCtrls,
  Datasnap.DBClient,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.DateUtils,
  uDataBase,
  uFrmMain,
  FMX.Ani,
  FMX.Effects,
  Loading,
  G2Mobile.Model.ResumoVendedorItens,
  G2Mobile.Model.ResumoVendedorClientes;

type
  TFrmResumoVend = class(TForm)
    LayoutClientPesq: TLayout;
    TabControl1: TTabControl;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Label8: TLabel;
    Layout7: TLayout;
    Layout8: TLayout;
    edt_DtIniProd: TDateEdit;
    edt_DtFimProd: TDateEdit;
    rct_BuscaProd: TRectangle;
    Label9: TLabel;
    Label10: TLabel;
    ListView1: TListView;
    FDMemTable1: TFDMemTable;
    Label2: TLabel;
    Layout9: TLayout;
    edt_DtIniClient: TDateEdit;
    edt_DtFimClient: TDateEdit;
    rct_BuscaClient: TRectangle;
    Label11: TLabel;
    Label12: TLabel;
    ListView2: TListView;
    lay_button: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    Layout11: TLayout;
    Layout12: TLayout;
    rct_TabClientes: TRectangle;
    rct_TabProd: TRectangle;
    Label14: TLabel;
    Label15: TLabel;
    Image2: TImage;
    Image3: TImage;
    Layout13: TLayout;
    Rectangle5: TRectangle;
    ShadowEffect1: TShadowEffect;
    lbl_qtdPedClient: TLabel;
    lbl_PesoClient: TLabel;
    lbl_VlrTotClient: TLabel;
    ShadowEffect3: TShadowEffect;
    Layout14: TLayout;
    Rectangle7: TRectangle;
    lbl_PesoProd: TLabel;
    lbl_QtdPedProd: TLabel;
    lbl_VlrTotProd: TLabel;
    ShadowEffect2: TShadowEffect;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure rct_BuscaProdClick(Sender: TObject);
    procedure rct_TabClientesClick(Sender: TObject);
    procedure rct_TabProdClick(Sender: TObject);
    procedure rct_BuscaClientClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmResumoVend: TFrmResumoVend;

implementation

{$R *.fmx}

uses
  uFrmUtilFormate,
  G2Mobile.View.Inicio;

procedure TFrmResumoVend.Button3Click(Sender: TObject);
begin
  FrmMain.MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
end;

procedure TFrmResumoVend.FormCreate(Sender: TObject);
var

  ListClient, ListProd: TStringList;
begin
  inherited;

  edt_DtIniClient.Date := StartOfTheMonth(Date);
  edt_DtFimClient.Date := EndOfTheMonth(Date);
  edt_DtIniProd.Date := StartOfTheMonth(Date);
  edt_DtFimProd.Date := EndOfTheMonth(Date);

  TabControl1.TabIndex := 0;

  try
    ListProd := TStringList.Create;

    TModelResumoVendedorItens.new.PopulaListView(ListView1, ListProd);

    lbl_QtdPedProd.Text := ListProd[0];
    lbl_PesoProd.Text := ListProd[1];
    lbl_VlrTotProd.Text := ListProd[2];

  finally
    FreeAndNil(ListProd);
  end;

  try
    ListClient := TStringList.Create;

    TModelResumoVendedorClientes.new.PopulaListView(ListView2, ListClient);

    lbl_qtdPedClient.Text := ListClient[0];
    lbl_PesoClient.Text := ListClient[1];
    lbl_VlrTotClient.Text := ListClient[2];
  finally
    FreeAndNil(ListClient);
  end;
end;

procedure TFrmResumoVend.rct_BuscaClientClick(Sender: TObject);
var
  DataSet   : TFDMemTable;
  ListClient: TStringList;
begin

  TLoading.Show('Consultando...');
  TThread.CreateAnonymousThread(
    procedure
    var
      DataSet: TFDMemTable;
      ListClient: TStringList;
    begin
      if verificaConexao then
      begin
        try
          ListClient := TStringList.Create;
          DataSet := TFDMemTable.Create(nil);

          TModelResumoVendedorClientes.new.LimpaTabelas.BuscaClienteVendidosServidor(edt_DtIniClient.Date,
            edt_DtFimClient.Date, codVend, DataSet).PopulaClienteVendidoSqLite(DataSet).PopulaListView(ListView2,
            ListClient);

          lbl_qtdPedClient.Text := ListClient[0];
          lbl_PesoClient.Text := ListClient[1];
          lbl_VlrTotClient.Text := ListClient[2];
        finally
          FreeAndNil(DataSet);
          FreeAndNil(ListClient);
        end;

      end;

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
        end);

    end).Start;

end;

procedure TFrmResumoVend.rct_BuscaProdClick(Sender: TObject);
var
  DataSet : TFDMemTable;
  ListProd: TStringList;
begin

  TLoading.Show('Consultando...');

  TThread.CreateAnonymousThread(
    procedure
    var
      DataSet: TFDMemTable;
      ListClient: TStringList;
    begin
      if verificaConexao then
      begin
        try
          ListProd := TStringList.Create;
          DataSet := TFDMemTable.Create(nil);

          TModelResumoVendedorItens.new.LimpaTabelas.BuscaProdVendidosServidor(edt_DtIniProd.Date, edt_DtFimProd.Date,
            codVend, DataSet).PopulaProdVendidoSqLite(DataSet).PopulaListView(ListView1, ListProd);

          lbl_QtdPedProd.Text := ListProd[0];
          lbl_PesoProd.Text := ListProd[1];
          lbl_VlrTotProd.Text := ListProd[2];
        finally
          FreeAndNil(DataSet);
          FreeAndNil(ListProd);
        end;

      end;

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
        end);

    end).Start;

end;

procedure TFrmResumoVend.rct_TabClientesClick(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TFrmResumoVend.rct_TabProdClick(Sender: TObject);
begin
  TabControl1.TabIndex := 1;
end;

end.
