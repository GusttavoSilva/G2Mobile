unit uConsts;

interface

uses uRESTDWBase;

Const
  vUsername = 'testserver';
  vPassword = 'testserver';
//  vPort = 8082;
//  servidor = '192.168.1.220';
  EncodedData = True;
  SSLPrivateKeyFile = '';
  SSLPrivateKeyPassword = '';
  SSLCertFile = '';
  database = 'express-teste';
  usuario_BD = 'sa';
  senha_BD = 'Express123';
  CPathIniFile = 'C:\G2 Server RDW';

  {
    SERVIDOR - data base
    MA: SERVER1\SQLEXPRESS - express
    peixe: 192.168.0.215 - peixebom/peixeteste/vereda/veredateste - sa - Expr3ss515@!
    Araguaia: 192.168.1.220 - express - express-teste -  araguaiaal.ddns.net
    Natural: 186.235.86.240
    Servidor alugado: WIN-QV7VO16OEI9\SQLEXPRESS -
  }

Var
  RESTServicePooler: TRESTServicePooler;


implementation

Initialization

RESTServicePooler := TRESTServicePooler.Create(Nil);

Finalization

RESTServicePooler.Active := False;
RESTServicePooler.DisposeOf;

end.
