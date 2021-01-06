unit uClasseNovoPedidoItem;

interface

uses
  uInterfaceNovoPedidoItem,
  FMX.Grid,
  FMX.ListView,
  System.Classes,
  Datasnap.DBClient,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.Graphics,
  System.UITypes;

const

  CONST_POPULAPRODSQLSTRINGGRID =
    '  SELECT  vi.cod_prod, vi.valor, vi.desconto, case when vi.unidade = 0 then ''UND'' else ''PESO'' end as unidade, '+
    ' pd.desc_ind as nomeproduto, vi.quantidade as qtd_ped, ia.qtd_tot, ia.pes_tot, ia.vlr_tot, VI.TOTAL '+
    ' FROM VENDITEM  vi left outer join venda v on (vi.chave = v.chave) left outer join produto pd on (pd.cod_prod = vi.cod_prod) '+
    ' left outer join ITENS_ATUALIZADO ia on (ia.cod_prod = vi.cod_prod and vi.chave  = ia.chave) WHERE vi.chave = :chave ';

  CONST_CALCPRODUTO = ' SELECT CASE WHEN  VALOR_PROD < :EDTVALORITEM THEN 0 ELSE  (VALOR_PROD - :EDTVALORITEM) * ' +
    ' CASE ' + ' WHEN TIPO_CALC = 0 THEN CASE WHEN PESO_PADRAO = 0 THEN 1 ELSE PESO_PADRAO END ' +
    ' WHEN TIPO_CALC = 1 THEN CASE WHEN QUANT_CX = 0 THEN 1 ELSE QUANT_CX END ' + ' END * :QUANTIDADE END AS DESCONTO, '
    + ' :QUANTIDADE * :EDTVALORITEM * ' + ' CASE ' +
    ' WHEN TIPO_CALC = 0 THEN CASE WHEN PESO_PADRAO = 0 THEN 1 ELSE PESO_PADRAO END ' +
    ' WHEN TIPO_CALC = 1 THEN CASE WHEN QUANT_CX = 0 THEN 1 ELSE QUANT_CX END ' + ' END AS VALORPROD ' +
    ' FROM PRODUTO WHERE COD_PROD = :CODPROD ';

  CONST_VALIDAVALORMINIMO = ' SELECT ' +
    ' CASE WHEN VALOR_MIN > :EDTVALORITEM AND (SELECT BLOQ_VLR_MIN FROM PARAMETROS) = 1 THEN 0 /*BLOQUEIA DIRETO*/ ' +
    ' WHEN VALOR_MIN > :EDTVALORITEM AND (SELECT BLOQ_VLR_MIN FROM PARAMETROS) = 0 THEN 1 /*PERGUNTA REALMENTE QUER INCLUIR*/ '
    + ' ELSE 2 /*ok*/ END AS SITUACAO FROM PRODUTO WHERE COD_PROD = :CODPROD; ';

  CONST_INSERTITENS = ' INSERT INTO venditem (chave,cod_prod,quantidade, valor,desconto,total,unidade,pcBruto) VALUES '
    + ' (:chave, :cod_prod, :quantidade, :valor, :desconto, :total, :unidade, :pcBruto) ';

  CONST_EDITARPOPULARITEM =
    ' SELECT  vi.cod_prod, vi.quantidade, vi.valor, vi.desconto, case when vi.unidade = 0 then ''UND'' else ''PESO'' end as unidade, '
    + ' Vi.TOTAL , pd.desc_ind  , vi.pcBruto   FROM VENDITEM  vi  left outer join venda v on (vi.chave = v.chave) ' +
    ' left outer join produto pd on (pd.cod_prod = vi.cod_prod) where vi.chave = :chave ';

  CONST_DELETEITENS = ' DELETE FROM VENDITEM WHERE CHAVE = :CHAVE ';

type

  TNovoPedidoItem = class(TInterfacedObject, iModelNovoPedidoItem)
  private
    FQry: TFDQuery;

    FCodProd: Integer;
    FNomeProd: String;
    FQnt: Integer;
    FVlrUnit: Double;
    FTotBruto: Double;
    FVlrDesconto: Double;
    FVlrLiquido: Double;
    FUnd: Integer;
    FChave: String;

  public
    constructor create;
    destructor destroy; override;
    class function new: iModelNovoPedidoItem;

    function chave(value: String): iModelNovoPedidoItem;
    function cod_Prod(value: Integer): iModelNovoPedidoItem;
    function NomeProd(value: String): iModelNovoPedidoItem;
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

{ TNovoPedidoItem }

uses
  uDmDados,
  System.SysUtils,
  uFrmUtilFormate,
  Form_Mensagem;

class function TNovoPedidoItem.new: iModelNovoPedidoItem;
begin
  Result := Self.create;
