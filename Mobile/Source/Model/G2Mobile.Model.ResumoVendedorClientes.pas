unit G2Mobile.Model.ResumoVendedorClientes;

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
  G2Mobile.Controller.ResumoVendedor;

type

  TModelResumoVendedorClientes = class(TInterfacedObject, iModelResumoVendedorClientes)
  private
    FCodVend: Integer;
    FPesoTot: Double;
    FVlrTot : Double;
    FQntReal: Integer;

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelResumoVendedorClientes;

    function CodVend(value: Integer): iModelResumoVendedorClientes;
    function PesoTot(value: Double): iModelResumoVendedorClientes;
    function VlrTot(value: Double): iModelResumoVendedorClientes;
    function QntReal(value: Integer): iModelResumoVendedorClientes;
    function BuscaClienteVendidosServidor(dt_ini, dt_fim: TDatetime; vend: Integer; ADataSet: TFDMemTable)
      : iModelResumoVendedorClientes;
    function PopulaClienteVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorClientes;
    function PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorClientes;
    function LimpaTabelas: iModelResumoVendedorClientes;

  end;

implementation

{ TResumoVendedorItens }

{ TModelResumoVendedorClientes }

class function TModelResumoVendedorClientes.new: iModelResumoVendedorClientes;
begin
  result := self.create;
end;

constructor TModelResumoVendedorClientes.create;
begin

end;

destructor TModelResumoVendedorClientes.destroy;
begin

  inherited;
end;

function TModelResumoVendedorClientes.CodVend(value: Integer): iModelResumoVendedorClientes;
begin
  result := self;
  FCodVend := value;
end;

function TModelResumoVendedorClientes.QntReal(value: Integer): iModelResumoVendedorClientes;
begin
  result := self;
  FQntReal := value;
end;

function TModelResumoVendedorClientes.VlrTot(value: Double): iModelResumoVendedorClientes;
begin
  result := self;
  FVlrTot := value;
end;

function TModelResumoVendedorClientes.PesoTot(value: Double): iModelResumoVendedorClientes;
begin
  result := self;
  FPesoTot := value;
end;

function TModelResumoVendedorClientes.LimpaTabelas: iModelResumoVendedorClientes;
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
    qry.ExecSQL('delete from ResumoClientes')
  finally
    FreeAndNil(qry);
  end;
end;

function TModelResumoVendedorClientes.PopulaClienteVendidoSqLite(ADataSet: TFDMemTable): iModelResumoVendedorClientes;
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
      qry.SQL.Add(' INSERT INTO ResumoClientes ( cod_cliente, qtd_tot, pes_tot, vlr_tot, qtd_ped) VALUES ' +
        '( :cod_cliente, :qtd_tot, :pes_tot, :vlr_tot, :qtd_ped)');

      qry.ParamByName('cod_cliente').AsString := ADataSet.FieldByName('cod_cliente').AsString;
      qry.ParamByName('pes_tot').AsFloat := ADataSet.FieldByName('pes_tot').AsFloat;
      qry.ParamByName('vlr_tot').AsFloat := ADataSet.FieldByName('vlr_tot').AsFloat;
      qry.ParamByName('qtd_tot').asInteger := ADataSet.FieldByName('qtd_tot').asInteger;
      qry.ParamByName('qtd_ped').asInteger := ADataSet.FieldByName('qtd_ped').asInteger;
      qry.ExecSQL;
      ADataSet.Next;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

function TModelResumoVendedorClientes.PopulaListView(value: TListView; AList: TStringList): iModelResumoVendedorClientes;
var
  x                        : Integer;
  qry                      : TFDQuery;
  item                     : TListViewItem;
  txt                      : TListItemText;
  qtd_ped, pes_tot, vlr_tot: Double;
