unit uClasseClientes;

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
  uInterfaceClientes,
  FMX.Graphics;

type

  TClientes = class(TInterfacedObject, iModelClientes)
  private

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelClientes;

    function BuscaClientesServidor(Super, cod_vend: Integer; ADataSet: TFDMemTable): iModelClientes;
    function PopulaClientesSqLite(ADataSet: TFDMemTable): iModelClientes;
    function LimpaTabelaClientes: iModelClientes;
    function PopulaListView(value: TListView; positivo, negativo: TImage; Pesq: String): iModelClientes;
    function PopulaCampos(value: Integer; AList: TStringList): iModelClientes;
    function BuscarCliente(value: Integer): String;
    function RetornaLimite(value: Integer): String;
    function ValidaCliente(value: Integer): Integer;
  end;

implementation

{ TClientes }

uses
  uFrmUtilFormate,
  System.UITypes,
  uFrmInforSistema,
  Form_Mensagem;

class function TClientes.new: iModelClientes;
begin
  result := self.create;
end;

constructor TClientes.create;
begin

end;

destructor TClientes.destroy;
begin

  inherited;
end;

function TClientes.LimpaTabelaClientes: iModelClientes;
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
    qry.ExecSQL('DELETE FROM CLIENTE')
  finally
    FreeAndNil(qry);
  end;

end;

function TClientes.BuscaClientesServidor(Super, cod_vend: Integer; ADataSet: TFDMemTable): iModelClientes;
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
    rdwSQLTemp.SQL.Add
      (' select t.cod_pessoa, t.nome_razao, t.nome_fant, t.comissao, t.endereco, t.bairro, c.municipio, t.telefone, ' +
      ' t.cpf_cnpj, t.email, ISNULL(t.cod_vend, 0) as cod_vend, ISNULL(t.cod_doc, 0) as cod_doc, t.situacao,	t.dt_visitar, '
      + ' case when isnull(t1.vlr_crd, 0) < (isnull(t2.sld_chq,0) + isnull(t3.sld_dev, 0)) then 0 else 1 end as credito, '
      + ' case when min_dta is not null then 0 else 1 end as atraso, ' + ' isnull(t1.vlr_crd, 0) as crd_permitido, ' +
      ' isnull(t2.sld_chq,0) + isnull(t3.sld_dev, 0) as Vlr_Pagar, ' +
      ' isnull(t1.vlr_crd, 0) - (isnull(t2.sld_chq,0) + isnull(t3.sld_dev, 0)) as cdr_disponivel ' + ' from t_pessoa t '
      + ' left outer join t_cidade c on (t.cod_cidade = c.cod_cidade) ' +
      ' left outer join  (select tc.cod_cliente, tc.credito as vlr_crd from t_credito tc  where ' +
      ' tc.cod =  (select max(cod) from t_credito  where cod_cliente = tc.cod_cliente)) t1 on (t.cod_pessoa = t1.cod_cliente) '
      + ' left outer join (select cod_cliente, sum(valor) as sld_chq from v_cheques_receb where status = 0 group by cod_cliente) t2 on (t.cod_pessoa = t2.cod_cliente) '
      + ' left outer join (select cod_cliente, sum(sld_dev) as sld_dev from v_contas_receb where status = ''A'' group by cod_cliente) t3 on (t.cod_pessoa = t3.cod_cliente) '
      + ' left outer join ( select cod_cliente, min(data_venc) as min_dta  from t_contas_receb where status = ''A'' and '
      + ' (select dateadd(day, dias_carencia, data_venc) from t_config where dias_carencia is not null)  <= getdate() '
      + ' group by cod_cliente ) t4 on (t.cod_pessoa = t4.cod_cliente) ');

    if (Super = 1) or (cod_vend = 0) then
    begin
      rdwSQLTemp.SQL.Add('where t.situacao = 1  and cliente = 1');
    end
    else
    begin
      rdwSQLTemp.SQL.Add('where  t.cod_vend = :cod and t.situacao = 1 and cliente = 1');
      rdwSQLTemp.ParamByName('cod').value := cod_vend;
    end;

    rdwSQLTemp.Active := True;
    rdwSQLTemp.RecordCount;
    ADataSet.CopyDataSet(rdwSQLTemp, [coStructure, coRestart, coAppend]);
  finally
    FreeAndNil(rdwSQLTemp);
  end;

end;

