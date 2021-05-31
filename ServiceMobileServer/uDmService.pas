UNIT uDmService;

INTERFACE

USES
  System.SysUtils,
  Classes,
  System.IOUtils,
  SysTypes,
  UDWDatamodule,
  System.JSON,
  System.DateUtils,
  UDWJSONObject,
  Dialogs,
  ServerUtils,
  UDWConsts,
  FireDAC.Dapt,
  UDWConstsData,
  FireDAC.Phys.FBDef,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  FireDAC.Stan.StorageJSON,
  URESTDWPoolerDB,
  URestDWDriverFD,
  System.JSON.Readers,
  uConsts,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,
  Vcl.SvcMgr, FireDAC.Stan.Param, System.StrUtils, System.NetEncoding,
  FireDAC.DatS, FireDAC.Dapt.Intf,
  uRESTDWServerEvents, FireDAC.Comp.DataSet, uDWAbout, IniFiles, Vcl.Graphics,
  IdSSLOpenSSLHeaders,
  IdCoder, IdCoderMIME, FireDAC.Phys.PGDef, FireDAC.Phys.ODBCDef,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, uRESTDWServerContext,
  FireDAC.Phys.ODBC, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient,
  FireDAC.Phys.PG;

TYPE
  TServerMethodDM = CLASS(TServerMethodDataModule)
    RESTDWPoolerFD: TRESTDWPoolerDB;
    RESTDWDriverFD1: TRESTDWDriverFD;
    Server_FDConnection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDTransaction1: TFDTransaction;
    DWSETESTE: TDWServerEvents;
    FDQuery1: TFDQuery;
    DWServerEvents2: TDWServerEvents;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    dwcrEmployee: TDWContextRules;
    dwcLogin: TDWContextRules;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    FDPhysODBCDriverLink1: TFDPhysODBCDriverLink;
    FDQuery2: TFDQuery;
    FDQLogin: TFDQuery;
    DWServerContext1: TDWServerContext;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    PROCEDURE Server_FDConnectionBeforeConnect(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  ServerMethodDM: TServerMethodDM;

IMPLEMENTATIOn

uses
  Soap.EncdDecd;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

PROCEDURE TServerMethodDM.Server_FDConnectionBeforeConnect(Sender: TObject);
var
  ArqIni: TIniFile;
  LPort: Integer;
  LServidor: string;
  LUserName: string;
  LDatabase: string;
  LPassword: string;
begin
  ArqIni := TIniFile.Create(CPathIniFile + '\cfg.ini');
  try
    LPort := ArqIni.ReadInteger('Dados', 'Porta', 0);
    LUserName := ArqIni.ReadString('Dados', 'Usuario', '');
    LPassword := ArqIni.ReadString('Dados', 'Senha', '');
    LDatabase := ArqIni.ReadString('Dados', 'Banco', '');
    LServidor := ArqIni.ReadString('Dados', 'Servidor', '');

    TFDConnection(Sender).Params.Clear;
    TFDConnection(Sender).Params.Add('DriverID=MSSQL');
    TFDConnection(Sender).Params.Add('Server=' + LServidor);
    TFDConnection(Sender).Params.Add('Database=' + LDatabase);
    TFDConnection(Sender).Params.Add('User_Name=' + LUserName);
    TFDConnection(Sender).Params.Add('Password=' + LPassword);
    TFDConnection(Sender).DriverName := 'MSSQL';
    TFDConnection(Sender).LoginPrompt := FALSE;
    TFDConnection(Sender).UpdateOptions.CountUpdatedRecords := FALSE;
  finally
    ArqIni.Free;
  end;

END;

END.
