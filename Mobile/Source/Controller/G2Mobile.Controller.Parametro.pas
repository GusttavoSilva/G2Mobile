unit G2Mobile.Controller.Parametro;

interface

uses FMX.ListView, System.Classes, Datasnap.DBClient, FireDAC.Comp.Client,
  FMX.Objects;

type

  iModelParametros = interface
    ['{874D353B-A452-4C99-AD87-401A56763058}']

    function BuscaParametrosServidor(DeviceId: String; ADataSet: TFDMemTable): iModelParametros;
    function PopulaParametrosSqLite(ADataSet: TFDMemTable): iModelParametros;
    function LimpaTabelaParametros: iModelParametros;
    function RetornaLogo(AImage: TImage): iModelParametros;
    function VerificaTablet: Boolean;
    function Parametro(value: String): Variant;
  end;

implementation

end.
