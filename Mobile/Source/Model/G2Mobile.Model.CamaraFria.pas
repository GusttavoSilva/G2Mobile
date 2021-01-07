unit G2Mobile.Model.CamaraFria;

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
  G2Mobile.Controller.CamaraFria;

const

  CONST_DELETECAMARAFRIA = 'DELETE FROM CAMARA_FRIA';

  CONST_BUSCACAMARAFRIASERVIDOR = 'SELECT COD_CAMARA, DESCRICAO FROM T_CAMARA_FRIA';

  CONST_INSERTCAMARAFRIA = 'INSERT INTO CAMARA_FRIA ( COD_CAMARA, DESCRICAO) VALUES ( :COD_CAMARA, :DESCRICAO)';

  CONST_BUSCARCAMARAFRIA = 'SELECT DESCRICAO FROM CAMARA_FRIA WHERE COD_CAMARA = :COD_CAMARA';

  CONST_lISTACAMARAFRIA = 'select * from camara_fria';

  CONST_RETORNACAMARAFRIAVENDEDOR = 'SELECT u.cod_camara, c.descricao FROM usuarios u ' +
    'left outer join camara_fria c on (c.cod_camara = u.cod_camara) ' + 'where u.cod_user = :COD_USER';

type

  TModelCamaraFria = class(TInterfacedObject, iModelCamaraFria)
  private
    FQry       : TFDQuery;
    FRdwSQLTemp: TRESTDWClientSQL;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelCamaraFria;

    function BuscaCamaraFriaServidor(ADataSet: TFDMemTable): iModelCamaraFria;
    function PopulaCamaraFriaSqLite(ADataSet: TFDMemTable): iModelCamaraFria;
    function LimpaTabelaCamaraFria: iModelCamaraFria;
    function PopulaListView(value: TListView; imageForma: Timage): iModelCamaraFria;
    function BuscarCamaraFria(value: Integer): String;
    function RetornaCamaraFriaVendedor(value: Integer): String;

  end;

implementation

{ TModelCamaraFria }

class function TModelCamaraFria.new: iModelCamaraFria;
begin
  result := self.create;
end;

constructor TModelCamaraFria.create;
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

destructor TModelCamaraFria.destroy;
begin
  FreeAndNil(FQry);
  inherited;
end;

function TModelCamaraFria.LimpaTabelaCamaraFria: iModelCamaraFria;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETECAMARAFRIA)
end;

function TModelCamaraFria.BuscaCamaraFriaServidor(ADataSet: TFDMemTable): iModelCamaraFria;
begin
  result := self;
  FRdwSQLTemp.SQL.Text := CONST_BUSCACAMARAFRIASERVIDOR;
  FRdwSQLTemp.Active := True;

  FRdwSQLTemp.RecordCount;
  ADataSet.CopyDataSet(FRdwSQLTemp, [coStructure, coRestart, coAppend]);
end;

function TModelCamaraFria.PopulaCamaraFriaSqLite(ADataSet: TFDMemTable): iModelCamaraFria;
var
  i: Integer;
begin
  result := self;

  ADataSet.First;

  for i := 0 to ADataSet.RecordCount - 1 do
  begin
    FQry.SQL.Text := CONST_INSERTCAMARAFRIA;
    FQry.ParamByName('COD_CAMARA').AsInteger := ADataSet.FieldByName('COD_CAMARA').AsInteger;
    FQry.ParamByName('DESCRICAO').AsString := ADataSet.FieldByName('DESCRICAO').AsString;
    FQry.ExecSQL;
    ADataSet.Next;
  end;

end;

function TModelCamaraFria.BuscarCamaraFria(value: Integer): String;
begin
  FQry.SQL.Text := CONST_BUSCARCAMARAFRIA;
  FQry.ParamByName('COD_CAMARA').AsInteger := value;
  FQry.Open;

  if FQry.RecordCount = 0 then
    result := EmptyStr
  else
    result := FQry.FieldByName('DESCRICAO').AsString;
end;

function TModelCamaraFria.PopulaListView(value: TListView; imageForma: Timage): iModelCamaraFria;
var
  x   : Integer;
  item: TListViewItem;
  txt : TListItemText;
  img : TListItemImage;
  foto: TStream;
begin

  result := self;

  try
    FQry.Open(CONST_lISTACAMARAFRIA);

    value.Items.Clear;
    value.BeginUpdate;

    for x := 0 to FQry.RecordCount - 1 do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('codigo'));
        txt.Text := formatfloat('0000', FQry.FieldByName('cod_camara').AsFloat);
        txt.TagString := FQry.FieldByName('cod_camara').AsString;

        txt := TListItemText(Objects.FindDrawable('desc'));
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

function TModelCamaraFria.RetornaCamaraFriaVendedor(value: Integer): String;
begin
  FQry.SQL.Text := CONST_RETORNACAMARAFRIAVENDEDOR;
  FQry.ParamByName('COD_USER').AsInteger := value;
  FQry.Open;

  if FQry.RecordCount = 0 then
    result := '0'
  else
    result := formatfloat('0000', FQry.FieldByName('cod_camara').AsFloat);
end;

end.
