unit uClasseExportarPedidos;

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
  uInterfaceExportarPedidos;

const

  CONST_DELETEITEMATUALIZADO = ' DELETE FROM itens_atualizado';

  CONST_BUSCAATUALIZACAOPEDIDOS =
    ' select ti.cod_pedcar, ti.cod_prod, ti.chave, tpv.valor_final, tpv.status, tcp.motivo, ' +
    ' isnull(sum(th.qtd_tot), 0) as qtd_tot, isnull(sum(th.pes_tot), 0) as pes_tot, ' +
    ' isnull(sum(round(convert(numeric(14, 4), isnull(case tpr.tipo_calc when 0 then th.pes_tot when 1 then th.qtd_tot end, 0)*(ti.preco_unit-ti.desconto)), 2)), 0) as vlr_tot, '
    + ' isnull(sum(ti.quantidade), 0) as qtd_ped ' +
    ' from t_pedidovenda tp left outer join v_pessoa tc on (tp.cod_cliente = tc.cod_pessoa) left outer join v_prestador ts on (tp.cod_prest = ts.cod_prest) '
    + ' left outer join t_centro_custo tu on (tp.cod_cc = tu.cod_cc) left outer join t_vendedor tv on (tp.cod_vend = tv.cod_vend), '
    + ' t_pedidovendaitens ti ' + ' left outer join t_pedido_cancel tcp on (ti.cod_pedcar = tcp.cod_pedcar) ' +
    ' left outer join t_pedidovenda tpv on (tpv.cod_pedcar = ti.cod_pedcar) ' +
    ' left outer join t_produto tpr on (tpr.cod_prod = ti.cod_prod) ' +
    ' left outer join t_materia_prima tmp on (tmp.cod_materia = tpr.mat_prima) ' +
    ' left outer join (select tt.cod_pedcar, tt.num_item, isnull(count(tt.cod_pedcar), 0)+isnull(sum(tm.quant)-count(tm.item_pes), 0) as qtd_tot, isnull(sum(tt.peso), 0) as pes_tot from t_tendal tt '
    + ' left outer join t_tendal_multi tm on (tt.cod_pedcar = tm.cod_pedcar and tt.num_item = tm.num_item and tt.item_pes = tm.item_pes) group by tt.cod_pedcar, tt.num_item) th on (th.cod_pedcar = ti.cod_pedcar and th.num_item = ti.num_item) '
    + ' where tp.cod_pedcar = ti.cod_pedcar ' + ' and ti.chave in( ';

  CONST_PEDIDOSSINCRONIZADOS = 'select chave from venda where sincronizado = 1';

  CONST_INSERTPEDIDOATUALIZADO =
    ' INSERT INTO itens_atualizado (chave, cod_pedcar, cod_prod, qtd_ped, qtd_tot, pes_tot, vlr_tot, valor_final, motivo, status) VALUES '
    + ' (:chave, :cod_pedcar, :cod_prod, :qtd_ped, :qtd_tot, :pes_tot, :vlr_tot, :valor_final, :motivo, :status) ';

type

  TExportPedido = class(TInterfacedObject, iModelExportarPedidos)
  private
    FQry: TFDQuery;
    FRdwSQLTemp: TRESTDWClientSQL;

    FString: String;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelExportarPedidos;

    function DeleteItemAtualizado: iModelExportarPedidos;
    function BuscaInfoAtualizadaServidor(DataSet: TFDMemTable): iModelExportarPedidos;
    function GravaInfoAtulizadoPedidoSqlite(DataSet: TFDMemTable): iModelExportarPedidos;
    function VerificaPedidosSincronizadosSqlite: iModelExportarPedidos;
  end;

implementation

{ TParametros }

class function TExportPedido.new: iModelExportarPedidos;
begin
  result := self.create;
end;

constructor TExportPedido.create;
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

destructor TExportPedido.destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(FRdwSQLTemp);
  inherited;
end;

function TExportPedido.DeleteItemAtualizado: iModelExportarPedidos;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETEITEMATUALIZADO);
end;

function TExportPedido.VerificaPedidosSincronizadosSqlite: iModelExportarPedidos;
var
  I: Integer;
begin
  result := self;
  FString := EmptyStr;
  FQry.Open(CONST_PEDIDOSSINCRONIZADOS);

  if FQry.IsEmpty then
  begin
    FQry.SQL.Add(QuotedStr('') + ' ) ');
  end
  else
  begin
    for I := 0 to FQry.RecordCount - 1 do
    begin

      FString := FString +  QuotedStr(FQry.FieldByName('chave').AsString);

      if I <> FQry.RecordCount - 1 then
        FString := FString + ', ';

      FQry.Next;
    end;
    FString := FString + ' )';
  end;

end;

function TExportPedido.BuscaInfoAtualizadaServidor(DataSet: TFDMemTable): iModelExportarPedidos;
begin
  result := self;

  FRdwSQLTemp.SQL.Text := CONST_BUSCAATUALIZACAOPEDIDOS + FString +
    ' group by ti.cod_prod, tpr.desc_ind, tpr.tipo_calc,  tpv.status, tpv.valor_final,ti.cod_pedcar,ti.chave, tcp.motivo '
    + ' order by tpr.desc_ind ';
  FRdwSQLTemp.Active := True;
  FRdwSQLTemp.RecordCount;
  DataSet.CopyDataSet(FRdwSQLTemp, [coStructure, coRestart, coAppend]);
end;

function TExportPedido.GravaInfoAtulizadoPedidoSqlite(DataSet: TFDMemTable): iModelExportarPedidos;
var
  I: Integer;
begin
  result := self;

  DataSet.First;
  FQry.Active := false;
  for I := 0 to DataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_INSERTPEDIDOATUALIZADO;
    FQry.ParamByName('chave').AsString := DataSet.FieldByName('chave').AsString;
    FQry.ParamByName('cod_pedcar').AsInteger := DataSet.FieldByName('cod_pedcar').AsInteger;
    FQry.ParamByName('cod_prod').AsInteger := DataSet.FieldByName('cod_prod').AsInteger;
    FQry.ParamByName('qtd_ped').AsFloat := DataSet.FieldByName('qtd_ped').AsFloat;
    FQry.ParamByName('qtd_tot').AsFloat := DataSet.FieldByName('qtd_tot').AsFloat;
    FQry.ParamByName('pes_tot').AsFloat := DataSet.FieldByName('pes_tot').AsFloat;
    FQry.ParamByName('vlr_tot').AsFloat := DataSet.FieldByName('vlr_tot').AsFloat;
    FQry.ParamByName('valor_final').AsFloat := DataSet.FieldByName('valor_final').AsFloat;
    FQry.ParamByName('motivo').AsString := DataSet.FieldByName('motivo').AsString;
    FQry.ParamByName('status').AsInteger := DataSet.FieldByName('status').AsInteger;
    FQry.ExecSQL;
    DataSet.Next;
  end;
end;

end.
