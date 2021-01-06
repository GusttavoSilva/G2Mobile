unit uClasseProdutos;

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
  uInterfaceProdutos,
  Data.DB,
  FMX.Objects,
  FMX.Graphics;

const

  CONST_DELETASQLITE = 'DELETE FROM PRODUTO';

  CONST_BUSCAPRODSERVIDOR =
    ' SELECT P.COD_PROD, (DESC_REL) AS DESC_IND, P.UNID_MED, isnull(TP.PRECO1, 0) AS VALOR_MIN,  isnull(TP.PRECO_VENDA, 0) AS VALOR_PROD, '
    + ' CAST(P.GRUPO_COM AS varchar(10)) + '' - '' + tg.descricao_grupo as GRUPO_COM, ' +
    ' case when  p.validadetempo = 0 then  CAST(P.VALIDADE AS varchar(10))+'' MESES'' ' +
    ' when  p.validadetempo = 1 then  CAST(P.VALIDADE AS varchar(10))+'' DIAS'' ' +
    ' END AS VALIDADE , P.TIPO_CALC, P.QUANT_CX, P.PESO_PADRAO ' + ' from t_PRODUTO P ' +
    ' LEFT OUTER JOIN  T_PRECOS_PROD TP ON (P.COD_PROD = TP.COD_PROD AND TP.DATA = (SELECT mAX(DATA) FROM T_PRECOS_PROD WHERE COD_PROD = TP.COD_PROD)) '
    + ' LEFT OUTER JOIN t_gruposcomerciais tg on(p.grupo_com = tg.cod_grupo) ' +
    ' WHERE P.VENDAS = 1 AND TP.PRECO_VENDA <> 0 ';

  CONST_INSERTSQLITE =
    ' INSERT INTO PRODUTO ( COD_PROD, DESC_IND, UNID_MED, VALOR_MIN, VALOR_PROD, GRUPO_COM, VALIDADE, TIPO_CALC, QUANT_CX, PESO_PADRAO)'
    + ' VALUES ( :COD_PROD, :DESC_IND, :UNID_MED, :VALOR_MIN, :VALOR_PROD, :GRUPO_COM, :VALIDADE, :TIPO_CALC, :QUANT_CX, :PESO_PADRAO)';

  CONST_DELETASQLITEFOTOS = 'DELETE FROM PRODUTO_FOTO';

  CONST_BUSCAFOTOPRODSERVIDOR = ' SELECT TF.COD_PROD, TF.NOME_ARQ, TF.FOTO_ARQ AS FOTO FROM T_PRODUTO_FOTO TF ' +
    ' LEFT OUTER JOIN T_PRODUTO T ON (T.COD_PROD = TF.COD_PROD) ' +
    ' LEFT OUTER JOIN  T_PRECOS_PROD TP ON (T.COD_PROD = TP.COD_PROD AND TP.DATA = (SELECT mAX(DATA) FROM T_PRECOS_PROD WHERE COD_PROD = TP.COD_PROD)) '
    + ' WHERE T.VENDAS = 1 AND TP.PRECO_VENDA <> 0 ';

  CONST_INSERTSQLITEFOTO =
    ' INSERT INTO PRODUTO_FOTO ( COD_PROD, FOTO, NOME_ARQ) VALUES ( :COD_PROD, :FOTO, :NOME_ARQ)';

  CONST_POPULALISTVIEW = ' select p.cod_prod, p.desc_ind, p.unid_med,p.valor_prod, pf.foto from produto p ' +
    ' left join produto_foto pf on (p.cod_prod = pf.cod_prod) ';

  CONST_POPULACAMPOS =
    'select cod_prod, desc_ind as produto, validade, grupo_com, unid_med, valor_prod, quant_cx, peso_padrao from produto where cod_prod  = :id';

  CONST_RETORNAFOTO = 'SELECT FOTO FROM PRODUTO_FOTO WHERE COD_PROD = :ID';

