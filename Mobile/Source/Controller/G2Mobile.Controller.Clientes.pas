unit G2Mobile.Controller.Clientes;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Graphics,
  FMX.Grid;

type

  iModelClientes = interface
    ['{25F82A84-4E2F-43D5-ADE2-143CE97FFC1D}']

    function BuscaClientesServidor(Super, cod_vend: Integer; ADataSet: TFDMemTable): iModelClientes;
    function PopulaClientesSqLite(ADataSet: TFDMemTable): iModelClientes;
    function LimpaTabelaClientes: iModelClientes;
    function PopulaListView(value: TListView; positivo, negativo: TImage; Pesq: String): iModelClientes;
    function PopulaCampos(value: Integer; AList: TStringList): iModelClientes;
    function BuscarCliente(value: Integer): String;
    function RetornaLimite(value: Integer): String;
    function ValidaCliente(value: Integer): Integer;
  end;

  iModelPreCadClientes = interface
    ['{018B1039-EAD5-49F9-A925-68A98E48F93C}']

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

  iModelTitulosCliente = interface
    ['{F849F3CA-ED71-4B3E-99C4-7ED92DFF56C4}']

    function CodVend(value: Integer): iModelTitulosCliente;
    function CodCliente(value: Integer): iModelTitulosCliente;
    function CodPedcar(value: Integer): iModelTitulosCliente;
    function DeleteTitulos: iModelTitulosCliente;
    function DeleteItensTitulo: iModelTitulosCliente;
    function BuscaTitulosServidor(DataSet: TFDMemTable): iModelTitulosCliente;
    function BuscaItensTituloServidor(DataSet: TFDMemTable): iModelTitulosCliente;
    function GravaTitulosSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
    function GravaItensTituloSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
    function PopulaListView(value: TListView; aberta, vencida: TImage): iModelTitulosCliente;
    function PopulaItemTituloStringGrid(Grid: TStringGrid): iModelTitulosCliente;
  end;

implementation

end.
