unit uDmDados;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uDWConstsData,
  uRESTDWPoolerDB,
  uRESTDWBase,
  uDWAbout,
  uDWConsts,
  uRESTDWServerEvents,
  uDWJSONObject,
  IPPeerClient,
  REST.Client,
  REST.Authenticator.Basic,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Response.Adapter,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.DApt,
  FireDAC.Stan.StorageBin,
  System.DateUtils,
  FireDAC.Phys.SQLiteVDataSet,
  System.ImageList,
  FMX.ImgList;

type
  TSinc = (tP, tC, tF, tU, tV, tVI);

type
  TDmDados = class(TDataModule)
    ConexaoInterna: TFDConnection;
    RESTDWDataBase1: TRESTDWDataBase;
    RESTClientPooler1: TRESTClientPooler;
    FDTransaction1: TFDTransaction;
    rdwSQL: TRESTDWClientSQL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    // procedure getfotos;

  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  System.IOUtils,
  uFrmProdutos,
  System.IniFiles,
  FMX.Dialogs,
  uFrmUtilFormate,
  uDataBase;

procedure TDmDados.DataModuleCreate(Sender: TObject);
var
  LDataBasePath, ip, porta: string;
  ArquivoINI              : TIniFile;
begin

  ConexaoInterna.Params.Values['DriverID'] := 'SQLite';
  ConexaoInterna.LoginPrompt := false;
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
