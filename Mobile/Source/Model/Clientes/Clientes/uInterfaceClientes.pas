unit uInterfaceClientes;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Graphics;

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

implementation

end.
