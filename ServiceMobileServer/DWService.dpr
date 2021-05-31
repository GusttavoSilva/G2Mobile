program DWService;

{$ifdef DEBUG}
//Para o Release nao abrir terminal, basta descomentar esse IFDEF
{$APPTYPE CONSOLE}
{$endif}

uses
  Vcl.SvcMgr,
  System.SysUtils,
  uRESTDWBase,
  uConsts in 'uConsts.pas',
  uDmService in 'uDmService.pas' {ServerMethodDM: TServerMethodDataModule} ,
  undmsrv in 'undmsrv.pas' {RestDWsrv: TDataModule};

{$R *.RES}

Begin

  begin
{$ifdef DEBUG}
    // In debug mode the server acts as a console application.
    Try
      WriteLn('G2 SERVIDOR MOBILE 07/2019 : Modo de DEBUG. Press enter para Sair.');
      // Create the TService descendant manually.
      If Not Application.DelayInitialize Or Application.Installing Then
        Application.Initialize;
    Finally
    End;

    try
      Application.CreateForm(TRestDWsrv, RestDWsrv);
      Application.Run;
      ReadLn;
    Except
      On E: Exception Do
      Begin
        WriteLn(E.ClassName, ': ', E.Message);
        WriteLn('Press enter para Sair.');
        ReadLn;
      End;
    End;
{$ELSE}
    // Run as a true windows service (release).
    If Not Application.DelayInitialize Or Application.Installing Then
      Application.Initialize;
    Application.CreateForm(TRestDWsrv, RestDWsrv);
    Application.Run;
{$ENDIF}
  end;

End.
