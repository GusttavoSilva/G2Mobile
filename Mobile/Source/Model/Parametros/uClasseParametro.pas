unit uClasseParametro;

interface

uses
  FMX.ListView,
  uDmDados,
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
  uInterfaceParametro,
  FMX.Objects,
  uFrmUtilFormate,
  Form_Mensagem,
  uRESTDWPoolerDB;

const

  CONST_DELETEPARAMETRO = 'DELETE FROM PARAMETROS';

  CONST_PARAMETROSERVIDOR = 'SELECT TOP 1 BLOQ_CLIENTES, DOC_AVISTA, REG_DESCTO, LOGO, ' +
    '  ISNULL((SELECT ID_TABLET FROM T_TABLETS WHERE DEVICEID = :deviceID' +
    ' AND STATUS = 1),0) AS ID_TABLET, getdate() AS DT_SINC, BLOQ_VLR_MIN, UNID_MED  FROM T_CONFIG';

  CONST_INSERTPARAMETROS =
    ' INSERT INTO PARAMETROS ( BLOQ_CLIENTES, DOC_AVISTA, REG_DESCTO, LOGO, ID_TABLET, BLOQ_VLR_MIN, DT_SINC, UNID_MED) VALUES ' +
    '( :BLOQ_CLIENTES, :DOC_AVISTA, :REG_DESCTO, :LOGO, :ID_TABLET, :BLOQ_VLR_MIN, :DT_SINC, :UNID_MED)';

  CONST_LOGOEMPRESA = 'SELECT LOGO FROM PARAMETROS';

  CONST_PARAMETRO = 'SELECT * FROM PARAMETROS';

  CONST_VALIDATABLET = 'select id_tablet from parametros';

type

  TParametros = class(TInterfacedObject, iModelParametros)
  private
    FQry: TFDQuery;
    FRdwSQLTemp: TRESTDWClientSQL;

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelParametros;

    function BuscaParametrosServidor(DeviceId: String; ADataSet: TFDMemTable): iModelParametros;
    function PopulaParametrosSqLite(ADataSet: TFDMemTable): iModelParametros;
    function LimpaTabelaParametros: iModelParametros;
    function RetornaLogo(AImage: TImage): iModelParametros;
    function VerificaTablet: Boolean;
    function Parametro(value: String): Variant;
  end;

implementation

{ TParametros }

class function TParametros.new: iModelParametros;
begin
  result := self.create;
end;

constructor TParametros.create;
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

destructor TParametros.destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(FRdwSQLTemp);
  inherited;
end;

function TParametros.LimpaTabelaParametros: iModelParametros;
begin
  result := self;
  FQry.ExecSQL(CONST_DELETEPARAMETRO);
end;

function TParametros.BuscaParametrosServidor(DeviceId: String; ADataSet: TFDMemTable): iModelParametros;
begin
  result := self;

  FRdwSQLTemp.SQL.Text := CONST_PARAMETROSERVIDOR;
  FRdwSQLTemp.ParamByName('deviceID').AsString := DeviceId;
  FRdwSQLTemp.Active := True;
  FRdwSQLTemp.RecordCount;
  ADataSet.CopyDataSet(FRdwSQLTemp, [coStructure, coRestart, coAppend]);

end;

function TParametros.PopulaParametrosSqLite(ADataSet: TFDMemTable): iModelParametros;
var
  i: Integer;
  foto: TStream;
  img_foto: TImage;
begin
  result := self;
  img_foto := TImage.create(nil);
  ADataSet.First;
  try
    FQry.SQL.Text := CONST_INSERTPARAMETROS;

    foto := TStream.create;
    foto := ADataSet.CreateBlobStream(ADataSet.FieldByName('LOGO'), TBlobStreamMode.bmRead);
    img_foto.Bitmap.LoadFromStream(foto);

    FQry.ParamByName('BLOQ_CLIENTES').AsInteger := ADataSet.FieldByName('BLOQ_CLIENTES').AsInteger;
    FQry.ParamByName('DOC_AVISTA').AsInteger := ADataSet.FieldByName('DOC_AVISTA').AsInteger;
    FQry.ParamByName('REG_DESCTO').AsInteger := ADataSet.FieldByName('REG_DESCTO').AsInteger;
    FQry.ParamByName('LOGO').Assign(img_foto.Bitmap);
    FQry.ParamByName('ID_TABLET').AsInteger := ADataSet.FieldByName('ID_TABLET').AsInteger;
    FQry.ParamByName('BLOQ_VLR_MIN').AsInteger := ADataSet.FieldByName('BLOQ_VLR_MIN').AsInteger;
    FQry.ParamByName('DT_SINC').AsDateTime := ADataSet.FieldByName('DT_SINC').AsDateTime;
    FQry.ParamByName('UNID_MED').AsInteger := ADataSet.FieldByName('UNID_MED').AsInteger;
    FQry.ExecSQL;

  finally
    FreeAndNil(img_foto);
  end;

end;

function TParametros.RetornaLogo(AImage: TImage): iModelParametros;
var
  vStream: TMemoryStream;
begin

  result := self;

  FQry.Open(CONST_LOGOEMPRESA);

  vStream := TMemoryStream.create;
  TBlobField(FQry.FieldByName('logo')).SaveToStream(vStream);
  vStream.Position := 0;
  AImage.MultiResBitmap.LoadItemFromStream(vStream, 1);
  vStream.Free;

end;

function TParametros.Parametro(value: String): Variant;
begin
  FQry.Open(CONST_PARAMETRO);

  result := FQry.FieldByName(value).AsVariant;
end;

function TParametros.VerificaTablet: Boolean;
begin

  FQry.Open(CONST_VALIDATABLET);

{$IF DEFINED (ANDROID)}
  if (FQry.FieldByName('id_tablet').AsInteger <> 0) then

    result := True
  else
    result := false;
{$ENDIF}
{$IFDEF MSWINDOWS}
  result := True
{$ENDIF}
end;

end.
