unit uInterfacePreCadClientes;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Graphics;

type

  iModelPreCadClientes = interface
    ['{25F82A84-4E2F-43D5-ADE2-143CE97FFC1D}']

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

end.
