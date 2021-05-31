unit undmsrv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Win.Registry,
  System.IOUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.SvcMgr, Vcl.Dialogs, uConsts, inifiles;

type
  TRestDWsrv = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
  end;

var
  RestDWsrv: TRestDWsrv;

implementation

uses
  uDmService;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ Tdmsrv }

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  RestDWsrv.Controller(CtrlCode);
end;

function TRestDWsrv.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TRestDWsrv.ServiceAfterInstall(Sender: TService);
// Var
// Reg : TRegistry;
Begin
  { Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
    Try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    If Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, false) Then
    Begin
    Reg.WriteString('Description', 'RestDataware Server Service Application.');
    Reg.CloseKey;
    End;
    Finally
    Reg.Free;
    End; }
end;

procedure TRestDWsrv.ServiceCreate(Sender: TObject);
var
  ArqIni: TIniFile;
  LDirIni: string;
  LPort: Integer;
begin
  try
    try
      LDirIni := CPathIniFile;
      ArqIni := TIniFile.Create(CPathIniFile + '\cfg.ini');
      LPort := ArqIni.ReadInteger('Dados', 'Porta', 0);
      RESTServicePooler.ServerMethodClass := TServerMethodDM;
      RESTServicePooler.ServerParams.UserName := vUsername;
      RESTServicePooler.ServerParams.Password := vPassword;
      RESTServicePooler.ServicePort := LPort;
      RESTServicePooler.SSLPrivateKeyFile := SSLPrivateKeyFile;
      RESTServicePooler.SSLPrivateKeyPassword := SSLPrivateKeyPassword;
      RESTServicePooler.SSLCertFile := SSLCertFile;
      RESTServicePooler.Active := True;
{$IFDEF DEBUG}
      WriteLn('Conectado na porta: ' + LPort.ToString);
{$ENDIF}
    except
{$IFDEF DEBUG}
      on e: exception do
        WriteLn('Erro:' + inttostr(LPort) + #13 + 'Ocorreu o seguinte erro: ' +
          e.message);
{$ENDIF}
    end;
  finally
    ArqIni.Free;
  end;

end;

end.
