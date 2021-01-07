unit G2Mobile.Model.TitulosCliente;

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
  uFrmUtilFormate,
  Form_Mensagem,
  FMX.Grid,
  G2Mobile.Controller.Clientes;

const

  CONST_DELETETITULOS = ' DELETE FROM titulos_cliente';

  CONST_DELETEITENSTITULO = ' DELETE FROM venda_titulos';

  CONST_BUSCATITULOSCLIENTE =
    ' SELECT c.num_ped, CAST( c.parcela AS varchar) + ''/''   + CAST(c.num_parc  AS varchar)as parcelas, c.data_venc, c.data_emis, c.vlr_tit, c.cod_cliente, p.cod_vend, '
    + ' case when (select dateadd(day, dias_carencia, c.data_venc) from t_config where dias_carencia is not null)  <= getdate() and status = ''A''  then ''V'' else status end as status '
    + ' FROM v_contas_receb c left outer join t_pessoa p on (c.cod_cliente = p.cod_pessoa) where c.num_ped is not null and c.status = ''A''  ';

  CONST_BUSCAITENSTITULO = ' select ti.cod_pedcar, ti.cod_prod, ' + ' isnull(sum(ti.quantidade), 0) as qtd_ped, ' +
    ' isnull(sum(th.qtd_tot), 0) as qtd_tot, ' + ' isnull(sum(th.pes_tot), 0) as pes_tot, ' +
    ' isnull(sum(ti.preco_unit), 0) as vlr_unit, ' + ' ti.tipo_pes AS unid, ' +
    ' isnull(sum(round(convert(numeric(14, 4), isnull(case tpr.tipo_calc when 0 then th.pes_tot when 1 then th.qtd_tot end, 0)*(ti.preco_unit-ti.desconto)), 2)), 0) as vlr_tot '
    + ' from t_pedidovenda tp left outer join v_pessoa tc on (tp.cod_cliente = tc.cod_pessoa) left outer join v_prestador ts on (tp.cod_prest = ts.cod_prest) '
    + ' left outer join t_centro_custo tu on (tp.cod_cc = tu.cod_cc) left outer join t_vendedor tv on (tp.cod_vend = tv.cod_vend), '
    + ' t_pedidovendaitens ti ' + ' left outer join t_produto tpr on (tpr.cod_prod = ti.cod_prod) ' +
    ' left outer join (select tt.cod_pedcar, tt.num_item, isnull(count(tt.cod_pedcar), 0)+isnull(sum(tm.quant)-count(tm.item_pes), 0) as qtd_tot, isnull(sum(tt.peso), 0) as pes_tot from t_tendal tt '
    + ' left outer join t_tendal_multi tm on (tt.cod_pedcar = tm.cod_pedcar and tt.num_item = tm.num_item and tt.item_pes = tm.item_pes) group by tt.cod_pedcar, tt.num_item) th on (th.cod_pedcar = ti.cod_pedcar and th.num_item = ti.num_item) '
    + ' where tp.cod_pedcar = ti.cod_pedcar ' +
    ' and ti.cod_pedcar  in (select num_ped from v_contas_receb c left outer join t_pessoa p on (c.cod_cliente = p.cod_pessoa) where  status = ''A''';

  CONST_INSERTTITULOSCLIENTES =
    ' INSERT INTO titulos_cliente (num_ped, parcelas, data_venc, data_emis, vlr_tit, status, cod_cliente, cod_vend) VALUES '
    + ' (:num_ped, :parcelas, :data_venc, :data_emis, :vlr_tit, :status, :cod_cliente, :cod_vend) ';

  CONST_INSERTITENSTITULO =
    ' INSERT INTO venda_titulos (cod_pedcar, cod_prod, qtd_ped, qtd_tot, pes_tot, vlr_tot, unid, vlr_unit) VALUES ' +
    ' (:cod_pedcar, :cod_prod, :qtd_ped, :qtd_tot, :pes_tot, :vlr_tot, :unid, :vlr_unit) ';

  CONST_POPULALISTVIEWTITULO = 'SELECT * FROM titulos_cliente WHERE COD_CLIENTE = :COD_CLIENTE';

  CONST_POPULALISTVIEWITENSTITULO =
    'select v.*, p.desc_ind from venda_titulos v left outer join produto p on (v.cod_prod = p.cod_prod) where cod_pedcar = :codpedcar';

type

  TModelTitulosCliente = class(TInterfacedObject, iModelTitulosCliente)
  private
    FQry       : TFDQuery;
    FRdwSQLTemp: TRESTDWClientSQL;

    FCodVend   : Integer;
    FCodCliente: Integer;
    FCodPedcar : Integer;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelTitulosCliente;

    function CodVend(value: Integer): iModelTitulosCliente;
    function CodCliente(value: Integer): iModelTitulosCliente;
    function CodPedcar(value: Integer): iModelTitulosCliente;
    function DeleteTitulos: iModelTitulosCliente;
    function DeleteItensTitulo: iModelTitulosCliente;
    function BuscaTitulosServidor(DataSet: TFDMemTable): iModelTitulosCliente;
    function BuscaItensTituloServidor(DataSet: TFDMemTable): iModelTitulosCliente;
    function GravaTitulosSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
    function GravaItensTituloSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
    function PopulaListView(value: TListView; aberta, vencida: Timage): iModelTitulosCliente;
    function PopulaItemTituloStringGrid(Grid: TStringGrid): iModelTitulosCliente;
  end;

