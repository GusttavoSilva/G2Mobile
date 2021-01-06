unit uClasseCamaraFria;

interface

uses FMX.ListView, uDmDados, uRESTDWPoolerDB,
  System.SysUtils, IdSSLOpenSSLHeaders, FireDAC.Comp.Client, FMX.Dialogs,
  FMX.ListView.Appearances, FMX.ListView.Types, System.Classes,
  Datasnap.DBClient, FireDAC.Comp.DataSet, Data.DB,
  FMX.Objects, uInterfaceCamaraFria;

type

  TCamaraFria = class(TInterfacedObject, iModelCamaraFria)
  private
    // retorno1 : TRetornaCamaraFria;
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

{ TCamaraFria }

class function TCamaraFria.new: iModelCamaraFria;
begin
  result := self.create;
end;

constructor TCamaraFria.create;
begin

end;

destructor TCamaraFria.destroy;
begin

  inherited;
end;

function TCamaraFria.LimpaTabelaCamaraFria: iModelCamaraFria;
var
  qry: TFDQuery;
begin
  result := self;

  try
    qry                         := TFDQuery.create(nil);
    qry.Connection              := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active                  := false;
    qry.SQL.Clear;
    qry.ExecSQL('DELETE FROM CAMARA_FRIA')
  finally
    FreeAndNil(qry);
  end;

end;

function TCamaraFria.BuscaCamaraFriaServidor(ADataSet: TFDMemTable): iModelCamaraFria;
var
  rdwSQLTemp: TRESTDWClientSQL;
begin
  result := self;
  try
    rdwSQLTemp                             := TRESTDWClientSQL.create(nil);
    rdwSQLTemp.DataBase                    := DmDados.RESTDWDataBase1;
    rdwSQLTemp.BinaryRequest               := True;
    rdwSQLTemp.FormatOptions.MaxStringSize := 10000;
    rdwSQLTemp.Active                      := false;
    rdwSQLTemp.SQL.Clear;
    rdwSQLTemp.SQL.Add('SELECT COD_CAMARA, DESCRICAO FROM T_CAMARA_FRIA');
    rdwSQLTemp.Active := True;
    rdwSQLTemp.RecordCount;
    ADataSet.CopyDataSet(rdwSQLTemp, [coStructure, coRestart, coAppend]);
  finally
    FreeAndNil(rdwSQLTemp);
  end;

end;

function TCamaraFria.PopulaCamaraFriaSqLite(ADataSet: TFDMemTable): iModelCamaraFria;
var
  i:   Integer;
  qry: TFDQuery;
begin
  result := self;

  qry                         := TFDQuery.create(nil);
  qry.Connection              := DmDados.ConexaoInterna;
  qry.FetchOptions.RowsetSize := 50000;
  ADataSet.First;
  try
    qry.Active := false;
    for i      := 0 to ADataSet.RecordCount - 1 do
    begin
      qry.SQL.Clear;
      qry.SQL.Add(' INSERT INTO CAMARA_FRIA ( COD_CAMARA, DESCRICAO) VALUES ( :COD_CAMARA, :DESCRICAO)');
      qry.ParamByName('COD_CAMARA').AsInteger := ADataSet.FieldByName('COD_CAMARA').AsInteger;
      qry.ParamByName('DESCRICAO').AsString   := ADataSet.FieldByName('DESCRICAO').AsString;
      qry.ExecSQL;
      ADataSet.Next;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TCamaraFria.BuscarCamaraFria(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry                         := TFDQuery.create(nil);
    qry.Connection              := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active                  := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT DESCRICAO FROM CAMARA_FRIA WHERE COD_CAMARA = :COD_CAMARA');
    qry.ParamByName('COD_CAMARA').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
      result := EmptyStr
    else
      result := qry.FieldByName('DESCRICAO').AsString;

  finally
    FreeAndNil(qry);
  end;

end;

function TCamaraFria.PopulaListView(value: TListView; imageForma: Timage): iModelCamaraFria;
var
  x:    Integer;
  item: TListViewItem;
  txt:  TListItemText;
  img:  TListItemImage;
  foto: TStream;
  qry:  TFDQuery;
begin

  result := self;

  try
    qry                         := TFDQuery.create(nil);
    qry.Connection              := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active                  := false;
    qry.SQL.Clear;
    qry.Open('select * from camara_fria');

    value.Items.Clear;
    value.BeginUpdate;

    for x := 0 to qry.RecordCount - 1 do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt           := TListItemText(Objects.FindDrawable('codigo'));
        txt.Text      := formatfloat('0000', qry.FieldByName('cod_camara').AsFloat);
        txt.TagString := qry.FieldByName('cod_camara').AsString;

        txt      := TListItemText(Objects.FindDrawable('desc'));
        txt.Text := qry.FieldByName('descricao').AsString;

        img        := TListItemImage(Objects.FindDrawable('Image'));
        img.Bitmap := imageForma.Bitmap;
      end;
      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;

end;

function TCamaraFria.RetornaCamaraFriaVendedor(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry                         := TFDQuery.create(nil);
    qry.Connection              := DmDados.ConexaoInterna;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active                  := false;
    qry.SQL.Clear;
    qry.SQL.Add(' SELECT u.cod_camara, c.descricao FROM usuarios u left outer join camara_fria c on (c.cod_camara = u.cod_camara) ' +
      ' where u.cod_user = :COD_USER ');
    qry.ParamByName('COD_USER').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
      result := '0'
    else
      result := formatfloat('0000', qry.FieldByName('cod_camara').AsFloat);

  finally
    FreeAndNil(qry);
  end;

end;

end.
