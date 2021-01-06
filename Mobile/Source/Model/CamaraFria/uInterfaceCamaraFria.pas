unit uInterfaceCamaraFria;

interface

uses FMX.ListView, System.Classes, Datasnap.DBClient, FireDAC.Comp.Client,
  FMX.Objects;

type

  iModelCamaraFria = interface
    ['{3135FBC4-2E1C-4FEF-8030-05A3B9C80D85}']

    function BuscaCamaraFriaServidor(ADataSet: TFDMemTable): iModelCamaraFria;
    function PopulaCamaraFriaSqLite(ADataSet: TFDMemTable): iModelCamaraFria;
    function LimpaTabelaCamaraFria: iModelCamaraFria;
    function PopulaListView(value: TListView; imageForma: Timage): iModelCamaraFria;
    function BuscarCamaraFria(value: Integer): String;
    function RetornaCamaraFriaVendedor(value: Integer): String;
  end;

implementation

end.
