unit uInterfaceResumoVendedorItens;

interface

uses FMX.ListView, System.Classes, Datasnap.DBClient, FireDAC.Comp.Client;

type

  iModelResumoVendedorItens = interface
    ['{471C6EA7-8F8E-4798-B945-A6605A7F6D3A}']

    function NomeProd(value: String): iModelResumoVendedorItens;
    function PesoTot(value: Double): iModelResumoVendedorItens;
    function VlrTot(value: Double): iModelResumoVendedorItens;
    function QntReal(value: Integer): iModelResumoVendedorItens;
    function BuscaProdVendidosServidor(dt_ini, dt_fim: tDatetime; vend: Integer; ADataSet: TFDMemTable): iModelResumoVendedorItens;
    function PopulaProdVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorItens;
    function PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorItens;
    function LimpaTabelas: iModelResumoVendedorItens;
  end;

implementation

end.
