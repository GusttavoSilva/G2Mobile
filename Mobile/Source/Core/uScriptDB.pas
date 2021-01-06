unit uScriptDB;

interface

uses
  System.SysUtils, System.MaskUtils, StrUtils, FMX.Edit, FMX.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt, System.IOUtils;

function fncDBExisteDatabase(_databaseName, caminho: string): boolean;
function fncDBCriarDatabase(_databaseName, caminho: string): boolean;

function fncUpCampos(var _fdConnection: TFDConnection): string;

procedure tab_camara_fria(var _fdConnection: TFDConnection);
procedure tab_cliente(var _fdConnection: TFDConnection);
procedure tab_cliente_precad(var _fdConnection: TFDConnection);
procedure tab_formapagto(var _fdConnection: TFDConnection);
procedure tab_meses(var _fdConnection: TFDConnection);
procedure tab_parametros(var _fdConnection: TFDConnection);

procedure tab_receber(var _fdConnection: TFDConnection);
procedure tab_produto_foto(var _fdConnection: TFDConnection);
procedure tab_Tabelas(var _fdConnection: TFDConnection);
procedure tab_produto(var _fdConnection: TFDConnection);
procedure tab_pessoa_fpgto(var _fdConnection: TFDConnection);
procedure tab_venditem(var _fdConnection: TFDConnection);
procedure tab_usuarios(var _fdConnection: TFDConnection);
procedure tab_venda(var _fdConnection: TFDConnection);

var
  dbCon: TFDConnection;

implementation

function fncDBExisteDatabase(_databaseName, caminho: string): boolean;
var
  _databasePath: string;
begin
{$IF DEFINED (ANDROID)}
  _databasePath := TPath.Combine(TPath.GetDocumentsPath, _databaseName + '.db');
{$ENDIF}
{$IF DEFINED (MSWINDOWS)}
  _databasePath := caminho + _databaseName + '.db';
{$ENDIF}
  if (not FileExists(_databasePath)) then
    fncDBCriarDatabase(_databaseName, caminho);

end;

function fncDBCriarDatabase(_databaseName, caminho: string): boolean;
var
  _databasePath: string;
  _erroStr:      string;
begin

{$IF DEFINED (ANDROID)}
  _databasePath := TPath.Combine(TPath.GetDocumentsPath, _databaseName + '.db');
{$ENDIF}
{$IF DEFINED (MSWINDOWS)}
  _databasePath := caminho + _databaseName + '.db';
{$ENDIF}
  dbCon := TFDConnection.Create(Application);
  try
    try
      dbCon.Params.DriverID := 'SQLite';
      dbCon.Params.Database := _databasePath;
      dbCon.Open();
      Result := true;
    Except
      on e: Exception do
      begin
        _erroStr := e.Message;
        Result   := false;
      end;
    end;
  finally
    if dbCon.Connected then
      dbCon.Connected := false;
    dbCon.DisposeOf;

  end;
end;

function fncUpCampos(var _fdConnection: TFDConnection): string;
begin

  tab_camara_fria(_fdConnection);
  tab_cliente(_fdConnection);
  tab_cliente_precad(_fdConnection);
  tab_formapagto(_fdConnection);
  tab_meses(_fdConnection);
  tab_parametros(_fdConnection);

  tab_pessoa_fpgto(_fdConnection);

  tab_receber(_fdConnection);
  tab_produto_foto(_fdConnection);

  tab_Tabelas(_fdConnection);
  tab_produto(_fdConnection);

  tab_usuarios(_fdConnection);

  tab_venda(_fdConnection);
  tab_venditem(_fdConnection);

end;