function TClientes.BuscarCliente(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME_FANT FROM CLIENTE WHERE COD_PESSOA = :COD_PESSOA');
    qry.ParamByName('COD_PESSOA').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
      result := EmptyStr
    else
      result := qry.FieldByName('NOME_FANT').AsString;

  finally
    FreeAndNil(qry);
  end;

end;

function TClientes.PopulaClientesSqLite(ADataSet: TFDMemTable): iModelClientes;
var
  i: Integer;
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
      qry.SQL.Add
        ('INSERT INTO CLIENTE (COD_PESSOA, NOME_RAZAO, NOME_FANT, ENDERECO, BAIRRO, MUNICIPIO, TELEFONE, CPF_CNPJ, EMAIL, COD_VEND, '
        + ' CREDITO, ATRASO, COD_DOC, DT_VISITAR, CRD_PERMITIDO, VLR_PAGAR, CDR_DISPONIVEL, COMISSAO) ' + ' VALUES ' +
        ' (:COD_PESSOA, :NOME_RAZAO, :NOME_FANT, :ENDERECO, :BAIRRO, :MUNICIPIO, :TELEFONE, :CPF_CNPJ, :EMAIL, :COD_VEND, '
        + ' :CREDITO, :ATRASO, :COD_DOC, :DT_VISITAR, :CRD_PERMITIDO, :vLR_pAGAR, :CDR_DISPONIVEL, :COMISSAO)');

      qry.ParamByName('COD_PESSOA').AsInteger := ADataSet.FieldByName('COD_PESSOA').AsInteger;
      qry.ParamByName('NOME_RAZAO').AsString := ADataSet.FieldByName('NOME_RAZAO').AsString;
      qry.ParamByName('NOME_FANT').AsString := ADataSet.FieldByName('NOME_FANT').AsString;
      qry.ParamByName('ENDERECO').AsString := ADataSet.FieldByName('ENDERECO').AsString;
      qry.ParamByName('BAIRRO').AsString := ADataSet.FieldByName('BAIRRO').AsString;
      qry.ParamByName('MUNICIPIO').AsString := ADataSet.FieldByName('MUNICIPIO').AsString;
      qry.ParamByName('TELEFONE').AsString := ADataSet.FieldByName('TELEFONE').AsString;
      qry.ParamByName('CPF_CNPJ').AsString := ADataSet.FieldByName('CPF_CNPJ').AsString;
      qry.ParamByName('EMAIL').AsString := ADataSet.FieldByName('EMAIL').AsString;
      qry.ParamByName('COD_VEND').AsInteger := ADataSet.FieldByName('COD_VEND').AsInteger;
      qry.ParamByName('CREDITO').AsFloat := ADataSet.FieldByName('CREDITO').AsFloat;
      qry.ParamByName('ATRASO').AsInteger := ADataSet.FieldByName('ATRASO').AsInteger;
      qry.ParamByName('COD_DOC').AsInteger := ADataSet.FieldByName('COD_DOC').AsInteger;
      qry.ParamByName('DT_VISITAR').AsDateTime := ADataSet.FieldByName('DT_VISITAR').AsDateTime;
      qry.ParamByName('CRD_PERMITIDO').AsFloat := ADataSet.FieldByName('CRD_PERMITIDO').AsFloat;
      qry.ParamByName('VLR_PAGAR').AsFloat := ADataSet.FieldByName('VLR_PAGAR').AsFloat;
      qry.ParamByName('CDR_DISPONIVEL').AsFloat := ADataSet.FieldByName('CDR_DISPONIVEL').AsFloat;
      qry.ParamByName('COMISSAO').AsInteger := ADataSet.FieldByName('COMISSAO').AsInteger;
      qry.ExecSQL;
      ADataSet.Next;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TClientes.PopulaListView(value: TListView; positivo, negativo: TImage; Pesq: String): iModelClientes;
var
  x: Integer;
  qry: TFDQuery;
  item: TListViewItem;
  txt: TListItemText;
  img: TListItemImage;
begin
  try
    result := self;
    qry := TFDQuery.create(nil);
    qry.Connection := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      (' select substr(''0000''||cod_pessoa, -4, 4) as cod_pessoa, nome_fant, nome_razao,cpf_cnpj, bairro|| '' - '' || municipio as endereco, '
      + ' case when credito = 1 and atraso = 1 then  ''OK!'' when credito = 1 and atraso = 0 then  ''TÍTULOS EM ATRASO!'' '
      + ' when credito = 0 and atraso = 1 then  ''LIMITE EXCEDIDO!'' else  ''LIMITE EXCEDIDO E TÍTULOS EM ATRASO!''END as situacao from cliente '
      + 'where cod_pessoa = ' + QuotedStr(Pesq) + ' or nome_fant like ''%' + Pesq +
      '%'' or nome_razao like ''%' + Pesq + '%''');
    qry.Open;
    qry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 1 to qry.RecordCount do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('cod_cliente'));
        txt.Text := formatfloat('0000', qry.FieldByName('cod_pessoa').AsFloat);
        txt.TagString := qry.FieldByName('cod_pessoa').AsString;

        if qry.FieldByName('situacao').AsString <> 'OK!' then
          txt.TextColor := $FFF60000
        else
          txt.TextColor := $FF0C76C1;

        txt := TListItemText(Objects.FindDrawable('nome_fant'));
        txt.Text := ' - ' + qry.FieldByName('nome_fant').AsString;

        if qry.FieldByName('situacao').AsString <> 'OK!' then
          txt.TextColor := $FFF60000
        else
          txt.TextColor := $FF0C76C1;

        txt := TListItemText(Objects.FindDrawable('nome_razao'));
        txt.Text := qry.FieldByName('nome_razao').AsString;

        if qry.FieldByName('situacao').AsString <> 'OK!' then
          txt.TextColor := $FFF60000
        else
          txt.TextColor := $FF0C76C1;

        txt := TListItemText(Objects.FindDrawable('cpf_cnpj'));
        txt.Text := 'CPF/CNPJ: ' + FormataDoc(qry.FieldByName('cpf_cnpj').AsString);

        txt := TListItemText(Objects.FindDrawable('bairro'));
        txt.Text := 'ENDEREÇO: ' + qry.FieldByName('endereco').AsString;

        txt := TListItemText(Objects.FindDrawable('situacao'));
        txt.Text := 'SITUAÇÃO: ' + qry.FieldByName('situacao').AsString;

        img := TListItemImage(Objects.FindDrawable('Image7'));
        if qry.FieldByName('situacao').AsString <> 'OK!' then
          img.Bitmap := negativo.Bitmap
        else
          img.Bitmap := positivo.Bitmap;

      end;

      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;
