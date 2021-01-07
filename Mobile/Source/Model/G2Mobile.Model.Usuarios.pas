unit G2Mobile.Model.Usuarios;

interface

uses
  FMX.ListView,
  uDmDados,
  uRESTDWPoolerDB,
  System.SysUtils,
  IdSSLOpenSSLHeaders,
  FireDAC.Comp.Client,
  FMX.Dialogs,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.DataSet,
  Data.DB,
  G2Mobile.Controller.Usuarios,
  FMX.Objects,
  Form_Mensagem,
  uFrmUtilFormate;

type

  TModelUsuarios = class(TInterfacedObject, iModelUsuarios)
  private
    FUsuario: String;
    FSenha  : String;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelUsuarios;

    function Usuario(value: String): iModelUsuarios;
    function Senha(value: String): iModelUsuarios;
    function BuscaUserServidor(ADataSet: TFDMemTable): iModelUsuarios;
    function PopulaUserSqLite(ADataSet: TFDMemTable): iModelUsuarios;
    function LimpaTabelaUser: iModelUsuarios;
    function ValidaLogin: iModelUsuarios;
  end;

implementation

{ TModelUsuarios }

class function TModelUsuarios.new: iModelUsuarios;
begin
  result := self.create;
end;

constructor TModelUsuarios.create;
begin

end;

destructor TModelUsuarios.destroy;
begin

  inherited;
end;

function TModelUsuarios.Senha(value: String): iModelUsuarios;
begin
  result := self;
  FSenha := value;
end;

function TModelUsuarios.Usuario(value: String): iModelUsuarios;
begin
  result := self;
  FUsuario := value;
end;

function TModelUsuarios.LimpaTabelaUser: iModelUsuarios;
var
  qry: TFDQuery;
begin
  result := self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.ExecSQL('DELETE FROM USUARIOS')
  finally
    FreeAndNil(qry);
  end;

end;

function TModelUsuarios.BuscaUserServidor(ADataSet: TFDMemTable): iModelUsuarios;
var
  rdwSQLTemp: TRESTDWClientSQL;
begin
  result := self;
  try
    rdwSQLTemp := TRESTDWClientSQL.create(nil);
    rdwSQLTemp.DataBase := DmDados.RESTDWDataBase1;
    rdwSQLTemp.BinaryRequest := True;
    rdwSQLTemp.FormatOptions.MaxStringSize := 10000;
    rdwSQLTemp.Active := false;
    rdwSQLTemp.SQL.Clear;
    rdwSQLTemp.SQL.Add
      ('select cod_user, usuario, nome, senha, ISNULL(cod_vend, 0) as cod_vendedor, ISNULL(cod_camara, 0) as cod_camara, super from t_usuarios');
    rdwSQLTemp.Active := True;
    rdwSQLTemp.RecordCount;
    ADataSet.CopyDataSet(rdwSQLTemp, [coStructure, coRestart, coAppend]);
  finally
    FreeAndNil(rdwSQLTemp);
  end;

end;

function TModelUsuarios.PopulaUserSqLite(ADataSet: TFDMemTable): iModelUsuarios;
var
  i  : Integer;
  qry: TFDQuery;
begin
  result := self;

  qry := TFDQuery.create(nil);
  qry.Connection := DmDados.ConexaoInterna;
  qry.FetchOptions.RowsetSize := 50000;
  ADataSet.First;
  try
    qry.Active := false;
    for i := 0 to ADataSet.RecordCount - 1 do
    begin
      qry.SQL.Clear;
      qry.SQL.Add(' INSERT INTO USUARIOS ( COD_USER, USUARIO, NOME, SENHA, COD_VENDEDOR, SUPER, COD_CAMARA) VALUES ' +
        '( :COD_USER, :USUARIO, :NOME, :SENHA, :COD_VENDEDOR, :SUPER, :COD_CAMARA)');

      qry.ParamByName('COD_USER').AsInteger := ADataSet.FieldByName('COD_USER').AsInteger;
      qry.ParamByName('USUARIO').AsString := ADataSet.FieldByName('USUARIO').AsString;
      qry.ParamByName('NOME').AsString := ADataSet.FieldByName('NOME').AsString;
      qry.ParamByName('SENHA').AsString := ADataSet.FieldByName('SENHA').AsString;
      qry.ParamByName('COD_VENDEDOR').AsInteger := ADataSet.FieldByName('COD_VENDEDOR').AsInteger;
      qry.ParamByName('SUPER').AsInteger := ADataSet.FieldByName('SUPER').AsInteger;
      qry.ParamByName('COD_CAMARA').AsInteger := ADataSet.FieldByName('COD_CAMARA').AsInteger;
      qry.ExecSQL;
      ADataSet.Next;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TModelUsuarios.ValidaLogin: iModelUsuarios;
var
  qry: TFDQuery;
begin
  result := self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM USUARIOS WHERE USUARIO = :USUARIO AND SENHA = :SENHA');
    qry.ParamByName('USUARIO').AsString := FUsuario;
    qry.ParamByName('SENHA').AsString := FSenha;
    qry.open;

    CodVend := qry.FieldByName('COD_VENDEDOR').AsInteger;
    codUser := qry.FieldByName('COD_USER').AsInteger;
    SuperUser := qry.FieldByName('SUPER').AsInteger;
    NomeUsuario := qry.FieldByName('NOME').AsString;

    if qry.RecordCount = 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Usuario ou senha invalido!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

end.
