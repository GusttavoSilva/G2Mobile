unit G2Mobile.Controller.Pedidos;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Grid;

type
  iModelNovoPedido = interface
    ['{039F3079-57D3-49A1-9C32-45D9DA2C6251}']
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

  iModelNovoPedidoItem = interface
    ['{05965F38-F1B7-4B7C-8710-3B5FAA414321}']

    function Chave(value: String): iModelNovoPedidoItem;
    function cod_Prod(value: Integer): iModelNovoPedidoItem;
    function NomePRod(value: String): iModelNovoPedidoItem;
    function Und(value: Integer): iModelNovoPedidoItem;
    function Qnt(value: Integer): iModelNovoPedidoItem;
    function VlrUnit(value: Double): iModelNovoPedidoItem;
    function TotBruto(value: Double): iModelNovoPedidoItem;
    function VlrDesconto(value: Double): iModelNovoPedidoItem;
    function VlrLiquido(value: Double): iModelNovoPedidoItem;
    Function PopulaProdInfoStringGrid(Chave: String; Grid: TStringGrid): iModelNovoPedidoItem;
    Function InsertItens(Grid: TStringGrid): iModelNovoPedidoItem;
    function CalcProduto(AList: TStringList): iModelNovoPedidoItem;
    function ValidaPrecoMinino: Integer;
    function AddProdlistPedido(Grid: TStringGrid): iModelNovoPedidoItem;
    function VerificaItemIncluidos(Grid: TStringGrid): Integer;
    function SomaStringGrid(AList: TStringList; Grid: TStringGrid): iModelNovoPedidoItem;
    function EditaRecplicarItem(Grid: TStringGrid): iModelNovoPedidoItem;
    function DeleteItems: iModelNovoPedidoItem;
  end;

  iModelExportarPedidos = interface
    ['{25BF2E4D-E50C-47B4-99EC-6592239D314B}']

    function DeleteItemAtualizado: iModelExportarPedidos;
    function BuscaInfoAtualizadaServidor(DataSet: TFDMemTable): iModelExportarPedidos;
    function GravaInfoAtulizadoPedidoSqlite(DataSet: TFDMemTable): iModelExportarPedidos;
    function VerificaPedidosSincronizadosSqlite: iModelExportarPedidos;
  end;

implementation

end.