end;

constructor TNovoPedidoItem.create;
begin
  FQry := TFDQuery.create(nil);
  FQry.Connection := DmDados.ConexaoInterna;
  FQry.FetchOptions.RowsetSize := 50000;
  FQry.Active := false;
  FQry.SQL.Clear;
end;

destructor TNovoPedidoItem.destroy;
begin
  FreeandNil(FQry);
  inherited;
end;

function TNovoPedidoItem.chave(value: String): iModelNovoPedidoItem;
begin
  Result := Self;
  FChave := value;
end;

function TNovoPedidoItem.cod_Prod(value: Integer): iModelNovoPedidoItem;
begin
  Result := Self;
  FCodProd := value;
end;

function TNovoPedidoItem.NomeProd(value: String): iModelNovoPedidoItem;
begin
  Result := Self;
  FNomeProd := value;
end;

function TNovoPedidoItem.Qnt(value: Integer): iModelNovoPedidoItem;
begin
  Result := Self;
  FQnt := value;
end;

function TNovoPedidoItem.TotBruto(value: Double): iModelNovoPedidoItem;
begin
  Result := Self;
  FTotBruto := value;
end;

function TNovoPedidoItem.Und(value: Integer): iModelNovoPedidoItem;
begin
  Result := Self;
  FUnd := value;
end;

function TNovoPedidoItem.VlrDesconto(value: Double): iModelNovoPedidoItem;
begin
  Result := Self;
  FVlrDesconto := value;
end;

function TNovoPedidoItem.VlrLiquido(value: Double): iModelNovoPedidoItem;
begin
  Result := Self;
  FVlrLiquido := value;
end;

function TNovoPedidoItem.VlrUnit(value: Double): iModelNovoPedidoItem;
begin
  Result := Self;
  FVlrUnit := value;
end;

function TNovoPedidoItem.PopulaProdInfoStringGrid(chave: String; Grid: TStringGrid): iModelNovoPedidoItem;
var
  I: Integer;
begin
  Result := Self;

  FQry.SQL.Text := CONST_POPULAPRODSQLSTRINGGRID;
  FQry.ParamByName('CHAVE').AsString := chave;
  FQry.Open;
  for I := 0 to FQry.RecordCount - 1 do
  begin
    with Grid do
    begin

      RowCount := RowCount + 1;
      Row := RowCount - 1;

       Cells[0, Row] := FQry.FieldByName('cod_prod').AsString;
       Cells[1, Row] := FQry.FieldByName('nomeproduto').AsString;
       Cells[2, Row] := FQry.FieldByName('unidade').AsString;
       Cells[3, Row] := FormatFloat('0000',FQry.FieldByName('qtd_ped').AsFloat);
       Cells[4, Row] := FormatFloat('0000',FQry.FieldByName('qtd_tot').AsFloat);
       Cells[5, Row] := FormatFloat('#,##0.000',FQry.FieldByName('pes_tot').AsFloat);
       Cells[6, Row] := FormatFloat('#,##0.00',FQry.FieldByName('valor').AsFloat);
       Cells[7, Row] := FormatFloat('#,##0.00',FQry.FieldByName('desconto').AsFloat);
       Cells[8, Row] := FormatFloat('#,##0.00',FQry.FieldByName('total').AsFloat);
       Cells[9, Row] := FormatFloat('#,##0.00', FQry.FieldByName('vlr_tot').AsFloat);
    end;
    FQry.Next;
  end;
end;

function TNovoPedidoItem.DeleteItems: iModelNovoPedidoItem;
begin
  Result := Self;
  FQry.SQL.Text := CONST_DELETEITENS;
  FQry.ParamByName('CHAVE').AsString := FChave;
  FQry.ExecSQL;
end;

function TNovoPedidoItem.EditaRecplicarItem(Grid: TStringGrid): iModelNovoPedidoItem;
var
  I: Integer;
begin
  Result := Self;

  FQry.SQL.Text := CONST_EDITARPOPULARITEM;
  FQry.ParamByName('CHAVE').AsString := FChave;
  FQry.Open;
  for I := 0 to FQry.RecordCount - 1 do
  begin
    with Grid do
    begin

      RowCount := RowCount + 1;
      Row := RowCount - 1;

      Cells[0, Row] := FQry.FieldByName('cod_prod').AsString;
      Cells[1, Row] := FQry.FieldByName('desc_ind').AsString;
      Cells[2, Row] := FQry.FieldByName('unidade').AsString;
      Cells[3, Row] := formatfloat('0000', FQry.FieldByName('quantidade').AsFloat);
      Cells[4, Row] := formatfloat('#,##0.00', FQry.FieldByName('valor').AsFloat);
      Cells[5, Row] := formatfloat('#,##0.00', FQry.FieldByName('pcbruto').AsFloat);
      Cells[6, Row] := formatfloat('#,##0.00', FQry.FieldByName('desconto').AsFloat);
      Cells[7, Row] := formatfloat('#,##0.00', FQry.FieldByName('total').AsFloat);
    end;
    FQry.Next;
  end;

