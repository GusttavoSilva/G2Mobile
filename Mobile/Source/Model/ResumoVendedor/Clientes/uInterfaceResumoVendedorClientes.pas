unit uInterfaceResumoVendedorClientes;

interface

uses FMX.ListView, System.Classes, Datasnap.DBClient, FireDAC.Comp.Client;

type

  iModelResumoVendedorClientes = interface
    ['{471C6EA7-8F8E-4798-B945-A6605A7F6D3A}']

    function CodVend(value: Integer): iModelResumoVendedorClientes;
    function PesoTot(value: Double): iModelResumoVendedorClientes;
    function VlrTot(value: Double): iModelResumoVendedorClientes;
    function QntReal(value: Integer): iModelResumoVendedorClientes;
    function BuscaClienteVendidosServidor(dt_ini, dt_fim: tDatetime; vend:integer; ADataSet: TFDMemTable): iModelResumoVendedorClientes;
    function PopulaClienteVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorClientes;
    function PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorClientes;
    function LimpaTabelas: iModelResumoVendedorClientes;
  end;

implementation

end.
