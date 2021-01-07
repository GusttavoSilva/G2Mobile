unit G2Mobile.Model.ResumoVendedorItens;

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
  FireDAC.Comp.DataSet, G2Mobile.Controller.ResumoVendedor;

type

  TModelResumoVendedorItens = class(TInterfacedObject, iModelResumoVendedorItens)
  private
    FNomeProd: String;
    FPesoTot : Double;
    FVlrTot  : Double;
    FQntReal : Integer;

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelResumoVendedorItens;

    function NomeProd(value: String): iModelResumoVendedorItens;
    function PesoTot(value: Double): iModelResumoVendedorItens;
    function QntReal(value: Integer): iModelResumoVendedorItens;
    function VlrTot(value: Double): iModelResumoVendedorItens;
    function BuscaProdVendidosServidor(dt_ini, dt_fim: tDatetime; vend: Integer; ADataSet: TFDMemTable)
      : iModelResumoVendedorItens;
    function PopulaProdVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorItens;
    function PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorItens;
    function LimpaTabelas: iModelResumoVendedorItens;

  end;

implementation

{ TModelResumoVendedorItens }

constructor TModelResumoVendedorItens.create;
begin

end;

destructor TModelResumoVendedorItens.destroy;
begin

  inherited;
end;

class function TModelResumoVendedorItens.new: iModelResumoVendedorItens;
begin
  result := self.create;
end;

function TModelResumoVendedorItens.NomeProd(value: String): iModelResumoVendedorItens;
begin
  result := self;
  FNomeProd := value;
end;

function TModelResumoVendedorItens.QntReal(value: Integer): iModelResumoVendedorItens;
begin
  result := self;
  FQntReal := value;
end;

function TModelResumoVendedorItens.VlrTot(value: Double): iModelResumoVendedorItens;
begin
  result := self;
  FVlrTot := value;
end;

function TModelResumoVendedorItens.PesoTot(value: Double): iModelResumoVendedorItens;
begin
  result := self;
  FPesoTot := value;
end;

function TModelResumoVendedorItens.LimpaTabelas: iModelResumoVendedorItens;
var
  qry: TFDQuery;
begin
  result := self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.ExecSQL('DELETE FROM RESUMOPRODTUOS')
  finally
    FreeAndNil(qry);
  end;
end;

function TModelResumoVendedorItens.PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorItens;
var
  x                        : Integer;
  qry                      : TFDQuery;
  item                     : TListViewItem;
  txt                      : TListItemText;
  qtd_tot, pes_tot, vlr_tot: Double;
begin

  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM RESUMOPRODTUOS ORDER BY VLR_TOT DESC');
    qry.Open;
    qry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 1 to 1 do
    begin
      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('lbl_produto'));
        txt.Text := 'PRODUTO';
        txt.TagString := '0';

        txt := TListItemText(Objects.FindDrawable('lbl_qntreal'));
        txt.Text := 'QNT.';

        txt := TListItemText(Objects.FindDrawable('lbl_pesotot'));
        txt.Text := 'PESO';

        txt := TListItemText(Objects.FindDrawable('lbl_vlrtot'));
        txt.Text := 'VALOR';

      end;
    end;

    for x := 1 to qry.RecordCount do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('PRODUTO'));
        txt.Text := qry.FieldByName('produto').AsString;
        txt.TagString := qry.FieldByName('produto').AsString;

        txt := TListItemText(Objects.FindDrawable('QNT_REAL'));
        txt.Text := formatFloat('000', qry.FieldByName('QTD_TOT').AsFloat);

        txt := TListItemText(Objects.FindDrawable('PESO_TOT'));
        txt.Text := formatFloat('0.000', qry.FieldByName('PES_TOT').AsFloat);

        txt := TListItemText(Objects.FindDrawable('VLR_TOT'));
        txt.Text := formatFloat('R$#,##0.00', qry.FieldByName('VLR_TOT').AsFloat);

      end;

      qtd_tot := qtd_tot + qry.FieldByName('QTD_TOT').AsFloat;
      pes_tot := pes_tot + qry.FieldByName('PES_TOT').AsFloat;
      vlr_tot := vlr_tot + qry.FieldByName('VLR_TOT').AsFloat;

      qry.Next
    end;

    AList.Add('Produtos Vendidos: ' + formatFloat('000', qtd_tot));
    AList.Add('Peso: ' + formatFloat('0.000', pes_tot));
    AList.Add('Valor: ' + formatFloat('R$#,##0.00', vlr_tot));

  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;
end;

function TModelResumoVendedorItens.PopulaProdVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorItens;
var
  i  : Integer;
  qry: TFDQuery;