begin

  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('SELECT rc.*, c.nome_fant as cliente FROM ResumoClientes rc left outer join cliente c on (c.cod_pessoa = rc.cod_cliente) order by vlr_tot desc');
    qry.Open;
    qry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 1 to 1 do
    begin
      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('lbl_cliente'));
        txt.Text := 'CLIENTE';
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
        txt := TListItemText(Objects.FindDrawable('CLIENTE'));
        txt.Text := qry.FieldByName('cliente').AsString;
        txt.TagString := qry.FieldByName('cliente').AsString;

        txt := TListItemText(Objects.FindDrawable('QNT_REAL'));
        txt.Text := formatFloat('000', qry.FieldByName('QTD_PED').AsFloat);

        txt := TListItemText(Objects.FindDrawable('PESO_TOT'));
        txt.Text := formatFloat('0.000', qry.FieldByName('PES_TOT').AsFloat);

        txt := TListItemText(Objects.FindDrawable('VLR_TOT'));
        txt.Text := formatFloat('R$#,##0.00', qry.FieldByName('VLR_TOT').AsFloat);

      end;

      qtd_ped := qtd_ped + qry.FieldByName('QTD_PED').AsFloat;
      pes_tot := pes_tot + qry.FieldByName('PES_TOT').AsFloat;
      vlr_tot := vlr_tot + qry.FieldByName('VLR_TOT').AsFloat;

      qry.Next
    end;

    AList.Add('Pedidos: ' + formatFloat('000', qtd_ped));
    AList.Add('Peso: ' + formatFloat('0.000', pes_tot));
    AList.Add('Valor: ' + formatFloat('R$#,##0.00', vlr_tot));

  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;
end;

function TModelResumoVendedorClientes.BuscaClienteVendidosServidor(dt_ini, dt_fim: TDatetime; vend: Integer;
  ADataSet: TFDMemTable): iModelResumoVendedorClientes;
var
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
    rdwSQLTemp.SQL.Add(' select tp.cod_cliente, ' + ' isnull(sum(th.qtd_tot), 0) as qtd_tot, ' +
      ' isnull(sum(th.pes_tot), 0) as pes_tot, ' +
      ' isnull(sum(round(convert(numeric(14, 4), isnull(case tpr.tipo_calc when 0 then th.pes_tot when 1 then th.qtd_tot end, 0)*(ti.preco_unit-ti.desconto)), 2)), 0) as vlr_tot, '
      + ' isnull(sum(ti.quantidade), 0) as qtd_ped   from t_pedidovenda tp ' +
      ' left outer join v_pessoa tc on (tp.cod_cliente = tc.cod_pessoa) ' +
      ' left outer join v_prestador ts on (tp.cod_prest = ts.cod_prest) ' +
      ' left outer join t_centro_custo tu on (tp.cod_cc = tu.cod_cc) ' +
      ' left outer join t_vendedor tv on (tp.cod_vend = tv.cod_vend), ' + ' t_pedidovendaitens ti ' +
      ' left outer join t_produto tpr on (tpr.cod_prod = ti.cod_prod) ' +
      ' left outer join t_materia_prima tmp on (tmp.cod_materia = tpr.mat_prima) ' +
      ' left outer join (select tt.cod_pedcar, tt.num_item, isnull(count(tt.cod_pedcar), 0)+isnull(sum(tm.quant)-count(tm.item_pes), 0) as qtd_tot, isnull(sum(tt.peso), 0) as pes_tot from t_tendal tt '
      + ' left outer join t_tendal_multi tm on (tt.cod_pedcar = tm.cod_pedcar and tt.num_item = tm.num_item and tt.item_pes = tm.item_pes) group by tt.cod_pedcar, tt.num_item) th on (th.cod_pedcar = ti.cod_pedcar and th.num_item = ti.num_item) '
      + ' where tp.cod_pedcar = ti.cod_pedcar ' + ' and tp.status <> 4 ' + ' and tp.cod_vend = ' + IntToStr(vend) +
      ' and tp.data_ped between ' + QuotedStr(DateTimeToStr(dt_ini)) + ' and ' + QuotedStr(DateTimeToStr(dt_fim)) +
      ' group by  tp.cod_vend, tp.cod_cliente,tc.nome_fant ' + ' order by tp.cod_cliente ');

    rdwSQLTemp.Active := True;
    rdwSQLTemp.RecordCount;
    ADataSet.CopyDataSet(rdwSQLTemp, [coStructure, coRestart, coAppend]);

  finally
    FreeAndNil(rdwSQLTemp);
  end;
end;

end.
