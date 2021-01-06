unit uInterfaceNovoPedido;

interface

uses
  FMX.Objects,
  FMX.ListView,
  System.Classes,
  FMX.Grid;

type
  iModelNovoPedido = interface
    ['{E6DFA303-0FDE-432D-B3AA-C6F3B8998EC2}']

    function PSituacao(value: Integer): iModelNovoPedido; // P = Pesquisa
    function PDataIni(value: TDateTime): iModelNovoPedido; // P = Pesquisa
    function PDataFim(value: TDateTime): iModelNovoPedido; // P = Pesquisa

    function Acao(value: Integer): iModelNovoPedido;
    function Chave(value: String): iModelNovoPedido;
    function FormaPagamento(value: Integer): iModelNovoPedido;
    function CodCamara(value: Integer): iModelNovoPedido;
    function CodUser(value: Integer): iModelNovoPedido;
    function CodVendedor(value: Integer): iModelNovoPedido;
    function CodCliente(value: Integer): iModelNovoPedido;
    function Emissao(value: TDateTime): iModelNovoPedido;
    function DataEmb(value: TDate): iModelNovoPedido;
    function Valor(value: Double): iModelNovoPedido;
    function Desconto(value: Double): iModelNovoPedido;
    function Total(value: Double): iModelNovoPedido;
    function Comissao(value: Integer): iModelNovoPedido;
    function Latitude(value: String): iModelNovoPedido;
    function Longitude(value: String): iModelNovoPedido;
    function Obs(value: String): iModelNovoPedido;

    function PopulaListPedidos(value: TListView; enviado, pendente, aprovado, reprovado: TImage): iModelNovoPedido;
    function Filter: iModelNovoPedido;
    Function InfoPedido(value: String; AList: TStringList): iModelNovoPedido;
    function ValidaAddProd: iModelNovoPedido;
    function InsertPedido: iModelNovoPedido;
    function VerificaPedido(Grid: TStringGrid): String;
    function EditaReplicaPedido(AList: TStringList): iModelNovoPedido;
    function DeletePedido: iModelNovoPedido;
    function StatusPedido: iModelNovoPedido;
  end;

implementation

end.
