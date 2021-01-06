unit DM;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDWConstsData, uRESTDWPoolerDB, uRESTDWBase, uDWAbout, uDWConsts, uRESTDWServerEvents,
  uDWJSONObject, IPPeerClient, REST.Client, REST.Authenticator.Basic,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Response.Adapter,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.DApt, uDWDatamodule;

type
  TDMExp = class(TServerMethodDataModule)
    RESTClientPooler1: TRESTClientPooler;
    DWClientEvents1: TDWClientEvents;
    RESTDWDataBase1: TRESTDWDataBase;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetPedidos;
    procedure SetPedidosItem;
  end;

var
  DMExp: TDMExp;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uDmDados;

{$R *.dfm}

{ TDataModule1 }

procedure TDMExp.SetPedidos;
const
  _SQL =
    'SELECT                       '+
	  '       *                     '+
    'FROM   venda                 ';
var
  JSONValue   : TJSONValue;
  QuerySinc6      : TFDQuery;
  Params : TDWParams;
  VError: string;
begin
    JSONValue   := TJSONValue.Create;
    QuerySinc6 := TFDQuery.Create(nil);
    QuerySinc6.Connection := Dmdados.ConexaoInterna;
    TRY
        QuerySinc6.Active := False;
        QuerySinc6.SQL.Clear;
        QuerySinc6.SQL.Text := _SQL;
        QuerySinc6.Active := True;
      TRY
        //QuerySinc6.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        //Cria o evento
        DWClientEvents1.CreateDWParams('SetPedidos', Params);

        JSONValue.LoadFromDataset('pedidosinc', QuerySinc6, True, Params.JsonMode, '');
        Params.ItemsString['Pedidos'].AsString := JSONValue.ToJSON;

        //Envia o evento
        DWClientEvents1.SendEvent('SetPedidos', Params, VError);
      Except
      //
      END;
    FINALLY
      JSONValue.Free;
      if QuerySinc6.Active then
        FreeAndNil(QuerySinc6);
    END;
end;

procedure TDMExp.SetPedidosItem;
const
  _SQL =
    'SELECT                       '+
	  '       *                     '+
    'FROM   venditem                 ';
var
  JSONValue   : TJSONValue;
  QuerySinc7      : TFDQuery;
  Params : TDWParams;
  VError: string;
begin
    JSONValue   := TJSONValue.Create;
    QuerySinc7 := TFDQuery.Create(nil);
    QuerySinc7.Connection := Dmdados.ConexaoInterna;
    TRY
        QuerySinc7.Active := False;
        QuerySinc7.SQL.Clear;
        QuerySinc7.SQL.Text := _SQL;
        QuerySinc7.Active := True;
      TRY
        //QuerySinc7.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        //Cria o evento
        DWClientEvents1.CreateDWParams('SetPedidosItem', Params);

        JSONValue.LoadFromDataset('pedidoitemsinc', QuerySinc7, True, Params.JsonMode, '');
        Params.ItemsString['PedidosItem'].AsString := JSONValue.ToJSON;

        //Envia o evento
        DWClientEvents1.SendEvent('SetPedidosItem', Params, VError);
      Except
      //
      END;
    FINALLY
      JSONValue.Free;
      if QuerySinc7.Active then
        FreeAndNil(QuerySinc7);
    END;
end;

end.