procedure tab_camara_fria(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;

    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS camara_fria ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM camara_fria;');

    _table.ExecSQL(' DROP TABLE camara_fria; ');

    _table.ExecSQL('CREATE TABLE camara_fria ( ' + ' cod_camara INTEGER, ' + '  descricao  VARCHAR (30) ) ');

    _table.ExecSQL(' INSERT INTO camara_fria ( ' + ' cod_camara, ' + ' descricao ' + ' ) ' + ' SELECT ' + 'cod_camara, ' + ' descricao ' +
      ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_cliente(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    try
      _table := TFDQuery.Create(nil);

      _table.Connection := _fdConnection;
      _table.SQL.Clear;
      _table.Close;

      _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

      _table.ExecSQL(' CREATE TABLE IF NOT EXISTS cliente ( ID NUMERIC(9) ); ');

      _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

      _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM cliente;');

      _table.ExecSQL(' DROP TABLE cliente; ');

      _table.ExecSQL(' CREATE TABLE cliente ( ' +

      ' cod_pessoa     INTEGER       NOT NULL, '+
      ' nome_razao     VARCHAR (80), '+
      ' nome_fant      VARCHAR (80), '+
      ' endereco       VARCHAR (100), '+
      ' bairro         VARCHAR (30), '+
      ' municipio      VARCHAR (100), '+
      ' telefone       VARCHAR (15), '+
      ' cpf_cnpj       VARCHAR (14), '+
      ' email          VARCHAR (120), '+
      ' cod_vend       INTEGER, '+
      ' credito        DOUBLE, '+
      ' atraso         INTEGER, '+
      ' cod_doc        INTEGER, '+
      ' dt_visitar     DATE, '+
      ' crd_permitido  DOUBLE, '+
      ' Vlr_Pagar      DOUBLE, '+
      ' cdr_disponivel DOUBLE, '+
      ' comissao       INTEGER '+
      ' ); '

        );

      _table.ExecSQL(' INSERT INTO cliente ( ' +

        ' cod_pessoa, ' + ' nome_razao, ' + ' nome_fant, ' + ' endereco, ' + ' bairro, ' + ' municipio, ' + ' telefone, ' + ' cpf_cnpj, ' +
        ' email, ' + ' cod_vend, ' + ' credito, ' + ' atraso, ' + ' cod_doc, ' + ' dt_visitar, ' + ' crd_permitido, ' + ' Vlr_Pagar, ' +
        ' cdr_disponivel, ' + ' comissao ' + ' ) ' + ' SELECT cod_pessoa, ' + ' nome_razao, ' + ' nome_fant, ' + ' endereco, ' + ' bairro, '
        + ' municipio, ' + ' telefone, ' + ' cpf_cnpj, ' + ' email, ' + ' cod_vend, ' + ' credito, ' + ' atraso, ' + ' cod_doc, ' +
        ' dt_visitar, ' + ' crd_permitido, ' + ' Vlr_Pagar, ' + ' cdr_disponivel, ' + ' comissao ' + ' FROM sqlitestudio_temp_table; '

        );

      _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

      _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

    finally
      FreeAndNil(_table);
    end;
  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_cliente_precad(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS cliente_precad ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM cliente_precad;');

    _table.ExecSQL(' DROP TABLE cliente_precad; ');

    _table.ExecSQL(' CREATE TABLE cliente_precad ( ' + ' codigo         INTEGER       PRIMARY KEY AUTOINCREMENT NOT NULL, ' +
      ' cpfcnpj        VARCHAR (18)  NOT NULL UNIQUE, ' + ' nome           VARCHAR (250) NOT NULL, ' +
      ' endereco       VARCHAR (250) NOT NULL, ' + ' bairro         VARCHAR (200) NOT NULL, ' + ' cidade         VARCHAR (200) NOT NULL, ' +
      ' estado         VARCHAR (2)   NOT NULL, ' + ' cep            VARCHAR (10), ' + ' telefone       VARCHAR (11)  NOT NULL, ' +
      ' contato        VARCHAR (250), ' + ' celular        VARCHAR (11)  NOT NULL, ' + ' email          VARCHAR (200), ' +
      ' latitude       VARCHAR (50), ' + ' cod_vendedor   INT           NOT NULL, ' + ' longitude      VARCHAR (50), ' +
      ' status         VARCHAR (1), ' + ' formapagamento INTEGER, ' + ' limitecred     DOUBLE, ' + ' foto           BLOB, ' +
      ' aniversario    DATETIME ' + ' ); ');

    _table.ExecSQL(' INSERT INTO cliente_precad ( ' + ' codigo, ' + ' cpfcnpj, ' + ' nome, ' + ' endereco, ' + ' bairro, ' + ' cidade, ' +
      ' estado, ' + ' cep, ' + ' telefone, ' + ' contato, ' + ' celular, ' + ' email, ' + ' latitude, ' + ' cod_vendedor, ' + ' longitude, '
      + ' status, ' + ' formapagamento, ' + ' limitecred, ' + ' foto, ' + ' aniversario ' + ' ) ' + ' SELECT codigo, ' + ' cpfcnpj, ' +
      ' nome, ' + ' endereco, ' + ' bairro, ' + ' cidade, ' + ' estado, ' + ' cep, ' + ' telefone, ' + ' contato, ' + ' celular, ' +
      ' email, ' + ' latitude, ' + ' cod_vendedor, ' + ' longitude, ' + ' status, ' + ' formapagamento, ' + ' limitecred, ' + ' foto, ' +
      ' aniversario ' + ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_formapagto(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.Close;

    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS formapagto ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM formapagto;');

    _table.ExecSQL(' DROP TABLE formapagto; ');

    _table.ExecSQL(' CREATE TABLE formapagto ( ' + ' cod_doc  INTEGER         NOT NULL, ' + ' descricao VARCHAR (30)    NOT NULL, ' +
      ' cod_forma INTEGER ); ');

    _table.ExecSQL(' INSERT INTO formapagto ( ' + ' cod_doc, ' + ' descricao, ' + ' cod_forma ) ' + ' SELECT cod_doc, ' + ' descricao, ' +
      ' cod_forma FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_meses(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS meses ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM meses;');

    _table.ExecSQL('  DROP TABLE if exists meses; ');

    _table.ExecSQL(' CREATE TABLE meses ( ' + ' id_mes   INTEGER       PRIMARY KEY AUTOINCREMENT UNIQUE ' + ' NOT NULL, ' +
      ' descricao VARCHAR (255) NOT NULL ' + ' ); ');

    _table.ExecSQL(' INSERT INTO meses ( ' + ' id_mes, ' + ' descricao ' + ' ) ' + ' SELECT id_mes, ' + ' descricao ' +
      ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_parametros(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS parametros ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM parametros;');

    _table.ExecSQL(' DROP TABLE parametros; ');

    _table.ExecSQL(' CREATE TABLE parametros ( ' + ' bloq_clientes  INTEGER, ' + ' doc_avista     INTEGER, ' + ' reg_descto     INTEGER, ' +
      ' logo           BLOB, ' + ' id_tablet     INTEGER, ' + ' bloq_vlr_min     INTEGER, ' + ' dt_sinc        DATETIME ' + ' ); ');

    _table.ExecSQL(' INSERT INTO parametros ( ' + ' bloq_vlr_min, ' + ' bloq_clientes, ' + ' doc_avista, ' + ' reg_descto, ' + ' logo, ' +
      ' dt_sinc ' + ' )' +

      ' SELECT bloq_vlr_min, ' + ' bloq_clientes, ' + ' doc_avista, ' + ' reg_descto, ' + ' logo, ' + ' dt_sinc ' +
      ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_pessoa_fpgto(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS pessoa_fpgto ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM pessoa_fpgto;');

    _table.ExecSQL(' DROP TABLE pessoa_fpgto; ');

    _table.ExecSQL(' CREATE TABLE pessoa_fpgto ( ' + ' cod_pessoa INTEGER, ' + ' cod_forma   INTEGER ' + ' ); ');

    _table.ExecSQL(' INSERT INTO pessoa_fpgto ( ' + ' cod_pessoa, ' + ' cod_forma ' + ' ) ' + ' SELECT cod_pessoa, ' + ' cod_forma ' +
      ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');
  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_produto(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS produto ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM produto;');

    _table.ExecSQL(' DROP TABLE produto; ');

    _table.ExecSQL(' CREATE TABLE produto ( ' + ' cod_prod    INTEGER         NOT NULL, ' + ' desc_ind    VARCHAR (80)    NOT NULL, ' +
      ' unid_med    VARCHAR (10), ' + ' valor_min   NUMERIC (10, 2), ' + ' valor_prod  NUMERIC (10, 2), ' + ' grupo_com   VARCHAR (100), ' +
      ' validade    INTEGER, ' + ' tipo_calc   INTEGER, ' + ' quant_cx    REAL (10, 2), ' + ' peso_padrao REAL (10, 3) ' + ' ); ');

    _table.ExecSQL(' INSERT INTO produto ( ' +

      ' cod_prod, ' + ' desc_ind, ' + ' unid_med, ' + ' valor_min, ' + ' valor_prod, ' + ' grupo_com, ' + ' validade, ' + ' tipo_calc, ' +
      ' quant_cx, ' + ' peso_padrao ' + ' ) ' + ' SELECT cod_prod, ' + ' desc_ind, ' + ' unid_med, ' + ' valor_min, ' + ' valor_prod, ' +
      ' grupo_com, ' + ' validade, ' + ' tipo_calc, ' + ' quant_cx, ' + ' peso_padrao ' + ' FROM sqlitestudio_temp_table; '

      );

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_produto_foto(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS produto_foto ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM produto_foto;');

    _table.ExecSQL(' DROP TABLE produto_foto; ');

    _table.ExecSQL(' CREATE TABLE produto_foto ( ' + ' id      INTEGER PRIMARY KEY, ' + ' cod_prod INTEGER, ' + ' foto     BLOB, ' +
      ' nome_arq STRING ' + ' ); ');

    _table.ExecSQL(' INSERT INTO produto_foto ( ' + ' id, ' + ' cod_prod, ' + ' foto, ' + ' nome_arq ' + ' ) ' + ' SELECT id, ' +
      ' cod_prod, ' + ' foto, ' + ' nome_arq ' + ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_receber(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS receber ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM receber;');

    _table.ExecSQL(' DROP TABLE receber; ');

    _table.ExecSQL(' CREATE TABLE receber ( ' + ' cpf_cnpj      VARCHAR (14)  PRIMARY KEY ' + ' NOT NULL, ' +
      ' documento     VARCHAR (15)  NOT NULL, ' + ' tipodocumento VARCHAR (20)  NOT NULL, ' + ' saldo         REAL (10, 2), ' +
      ' emissao       DATE, ' + ' vencimento    DATE, ' + ' observacao    VARCHAR (200), ' + ' vendedor      INTEGER ' + ' ); ');

    _table.ExecSQL(' INSERT INTO receber ( ' + ' cpf_cnpj, ' + ' documento, ' + ' tipodocumento, ' + ' saldo, ' + ' emissao, ' +
      ' vencimento, ' + ' observacao, ' + ' vendedor ' + ' ) ' + ' SELECT cpf_cnpj, ' + ' documento, ' + ' tipodocumento, ' + ' saldo, ' +
      ' emissao, ' + ' vencimento, ' + ' observacao, ' + ' vendedor ' + ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');
  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_Tabelas(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS Tabelas ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM Tabelas;');

    _table.ExecSQL(' DROP TABLE Tabelas; ');

    _table.ExecSQL(' CREATE TABLE Tabelas ( ' + ' Id            INTEGER         PRIMARY KEY AUTOINCREMENT ' + ' UNIQUE ' + ' NOT NULL, ' +
      ' Cod_Vendedor  INTEGER, ' + ' Cod_Tabela    INTEGER, ' + ' pcMin         NUMERIC (10, 2), ' + ' pcMax         NUMERIC (10, 2), ' +
      ' Cod_Produto   INTEGER, ' + ' descricao     VARCHAR (255), ' + ' dt_ativacao   DATETIME, ' + ' dt_vencimento DATETIME ' + ' ); ');

    _table.ExecSQL(' INSERT INTO Tabelas ( ' + ' Id, ' + ' Cod_Vendedor, ' + ' Cod_Tabela, ' + ' pcMin, ' + ' pcMax, ' + ' Cod_Produto, ' +
      ' descricao, ' + ' dt_ativacao, ' + ' dt_vencimento ' + ' ) ' + ' SELECT Id, ' + ' Cod_Vendedor, ' + ' Cod_Tabela, ' + ' pcMin, ' +
      ' pcMax, ' + ' Cod_Produto, ' + ' descricao, ' + ' dt_ativacao, ' + ' dt_vencimento ' + ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_usuarios(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS usuarios ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM usuarios;');

    _table.ExecSQL(' DROP TABLE usuarios; ');

    _table.ExecSQL(' CREATE TABLE usuarios ( ' + ' cod_user     INTEGER      PRIMARY KEY ' + ' NOT NULL, ' +
      ' usuario      VARCHAR (20) NOT NULL, ' + ' nome         VARCHAR (80) NOT NULL, ' + ' senha        VARCHAR (20) NOT NULL, ' +
      ' cod_vendedor INTEGER      NOT NULL, ' + ' super        INTEGER, ' + ' cod_camara   INTEGER ' + ' ); ');

    _table.ExecSQL(' INSERT INTO usuarios ( ' + ' cod_user, ' + ' usuario, ' + ' nome, ' + ' senha, ' + ' cod_vendedor, ' + ' super, ' +
      ' cod_camara ' + ' ) ' + ' SELECT cod_user, ' + ' usuario, ' + ' nome, ' + ' senha, ' + ' cod_vendedor, ' + ' super, ' +
      ' cod_camara ' + ' FROM sqlitestudio_temp_table; ');

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_venda(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS venda ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM venda;');

    _table.ExecSQL(' DROP TABLE venda; ');

    _table.ExecSQL(' CREATE TABLE venda ( ' + ' chave            VARCHAR (250), ' + ' formapagto       INTEGER         NOT NULL, ' +
      ' cod_camara       INTEGER, ' + ' cod_user         INTEGER         NOT NULL, ' + ' cod_vendedor     INTEGER         NOT NULL, ' +
      ' cod_cliente      INTEGER         NOT NULL, ' + ' emissao          DATETIME, ' + ' data_emb         DATETIME, ' +
      ' valor            NUMERIC (10, 2), ' + ' desconto         NUMERIC (10, 2), ' + ' total            NUMERIC (10, 2), ' +
      ' valorfaturamento REAL (10, 2), ' + ' situacao         VARCHAR (15)    DEFAULT (0), ' + ' sincronizado     INTEGER (1), ' +
      ' comissao         INTEGER, ' + ' latitude         VARCHAR (50), ' + ' longitude        VARCHAR (50), ' +
      ' cod_ret          INTEGER, ' + ' Obs              VARCHAR (255), ' + ' motivo_cancel    STRING (255) ' + ' ); ');

    _table.ExecSQL(' INSERT INTO venda (' + ' chave, ' + ' formapagto, ' + ' cod_camara, ' + ' cod_user, ' + ' cod_vendedor, ' +
      ' cod_cliente, ' + ' emissao, ' + ' data_emb, ' + ' valor, ' + ' desconto, ' + ' total, ' + ' valorfaturamento, ' + ' situacao, ' +
      ' sincronizado, ' + ' comissao, ' + ' latitude, ' + ' longitude, ' + ' cod_ret, ' + ' Obs, ' + ' motivo_cancel ' + ' ) ' +
      ' SELECT chave, ' + ' formapagto, ' + ' cod_camara, ' + ' cod_user, ' + ' cod_vendedor, ' + ' cod_cliente, ' + ' emissao, ' +
      ' data_emb, ' + ' valor, ' + ' desconto, ' + ' total, ' + ' valorfaturamento, ' + ' situacao, ' + ' sincronizado, ' + ' comissao, ' +
      ' latitude, ' + ' longitude, ' + ' cod_ret, ' + ' Obs, ' + ' motivo_cancel ' + ' FROM sqlitestudio_temp_table; '

      );

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');

  finally
    FreeAndNil(_table);
  end;
end;

procedure tab_venditem(var _fdConnection: TFDConnection);
var
  _table: TFDQuery;
begin
  try
    _table := TFDQuery.Create(nil);

    _table.Connection := _fdConnection;
    _table.SQL.Clear;
    _table.Close;
    _table.ExecSQL(' PRAGMA foreign_keys = 0; ');

    _table.ExecSQL(' CREATE TABLE IF NOT EXISTS venditem ( ID NUMERIC(9) ); ');

    _table.ExecSQL(' drop table if exists sqlitestudio_temp_table; ');

    _table.ExecSQL(' CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM venditem;');

    _table.ExecSQL(' DROP TABLE venditem; ');

    _table.ExecSQL(' CREATE TABLE venditem ( ' +

      ' chave            VARCHAR (250), ' + ' cod_prod         INTEGER         NOT NULL, ' + ' quantidade       NUMERIC (10, 3), ' +
      ' valor            NUMERIC (10, 2), ' + ' desconto         NUMERIC (10, 2), ' + ' total            NUMERIC (10, 2), ' +
      ' unidade          VARCHAR (10), ' + ' pcBruto          NUMERIC (10, 2), ' + ' valorfaturamento REAL (10, 2) ' + ' ); ');

    _table.ExecSQL(' INSERT INTO venditem ( ' +

      ' chave, ' + ' cod_prod, ' + ' quantidade, ' + ' valor, ' + ' desconto, ' + ' total, ' + ' unidade, ' + ' pcBruto, ' +
      ' valorfaturamento ' + ' ) ' + ' SELECT chave, ' + ' cod_prod, ' + ' quantidade, ' + ' valor, ' + ' desconto, ' + ' total, ' +
      ' unidade, ' + ' pcBruto, ' + ' valorfaturamento ' + ' FROM sqlitestudio_temp_table; '

      );

    _table.ExecSQL(' DROP TABLE sqlitestudio_temp_table; ');

    _table.ExecSQL(' PRAGMA foreign_keys = 1; ');
  finally
    FreeAndNil(_table);
  end;
end;

end.