type

  TProdutos = class(TInterfacedObject, iModelProdutos)
  private
    FQry: TFDQuery;
    FRdwSQL: TRESTDWClientSQL;

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelProdutos;

    function BuscaProdServidor(ADataSet: TFDMemTable): iModelProdutos;
    function BuscaFotoProdServidor(ADataSet: TFDMemTable): iModelProdutos;
    function PopulaProdSqLite(ADataSet: TFDMemTable): iModelProdutos;
    function PopulaFotosProdSqLite(ADataSet: TFDMemTable): iModelProdutos;
    function PopulaListView(value: TListView; SemFoto: Timage; Pesq:String): iModelProdutos;
    function LimpaTabelaProd: iModelProdutos;
    function LimpaTabelaProdFoto: iModelProdutos;
    function PopulaCampos(value: integer; AList: TStringList): iModelProdutos;
    function RetornaFoto(value: integer; SemFoto, AImage: Timage): iModelProdutos;

  end;

implementation

{ TProdutos }

uses
  Form_Mensagem,
  uFrmUtilFormate;

class function TProdutos.new: iModelProdutos;
begin
  result := self.create;
end;

constructor TProdutos.create;
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

destructor TProdutos.destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(FRdwSQL);
  inherited;
end;

function TProdutos.LimpaTabelaProd: iModelProdutos;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETASQLITE)
end;

function TProdutos.BuscaProdServidor(ADataSet: TFDMemTable): iModelProdutos;
begin
  result := self;

  FRdwSQL.SQL.Text := CONST_BUSCAPRODSERVIDOR;
  FRdwSQL.Active := True;
  ADataSet.CopyDataSet(FRdwSQL, [coStructure, coRestart, coAppend]);

end;

function TProdutos.PopulaProdSqLite(ADataSet: TFDMemTable): iModelProdutos;
var
  i: integer;
begin
  result := self;

  ADataSet.First;
  for i := 0 to ADataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_INSERTSQLITE;
    FQry.ParamByName('COD_PROD').AsInteger := ADataSet.FieldByName('COD_PROD').AsInteger;
    FQry.ParamByName('DESC_IND').AsString := ADataSet.FieldByName('DESC_IND').AsString;
    FQry.ParamByName('UNID_MED').AsString := ADataSet.FieldByName('UNID_MED').AsString;
    FQry.ParamByName('VALOR_MIN').AsFloat := ADataSet.FieldByName('VALOR_MIN').AsFloat;
    FQry.ParamByName('VALOR_PROD').AsFloat := ADataSet.FieldByName('VALOR_PROD').AsFloat;
    FQry.ParamByName('GRUPO_COM').AsString := ADataSet.FieldByName('GRUPO_COM').AsString;
    FQry.ParamByName('VALIDADE').AsString := ADataSet.FieldByName('VALIDADE').AsString;
    FQry.ParamByName('TIPO_CALC').AsInteger := ADataSet.FieldByName('TIPO_CALC').AsInteger;
    FQry.ParamByName('QUANT_CX').AsFloat := ADataSet.FieldByName('QUANT_CX').AsFloat;
    FQry.ParamByName('PESO_PADRAO').AsFloat := ADataSet.FieldByName('PESO_PADRAO').AsFloat;
    FQry.ExecSQL;
    ADataSet.Next;
  end;

end;

function TProdutos.LimpaTabelaProdFoto: iModelProdutos;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETASQLITEFOTOS)
end;

function TProdutos.BuscaFotoProdServidor(ADataSet: TFDMemTable): iModelProdutos;
begin
  result := self;

  FRdwSQL.SQL.Text := CONST_BUSCAFOTOPRODSERVIDOR;
  FRdwSQL.Active := True;
  ADataSet.CopyDataSet(FRdwSQL, [coStructure, coRestart, coAppend]);
end;

