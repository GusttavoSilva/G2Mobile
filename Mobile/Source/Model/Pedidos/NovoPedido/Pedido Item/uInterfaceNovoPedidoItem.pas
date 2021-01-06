unit uInterfaceNovoPedidoItem;

interface

uses
  FMX.Grid,
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Graphics;

type
  iModelNovoPedidoItem = interface
    ['{39D6CE0A-3594-47BF-A5B8-DB91E996BF67}']

    function chave(value: String): iModelNovoPedidoItem;
    function cod_Prod(value: Integer): iModelNovoPedidoItem;
    function NomePRod(value: String): iModelNovoPedidoItem;
    function Und(value: Integer): iModelNovoPedidoItem;
    function Qnt(value: Integer): iModelNovoPedidoItem;
    function VlrUnit(value: Double): iModelNovoPedidoItem;
    function TotBruto(value: Double): iModelNovoPedidoItem;
    function VlrDesconto(value: Double): iModelNovoPedidoItem;
    function VlrLiquido(value: Double): iModelNovoPedidoItem;
    Function PopulaProdInfoStringGrid(chave: String; Grid: TStringGrid): iModelNovoPedidoItem;
    Function InsertItens(Grid: TStringGrid): iModelNovoPedidoItem;
    function CalcProduto(AList: TStringList): iModelNovoPedidoItem;
    function ValidaPrecoMinino: Integer;
    function AddProdlistPedido(Grid: TStringGrid): iModelNovoPedidoItem;
    function VerificaItemIncluidos(Grid: TStringGrid): Integer;
    function SomaStringGrid(AList: TStringList; Grid: TStringGrid): iModelNovoPedidoItem;
    function EditaRecplicarItem(Grid: TStringGrid): iModelNovoPedidoItem;
    function DeleteItems: iModelNovoPedidoItem;
  end;

implementation

end.