begin
  result := self;

  qry := TFDQuery.create(nil);
  qry.Connection := DmDados.ConexaoInterna;
  qry.FetchOptions.RowsetSize := 50000;
  ADataSet.First;
  try
    qry.Active := false;
    for i := 0 to ADataSet.RecordCount - 1 do
    begin
      qry.SQL.Clear;
      qry.SQL.Add(' INSERT INTO RESUMOPRODTUOS ( PRODUTO, QTD_TOT, PES_TOT, VLR_TOT) VALUES ' +
        '( :PRODUTO, :QTD_TOT, :PES_TOT, :VLR_TOT)');

      qry.ParamByName('PRODUTO').AsString := ADataSet.FieldByName('produto').AsString;
      qry.ParamByName('PES_TOT').AsFloat := ADataSet.FieldByName('pes_tot').AsFloat;
      qry.ParamByName('VLR_TOT').AsFloat := ADataSet.FieldByName('vlr_tot').AsFloat;
      qry.ParamByName('QTD_TOT').asInteger := ADataSet.FieldByName('qtd_tot').asInteger;
      qry.ExecSQL;
      ADataSet.Next;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TModelResumoVendedorItens.BuscaProdVendidosServidor(dt_ini, dt_fim: tDatetime; vend: Integer; ADataSet: TFDMemTable)
  : iModelResumoVendedorItens;
var
  i         : Integer;
  rdwSQLTemp: TRESTDWClientSQL;
begin
  result := self;
  try
    rdwSQLTemp := TRESTDWClientSQL.create(nil);
    rdwSQLTemp.DataBase := DmDados.RESTDWDataBase1;
    rdwSQLTemp.BinaryRequest := True;
    rdwSQLTemp.FormatOptions.MaxStringSize := 10000;
    rdwSQLTemp.Active := false;
    rdwSQLTemp.SQL.Clear;
    rdwSQLTemp.SQL.Add
      (' SELECT REPLICATE(''0'', (6-LEN(CAST(TI.COD_PROD AS VARCHAR))))+CAST(TI.COD_PROD AS VARCHAR)+'' - ''+TPR.DESC_IND AS PRODUTO, '
      + ' ISNULL(SUM(TH.QTD_TOT), 0) AS QTD_TOT, ISNULL(SUM(TH.PES_TOT), 0) AS PES_TOT, ISNULL(SUM(ROUND(CONVERT(NUMERIC(14, 4), ISNULL(CASE TPR.TIPO_CALC WHEN 0 THEN TH.PES_TOT WHEN 1 THEN TH.QTD_TOT END, 0)*(TI.PRECO_UNIT-TI.DESCONTO)), 2)), 0) AS VLR_TOT '
      + ' FROM T_PEDIDOVENDA TP LEFT OUTER JOIN V_PESSOA TC ON (TP.COD_CLIENTE = TC.COD_PESSOA) LEFT OUTER JOIN V_PRESTADOR TS ON (TP.COD_PREST = TS.COD_PREST) '
      + ' LEFT OUTER JOIN T_CENTRO_CUSTO TU ON (TP.COD_CC = TU.COD_CC) LEFT OUTER JOIN T_VENDEDOR TV ON (TP.COD_VEND = TV.COD_VEND), '
      + ' T_PEDIDOVENDAITENS TI LEFT OUTER JOIN T_PRODUTO TPR ON (TPR.COD_PROD = TI.COD_PROD) LEFT OUTER JOIN T_MATERIA_PRIMA TMP ON (TMP.COD_MATERIA = TPR.MAT_PRIMA) '
      + ' LEFT OUTER JOIN (SELECT TT.COD_PEDCAR, TT.NUM_ITEM, ISNULL(COUNT(TT.COD_PEDCAR), 0)+ISNULL(SUM(TM.QUANT)-COUNT(TM.ITEM_PES), 0) AS QTD_TOT, ISNULL(SUM(TT.PESO), 0) AS PES_TOT FROM T_TENDAL TT '
      + ' LEFT OUTER JOIN T_TENDAL_MULTI TM ON (TT.COD_PEDCAR = TM.COD_PEDCAR AND TT.NUM_ITEM = TM.NUM_ITEM AND TT.ITEM_PES = TM.ITEM_PES) GROUP BY TT.COD_PEDCAR, TT.NUM_ITEM) TH ON (TH.COD_PEDCAR = TI.COD_PEDCAR AND TH.NUM_ITEM = TI.NUM_ITEM) '
      + ' WHERE TP.COD_PEDCAR = TI.COD_PEDCAR ' + ' AND TP.STATUS <> 4 ' + ' AND TP.COD_VEND = ' + IntToStr(vend) +
      ' AND TP.DATA_PED BETWEEN ' + QuotedStr(DateTimeToStr(dt_ini)) + ' AND ' + QuotedStr(DateTimeToStr(dt_fim)) +
      ' GROUP BY TI.COD_PROD, TPR.DESC_IND, TPR.TIPO_CALC, TP.COD_VEND ' + ' ORDER BY TPR.DESC_IND ');

    rdwSQLTemp.Active := True;
    rdwSQLTemp.RecordCount;
    ADataSet.CopyDataSet(rdwSQLTemp, [coStructure, coRestart, coAppend]);

  finally
    FreeAndNil(rdwSQLTemp);
  end;
end;

end.
