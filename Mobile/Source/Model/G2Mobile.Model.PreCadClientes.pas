unit G2Mobile.Model.PreCadClientes;

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
  FMX.Objects,
  G2Mobile.Controller.Clientes,
  FMX.Graphics;

type

  TModelPreCadClientes = class(TInterfacedObject, iModelPreCadClientes)
  private
    FQry       : TFDQuery;
    FRdwSQLTemp: TRESTDWClientSQL;

    FTipoPes    : Integer;
    FCpfCnpj    : String;
    FNomeRazao  : String;
    FNomeFant   : String;
    FEndereco   : String;
    FBairro     : String;
    FNumero     : Integer;
    FCep        : String;
    FTelefone   : String;
    FEmail      : String;
    FCodVendedor: Integer;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelPreCadClientes;

    function TipoPes(value: Integer): iModelPreCadClientes;
    function CpfCnpj(value: String): iModelPreCadClientes;
    function NomeRazao(value: String): iModelPreCadClientes;
    function NomeFant(value: String): iModelPreCadClientes;
    function Endereco(value: String): iModelPreCadClientes;
    function Bairro(value: String): iModelPreCadClientes;
    function Numero(value: Integer): iModelPreCadClientes;
    function Cep(value: String): iModelPreCadClientes;
    function Telefone(value: String): iModelPreCadClientes;
    function Email(value: String): iModelPreCadClientes;
    function CodVendedor(value: Integer): iModelPreCadClientes;

    function InsertPreCadCliente: iModelPreCadClientes;
    function UpdatePreCadCliente: iModelPreCadClientes;
    function DeletePreCadCliente: iModelPreCadClientes;
    function PopulaCamposPreCadCliente(AList: TStringList): iModelPreCadClientes;
    function PopulaListViewPreCadCliente(value: TListView; icon: TImage): iModelPreCadClientes;

  end;

implementation

{ TModelPreCadClientes }

uses
  uFrmUtilFormate,
  System.UITypes,
  uFrmInforSistema,
  Form_Mensagem;

{ TModelPreCadClientes }

class function TModelPreCadClientes.new: iModelPreCadClientes;
begin
  Result := self.create;
end;

constructor TModelPreCadClientes.create;
begin
  FQry := TFDQuery.create(nil);
  FQry.Connection := DmDados.ConexaoInterna;
  FQry.FetchOptions.RowsetSize := 50000;
  FQry.Active := false;
  FQry.SQL.Clear;

  FRdwSQLTemp := TRESTDWClientSQL.create(nil);
  FRdwSQLTemp.DataBase := DmDados.RESTDWDataBase1;
  FRdwSQLTemp.BinaryRequest := True;
  FRdwSQLTemp.FormatOptions.MaxStringSize := 10000;
  FRdwSQLTemp.Active := false;
  FRdwSQLTemp.SQL.Clear;
end;

destructor TModelPreCadClientes.destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(FRdwSQLTemp);
  inherited;
end;

function TModelPreCadClientes.Bairro(value: String): iModelPreCadClientes;
begin
  Result := self;
  FBairro := value;
end;

function TModelPreCadClientes.Cep(value: String): iModelPreCadClientes;
begin
  Result := self;
  FCep := value;
end;

function TModelPreCadClientes.CodVendedor(value: Integer): iModelPreCadClientes;
begin
  Result := self;
  FCodVendedor := value;
end;

function TModelPreCadClientes.CpfCnpj(value: String): iModelPreCadClientes;
begin
  Result := self;
  FCpfCnpj := value;
end;

function TModelPreCadClientes.NomeFant(value: String): iModelPreCadClientes;
begin
  Result := self;
  FNomeFant := value;
end;

function TModelPreCadClientes.NomeRazao(value: String): iModelPreCadClientes;
begin
  Result := self;
  FNomeRazao := value;
end;

function TModelPreCadClientes.Numero(value: Integer): iModelPreCadClientes;
begin
  Result := self;
  FNumero := value;
end;

function TModelPreCadClientes.Telefone(value: String): iModelPreCadClientes;
begin
  Result := self;
  FTelefone := value;
end;

function TModelPreCadClientes.TipoPes(value: Integer): iModelPreCadClientes;
begin
  Result := self;
  FTipoPes := value;
end;

function TModelPreCadClientes.Email(value: String): iModelPreCadClientes;
begin
  Result := self;
  FEmail := value;
end;

function TModelPreCadClientes.Endereco(value: String): iModelPreCadClientes;
begin
  Result := self;
  FEndereco := value;
end;

function TModelPreCadClientes.InsertPreCadCliente: iModelPreCadClientes;
begin
  Result := self;

end;

function TModelPreCadClientes.DeletePreCadCliente: iModelPreCadClientes;
begin
  Result := self;

end;

function TModelPreCadClientes.UpdatePreCadCliente: iModelPreCadClientes;
begin
  Result := self;

end;

function TModelPreCadClientes.PopulaCamposPreCadCliente(AList: TStringList): iModelPreCadClientes;
begin
  Result := self;

end;

function TModelPreCadClientes.PopulaListViewPreCadCliente(value: TListView; icon: TImage): iModelPreCadClientes;
begin
  Result := self;

end;

end.
