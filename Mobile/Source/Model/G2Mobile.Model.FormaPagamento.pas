unit G2Mobile.Model.FormaPagamento;

interface

uses
  FMX.ListView,
  uDmDados,
  uRESTDWPoolerDB,
  System.SysUtils,
  IdSSLOpenSSLHeaders,
  FireDAC.Comp.Client,
  FMX.Dialogs,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.DataSet,
  Data.DB,
  FMX.Objects,
  G2Mobile.Controller.FormaPagamento,
  FMX.Graphics;

const

  CONST_LIMPATABELAFORMAPAGAMENTO = 'DELETE FROM FORMAPAGTO';

  CONST_BUSCAFORMAPAGAMENTOSERVIDOR =
    'SELECT COD_FORMA, DESCRICAO, COD_DOC FROM T_FORMA_PGTO union SELECT 0, ''A VISTA'', ISNULL(DOC_AVISTA,0)DOC_AVISTA FROM T_CONFIG';

  CONST_POPULAFORMAPAGAMENTOSQLITE =
    ' INSERT INTO FORMAPAGTO ( COD_DOC, DESCRICAO, COD_FORMA) VALUES ( :COD_DOC, :DESCRICAO, :COD_FORMA)';

  CONST_LIMPATABELAPAGAMENTOPESSOA = 'DELETE FROM pessoa_fpgto';

  CONST_BUSCAPAGAMENTOPESSOASERVIDOR = 'SELECT COD_PESSOA, COD_FORMA FROM T_PESSOA_FPGTO';

  CONST_POPULAPAGAMENTOPESSOASQlITE =
    ' INSERT INTO PESSOA_FPGTO ( COD_PESSOA, COD_FORMA) VALUES ( :COD_PESSOA, :COD_FORMA)';

  CONST_POPULALISTVIEW =
    'select pf.cod_pessoa, pf.cod_forma, fp.descricao from pessoa_fpgto pf left outer join formapagto fp on (pf.cod_forma = fp.cod_forma)  '
    + ' where cod_pessoa = :CLIENTE union select :CLIENTE, 0, ''A VISTA'' ';

  CONST_BUSCAFORMAPAGAMENTO = ' SELECT DESCRICAO FROM FORMAPAGTO WHERE COD_FORMA = :COD_FORMA';

type

  TModelFormaPagamento = class(TInterfacedObject, iModelFormaPagamento)

  private
    FQry   : TFDQuery;
    FRdwSQL: TRESTDWClientSQL;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelFormaPagamento;

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

{ TFormaPagamento }

class function TModelFormaPagamento.new: iModelFormaPagamento;
begin
  result := self.create;
end;

constructor TModelFormaPagamento.create;
begin
  FQry := TFDQuery.create(nil);
  FQry.Connection := DmDados.ConexaoInterna;
  FQry.FetchOptions.RowsetSize := 50000;
  FQry.Active := false;
  FQry.SQL.Clear;

  FRdwSQL := TRESTDWClientSQL.create(nil);
  FRdwSQL.DataBase := DmDados.RESTDWDataBase1;
  FRdwSQL.BinaryRequest := True;
  FRdwSQL.FormatOptions.MaxStringSize := 10000;
  FRdwSQL.Active := false;
  FRdwSQL.SQL.Clear;
end;

destructor TModelFormaPagamento.destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(FRdwSQL);
  inherited;
end;

function TModelFormaPagamento.LimpaTabelaFormaPagamento: iModelFormaPagamento;
begin
  result := self;

  FQry.ExecSQL(CONST_LIMPATABELAFORMAPAGAMENTO)

end;

function TModelFormaPagamento.BuscaFormaPagamentoServidor(ADataSet: TFDMemTable): iModelFormaPagamento;
begin
  result := self;

  FRdwSQL.SQL.Text := CONST_BUSCAFORMAPAGAMENTOSERVIDOR;
  FRdwSQL.Active := True;
  FRdwSQL.RecordCount;
  ADataSet.CopyDataSet(FRdwSQL, [coStructure, coRestart, coAppend]);

end;

