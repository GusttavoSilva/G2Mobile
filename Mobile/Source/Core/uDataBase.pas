unit uDataBase;

interface

uses
  System.SysUtils,
  System.MaskUtils,
  StrUtils,
  FMX.Edit,
  uRESTDWPoolerDB,
  System.IniFiles,
  uDmDados,
  FireDAC.Comp.Client,
  System.Classes;

function TestarConexao: boolean;
function TestarInternet: boolean;
function CheckInternet(const AHost: string; const APort: integer): boolean;
function VerificaConexao: boolean;
procedure GeraIni;
procedure GravarConfiguracao(IP, Porta: String);
procedure LeArqIni;
function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
procedure GravarUser(cod_user: integer);
procedure conectarservidor;
function Parametros(parametro: String): Variant;
function testarnet: boolean;

var
  IpSrv, PortaSrv: String;
  ArquivoINI: TIniFile;
  ultimoUser: integer;

implementation

uses
  IdTCPClient,
  FMX.Dialogs,
  Form_Mensagem,
  uFrmUtilFormate;

procedure GeraIni;
begin
{$IFDEF ANDROID}
  ArquivoINI := TIniFile.Create(GetHomePath + PathDelim + '/ConfiguracaoINI.ini');
{$ELSE}
  ArquivoINI := TIniFile.Create(GetCurrentDir + '\ConfiguracaoINI.ini');
{$ENDIF}
end;

function Parametros(parametro: String): Variant;
const
  _SQLParametro = 'select * from parametros';
var
  Queryparam: TFDQuery;
begin
  Queryparam := TFDQuery.Create(nil);
  Queryparam.Connection := DmDados.ConexaoInterna;

  Queryparam.Active := False;
  Queryparam.SQL.Clear;
  Queryparam.SQL.Add(_SQLParametro);
  Queryparam.Active := True;
  result := Queryparam.FieldByName(parametro).AsVariant;
end;

procedure GravarConfiguracao(IP, Porta: String);
var
  LTryStrToInt: integer;
begin

  if (IP.IsEmpty) or (Porta.IsEmpty) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o IP e a Porta para conexão!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    Abort;
  end;
  if not(TryStrToInt(Porta, LTryStrToInt)) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Porta com valor inválido!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    Abort;
  end;
  try
    GeraIni;
    ArquivoINI.WriteString('Servidor', 'ip', IP);
    ArquivoINI.WriteString('Servidor', 'porta', Porta);
  finally
    ArquivoINI.Free;
  end;
  LeArqIni;
end;

procedure GravarUser(cod_user: integer);
begin
  try
    GeraIni;
    ArquivoINI.WriteInteger('UltimoUsuario', 'cod_usuario', codUser);
  finally
    ArquivoINI.Free;
  end;
  LeArqIni;
end;

procedure conectarservidor;
begin
  LeArqIni;
  if (IpSrv.IsEmpty) and (PortaSrv.IsEmpty) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Por favor Informar o IP e a Porta para acesso ao servidor!', 'OK', '',
      $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    Abort;
  end
  else
  begin
    DmDados.RESTDWDataBase1.PoolerService := IpSrv;
    DmDados.RESTClientPooler1.Host := IpSrv;
    DmDados.RESTDWDataBase1.PoolerPort := PortaSrv.ToInteger;
    DmDados.RESTClientPooler1.Port := PortaSrv.ToInteger;
  end;
end;

procedure LeArqIni;
begin
  try
    GeraIni;
    IpSrv := ArquivoINI.ReadString('Servidor', 'ip', '');
    PortaSrv := ArquivoINI.ReadString('Servidor', 'porta', '');
    ultimoUser := ArquivoINI.ReadInteger('UltimoUsuario', 'cod_usuario', 0);
  finally
    ArquivoINI.Free;
  end;
end;

function VerificaConexao: boolean;
begin
  conectarservidor;
  TestarInternet;
  TestarConexao;
  if (TestarInternet) and (TestarConexao) then
    result := True;

end;

function TestarConexao: boolean;
begin
  if not(CheckInternet(IpSrv, StrToInt(PortaSrv))) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', ' Sem conexão com o servidor: ' + #13 + ' IP: ' + IpSrv + #13 + ' Porta: '
      + PortaSrv + '!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    Abort;
  end
  else
    result := True;
end;

function TestarInternet: boolean;
begin
  LeArqIni;
  if not(CheckInternet('www.google.com', 80)) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Sem conexão com a Internet!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    Abort;
  end
  else
    result := True;
end;

function CheckInternet(const AHost: string; const APort: integer): boolean;
var
  IdTCPClient: TIdTCPClient;
begin
  result := False;
  try
    try
      IdTCPClient := TIdTCPClient.Create();
      IdTCPClient.ReadTimeout := 2000;
      IdTCPClient.ConnectTimeout := 2000;
      IdTCPClient.Port := APort;
      IdTCPClient.Host := AHost;
      IdTCPClient.connect;
      IdTCPClient.Disconnect;
      result := True;
    Except
      on E: Exception do
      begin
        result := False;
      end;
    end;
  finally
    IdTCPClient.DisposeOf;
  end;
end;

function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
begin
  if Expressao then
    result := ParteTRUE
  else
    result := ParteFALSE;
end;

function testarnet: boolean;
begin
  LeArqIni;
  if CheckInternet('www.google.com', 80) then
    result := True;
end;

end.
