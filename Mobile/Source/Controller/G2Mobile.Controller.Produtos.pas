unit G2Mobile.Controller.Produtos;

interface

uses
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects;

type

  iModelProdutos = interface
    ['{39F06291-63DD-4B97-88D9-C07299DFB942}']
    function BuscaProdServidor(ADataSet: TFDMemTable): iModelProdutos;
    function BuscaFotoProdServidor(ADataSet: TFDMemTable): iModelProdutos;

    function PopulaProdSqLite(ADataSet: TFDMemTable): iModelProdutos;
    function PopulaFotosProdSqLite(ADataSet: TFDMemTable): iModelProdutos;
    function PopulaListView(value: TListView; SemFoto: Timage; Pesq: String): iModelProdutos;
    function LimpaTabelaProd: iModelProdutos;
    function LimpaTabelaProdFoto: iModelProdutos;
    function PopulaCampos(value: integer; AList: TStringList): iModelProdutos;
    function RetornaFoto(value: integer; SemFoto, AImage: Timage): iModelProdutos;

  end;

implementation

end.