implementation

{ TModelTitulosCliente }

class function TModelTitulosCliente.new: iModelTitulosCliente;
begin
  result := self.create;
end;

constructor TModelTitulosCliente.create;
begin
  FQry := TFDQuery.create(nil);
  FQry.Connection := DmDados.ConexaoInterna;
  FQry.FetchOptions.RowsetSize := 50000;
  FQry.Active := false;
  FQry.SQL.Clear;

  FRdwSQLTemp := TRESTDWClientSQL.create(nil);
  FRdwSQLTemp.DataBase := DmDados.RESTDWDataBase1;
  FRdwSQLTemp.BinaryRequest := True;
  FRdwSQLTemp.FormatOptions.MaxStringSize := 10000;
  FRdwSQLTemp.Active := false;
  FRdwSQLTemp.SQL.Clear;
end;

destructor TModelTitulosCliente.destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(FRdwSQLTemp);
  inherited;
end;

function TModelTitulosCliente.DeleteTitulos: iModelTitulosCliente;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETETITULOS);
end;

function TModelTitulosCliente.DeleteItensTitulo: iModelTitulosCliente;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETEITENSTITULO);
end;

function TModelTitulosCliente.BuscaTitulosServidor(DataSet: TFDMemTable): iModelTitulosCliente;
begin
  result := self;

  FRdwSQLTemp.SQL.Add(CONST_BUSCATITULOSCLIENTE);
  if FCodVend <> 0 then
    FRdwSQLTemp.SQL.Add(' and p.cod_vend = ' + FCodVend.ToString);
  FRdwSQLTemp.Active := True;
  FRdwSQLTemp.RecordCount;
  DataSet.CopyDataSet(FRdwSQLTemp, [coStructure, coRestart, coAppend]);
end;

function TModelTitulosCliente.CodCliente(value: Integer): iModelTitulosCliente;
begin
  result := self;
  FCodCliente := value;
end;

function TModelTitulosCliente.CodPedcar(value: Integer): iModelTitulosCliente;
begin
  result := self;
  FCodPedcar := value;
end;

function TModelTitulosCliente.CodVend(value: Integer): iModelTitulosCliente;
begin
  result := self;
  FCodVend := value;
end;

function TModelTitulosCliente.GravaTitulosSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
var
  I: Integer;
begin
  result := self;

  DataSet.First;
  FQry.Active := false;
  for I := 0 to DataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_INSERTTITULOSCLIENTES;
    FQry.ParamByName('num_ped').AsInteger := DataSet.FieldByName('num_ped').AsInteger;
    FQry.ParamByName('parcelas').AsString := DataSet.FieldByName('parcelas').AsString;
    FQry.ParamByName('data_venc').AsDateTime := DataSet.FieldByName('data_venc').AsDateTime;
    FQry.ParamByName('data_emis').AsDateTime := DataSet.FieldByName('data_emis').AsDateTime;
    FQry.ParamByName('vlr_tit').AsFloat := DataSet.FieldByName('vlr_tit').AsFloat;
    FQry.ParamByName('status').AsString := DataSet.FieldByName('status').AsString;
    FQry.ParamByName('cod_cliente').AsInteger := DataSet.FieldByName('cod_cliente').AsInteger;
    FQry.ParamByName('cod_vend').AsInteger := DataSet.FieldByName('cod_vend').AsInteger;
    FQry.ExecSQL;
    DataSet.Next;
  end;
end;

function TModelTitulosCliente.BuscaItensTituloServidor(DataSet: TFDMemTable): iModelTitulosCliente;
begin
  result := self;

  FRdwSQLTemp.SQL.Add(CONST_BUSCAITENSTITULO);
  if FCodVend <> 0 then
    FRdwSQLTemp.SQL.Add(' and p.cod_vend = ' + FCodVend.ToString);
  FRdwSQLTemp.SQL.Add(') group by ti.cod_prod,  tpr.tipo_calc, ti.cod_pedcar, ti.tipo_pes ');
  FRdwSQLTemp.Active := True;
  FRdwSQLTemp.RecordCount;
  DataSet.CopyDataSet(FRdwSQLTemp, [coStructure, coRestart, coAppend]);
end;

function TModelTitulosCliente.GravaItensTituloSqlite(DataSet: TFDMemTable): iModelTitulosCliente;
var
  I: Integer;
