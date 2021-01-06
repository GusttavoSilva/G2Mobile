unit uInterfaceTitulosCliente;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Grid;

type
  iModelTitulosCliente = interface
    ['{25BF2E4D-E50C-47B4-99EC-6592239D314B}']

    function CodVend(value: Integer): iModelTitulosCliente;
    function CodCliente(value: Integer): iModelTitulosCliente;
    function CodPedcar(value: Integer): iModelTitulosCliente;
    function DeleteTitulos: iModelTitulosCliente;
    function DeleteItensTitulo: iModelTitulosCliente;
    function BuscaTitulosServidor(DataSet: TFDMemTable): iModelTitulosCliente;
    function BuscaItensTituloServidor(DataSet: TFDMemTable): iModelTitulosCliente;
    function GravaTitulosSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
    function GravaItensTituloSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
    function PopulaListView(value: TListView; aberta, vencida: Timage): iModelTitulosCliente;
    function PopulaItemTituloStringGrid(Grid: TStringGrid): iModelTitulosCliente;
  end;

implementation

end.
