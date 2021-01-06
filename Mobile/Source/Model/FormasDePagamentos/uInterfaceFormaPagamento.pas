unit uInterfaceFormaPagamento;

interface

uses FMX.ListView, System.Classes, Datasnap.DBClient, FireDAC.Comp.Client,
  FMX.Objects;

type

  iModelFormaPagamento = interface
    ['{41C159D2-C15E-4FE4-BFA8-BED2E1B4F9C3}']

    function BuscaFormaPagamentoServidor(ADataSet: TFDMemTable): iModelFormaPagamento;
    function PopulaFormaPagamentoSqLite(ADataSet: TFDMemTable): iModelFormaPagamento;
    function BuscaPagamentoPessoaServidor(ADataSet: TFDMemTable): iModelFormaPagamento;
    function PopulaPagamentoPessoaSqLite(ADataSet: TFDMemTable): iModelFormaPagamento;
    function LimpaTabelaFormaPagamento: iModelFormaPagamento;
    function LimpaTabelaPagamentoPessoa: iModelFormaPagamento;
    function PopulaListView(Cod: integer; value: TListView; imageForma: Timage): iModelFormaPagamento;
    function BuscarFormaPagamento(value: integer): String;
    function BuscaUltimaFormaDePagamentoCliente(value: integer): String;
  end;

implementation

end.
