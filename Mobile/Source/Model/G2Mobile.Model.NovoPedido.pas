unit G2Mobile.Model.NovoPedido;

interface

uses
  FMX.Objects,
  FMX.ListView,
  FireDAC.Comp.Client,
  uDmDados,
  System.SysUtils,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.Graphics,
  System.Classes,
  FMX.Grid, G2Mobile.Controller.Pedidos;

const

  CONST_POPULALISTPEDIDOS =
' select substr(''0000''||c.cod_pessoa, -4, 4)|| '' - '' || c.nome_fant  as nome_fant, c.nome_razao,  strftime(''%d/%m/%Y'',v.emissao) as emissao, '+
' strftime(''%d/%m/%Y'',v.data_emb) as data_emb, case v.comissao when 1 then ''SIM'' ELSE ''NÃO'' END as comissao, '+
' case  when v.sincronizado = 1 and i.status = 3 then 1 /*Pedido já Faturado!*/ '+
' when v.sincronizado = 1 and i.status = 4 then 2 /*Pedido Reprovado/Cancelado!*/ '+
' when v.sincronizado = 1  then 3 /*Pedido sincronizado com o servidor!*/ '+
' when v.sincronizado = 0 then 4 /*Sincronismo de envio pendente!*/ '+
' END as situacao ,   v.chave from venda v left outer join cliente c on (v.cod_cliente = c.cod_pessoa) '+
' left outer join formapagto f on (v.formapagto = f.cod_forma) '+
' left outer join itens_atualizado i on (i.chave = v.chave) ';



  CONST_INFOPEDIDO = ' SELECT IFNULL( IA.MOTIVO, '''') MOTIVO,' +
    ' CASE WHEN V.FORMAPAGTO = 0 THEN ''0000 - a vista'' else   SUBSTR(''0000''||V.FORMAPAGTO, -4, 4) || '' - '' || P.DESCRICAO end as PAGAMENTO, '
    + ' CASE  WHEN IA.cod_pedcar IS NULL THEN ''NÃO GERADO!'' ELSE IA.cod_pedcar END AS COD_RET, ' +
    ' STRFTIME(''%d/%m/%Y'', V.DATA_EMB) as DATA_EMB, ' +
    ' SUBSTR(''0000''||V.COD_CLIENTE, -4, 4)|| '' - ''|| TRIM(C.NOME_FANT) AS NOME_FANT, ' +
    ' STRFTIME(''%d/%m/%Y %H:%M'', V.EMISSAO) AS EMISSAO, ' +
    ' SUBSTR(''0000''||V.COD_CAMARA, -4, 4)|| '' - ''|| CF.DESCRICAO AS CAMARA, ' +
    ' CASE V.COMISSAO WHEN 1 THEN ''SIM'' ELSE ''NÃO'' END AS COMISSAO, ' +
    ' CASE  WHEN V.SINCRONIZADO = 1 AND IA.status = 3 THEN ''FATURADO'' WHEN V.SINCRONIZADO = 1 AND  IA.status = 4 THEN  ''REPROVADO'' WHEN V.SINCRONIZADO = 1  THEN ''ENVIADO'' else ''PENDENTE'' END AS SITUACAO, '
    + ' V.TOTAL,  IFNULL(IA.VALOR_FINAL, 0) VALOR_FINAL, ' + ' V.OBS ' + ' FROM VENDA  V ' +
    ' LEFT OUTER JOIN FORMAPAGTO P ON (V.FORMAPAGTO = P.COD_FORMA) ' +
    ' LEFT OUTER JOIN CLIENTE C ON (C.COD_PESSOA = V.COD_CLIENTE) ' +
    ' LEFT OUTER JOIN CAMARA_FRIA CF ON (CF.COD_CAMARA = V.COD_CAMARA) ' +
    ' LEFT OUTER JOIN ITENS_ATUALIZADO IA ON (V.chave = IA.CHAVE) ' + ' where V.CHAVE = :CHAVE ';

  CONST_INSERTPEDIDO =
    ' INSERT INTO venda (chave, formapagto, cod_camara, cod_user, cod_vendedor, cod_cliente, emissao, data_emb, ' +
    ' valor, desconto, total, situacao, sincronizado, comissao,latitude,longitude, Obs) VALUES ' +
    ' (:chave, :formapagto, :cod_camara, :cod_user, :cod_vendedor, :cod_cliente,:emissao, :data_emb, ' +
    ' :valor, :desconto, :total, 0, 0, :comissao, :latitude, :longitude, :Obs) ';

  CONST_EDITAPEDIDO = 'UPDATE VENDA  SET formapagto = :formapagto, cod_camara = :cod_camara, ' +
    ' cod_user = :cod_user,  cod_vendedor = :cod_vendedor, cod_cliente = :cod_cliente,  emissao = :emissao, ' +
    ' data_emb = :data_emb,  valor = :valor,  desconto = :desconto,  total = :total, ' +
    '  comissao = :comissao, latitude = :latitude,  longitude = :longitude,  Obs = :Obs  WHERE chave = :chave ';

  CONST_VERIFICAPEDIDOFINALIZAR = ' SELECT case when credito = 1 and atraso = 1 then 1 /*Situação OK!*/ ' +
    ' when credito = 1 and atraso = 0 then 2 /*Títulos em atraso!*/ when credito = 0 and atraso = 1 then 3 /*Limite excedido!*/ '
    + ' else 4  /*Limite excedido e títulos em atraso!*/ END as situacao FROM cliente where cod_pessoa = :cliente';

  CONST_VERIFICAPEDIDOITEMFINALIZAR = 'select cod_prod, desc_ind , valor_min from produto where cod_prod = :cod_prod';

  CONST_EDITAREPLICAPEDIDO =
    'select cod_cliente, formapagto, cod_camara,  comissao, obs, data_emb from venda where chave = :CHAVE';

  CONST_DELETEPEDIDO = ' DELETE FROM VENDA WHERE CHAVE = :CHAVE ';

  CONST_STATUSPEDIDO = ' SELECT SINCRONIZADO FROM VENDA WHERE CHAVE = :CHAVE ';

type
  TModelNovoPedido = class(TInterfacedObject, iModelNovoPedido)
  private
    FQry: TFDQuery;

    FPSituacao: integer;
    FPDataIni: Tdatetime;
    FPDataFim: Tdatetime;
    FString: String;

    FChave: String;
    FFormaPagamento: integer;
    FCodCamara: integer;
    FCodUser: integer;
    FCodVendedor: integer;
    FCodCliente: integer;
    FEmissao: Tdatetime;
    FDataEmb: TDate;
    FValor: Double;
    FDesconto: Double;
    FTotal: Double;
    FComissao: integer;
    FAcao: integer;
    FLatitude: String;
    FLongitude: String;
    FObs: String;

  public
    constructor create;
    destructor destroy; override;
    class function new: iModelNovoPedido;
    function PSituacao(value: integer): iModelNovoPedido; // P = Pesquisa
    function PDataIni(value: Tdatetime): iModelNovoPedido; // P = Pesquisa
    function PDataFim(value: Tdatetime): iModelNovoPedido; // P = Pesquisa

    function Acao(value: integer): iModelNovoPedido;
    function Chave(value: String): iModelNovoPedido;
    function FormaPagamento(value: integer): iModelNovoPedido;
    function CodCamara(value: integer): iModelNovoPedido;
    function CodUser(value: integer): iModelNovoPedido;
    function CodVendedor(value: integer): iModelNovoPedido;
    function CodCliente(value: integer): iModelNovoPedido;
    function Emissao(value: Tdatetime): iModelNovoPedido;
    function DataEmb(value: TDate): iModelNovoPedido;
    function Valor(value: Double): iModelNovoPedido;
    function Desconto(value: Double): iModelNovoPedido;
    function Total(value: Double): iModelNovoPedido;
    function Comissao(value: integer): iModelNovoPedido;
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

implementation

{ TModelNovoPedido }

uses
  Form_Mensagem,
  uFrmUtilFormate;

class function TModelNovoPedido.new: iModelNovoPedido;
begin
  result := self.create;
end;

constructor TModelNovoPedido.create;
begin
  FQry := TFDQuery.create(nil);
  FQry.Connection := DmDados.ConexaoInterna;
  FQry.FetchOptions.RowsetSize := 50000;
  FQry.Active := false;
  FQry.SQL.Clear;
end;

destructor TModelNovoPedido.destroy;
begin
  FreeAndNil(FQry);
  inherited;
end;

function TModelNovoPedido.PSituacao(value: integer): iModelNovoPedido;
begin
  result := self;
  FPSituacao := value;
end;

function TModelNovoPedido.Total(value: Double): iModelNovoPedido;
begin
  result := self;
  FTotal := value;
end;

function TModelNovoPedido.Emissao(value: Tdatetime): iModelNovoPedido;
begin
  result := self;
  FEmissao := value;
end;

function TModelNovoPedido.CodUser(value: integer): iModelNovoPedido;
begin
  result := self;
  FCodUser := value;
end;

function TModelNovoPedido.CodVendedor(value: integer): iModelNovoPedido;
begin
  result := self;
  FCodVendedor := value;
end;

function TModelNovoPedido.Comissao(value: integer): iModelNovoPedido;
begin
  result := self;
  FComissao := value;
end;

function TModelNovoPedido.Obs(value: String): iModelNovoPedido;
begin
  result := self;
  FObs := value;
end;

function TModelNovoPedido.Valor(value: Double): iModelNovoPedido;
begin
  result := self;
  FValor := value;
end;

function TModelNovoPedido.Acao(value: integer): iModelNovoPedido;
begin
  result := self;
  FAcao := value;
end;

function TModelNovoPedido.Chave(value: String): iModelNovoPedido;
begin
  result := self;
  FChave := value;
end;

function TModelNovoPedido.CodCamara(value: integer): iModelNovoPedido;
begin
  result := self;
  FCodCamara := value;
end;

function TModelNovoPedido.Desconto(value: Double): iModelNovoPedido;
begin
  result := self;
  FDesconto := value;
end;

function TModelNovoPedido.Latitude(value: String): iModelNovoPedido;
begin
  result := self;
  FLatitude := value;
end;

function TModelNovoPedido.Longitude(value: String): iModelNovoPedido;
begin
  result := self;
  FLongitude := value;
end;

function TModelNovoPedido.PDataIni(value: Tdatetime): iModelNovoPedido;
begin
  result := self;
  FPDataIni := value;
end;

function TModelNovoPedido.PDataFim(value: Tdatetime): iModelNovoPedido;
begin
  result := self;
  FPDataFim := value;
end;

function TModelNovoPedido.CodCliente(value: integer): iModelNovoPedido;
begin
  result := self;
  FCodCliente := value;
end;

function TModelNovoPedido.DataEmb(value: TDate): iModelNovoPedido;
begin
  result := self;
  FDataEmb := value;
end;

function TModelNovoPedido.FormaPagamento(value: integer): iModelNovoPedido;
begin
  result := self;
  FFormaPagamento := value;
end;

function TModelNovoPedido.Filter: iModelNovoPedido;
begin
  result := self;

  FString := ' where   strftime(''%d/%m/%Y'',v.emissao) BETWEEN ' + QuotedStr(DatetimeToStr(FPDataIni)) + ' AND ' +
    QuotedStr(DatetimeToStr(FPDataFim));

  case FPSituacao of
    1: // ENVIADO
      FString := FString + ' and v.sincronizado = 1 ';
    2: // PENDENTE
      FString := FString + ' and v.sincronizado = 0 ';
    3: // FATURADO
      FString := FString + ' and v.sincronizado = 1 and i.status = 3 ';
    4: // REPROVADO
      FString := FString + ' and v.sincronizado = 1 and i.status = 4 ';
  end;
  if FCodVendedor <> 0 then
    FString := FString + ' and v.cod_vendedor = ' + CodVend.ToString;
    FString := FString + ' group by v.chave ';
end;

function TModelNovoPedido.DeletePedido: iModelNovoPedido;
begin
  result := self;
  FQry.SQL.Text := CONST_DELETEPEDIDO;
  FQry.ParamByName('CHAVE').AsString := FChave;
  FQry.ExecSQL;
end;

function TModelNovoPedido.PopulaListPedidos(value: TListView; enviado, pendente, aprovado, reprovado: TImage)
  : iModelNovoPedido;
var
  x: integer;
  item: TListViewItem;
  txt: TListItemText;
  img: TListItemImage;
begin

  result := self;
  FQry.Open(CONST_POPULALISTPEDIDOS + FString);
  FQry.First;

  try
    value.Items.Clear;
    value.BeginUpdate;
    for x := 0 to FQry.RecordCount - 1 do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('chave'));
        txt.Text := FQry.FieldByName('chave').AsString;
        txt.TagString := FQry.FieldByName('chave').AsString;

        txt := TListItemText(Objects.FindDrawable('nomefant'));
        txt.Text := FQry.FieldByName('nome_fant').AsString;

        txt := TListItemText(Objects.FindDrawable('nomerazao'));
        txt.Text := FQry.FieldByName('nome_razao').AsString;

        txt := TListItemText(Objects.FindDrawable('dataemissao'));
        txt.Text := 'EMISSÃO: ' + FQry.FieldByName('emissao').AsString;

        txt := TListItemText(Objects.FindDrawable('dataentrega'));
        txt.Text := 'ENTREGA: ' + FQry.FieldByName('data_emb').AsString;

        txt := TListItemText(Objects.FindDrawable('comissao'));
        txt.Text := 'COMISSAO: ' + FQry.FieldByName('COMISSAO').AsString;

        txt := TListItemText(Objects.FindDrawable('situacao'));
        case FQry.FieldByName('situacao').AsInteger of
          1:
            txt.Text := 'STATUS: FATURADO.';
          2:
            txt.Text := 'STATUS: REPROVADO.';
          3:
            txt.Text := 'STATUS: ENVIADO.';
          4:
            txt.Text := 'STATUS: PENDENTE.';
        end;

        img := TListItemImage(Objects.FindDrawable('image'));
        case FQry.FieldByName('situacao').AsInteger of
          1:
            img.Bitmap := aprovado.Bitmap;
          2:
            img.Bitmap := reprovado.Bitmap;
          3:
            img.Bitmap := enviado.Bitmap;
          4:
            img.Bitmap := pendente.Bitmap;
        end;
      end;
      FQry.Next
    end;
  finally
    value.EndUpdate;
  end;

end;

function TModelNovoPedido.InfoPedido(value: String; AList: TStringList): iModelNovoPedido;
var
  i: integer;
begin
  result := self;
  FQry.SQL.Text := CONST_INFOPEDIDO;
  FQry.ParamByName('chave').AsString := value;
  FQry.Open();

  if FQry.RecordCount = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  for i := 0 to FQry.FieldCount - 1 do
  begin
    AList.Add(FQry.Fields[i].AsString);
    FQry.Next;
  end;
end;

function TModelNovoPedido.StatusPedido: iModelNovoPedido;
begin
  result := self;
  FQry.SQL.Text := CONST_STATUSPEDIDO;
  FQry.ParamByName('CHAVE').AsString := FChave;
  FQry.Open;

  if FQry.RecordCount = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FQry.FieldByName('sincronizado').AsInteger = 1 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Pedido já enviado para o servidor!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TModelNovoPedido.EditaReplicaPedido(AList: TStringList): iModelNovoPedido;
var
  i: integer;
begin
  result := self;
  FQry.SQL.Text := CONST_EDITAREPLICAPEDIDO;
  FQry.ParamByName('chave').AsString := FChave;
  FQry.Open;

  if FQry.RecordCount = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  for i := 0 to FQry.FieldCount - 1 do
  begin
    AList.Add(FQry.Fields[i].AsString);
    FQry.Next;
  end;
end;

function TModelNovoPedido.ValidaAddProd: iModelNovoPedido;
begin
  result := self;
  if FCodCliente = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Selecione um cliente valido!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FCodCamara = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Selecione um centro de distribuição valido!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if (FDataEmb < DataHoje) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Selecione uma data valida!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;
end;

function TModelNovoPedido.InsertPedido: iModelNovoPedido;
begin
  result := self;
  DmDados.ConexaoInterna.StartTransaction;
  try
    case FAcao of
      0:
        FQry.SQL.Text := CONST_INSERTPEDIDO;
      1:
        FQry.SQL.Text := CONST_EDITAPEDIDO;
    end;

    FQry.ParamByName('chave').AsString := FChave;
    FQry.ParamByName('formapagto').AsInteger := FFormaPagamento;
    FQry.ParamByName('cod_camara').AsInteger := FCodCamara;
    FQry.ParamByName('cod_user').AsInteger := FCodUser;
    FQry.ParamByName('cod_vendedor').AsInteger := FCodVendedor;
    FQry.ParamByName('cod_cliente').AsInteger := FCodCliente;
    FQry.ParamByName('emissao').AsDateTime := FEmissao;
    FQry.ParamByName('data_emb').AsDateTime := FDataEmb;
    FQry.ParamByName('valor').AsFloat := FValor;
    FQry.ParamByName('desconto').AsFloat := FDesconto;
    FQry.ParamByName('total').AsFloat := FTotal;
    FQry.ParamByName('comissao').AsInteger := FComissao;
    FQry.ParamByName('latitude').AsString := FLatitude;
    FQry.ParamByName('longitude').AsString := FLongitude;
    FQry.ParamByName('Obs').AsString := FObs;
    FQry.ExecSQL;

    DmDados.ConexaoInterna.Commit;
  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao Gravar' + sLineBreak + E.Message, 'OK', '', $FFDF5447,
        $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;
  end;
end;

function TModelNovoPedido.VerificaPedido(Grid: TStringGrid): String;

var
  Error, ErrorItem, ErrorMsg: String;
  pa: integer;
begin

  FQry.SQL.Text := CONST_VERIFICAPEDIDOFINALIZAR;
  FQry.ParamByName('cliente').AsInteger := FCodCliente;
  FQry.Open;

  case FQry.FieldByName('situacao').AsInteger of
    2:
      Error := 'Cliente com Títulos em atraso!';
    3:
      Error := 'Cliente com Limite excedido!';
    4:
      Error := 'Cliente com Limite excedido e títulos em atraso!';
  end;

  if Error <> '' then
    Error := Error + sLineBreak + StringOfChar('-', 70);

  for pa := 0 to Grid.RowCount - 1 do
  begin

    FQry.SQL.Text := CONST_VERIFICAPEDIDOITEMFINALIZAR;
    FQry.ParamByName('cod_prod').AsString := Grid.Cells[0, pa];
    FQry.Open;

    if (FQry.FieldByName('valor_min').AsFloat > StrParaDouble(Grid.Cells[4, pa])) then
      ErrorItem := ErrorItem + sLineBreak + FQry.FieldByName('cod_prod').AsString + ' - ' + FQry.FieldByName('desc_ind')
        .AsString + sLineBreak

  end;

  if ErrorItem <> '' then
    Error := Error + sLineBreak + 'Produtos com valor minimo excedido: ' + sLineBreak + ErrorItem;

  result := Error;

end;

end.