function TModelFormaPagamento.PopulaFormaPagamentoSqLite(ADataSet: TFDMemTable): iModelFormaPagamento;
var
  i: integer;
begin
  result := self;

  ADataSet.First;
  for i := 0 to ADataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_POPULAFORMAPAGAMENTOSQLITE;
    FQry.ParamByName('COD_DOC').AsInteger := ADataSet.FieldByName('COD_DOC').AsInteger;
    FQry.ParamByName('DESCRICAO').AsString := ADataSet.FieldByName('DESCRICAO').AsString;
    FQry.ParamByName('COD_FORMA').AsString := ADataSet.FieldByName('COD_FORMA').AsString;
    FQry.ExecSQL;
    ADataSet.Next;
  end;

end;

function TModelFormaPagamento.LimpaTabelaPagamentoPessoa: iModelFormaPagamento;
begin
  result := self;

  FQry.ExecSQL(CONST_LIMPATABELAPAGAMENTOPESSOA)

end;

function TModelFormaPagamento.BuscaPagamentoPessoaServidor(ADataSet: TFDMemTable): iModelFormaPagamento;
begin
  result := self;

  FRdwSQL.SQL.Text := CONST_BUSCAPAGAMENTOPESSOASERVIDOR;
  FRdwSQL.Active := True;
  FRdwSQL.RecordCount;
  ADataSet.CopyDataSet(FRdwSQL, [coStructure, coRestart, coAppend]);

end;

function TModelFormaPagamento.PopulaPagamentoPessoaSqLite(ADataSet: TFDMemTable): iModelFormaPagamento;
var
  i: integer;
begin
  result := self;

  ADataSet.First;
  for i := 0 to ADataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_POPULAPAGAMENTOPESSOASQlITE;
    FQry.ParamByName('COD_PESSOA').AsInteger := ADataSet.FieldByName('COD_PESSOA').AsInteger;
    FQry.ParamByName('COD_FORMA').AsString := ADataSet.FieldByName('COD_FORMA').AsString;
    FQry.ExecSQL;
    ADataSet.Next;
  end;

end;

function TModelFormaPagamento.BuscarFormaPagamento(value: integer): String;
begin
  FQry.SQL.Text := CONST_BUSCAFORMAPAGAMENTO;
  FQry.ParamByName('COD_FORMA').AsInteger := value;
  FQry.Open;

  if FQry.RecordCount = 0 then
    result := EmptyStr
  else
    result := FQry.FieldByName('DESCRICAO').AsString;
end;

function TModelFormaPagamento.BuscaUltimaFormaDePagamentoCliente(value: integer): String;
begin
  FQry.SQL.Text := CONST_POPULALISTVIEW + ' order by pf.cod_forma desc';
  FQry.ParamByName('CLIENTE').AsInteger := value;
  FQry.Open;

  if FQry.RecordCount = 0 then
    result := EmptyStr
  else
    result := FormatFloat('0000', FQry.FieldByName('cod_forma').AsFloat);
end;

function TModelFormaPagamento.PopulaListView(Cod: integer; value: TListView; imageForma: Timage): iModelFormaPagamento;
var
  x   : integer;
  item: TListViewItem;
  txt : TListItemText;
  img : TListItemImage;
  bmp : TBitmap;
  foto: TStream;
begin

  result := self;

  try
    FQry.SQL.Text := CONST_POPULALISTVIEW;
    FQry.ParamByName('CLIENTE').AsInteger := Cod;
    FQry.Open;
    FQry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 0 to FQry.RecordCount - 1 do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('codigo'));
        txt.Text := FormatFloat('0000', FQry.FieldByName('cod_forma').AsFloat);
        txt.TagString := FQry.FieldByName('cod_forma').AsString;

        txt := TListItemText(Objects.FindDrawable('formadepagamento'));
        txt.Text := FQry.FieldByName('descricao').AsString;

        img := TListItemImage(Objects.FindDrawable('Image'));
        img.Bitmap := imageForma.Bitmap;
      end;
      FQry.Next
    end;
  finally
    value.EndUpdate;
  end;
end;

end.