end;

function TClientes.RetornaLimite(value: Integer): String;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.create(nil);
  qry.Connection := DmDados.ConexaoInterna;
  qry.FetchOptions.RowsetSize := 50000;
  qry.Active := false;
  qry.SQL.Add('SELECT CDR_DISPONIVEL FROM CLIENTE WHERE COD_PESSOA = :ID');
  qry.ParamByName('ID').AsInteger := value;
  qry.Open;

  result := formatfloat('#,##0.00', qry.FieldByName('CDR_DISPONIVEL').AsFloat);

end;

function TClientes.ValidaCliente(value: Integer): Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.create(nil);
  qry.Connection := DmDados.ConexaoInterna;
  qry.FetchOptions.RowsetSize := 50000;
  qry.Active := false;
  qry.SQL.Add(' SELECT case when credito = 1 and atraso = 1 then 1 /*Situação OK!*/ ' +
    ' when credito = 1 and atraso = 0 then 2 /*Títulos em atraso!*/ ' +
    ' when credito = 0 and atraso = 1 then 3 /*Limite excedido!*/ ' +
    ' else 4  /*Limite excedido e títulos em atraso!*/ ' +
    ' END as situacao, (select bloq_clientes from parametros) as bloq_clientes FROM cliente where cod_pessoa = :cliente ');
  qry.ParamByName('cliente').AsInteger := value;
  qry.Open;

  if (qry.FieldByName('bloq_clientes').AsInteger = 0) and (qry.FieldByName('situacao').AsInteger <> 1) then
    result := 1 // pergunta
  else if (qry.FieldByName('bloq_clientes').AsInteger = 1) and (qry.FieldByName('situacao').AsInteger <> 1) then
    result := 2 // bloquea
  else
    result := 3;

end;

function TClientes.PopulaCampos(value: Integer; AList: TStringList): iModelClientes;
var
  i: Integer;
  qry: TFDQuery;
begin

  result := self;

  qry := TFDQuery.create(nil);
  qry.Connection := DmDados.ConexaoInterna;
  qry.FetchOptions.RowsetSize := 50000;
  qry.Active := false;
  qry.SQL.Add
    ('select cod_pessoa, nome_fant, Nome_razao, cpf_cnpj, telefone, dt_visitar, email, endereco, bairro, municipio, crd_permitido, '
    + ' cdr_disponivel, vlr_pagar  from cliente where cod_pessoa = :ID');
  qry.ParamByName('ID').AsInteger := value;
  qry.Open;

  if qry.RecordCount = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  for i := 0 to qry.FieldCount - 1 do
  begin
    AList.Add(qry.Fields[i].AsString);
    qry.Next;
  end;

end;

end.