function TProdutos.PopulaFotosProdSqLite(ADataSet: TFDMemTable): iModelProdutos;
var
  i: integer;
  foto: TStream;
  img_foto: Timage;
begin
  result := self;

  img_foto := Timage.create(nil);

  ADataSet.First;
  try
    for i := 0 to ADataSet.RecordCount - 1 do
    begin
      FQry.SQL.Text := CONST_INSERTSQLITEFOTO;

      foto := TStream.create;
      foto := ADataSet.CreateBlobStream(ADataSet.FieldByName('FOTO'), TBlobStreamMode.bmRead);
      img_foto.Bitmap.LoadFromStream(foto);

      FQry.ParamByName('COD_PROD').AsInteger := ADataSet.FieldByName('COD_PROD').AsInteger;
      FQry.ParamByName('FOTO').Assign(img_foto.Bitmap);
      FQry.ParamByName('NOME_ARQ').AsString := ADataSet.FieldByName('NOME_ARQ').AsString;
      FQry.ExecSQL;
      ADataSet.Next;
    end;

  finally
    FreeAndNil(img_foto);
  end;

end;

function TProdutos.PopulaListView(value: TListView; SemFoto: Timage; Pesq:String): iModelProdutos;
var
  x: integer;
  item: TListViewItem;
  txt: TListItemText;
  img: TListItemImage;
  bmp: TBitmap;
  foto: TStream;
begin

  result := self;

  try

    FQry.SQL.Text := CONST_POPULALISTVIEW + ' where  p.cod_prod = '+QuotedStr(Pesq)+' or  p.desc_ind like ''%'+Pesq+'%''';
    FQry.Open;
    FQry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 0 to FQry.RecordCount - 1 do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('cod_prod'));
        txt.Text := formatfloat('0000', FQry.FieldByName('cod_prod').AsFloat);
        txt.TagString := FQry.FieldByName('cod_prod').AsString;

        txt := TListItemText(Objects.FindDrawable('desc_ind'));
        txt.Text := FQry.FieldByName('desc_ind').AsString;

        txt := TListItemText(Objects.FindDrawable('unid_med'));
        txt.Text := FQry.FieldByName('unid_med').AsString;

        txt := TListItemText(Objects.FindDrawable('valor_prod'));
        txt.Text := formatfloat('R$#,##0.00', FQry.FieldByName('valor_prod').AsFloat);

        img := TListItemImage(Objects.FindDrawable('Image'));
        if not(FQry.FieldByName('FOTO').isNull) then
        begin
          foto := FQry.CreateBlobStream(FQry.FieldByName('FOTO'), TBlobStreamMode.bmRead);
          bmp := TBitmap.create;
          bmp.LoadFromStream(foto);
          img.OwnsBitmap := True;
          img.Bitmap := bmp;
        end
        else
        begin
          img.Bitmap := SemFoto.Bitmap;
        end;
      end;
      FQry.Next
    end;
  finally
    value.EndUpdate;
  end;
end;

function TProdutos.PopulaCampos(value: integer; AList: TStringList): iModelProdutos;
var
  i: integer;
begin

  result := self;

  FQry.SQL.Text := CONST_POPULACAMPOS;
  FQry.ParamByName('ID').AsInteger := value;
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

function TProdutos.RetornaFoto(value: integer; SemFoto, AImage: Timage): iModelProdutos;
var
  vStream: TMemoryStream;
begin

  result := self;

  FQry.SQL.Text := CONST_RETORNAFOTO;
  FQry.ParamByName('ID').AsInteger := value;
  FQry.Open;

  if FQry.RecordCount <> 0 then
  begin
    vStream := TMemoryStream.create;
    TBlobField(FQry.FieldByName('FOTO')).SaveToStream(vStream);
    vStream.Position := 0;
    AImage.MultiResBitmap.LoadItemFromStream(vStream, 1);
    vStream.Free;

  end
  else
  begin
    AImage.Bitmap := SemFoto.Bitmap;
  end;
end;

end.