end;

function TNovoPedidoItem.CalcProduto(AList: TStringList): iModelNovoPedidoItem;
var
  I: Integer;
begin
  Result := Self;

  FQry.SQL.Text := CONST_CALCPRODUTO;
  FQry.ParamByName('CODPROD').AsInteger := FCodProd;
  FQry.ParamByName('QUANTIDADE').AsInteger := FQnt;
  FQry.ParamByName('EDTVALORITEM').AsFloat := FVlrUnit;
  FQry.Open;

  for I := 0 to FQry.FieldCount - 1 do
  begin
    AList.Add(FQry.Fields[I].AsString);
    FQry.Next;
  end;

end;

function TNovoPedidoItem.ValidaPrecoMinino: Integer;
begin

  FQry.SQL.Text := CONST_VALIDAVALORMINIMO;
  FQry.ParamByName('CODPROD').AsInteger := FCodProd;
  FQry.ParamByName('EDTVALORITEM').AsFloat := FVlrUnit;
  FQry.Open;

  Result := FQry.FieldByName('SITUACAO').AsInteger;

end;

function TNovoPedidoItem.VerificaItemIncluidos(Grid: TStringGrid): Integer;
var
  I: Integer;
begin
  with Grid do
  begin
    for I := 0 to Grid.RowCount - 1 do
    begin
      if Cells[0, Row] = FCodProd.ToString then
        Result := 1;
    end;
  end;
end;

function TNovoPedidoItem.AddProdlistPedido(Grid: TStringGrid): iModelNovoPedidoItem;
var
  I: Integer;
begin
  Result := Self;

  with Grid do
  begin

    RowCount := RowCount + 1;
    Row := RowCount - 1;

    Cells[0, Row] := FCodProd.ToString;
    Cells[1, Row] := FNomeProd;
    case FUnd of
      0:
        Cells[2, Row] := 'UND';
      1:
        Cells[2, Row] := 'PESO';
    end;
    Cells[3, Row] := formatfloat('0000', FQnt.ToDouble);
    Cells[4, Row] := formatfloat('#,##0.00', FVlrUnit);
    Cells[5, Row] := formatfloat('#,##0.00', FVlrLiquido + FVlrDesconto);
    Cells[6, Row] := formatfloat('#,##0.00', FVlrDesconto);
    Cells[7, Row] := formatfloat('#,##0.00', FVlrLiquido);
  end;
end;

function TNovoPedidoItem.SomaStringGrid(AList: TStringList; Grid: TStringGrid): iModelNovoPedidoItem;
var
  I: Integer;
  VlrBruto, VlrDesc, VlrLiq: Double;
begin
  VlrBruto := 0;
  VlrDesc := 0;
  VlrLiq := 0;

  for I := 0 to Grid.RowCount - 1 do
  begin
    VlrBruto := VlrBruto + StrParaDouble(Grid.Cells[5, I]);
    VlrDesc := VlrDesc + StrParaDouble(Grid.Cells[6, I]);
    VlrLiq := VlrLiq + StrParaDouble(Grid.Cells[7, I]);
  end;

  AList.Add(formatfloat('#,##0.00', VlrBruto));
  AList.Add(formatfloat('#,##0.00', VlrDesc));
  AList.Add(formatfloat('#,##0.00', VlrLiq));
end;

function TNovoPedidoItem.InsertItens(Grid: TStringGrid): iModelNovoPedidoItem;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Grid.RowCount - 1 do
  begin
    FQry.SQL.Text := CONST_INSERTITENS;
    FQry.ParamByName('chave').AsString := FChave;
    FQry.ParamByName('cod_prod').AsString := Grid.Cells[0, I];
    FQry.ParamByName('quantidade').AsString := Grid.Cells[3, I];
    FQry.ParamByName('valor').AsFloat := StrParaDouble(Grid.Cells[4, I]);
    FQry.ParamByName('desconto').AsFloat := StrParaDouble(Grid.Cells[6, I]);
    FQry.ParamByName('total').AsFloat := StrParaDouble(Grid.Cells[7, I]);

    if Grid.Cells[2, I].Equals('UND') then
    begin
      FQry.ParamByName('unidade').AsInteger := 0;
    end
    else
      FQry.ParamByName('unidade').AsInteger := 1;

    FQry.ParamByName('pcBruto').AsFloat := StrParaDouble(Grid.Cells[5, I]);
    FQry.ExecSQL;
  end;

end;

END.
