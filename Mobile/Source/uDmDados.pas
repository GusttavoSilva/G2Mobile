unit uDmDados;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDWConstsData, uRESTDWPoolerDB,
  uRESTDWBase, uDWAbout, uDWConsts, uRESTDWServerEvents,
  uDWJSONObject, IPPeerClient, REST.Client, REST.Authenticator.Basic,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Response.Adapter,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.DApt, FireDAC.Stan.StorageBin, System.DateUtils, FireDAC.Phys.SQLiteVDataSet, System.ImageList, FMX.ImgList;

type
  TSinc = (tP, tC, tF, tU, tV, tVI);

type
  TDmDados = class(TDataModule)
    memProdutoInfo: TFDMemTable;
    memProdutoInfocod_prod: TIntegerField;
    memProdutoInfodesc_rel: TStringField;
    memProdutoInfoclassific_fiscal: TStringField;
    memProdutoInfoncm: TStringField;
    memProdutoInfocest: TStringField;
    memProdutoInfosexo: TStringField;
    memProdutoInfovalor_prod: TFloatField;
    memProdutoInfovalidade: TIntegerField;
    memProdutoInfodesc_fat: TStringField;
    memProdutoInfogrupo_com: TIntegerField;
    memProdutoInfoicms: TFloatField;
    memProdutoInfopis_cofins: TIntegerField;
    memProdutoInfounid_med: TStringField;
    memProdutoInfoaliq_pis: TFloatField;
    memProdutoInfocst_pis: TStringField;
    memProdutoInfoaliq_cofins: TFloatField;
    memProdutoInfocst_cofins: TStringField;
    memProdutoInfocst_ext: TStringField;
    memProdutoInfotara_emb_pri: TFloatField;
    memProdutoInfotara_emp_sec: TFloatField;
    memVendasProd: TFDMemTable;
    memVendasProdcod_nota: TIntegerField;
    memVendasProdcod_prod: TIntegerField;
    memVendasProddescricao: TStringField;
    memVendasProdncm: TStringField;
    memVendasProdquant: TFloatField;
    memVendasProdvalor_unitario: TFloatField;
    memVendasProdvalor_total: TFloatField;
    memVendasProddata_emissao: TSQLTimeStampField;
    memVendas: TFDMemTable;
    memVendascod_nota: TIntegerField;
    memVendaspedido: TStringField;
    memVendasnfeaprovada: TStringField;
    memVendasforma_pgto: TIntegerField;
    memVendasvr_total_nota: TFloatField;
    memVendasdata_emissao: TSQLTimeStampField;
    memFichaFinanceira: TFDMemTable;
    memFichaFinanceiranum_ped: TIntegerField;
    memFichaFinanceiradata_venc: TSQLTimeStampField;
    memFichaFinanceiranum_parc: TIntegerField;
    memFichaFinanceiraparcela: TIntegerField;
    memFichaFinanceirastatus: TStringField;
    memFichaFinanceiradata_emis: TSQLTimeStampField;
    memFichaFinanceiravlr_tit: TFloatField;
    memNfeInfo: TFDMemTable;
    memNfeInfodescricao: TStringField;
    memNfeInfoquant: TFloatField;
    memNfeInfovalor_unitario: TFloatField;
    memNfeInfodata_emissao: TSQLTimeStampField;
    memNfeInfocod_nota: TIntegerField;
    memNfeInfovalor_total: TFloatField;
    memNfeInfoncm: TStringField;
    memNfeInfocfop: TStringField;
    memNfeInfovalor_icms: TFloatField;
    memNfeInfovalor_ipi: TFloatField;
    memVendascod_pessoa: TIntegerField;
    memClienteSincold: TFDMemTable;
    memClienteSincoldcod_pessoa: TIntegerField;
    memClienteSincoldnome_razao: TStringField;
    memClienteSincoldnome_fant: TStringField;
    memClienteSincoldendereco: TStringField;
    memClienteSincoldbairro: TStringField;
    memClienteSincoldtelefone: TStringField;
    memClienteSincoldcpf_cnpj: TStringField;
    memResumo: TFDMemTable;
    memResumodsc_anm: TStringField;
    memResumotot_qtd: TIntegerField;
    memResumotot_kgs: TFloatField;
    memResumotot_arb: TFloatField;
    memResumomed_arb: TFloatField;
    memResumocls_pes: TStringField;
    memProdutoB: TFDMemTable;
    IntegerField3: TIntegerField;
    StringField7: TStringField;
    FloatField1: TFloatField;
    StringField8: TStringField;
    memClienteSincoldemail: TStringField;
    memClienteSincoldcod_vend: TIntegerField;
    memClienteSincoldcredito: TIntegerField;
    memClienteSincoldatraso: TIntegerField;
    memClienteSincoldcod_doc: TIntegerField;
    memPedFinalizado: TFDMemTable;
    memPedFinalizadocod_pedcar_mobile: TIntegerField;
    memPedFinalizadostatus: TIntegerField;
    memPedFinalizadovalor_final: TFloatField;
    memVendasCP: TFDMemTable;
    memVendasCPcontroleinterno: TIntegerField;
    memVendasCPvendedor: TStringField;
    memVendasCPtotal: TFMTBCDField;
    memVendasCPnome_fant: TStringField;
    memVendasCPcod_vendedor: TIntegerField;
    memVendasCPemissao: TWideStringField;
    memClienteSincoldmunicipio: TStringField;
    memClienteSincolddt_visitar: TDateField;
    memPedFinalizadochave: TStringField;
    memPedFinalizadocod_pedcar: TStringField;
    memItemFinalizadoPed: TFDMemTable;
    StringField9: TStringField;
    memItemFinalizadoPedtotal: TFloatField;
    memItemFinalizadoPedcod_prod: TIntegerField;
    memPedFinalizadomotivo: TStringField;
    memProdutoInfovalor_min: TFloatField;
    memProdutoInfodesc_ind: TStringField;
    memProdutoInfopeso_padrao: TFloatField;
    memFichaFinanceirastatus1: TStringField;
    memClienteSincoldcrd_permitido: TFloatField;
    memClienteSincoldVlr_Pagar: TFloatField;
    memClienteSincoldcdr_disponivel: TFloatField;
    memClienteInf: TFDMemTable;
    IntegerField9: TIntegerField;
    StringField19: TStringField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    StringField25: TStringField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    IntegerField13: TIntegerField;
    IntegerField14: TIntegerField;
    StringField26: TStringField;
    StringField27: TStringField;
    DateField2: TDateField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    memClienteSincoldcomissao: TIntegerField;
    ConexaoInterna: TFDConnection;
    qryAux: TFDQuery;
    RESTDWDataBase1: TRESTDWDataBase;
    RESTClientPooler1: TRESTClientPooler;
    rdwSQL: TRESTDWClientSQL;
    ImportFoto: TFDMemTable;
    ImportFotoid: TIntegerField;
    ImportFotocod_prod: TIntegerField;
    ImportFotofoto: TBlobField;
    ImportFotonome_arq: TStringField;
    FDLocalSQL1: TFDLocalSQL;
    QImport: TFDQuery;
    FDTransaction1: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

//    procedure getfotos;

  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses System.IOUtils, uFrmMain, uFrmProdutos, System.IniFiles, FMX.Dialogs, uFrmUtilFormate, uDataBase;

procedure TDmDados.DataModuleCreate(Sender: TObject);
var
  LDataBasePath, ip, porta: string;
  ArquivoINI:               TIniFile;
begin

  ConexaoInterna.Params.Values['DriverID'] := 'SQLite';
  ConexaoInterna.LoginPrompt               := false;
{$IF DEFINED (ANDROID)}
  ConexaoInterna.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'g2mobile.db');
  ConexaoInterna.Params.Add('SharedCache=False');
  ConexaoInterna.Params.Add('LockingMode=Normal');
{$ENDIF}
{$IF DEFINED (MSWINDOWS)}
  ConexaoInterna.Params.Values['Database'] := 'E:\G2Sistemas\G2Mobile\Mobile\BD\g2mobile.db';
{$ENDIF}
  LDataBasePath := ConexaoInterna.Params.Values['Database'];
  if not(FileExists(LDataBasePath)) then
    StrToInt('1');

  ConexaoInterna.Connected := True;


end;


end.