begin
  result := self;

  DataSet.First;
  FQry.Active := false;
  for I := 0 to DataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_INSERTITENSTITULO;
    FQry.ParamByName('cod_pedcar').AsInteger := DataSet.FieldByName('cod_pedcar').AsInteger;
    FQry.ParamByName('cod_prod').AsInteger := DataSet.FieldByName('cod_prod').AsInteger;
    FQry.ParamByName('qtd_ped').AsInteger := DataSet.FieldByName('qtd_ped').AsInteger;
    FQry.ParamByName('qtd_tot').AsInteger := DataSet.FieldByName('qtd_tot').AsInteger;
    FQry.ParamByName('unid').AsInteger := DataSet.FieldByName('unid').AsInteger;
    FQry.ParamByName('vlr_unit').AsFloat := DataSet.FieldByName('vlr_unit').AsFloat;
    FQry.ParamByName('vlr_tot').AsFloat := DataSet.FieldByName('vlr_tot').AsFloat;
    FQry.ParamByName('pes_tot').AsFloat := DataSet.FieldByName('pes_tot').AsFloat;
    FQry.ExecSQL;
    DataSet.Next;
  end;
end;

function TModelTitulosCliente.PopulaListView(value: TListView; aberta, vencida: Timage): iModelTitulosCliente;
var
  x    : Integer;
  item : TListViewItem;
  txt  : TListItemText;
  img  : TListItemImage;
  color: Cardinal;
begin

  result := self;

  try

    FQry.SQL.Text := CONST_POPULALISTVIEWTITULO;
    FQry.ParamByName('COD_CLIENTE').AsInteger := FCodCliente;
    FQry.Open;
    FQry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 0 to FQry.RecordCount - 1 do
    begin

      item := value.Items.Add;
      if FQry.FieldByName('status').AsString.Equals('A') then
        color := $FF3498DB
      else
        color := $FFFF0000;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('codped'));

        txt.Text := formatfloat('0000', FQry.FieldByName('num_ped').AsFloat);
        txt.TagString := FQry.FieldByName('num_ped').AsString;
        txt.TextColor := color;

        txt := TListItemText(Objects.FindDrawable('status'));
        if FQry.FieldByName('status').AsString.Equals('A') then
          txt.Text := 'Status: ABERTO'
        else
          txt.Text := 'Status: VENCIDO';
        txt.TextColor := color;

        txt := TListItemText(Objects.FindDrawable('parcelas'));
        txt.Text := 'Parcelas: ' + FQry.FieldByName('parcelas').AsString;
        txt.TextColor := color;

        txt := TListItemText(Objects.FindDrawable('validade'));
        txt.Text := 'Dt. Venc.: ' + FormatDateTime('DD/MM/YYYY', FQry.FieldByName('data_venc').AsDateTime);
        txt.TextColor := color;

        txt := TListItemText(Objects.FindDrawable('valor'));
        txt.Text := 'Valor: ' + formatfloat('R$#,##0.00', FQry.FieldByName('vlr_tit').AsFloat);
        txt.TextColor := color;

        txt := TListItemText(Objects.FindDrawable('datapedido'));
        txt.Text := 'Dt. Ped.: ' + FormatDateTime('DD/MM/YYYY', FQry.FieldByName('data_emis').AsDateTime);
        txt.TextColor := color;
        img := TListItemImage(Objects.FindDrawable('Image7'));
        if FQry.FieldByName('status').AsString.Equals('A') then
          img.Bitmap := aberta.Bitmap
        else
          img.Bitmap := vencida.Bitmap

      end;
      FQry.Next
    end;
  finally
    value.EndUpdate;
  end;
end;

function TModelTitulosCliente.PopulaItemTituloStringGrid(Grid: TStringGrid): iModelTitulosCliente;
var
  I: Integer;
begin
  result := self;

  FQry.SQL.Text := CONST_POPULALISTVIEWITENSTITULO;
  FQry.ParamByName('codpedcar').AsInteger := FCodPedcar;
  FQry.Open;
  for I := 0 to FQry.RecordCount - 1 do
  begin
    with Grid do
    begin

      RowCount := RowCount + 1;
      Row := RowCount - 1;

      Cells[0, Row] := FQry.FieldByName('cod_prod').AsString;
      Cells[1, Row] := FQry.FieldByName('desc_ind').AsString;
      case FQry.FieldByName('unid').AsInteger of
        0:
          Cells[2, Row] := 'UND';
        1:
          Cells[2, Row] := 'PESO';
      end;
      Cells[3, Row] := formatfloat('0000', FQry.FieldByName('qtd_ped').AsFloat);
      Cells[4, Row] := formatfloat('0000', FQry.FieldByName('qtd_tot').AsFloat);
      Cells[5, Row] := formatfloat('#,##0.000', FQry.FieldByName('pes_tot').AsFloat);
      Cells[6, Row] := formatfloat('#,##0.00', FQry.FieldByName('vlr_unit').AsFloat);
      Cells[7, Row] := formatfloat('#,##0.00', FQry.FieldByName('vlr_tot').AsFloat);
    end;
    FQry.Next;
  end;
end;

end.
