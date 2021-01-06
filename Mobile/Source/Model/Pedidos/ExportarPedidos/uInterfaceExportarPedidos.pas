unit uInterfaceExportarPedidos;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects;

type
  iModelExportarPedidos = interface
    ['{25BF2E4D-E50C-47B4-99EC-6592239D314B}']

    function DeleteItemAtualizado: iModelExportarPedidos;
    function BuscaInfoAtualizadaServidor(DataSet: TFDMemTable): iModelExportarPedidos;
    function GravaInfoAtulizadoPedidoSqlite(DataSet: TFDMemTable): iModelExportarPedidos;
    function VerificaPedidosSincronizadosSqlite: iModelExportarPedidos;
  end;

implementation

end.
