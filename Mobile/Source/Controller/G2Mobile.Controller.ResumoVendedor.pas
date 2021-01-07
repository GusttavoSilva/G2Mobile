unit G2Mobile.Controller.ResumoVendedor;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client;

type

  iModelResumoVendedorClientes = interface
    ['{471C6EA7-8F8E-4798-B945-A6605A7F6D3A}']

    function CodVend(value: Integer): iModelResumoVendedorClientes;
    function PesoTot(value: Double): iModelResumoVendedorClientes;
    function VlrTot(value: Double): iModelResumoVendedorClientes;
    function QntReal(value: Integer): iModelResumoVendedorClientes;
    function BuscaClienteVendidosServidor(dt_ini, dt_fim: tDatetime; vend: Integer; ADataSet: TFDMemTable)
      : iModelResumoVendedorClientes;
    function PopulaClienteVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorClientes;
    function PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorClientes;
    function LimpaTabelas: iModelResumoVendedorClientes;
  end;

  iModelResumoVendedorItens = interface
    ['{7FFB6B23-A8EF-45D0-A8A0-E844116E595E}']

    function NomeProd(value: String): iModelResumoVendedorItens;
    function PesoTot(value: Double): iModelResumoVendedorItens;
    function VlrTot(value: Double): iModelResumoVendedorItens;
    function QntReal(value: Integer): iModelResumoVendedorItens;
    function BuscaProdVendidosServidor(dt_ini, dt_fim: tDatetime; vend: Integer; ADataSet: TFDMemTable)
      : iModelResumoVendedorItens;
    function PopulaProdVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorItens;
    function PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorItens;
    function LimpaTabelas: iModelResumoVendedorItens;
  end;

implementation

end.
