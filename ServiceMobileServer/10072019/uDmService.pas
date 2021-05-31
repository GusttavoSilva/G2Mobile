UNIT uDmService;

INTERFACE

USES
  System.SysUtils,
  Classes,
  System.IOUtils,
  SysTypes,
  UDWDatamodule,
  System.JSON,
  System.DateUtils,
  UDWJSONObject,
  Dialogs,
  ServerUtils,
  UDWConsts,
  FireDAC.Dapt,
  UDWConstsData,
  FireDAC.Phys.FBDef,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  FireDAC.Stan.StorageJSON,
  URESTDWPoolerDB,
  URestDWDriverFD,
  uConsts,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,
  Vcl.SvcMgr, FireDAC.Stan.Param, System.StrUtils, System.NetEncoding,
  FireDAC.DatS, FireDAC.Dapt.Intf,
  uRESTDWServerEvents, FireDAC.Comp.DataSet, uDWAbout, IniFiles;

TYPE
  TServerMethodDM = CLASS(TServerMethodDataModule)
    RESTDWPoolerDB1: TRESTDWPoolerDB;
    Server_FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDTransaction1: TFDTransaction;
    QAux: TFDQuery;
    memVendaSinc: TFDMemTable;
    memVendaSinccontroleinterno: TIntegerField;
    memVendaSinccpf_cnpj: TStringField;
    memVendaSincformapagto: TIntegerField;
    memVendaSincvendedor: TStringField;
    memVendaSincemissao: TDateField;
    memVendaSincvalor: TFloatField;
    memVendaSincdesconto: TFloatField;
    memVendaSinctotal: TFloatField;
    memVendaSincsituacao: TStringField;
    memVendaItemSinc: TFDMemTable;
    memVendaItemSinccontroleinterno: TIntegerField;
    memVendaItemSinccod_prod: TIntegerField;
    memVendaItemSinccod_venda: TIntegerField;
    memVendaItemSincnomeproduto: TStringField;
    memVendaItemSincquantidade: TFloatField;
    memVendaItemSincvalor: TFloatField;
    memVendaItemSincdesconto: TFloatField;
    memVendaItemSinctotal: TFloatField;
    memVendaItemSincunidade: TStringField;
    memVendaItemSincsituacao: TStringField;
    memVendaItemSinccomplemento: TStringField;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    DWServerEvents1: TDWServerEvents;
    RESTDWDataBase1: TRESTDWDataBase;
    RESTDWDriverFD1: TRESTDWDriverFD;
    procedure DWServerEvents1EventsValidarReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetClientesReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetProdutosReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetClienteInfoReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetProdutoInfoReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetVendasProdReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetVendasReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetFichaFinanceiraReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetNfeInfoReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetProdutoInfoSincReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetClienteInfoSincReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetFormapagtoSincReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetUsuariosSincReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetPedidoAttSincReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetPedidoItemAttSincReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsSetPedidosReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsSetPedidosItemReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetPedidoReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetItensPedidoReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsUpdateItemReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsUpdatePedidoReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsPedidoRelatorioReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsItensRelatorioReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsPedidoItensRelatorioReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetIdVendaReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsResumoAbateReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetLatLongReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetRotaReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetRelatorioVendedorReplyEvent
      (var Params: TDWParams; var Result: string);
    PROCEDURE Server_FDConnectionBeforeConnect(Sender: TObject);
    procedure ServerMethodDataModuleReplyEvent(SendType: TSendEvent;
      Context: string; var Params: TDWParams; var Result: string;
      AccessTag: string);
    procedure DWServerEvents1EventsGetFotoProdutoReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetPedidoFinalizadoReplyEvent
      (var Params: TDWParams; var Result: string);
    procedure DWServerEvents1EventsGetUsuarioCPReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsGetVendasCPReplyEvent(var Params: TDWParams;
      var Result: string);
  PRIVATE
    FUNCTION ConsultaBanco(VAR Params: TDWParams): STRING; OVERLOAD;
    function ValidarUsuario(JSON: String): String;
    function ProxCod(Tabela, Campo, Formato, Condicao: String): String;
    function iif(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  ServerMethodDM: TServerMethodDM;


IMPLEMENTATION

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

FUNCTION TServerMethodDM.ConsultaBanco(VAR Params: TDWParams): STRING;
VAR
  VSQL: STRING;
  JSONValue: TJSONValue;
  FdQuery: TFDQuery;
BEGIN
  IF Params.ItemsString['SQL'] <> NIL THEN
  BEGIN
    JSONValue := UDWJSONObject.TJSONValue.Create;
    JSONValue.Encoding := Encoding;
    IF Params.ItemsString['SQL'].Value <> '' THEN
    BEGIN
      IF Params.ItemsString['TESTPARAM'] <> NIL THEN
        Params.ItemsString['TESTPARAM'].SetValue('OK, OK');
      VSQL := Params.ItemsString['SQL'].Value;
{$IFDEF FPC}
{$ELSE}
      FdQuery := TFDQuery.Create(NIL);
      TRY
        FdQuery.Connection := Server_FDConnection;
        FdQuery.SQL.Add(VSQL);
        JSONValue.LoadFromDataset('sql', FdQuery, EncodedData);
        Result := JSONValue.ToJSON;
      FINALLY
        JSONValue.Free;
        FdQuery.Free;
      END;
{$ENDIF}
    END;
  END;
END;

procedure TServerMethodDM.ServerMethodDataModuleReplyEvent(SendType: TSendEvent;
  Context: string; var Params: TDWParams; var Result: string;
  AccessTag: string);
VAR
  JSONObject: TJSONObject;
BEGIN
  JSONObject := TJSONObject.Create;
  CASE SendType OF
    SePOST:
      BEGIN
        IF UpperCase(Context) = UpperCase('EMPLOYEE') THEN
          Result := ConsultaBanco(Params)
        ELSE
        BEGIN
          JSONObject.AddPair(TJSONPair.Create('STATUS', 'NOK'));
          JSONObject.AddPair(TJSONPair.Create('MENSAGEM',
            'Método não encontrado'));
          Result := JSONObject.ToJSON;
        END;
      END;
  END;
  JSONObject.Free;
END;

PROCEDURE TServerMethodDM.Server_FDConnectionBeforeConnect(Sender: TObject);
var
  ArqIni: TIniFile;
  LPort: Integer;
  LServidor: string;
  LUserName: string;
  LDatabase: string;
  LPassword: string;
begin
  ArqIni := TIniFile.Create(CPathIniFile + '\cfg.ini');
  try
    LPort := ArqIni.ReadInteger('Dados','Porta', 0);
    LUserName := ArqIni.ReadString('Dados', 'Usuario' , '');
    LPassword := ArqIni.ReadString('Dados', 'Senha'   , '');
    LDatabase := ArqIni.ReadString('Dados', 'Banco'   , '');
    LServidor := ArqIni.ReadString('Dados', 'Servidor', '');

    TFDConnection(Sender).Params.Clear;
    TFDConnection(Sender).Params.Add('DriverID=MSSQL');
    TFDConnection(Sender).Params.Add('Server='    + LServidor);
    TFDConnection(Sender).Params.Add('Database='  + LDatabase);
    TFDConnection(Sender).Params.Add('User_Name=' + LUserName);
    TFDConnection(Sender).Params.Add('Password='  + LPassword);
    TFDConnection(Sender).DriverName := 'MSSQL';
    TFDConnection(Sender).LoginPrompt := FALSE;
    TFDConnection(Sender).UpdateOptions.CountUpdatedRecords := FALSE;
  finally
    ArqIni.Free;
  end;

END;

procedure TServerMethodDM.DWServerEvents1EventsGetClienteInfoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT                       ' + '       *                     ' +
    'FROM T_PESSOA                ' + 'WHERE COD_PESSOA = :COD      ';
var
  JSONValue: TJSONValue;
  Query3: TFDQuery;
begin
  if (Params.ItemsString['Cliente'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query3 := TFDQuery.Create(nil);
    Query3.Connection := Server_FDConnection;
    TRY
      Query3.Active := FALSE;
      Query3.SQL.Clear;
      Query3.SQL.Text := _SQL;
      Query3.ParamByName('COD').AsInteger := Params.ItemsString['Cliente']
        .AsInteger;
      Query3.Active := True;
      TRY
        // Query3.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('cliente', Query3, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query3.Active then
        FreeAndNil(Query3);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetClienteInfoSincReplyEvent
  (var Params: TDWParams; var Result: string);
const

    {
        t.situacao = 1  --- LIBERADO
                     0  --- BLOQUEADO
    }
  _SQL =
    'select t.cod_pessoa, t.nome_razao, t.nome_fant, t.endereco, t.bairro, c.municipio, t.telefone, t.cpf_cnpj, t.email, t.cod_vend, t.cod_doc, t.situacao, 																									'
    +
    'case when isnull(t1.vlr_crd, 0) < isnull(t2.sld_chq+t3.sld_dev, 0) then 0 else 1 end as credito,																																				'
    +
    'case when min_dta is not null then 0 else 1 end as atraso																																														'
    +
    'from t_cidade c, t_pessoa t left outer join (select tc.cod_cliente, tc.credito as vlr_crd from t_credito tc where cod_cliente = 15																															'
    +
    'and tc.cod = (select max(cod) from t_credito where cod_cliente = tc.cod_cliente)) t1 on (t.cod_pessoa = t1.cod_cliente)																														'
    +
    'left outer join (select cod_cliente, sum(valor) as sld_chq from v_cheques_receb where status = 0 group by cod_cliente) t2 on (t.cod_pessoa = t2.cod_cliente)																					'
    +
    'left outer join (select cod_cliente, sum(sld_dev) as sld_dev from v_contas_receb where status = ''A'' group by cod_cliente) t3 on (t.cod_pessoa = t3.cod_cliente)																				'
    + 'left outer join (select cod_cliente, min(data_venc) as min_dta from t_contas_receb where status = ''A'' and data_venc < (select dateadd(day, dias_carencia, getdate()) from t_config) group by cod_cliente) t4 on (t.cod_pessoa = t4.cod_cliente)'
    +
    'where t.cod_vend = :cod	and t.cod_cidade = c.cod_cidade	and t.situacao = 1																																																				';
var
  JSONValue: TJSONValue;
  QuerySinc2: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc2 := TFDQuery.Create(nil);
  QuerySinc2.Connection := Server_FDConnection;
  TRY
    QuerySinc2.Active := FALSE;
    QuerySinc2.SQL.Clear;
    QuerySinc2.SQL.Text := _SQL;
    QuerySinc2.ParamByName('cod').AsInteger := Params.ItemsString['Cod']
      .AsInteger;
    QuerySinc2.Active := True;
    TRY
      // QuerySinc2.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('clientesinc', QuerySinc2, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc2.Active then
      FreeAndNil(QuerySinc2);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetClientesReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT TOP(100)     ' + ' COD_PESSOA,       ' + ' NOME_FANT,        '
    + ' ENDERECO,         ' + ' BAIRRO,           ' + ' CLIENTE,          ' +
    ' FORNECEDOR        ' + 'FROM T_PESSOA      ' + 'ORDER BY COD_PESSOA DESC';

  _SQL2 = 'SELECT TOP(100)               ' + ' COD_PESSOA,                 ' +
    ' NOME_FANT,                  ' + ' ENDERECO,                   ' +
    ' BAIRRO,                     ' + ' CLIENTE,                    ' +
    ' FORNECEDOR                  ' + 'FROM T_PESSOA                ' +
    'WHERE NOME_FANT = :NOME_FANT ' + 'ORDER BY COD_PESSOA DESC          ';
var
  JSONValue: TJSONValue;
  Query1: TFDQuery;
begin
  if (Params.ItemsString['Get'].AsString.Equals(EmptyStr)) then
  begin
    JSONValue := TJSONValue.Create;
    Query1 := TFDQuery.Create(nil);
    Query1.Connection := Server_FDConnection;
    TRY
      Query1.Active := FALSE;
      Query1.SQL.Clear;
      Query1.SQL.Text := _SQL;
      Query1.Active := True;
      TRY
        // Query1.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('clientes', Query1, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except

      END;
    FINALLY
      JSONValue.Free;
      if Query1.Active then
        FreeAndNil(Query1);
    END;
  end
  else
  begin
    JSONValue := TJSONValue.Create;
    Query1 := TFDQuery.Create(nil);
    Query1.Connection := Server_FDConnection;
    TRY
      Query1.Active := FALSE;
      Query1.SQL.Clear;
      Query1.SQL.Text := _SQL2;
      Query1.ParamByName('NOME_FANT').AsString := Params.ItemsString
        ['Get'].AsString;
      Query1.Active := True;
      if Query1.IsEmpty then
        Params.ItemsString['Result'].AsString := 'fail'
      else
      begin
        TRY
          // Query1.Open;
          JSONValue.JsonMode := Params.JsonMode;
          JSONValue.Encoding := Encoding;
          JSONValue.LoadFromDataset('clientes', Query1, True,
            Params.JsonMode, '');
          Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
        Except

        END;
      end;
    FINALLY
      JSONValue.Free;
      if Query1.Active then
        FreeAndNil(Query1);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetFichaFinanceiraReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT Top (100) *                           ' +
    'FROM v_contas_receb C                       ' +
    'WHERE 1 =1 and c.cod_cliente = :doc_cliente ' +
    'order by data_emis desc;                    ';
  _SQL2 = 'SELECT Top (100) *                           ' +
    'FROM v_contas_receb C                       ' +
    'WHERE 1 =1 and c.cod_cliente = :doc_cliente ' +
    'and status = :con_situacao                  ' +
    'order by data_emis desc;                    ';
var
  JSONValue: TJSONValue;
  Query7: TFDQuery;
begin
  if ((Params.ItemsString['GetFicha'].AsString <> EmptyStr) and
    (Params.ItemsString['Situacao'].AsString <> EmptyStr)) then
  begin
    JSONValue := TJSONValue.Create;
    Query7 := TFDQuery.Create(nil);
    Query7.Connection := Server_FDConnection;
    TRY
      Query7.Active := FALSE;
      Query7.SQL.Clear;
      if Params.ItemsString['Situacao'].AsString.Equals('T') then
      begin
        Query7.SQL.Text := _SQL;
        Query7.ParamByName('doc_cliente').AsInteger := Params.ItemsString
          ['GetFicha'].AsInteger
      end
      else
      begin
        Query7.SQL.Text := _SQL2;
        Query7.ParamByName('doc_cliente').AsInteger := Params.ItemsString
          ['GetFicha'].AsInteger;
        Query7.ParamByName('con_situacao').AsString := Params.ItemsString
          ['Situacao'].AsString;
      end;
      Query7.Active := True;
      TRY
        // Query7.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('ficha', Query7, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query7.Active then
        FreeAndNil(Query7);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetFormapagtoSincReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT                       ' + '       *                     ' +
    'FROM T_DOCUMENTO            ';
var
  JSONValue: TJSONValue;
  QuerySinc3: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc3 := TFDQuery.Create(nil);
  QuerySinc3.Connection := Server_FDConnection;
  TRY
    QuerySinc3.Active := FALSE;
    QuerySinc3.SQL.Clear;
    QuerySinc3.SQL.Text := _SQL;
    QuerySinc3.Active := True;
    TRY
      // QuerySinc3.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('formapagtsinc', QuerySinc3, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc3.Active then
      FreeAndNil(QuerySinc3);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetFotoProdutoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQLFOTO =
    'SELECT cod_prod, nome_arq, foto_arq from t_produto_foto ORDER BY cod_prod OFFSET %s ROWS FETCH NEXT %s ROWS ONLY';

  _SQL2008 = 'Select cod_prod, nome_arq, foto_arq ' +
    'from                                             ' +
    '(                                                ' +
    '	select cod_prod, nome_arq, foto_arq,            ' +
    '	ROW_NUMBER() OVER(ORDER by COD_PROD) as Seq     ' +
    '	from t_produto_foto                             ' +
    ')t                                               ' +
    'where Seq between %s and %s                       ';
var
  JSONValue: TJSONValue;
  QuerySinc1, qryAux: TFDQuery;
  ljo: TJSONObject;
  i: integer;
  StreamIn: TStream;
  StreamOut: TStringStream;
  Result1: TJSONArray;
  Fotos: string;
  LFirst: integer;
  LShow: integer;
begin
  if (Params.ItemsString['pFirst'] <> nil) and
    not(Params.ItemsString['pFirst'].AsString.Trim.IsEmpty) then
    LFirst := Params.ItemsString['pFirst'].AsInteger;
  if (Params.ItemsString['pShow'] <> nil) and
    not(Params.ItemsString['pShow'].AsString.Trim.IsEmpty) then
    LShow := Params.ItemsString['pShow'].AsInteger;

  JSONValue := TJSONValue.Create;

  qryAux := TFDQuery.Create(nil);
  qryAux.Connection := Server_FDConnection;
  // if not Params.ItemsString['Cod'].AsString.IsEmpty then
  // begin
  TRY

    qryAux.Active := FALSE;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := Format(_SQL2008, [LFirst.ToString, LShow.ToString]);
    // qryAux.Params[0].AsString := Params.ItemsString['Cod'].AsString;
    qryAux.Active := True;
    qryAux.Last;
    Params.ItemsString['pResultCount'].AsInteger := qryAux.RecordCount;

    if not qryAux.IsEmpty or not qryAux.FieldByName('foto_arq').IsNull then
    begin
      try
        if qryAux.Active then
        begin
          if qryAux.RecordCount > 0 then
          begin
            Result1 := TJSONArray.Create;
            try
              qryAux.First;
              while not(qryAux.Eof) do
              begin
                ljo := TJSONObject.Create;
                for i := 0 to qryAux.FieldCount - 1 do
                begin
                  if qryAux.Fields[i].IsNull then
                    // Tratando valores nulos para não "quebrar" a aplicação
                    ljo.AddPair(qryAux.Fields[i].DisplayName, EmptyStr)
                  else
                  begin
                    if qryAux.Fields[i].IsBlob then
                    begin
                      StreamIn := qryAux.CreateBlobStream
                        (qryAux.Fields[i], bmRead);
                      StreamOut := TStringStream.Create;
                      TNetEncoding.Base64.Encode(StreamIn, StreamOut);
                      StreamOut.Position := 0;
                      ljo.AddPair(qryAux.Fields[i].DisplayName,
                        StreamOut.DataString);
                    end
                    else
                    begin
                      ljo.AddPair(qryAux.Fields[i].DisplayName,
                        qryAux.Fields[i].Value);
                    end;
                  end;
                end;
                Result1.AddElement(ljo);
                // Fotos := ljo.ToJSON;
                // Params.ItemsString['Result'].AsString := Fotos;
                qryAux.Next;
              end;
            finally
            end;
          end;
        end;
      finally
        Params.ItemsString['Fotos'].AsString := Result1.ToString;
      end;
    end
    else
      Params.ItemsString['Fotos'].AsString := '0';

  finally
    if qryAux.Active then
      FreeAndNil(qryAux);
  end;
  // end
  // else
  // Params.ItemsString['Result'].AsString := '0';
end;

procedure TServerMethodDM.DWServerEvents1EventsGetIdVendaReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT controleinterno from t_vendamobile where vendedor = :vendedor order by controleinterno desc';
var
  JSONValue: TJSONValue;
  Query3: TFDQuery;
begin
  if (Params.ItemsString['Vendedor'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query3 := TFDQuery.Create(nil);
    Query3.Connection := Server_FDConnection;
    TRY
      Query3.Active := FALSE;
      Query3.SQL.Clear;
      Query3.SQL.Text := _SQL;
      Query3.ParamByName('vendedor').AsString := Params.ItemsString
        ['Vendedor'].AsString;
      Query3.Active := True;
      TRY
        // Query3.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('idclientevenda', Query3, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query3.Active then
        FreeAndNil(Query3);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetItensPedidoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT                       ' + '       *                     ' +
    'FROM T_VENDAITEMMOBILE                ' +
    'WHERE COD_VENDA = :CONTROLEINTERNO AND vendedor = :vendedor     ';
var
  JSONValue: TJSONValue;
  Query4: TFDQuery;
begin
  if (Params.ItemsString['Pedido'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query4 := TFDQuery.Create(nil);
    Query4.Connection := Server_FDConnection;
    TRY
      Query4.Active := FALSE;
      Query4.SQL.Clear;
      Query4.SQL.Text := _SQL;
      Query4.ParamByName('CONTROLEINTERNO').AsInteger := Params.ItemsString
        ['Pedido'].AsInteger;
      Query4.ParamByName('vendedor').AsString := Params.ItemsString
        ['Vendedor'].AsString;
      Query4.Active := True;
      TRY
        // Query4.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('itenspedido', Query4, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetLatLongReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT latitude,                      ' +
    '       longitude                     ' +
    'FROM T_VENDAMOBILE                ' +
    'WHERE controleinterno = :CONTROLEINTERNO AND vendedor = :vendedor     ';
var
  JSONValue: TJSONValue;
  Query4: TFDQuery;
begin
  if (Params.ItemsString['Venda'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query4 := TFDQuery.Create(nil);
    Query4.Connection := Server_FDConnection;
    TRY
      Query4.Active := FALSE;
      Query4.SQL.Clear;
      Query4.SQL.Text := _SQL;
      Query4.ParamByName('CONTROLEINTERNO').AsInteger := Params.ItemsString
        ['Venda'].AsInteger;
      Query4.ParamByName('vendedor').AsString := Params.ItemsString
        ['Vendedor'].AsString;
      Query4.Active := True;
      TRY
        // Query4.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('latlong', Query4, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetNfeInfoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = '   select n.cod_nota,                                             ' +
    '     n.data_emissao,                                              ' +
    '     n.data_saida_entra,                                          ' +
    '     n.hora,                                                      ' +
    '     n.pedido,                                                    ' +
    '     p.cod_pessoa,                                                ' +
    '     n.cpf_cnpj_r_d,                                              ' +
    '     p.nome_razao,                                                ' +
    '     n.vr_total_nota,                                             ' +
    '     n.forma_pgto,                                                ' +
    '     n.status,                                                    ' +
    '     n.nfeaprovada,                                               ' +
    '     n.lote,                                                      ' +
    '     n.protocolonfe,                                              ' +
    '     ti.descricao,                                                ' +
    '     ti.quant,                                                    ' +
    '     ti.valor_unitario,                                           ' +
    '     ti.data_emissao,                                             ' +
    '     ti.valor_total,                                              ' +
    '     ti.ncm,                                                      ' +
    '     ti.cfop,                                                     ' +
    '     ti.valor_icms,                                               ' +
    '     ti.valor_ipi                                                 ' +
    '   from t_nota_emitidas n,                                        ' +
    '     t_pessoa p, t_nota_itens ti                                  ' +
    '   where n.nf_sai_en = 2                                          ' +
    '   and                                                            ' +
    '      n.cod_nota = ti.cod_nota  and n.cod_empresa = ti.cod_empresa' +
    '   and                                                            ' +
    '     p.cpf_cnpj=n.cpf_cnpj_r_d                                    ' +
    '   and                                                            ' +
    '     p.cod_pessoa= :doc_cliente                                   ' +
    '   and                                                            ' +
    '     n.cod_nota = :doc_nota                                       ' +
    '   order by n.data_emissao desc                                   ';

var
  JSONValue: TJSONValue;
  Query7: TFDQuery;
begin
  if ((Params.ItemsString['CodCliente'].AsString <> EmptyStr) and
    (Params.ItemsString['CodNota'].AsString <> EmptyStr)) then
  begin
    JSONValue := TJSONValue.Create;
    Query7 := TFDQuery.Create(nil);
    Query7.Connection := Server_FDConnection;
    TRY
      Query7.Active := FALSE;
      Query7.SQL.Clear;
      Query7.SQL.Text := _SQL;
      Query7.ParamByName('doc_cliente').AsInteger := Params.ItemsString
        ['CodCliente'].AsInteger;
      Query7.ParamByName('doc_nota').AsInteger := Params.ItemsString['CodNota']
        .AsInteger;
      Query7.Active := True;
      TRY
        // Query7.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('infonfe', Query7, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query7.Active then
        FreeAndNil(Query7);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetPedidoAttSincReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'select TOP(500) controleinterno,               ' +
    '	cpf_cnpj,                     ' + '	formapagto,					' +
    '	vendedor,                     ' + '	convert(varchar(10), emissao, 103) as emissao,                    ' +
    '	valor,                      ' + '	desconto,                   ' +
    '	total,                       ' + '	cod_cliente,                   ' +
    ' data_emb, ' + ' cod_ret, ' + ' comissao ' +
    'from t_vendamobile              ' + 'where vendedor = :vendedor       ' +
    'order by emissao asc	         ';
var
  JSONValue: TJSONValue;
  QuerySinc5: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc5 := TFDQuery.Create(nil);
  QuerySinc5.Connection := Server_FDConnection;
  TRY
    QuerySinc5.Active := FALSE;
    QuerySinc5.SQL.Clear;
    QuerySinc5.SQL.Text := _SQL;
    QuerySinc5.ParamByName('vendedor').AsString := Params.ItemsString
      ['Vendedor'].AsString;
    QuerySinc5.Active := True;
    QuerySinc5.Connection.Commit;
    TRY
      // QuerySinc5.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('pedidosinc', QuerySinc5, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc5.Active then
      FreeAndNil(QuerySinc5);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetPedidoFinalizadoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'select cod_pedcar_mobile, status, valor_final FROM t_pedidovenda WHERE status = 3 and not cod_pedcar_mobile is null';
var
  JSONValue: TJSONValue;
  QuerySinc6: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc6 := TFDQuery.Create(nil);
  QuerySinc6.Connection := Server_FDConnection;
  TRY
    QuerySinc6.Active := FALSE;
    QuerySinc6.SQL.Clear;
    QuerySinc6.SQL.Text := _SQL;
    QuerySinc6.Active := True;
    QuerySinc6.Connection.Commit;
    TRY
      // QuerySinc6.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('pedidofinalizado', QuerySinc6, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc6.Active then
      FreeAndNil(QuerySinc6);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetPedidoItemAttSincReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'select											' + '	vi.cod_prod,								'
    + '	vi.cod_venda,								' +
    '	vi.nomeproduto,								' +
    '	vi.quantidade,								' + '	vi.valor,									' +
    '	vi.desconto,								' + '	vi.total,									' +
    '	vi.unidade,									' + '	vi.vendedor									' +
    'from  t_vendaitemmobile vi						' +
    'where vi.vendedor = :vendedor and vi.cod_venda = :cod ';
var
  JSONValue: TJSONValue;
  QuerySinc6: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc6 := TFDQuery.Create(nil);
  QuerySinc6.Connection := Server_FDConnection;
  TRY
    QuerySinc6.Active := FALSE;
    QuerySinc6.SQL.Clear;
    QuerySinc6.SQL.Text := _SQL;
    QuerySinc6.ParamByName('vendedor').AsString := Params.ItemsString
      ['Vendedor'].AsString;
    QuerySinc6.ParamByName('cod').AsInteger := Params.ItemsString['Cod']
      .AsInteger;
    QuerySinc6.Active := True;
    QuerySinc6.Connection.Commit;
    TRY
      // QuerySinc6.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('pedidoitemsinc', QuerySinc6, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc6.Active then
      FreeAndNil(QuerySinc6);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetPedidoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT                       ' + '       *                     ' +
    'FROM T_VENDAMOBILE           ' + 'WHERE situacao = :situacao   ';
  _SQLTODAS = 'SELECT                       ' + '       *                     '
    + 'FROM T_VENDAMOBILE           ';
var
  JSONValue: TJSONValue;
  QuerySinc1: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc1 := TFDQuery.Create(nil);
  QuerySinc1.Connection := Server_FDConnection;
  if Params.ItemsString['Situacao'].AsString.Equals('todas') then
  begin
    TRY
      QuerySinc1.Active := FALSE;
      QuerySinc1.SQL.Clear;
      QuerySinc1.SQL.Text := _SQLTODAS;
      // QuerySinc1.ParamByName('situacao').AsString := Params.ItemsString['Situacao'].AsString;
      QuerySinc1.Active := True;
      TRY
        // QuerySinc1.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('pedidos', QuerySinc1, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if QuerySinc1.Active then
        FreeAndNil(QuerySinc1);
    END;
  end
  else
  begin
    TRY
      QuerySinc1.Active := FALSE;
      QuerySinc1.SQL.Clear;
      QuerySinc1.SQL.Text := _SQL;
      QuerySinc1.ParamByName('situacao').AsString := Params.ItemsString
        ['Situacao'].AsString;
      QuerySinc1.Active := True;
      TRY
        // QuerySinc1.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('pedidos', QuerySinc1, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if QuerySinc1.Active then
        FreeAndNil(QuerySinc1);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetProdutoInfoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT                       ' + '       *                     ' +
    'FROM T_PRODUTO                ' + 'WHERE COD_PROD = :COD      ';
var
  JSONValue: TJSONValue;
  Query4: TFDQuery;
begin
  if (Params.ItemsString['Produto'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query4 := TFDQuery.Create(nil);
    Query4.Connection := Server_FDConnection;
    TRY
      Query4.Active := FALSE;
      Query4.SQL.Clear;
      Query4.SQL.Text := _SQL;
      Query4.ParamByName('COD').AsInteger := Params.ItemsString['Produto']
        .AsInteger;
      Query4.Active := True;
      TRY
        // Query4.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('produto', Query4, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetProdutoInfoSincReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL =
    'select tp.cod_prod, 																																		'
    +
    '		tp.desc_ind,																																		'
    +
    '		tp.unid_med,																																		'
    +
    '		tp.validade, tp.tipo_calc, tp.quant_cx, tp.peso_padrao,																																		'
    +
    '		coalesce(tg.descricao_grupo,''SEM GRUPO'') as grupo_com,																								'
    +
    '		coalesce(tpr.preco_venda, 0) as valor_prod,																											'
    +
    '		coalesce(tpr.preco1, 0) as valor_min,																											'
    +
    'case when (ativo is null) or (ativo = 1) then ''SIM'' else ''NÃO'' end as ativo																				'
    +
    'from t_produto tp left outer join t_gruposcomerciais tg on (tg.cod_grupo = tp.grupo_com)																	'
    + 'left outer join t_precos_prod tpr on (tpr.cod_prod = tp.cod_prod and tpr.data = (select max(data) from t_precos_prod where cod_prod = tpr.cod_prod))		'
    + 'WHERE vendas = 1 and (ativo is null or ativo = 1)' +
    'order by tp.cod_prod																																		';

var
  JSONValue: TJSONValue;
  QuerySinc1, qryAux: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc1 := TFDQuery.Create(nil);
  QuerySinc1.Connection := Server_FDConnection;

  TRY
    QuerySinc1.Active := FALSE;
    QuerySinc1.SQL.Clear;
    QuerySinc1.SQL.Text := _SQL;
    QuerySinc1.Active := True;

    TRY
      // QuerySinc1.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('produtosinc', QuerySinc1, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc1.Active then
      FreeAndNil(QuerySinc1);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetProdutosReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT TOP(50)     ' + ' COD_PROD,         ' + ' DESC_IND,         ' +
    ' DESC_FAT          ' + 'FROM T_PRODUTO     ' + 'ORDER BY COD_PROD  ';

  _SQL2 = 'SELECT TOP(50)            ' + ' COD_PROD,                ' +
    ' DESC_IND,                ' + ' DESC_FAT                 ' +
    'FROM T_PRODUTO            ' + 'WHERE DESC_IND = :DESC    ' +
    'ORDER BY COD_PROD         ';
var
  JSONValue: TJSONValue;
  Query2: TFDQuery;
begin
  if (Params.ItemsString['Get'].AsString.Equals(EmptyStr)) then
  begin
    JSONValue := TJSONValue.Create;
    Query2 := TFDQuery.Create(nil);
    Query2.Connection := Server_FDConnection;
    TRY
      Query2.Active := FALSE;
      Query2.SQL.Clear;
      Query2.SQL.Text := _SQL;
      Query2.Active := True;
      TRY
        // Query2.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('produtos', Query2, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except

      END;
    FINALLY
      JSONValue.Free;
      if Query2.Active then
        FreeAndNil(Query2);
    END;
  end
  else
  begin
    JSONValue := TJSONValue.Create;
    Query2 := TFDQuery.Create(nil);
    Query2.Connection := Server_FDConnection;
    TRY
      Query2.Active := FALSE;
      Query2.SQL.Clear;
      Query2.SQL.Text := _SQL2;
      Query2.ParamByName('DESC').AsString := Params.ItemsString['Get'].AsString;
      Query2.Active := True;
      if Query2.IsEmpty then
        Params.ItemsString['Result'].AsString := 'fail'
      else
      begin
        TRY
          // Query2.Open;
          JSONValue.JsonMode := Params.JsonMode;
          JSONValue.Encoding := Encoding;
          JSONValue.LoadFromDataset('produtos', Query2, True,
            Params.JsonMode, '');
          Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
        Except

        END;
      end;
    FINALLY
      JSONValue.Free;
      if Query2.Active then
        FreeAndNil(Query2);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetRelatorioVendedorReplyEvent
  (var Params: TDWParams; var Result: string);
const
  // _SQL =
  // 'SELECT vendedor,                                                                   '+
  // '	   sum(total) as valor_total_vendedor,                                            '+
  // '	   ((sum(total)*100)/(SELECT sum(total) as total_vendas                           '+
  // '							from t_vendamobile                                                    '+
  // '							where emissao between :emissaoA and :emissaoB)) as valor_porc_vendedor'+
  // 'FROM t_vendamobile                                                                 '+
  // 'WHERE emissao between :emissaoA and :emissaoB                                       '+
  // 'group by vendedor                                                                  '+
  // 'order by valor_total_vendedor desc, valor_porc_vendedor desc                       ';

  _SQL = 'SELECT vendedor,                                     ' +
    '	   sum(total) as valor_total_vendedor               ' +
    'FROM t_vendamobile                                   ' +
    'WHERE emissao between :emissaoA and :emissaoB        ' +
    'group by vendedor                                    ' +
    'order by valor_total_vendedor desc                   ';

  _SQL2 = 'SELECT sum(total) as valor_total             ' +
    'from t_vendamobile                            ' +
    'where emissao between :emissaoA and :emissaoB ';
var
  JSONValue: TJSONValue;
  Query4: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  Query4 := TFDQuery.Create(nil);
  Query4.Connection := Server_FDConnection;
  if Params.ItemsString['Opcao'].AsInteger = 1 then
  begin
    TRY
      Query4.Active := FALSE;
      Query4.SQL.Clear;
      Query4.SQL.Text := _SQL;
      Query4.ParamByName('emissaoA').AsString := Params.ItemsString
        ['DataA'].AsString;
      Query4.ParamByName('emissaoB').AsString := Params.ItemsString
        ['DataB'].AsString;
      Query4.Active := True;
      TRY
        // Query4.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatoriovendedor', Query4, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end
  else if Params.ItemsString['Opcao'].AsInteger = 0 then
  begin
    TRY
      Query4.Active := FALSE;
      Query4.SQL.Clear;
      Query4.SQL.Text := _SQL2;
      Query4.ParamByName('emissaoA').AsString := Params.ItemsString
        ['DataA'].AsString;
      Query4.ParamByName('emissaoB').AsString := Params.ItemsString
        ['DataB'].AsString;
      Query4.Active := True;
      TRY
        // Query4.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatoriovendedor', Query4, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end;

end;

procedure TServerMethodDM.DWServerEvents1EventsGetRotaReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT latitude,                                   ' +
    '       longitude ,                                 ' +
    '       controleinterno,                            ' +
    '       vendedor,                                   ' +
    '       cpf_cnpj,                                   ' +
    '       total,                                      ' +
    '       situacao                                    ' +
    'FROM T_VENDAMOBILE                                 ' +
    'WHERE vendedor = :vendedor and emissao = :emissao  ' +
    'ORDER BY emissao asc                               ';
var
  JSONValue: TJSONValue;
  Query4: TFDQuery;
begin
  if (Params.ItemsString['Data'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query4 := TFDQuery.Create(nil);
    Query4.Connection := Server_FDConnection;
    TRY
      Query4.Active := FALSE;
      Query4.SQL.Clear;
      Query4.SQL.Text := _SQL;
      Query4.ParamByName('vendedor').AsString := Params.ItemsString
        ['Vendedor'].AsString;
      Query4.ParamByName('emissao').AsString := Params.ItemsString
        ['Data'].AsString;
      Query4.Active := True;
      TRY
        // Query4.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('rota', Query4, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetUsuarioCPReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'select nome  ' + 'from t_usuarios           ' +
    'where cod_vend is not null';
var
  JSONValue: TJSONValue;
  QuerySinc20: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc20 := TFDQuery.Create(nil);
  QuerySinc20.Connection := Server_FDConnection;
  TRY
    QuerySinc20.Active := FALSE;
    QuerySinc20.SQL.Clear;
    QuerySinc20.SQL.Text := _SQL;
    QuerySinc20.Active := True;
    TRY
      // QuerySinc20.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('usuarioscp', QuerySinc20, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc20.Active then
      FreeAndNil(QuerySinc20);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetUsuariosSincReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT                       ' + '       *                     ' +
    'FROM T_USUARIOS              ';
var
  JSONValue: TJSONValue;
  QuerySinc4: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  QuerySinc4 := TFDQuery.Create(nil);
  QuerySinc4.Connection := Server_FDConnection;
  TRY
    QuerySinc4.Active := FALSE;
    QuerySinc4.SQL.Clear;
    QuerySinc4.SQL.Text := _SQL;
    QuerySinc4.Active := True;
    TRY
      // QuerySinc4.Open;
      JSONValue.JsonMode := Params.JsonMode;
      JSONValue.Encoding := Encoding;
      JSONValue.LoadFromDataset('usuariossinc', QuerySinc4, True,
        Params.JsonMode, '');
      Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    Except
      //
    END;
  FINALLY
    JSONValue.Free;
    if QuerySinc4.Active then
      FreeAndNil(QuerySinc4);
  END;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetVendasCPReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'select ve.controleinterno,                                                  '
    + '		ve.vendedor,                                                                      '
    + '	   FORMAT(cast(ve.emissao as date), ''dd/MM/yyyy'') emissao,                                                                      '
    + '	   ve.total,                                                                        '
    + '	   pe.nome_fant,                                                                    '
    + '	   us.cod_vend as cod_vendedor                                                      '
    + 'from t_vendamobile as ve, t_pessoa as pe, t_usuarios as us                           '
    + 'where pe.cpf_cnpj = ve.cpf_cnpj and us.usuario = :usuario and ve.vendedor = :usuario '
    + '       and CONVERT(date, zve.emissao, 121) between :dataA and :dataB                    '
    + 'order by ve.emissao desc                                                             ';
var
  JSONValue: TJSONValue;
  QuerySinc22: TFDQuery;
begin

  JSONValue := TJSONValue.Create;
  JSONValue.JsonMode := Params.JsonMode;
  JSONValue.Encoded := FALSE;
  QuerySinc22 := TFDQuery.Create(NIL);
  QuerySinc22.Connection := Server_FDConnection;

  QuerySinc22.Active := FALSE;
  QuerySinc22.SQL.Clear;
  QuerySinc22.SQL.Text := _SQL;
  QuerySinc22.ParamByName('usuario').AsString := Params.ItemsString
    ['Usuario'].AsString;
  QuerySinc22.ParamByName('dataA').AsString := Params.ItemsString
    ['DataA'].AsString;
  QuerySinc22.ParamByName('dataB').AsString := Params.ItemsString
    ['DataB'].AsString;
  QuerySinc22.Active := True;
  // ???
  try
    try
      if Params.JsonMode in [jmPureJSON, jmMongoDB] then
      begin
        JSONValue.LoadFromDataset('', QuerySinc22, FALSE, Params.JsonMode,
          'dd/mm/yyyy', '.');
        Result := JSONValue.ToJSON;
      end;
    except
      on E: Exception do
        Result := Format('{"Error":"%s"}', [E.Message])
    end;

  finally
    QuerySinc22.Close;
    JSONValue.Free;

{$REGION 'CÓDIGO ANTIGO'}
    // JSONValue := TJSONValue.Create;
    // QuerySinc22 := TFDQuery.Create(nil);
    // QuerySinc22.Connection := Server_FDConnection;
    // TRY
    // QuerySinc22.Active := FALSE;
    // QuerySinc22.SQL.Clear;
    // QuerySinc22.SQL.Text := _SQL;
    // QuerySinc22.ParamByName('usuario').AsString := Params.ItemsString['Usuario'].AsString;
    // QuerySinc22.ParamByName('dataA').AsString := Params.ItemsString['DataA'].AsString;
    // QuerySinc22.ParamByName('dataB').AsString := Params.ItemsString['DataB'].AsString;
    // QuerySinc22.Active := True;
    //
    // {QuerySinc22.First;
    // ShowMessage(QuerySinc22.FieldByName('emissao').AsString);}
    // TRY
    // // QuerySinc22.Open;
    // JSONValue.JsonMode := Params.JsonMode;
    // JSONValue.Encoding := Encoding;
    // JSONValue.LoadFromDataset('vendascp', QuerySinc22, True,
    // Params.JsonMode, '');
    // Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
    // Except
    // //
    // END;
    // FINALLY
    // JSONValue.Free;
    // if QuerySinc22.Active then
    // FreeAndNil(QuerySinc22);
    // END;
{$ENDREGION}
  end;

end;


procedure TServerMethodDM.DWServerEvents1EventsGetVendasProdReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = '   select Top (30)	ti.cod_empresa,                         ' +
    '     ti.serie,                                             ' +
    '     ti.cod_nota,                                          ' +
    '     ti.num_item,                                          ' +
    '     ti.cod_prod,                                          ' +
    '     ti.sigla,                                             ' +
    '     ti.descricao,                                         ' +
    '     ti.st,                                                ' +
    '     ti.valor_unitario_pt,                                 ' +
    '     ti.valor_total_pt,                                    ' +
    '     ti.data_emissao,                                      ' +
    '     ti.unidade,                                           ' +
    '     ti.ncm,                                               ' +
    '     ti.cest,                                              ' +
    '     ti.quant_pecas,                                       ' +
    '     ti.quant,                                             ' +
    '     ti.valor_unitario,                                    ' +
    '     ti.vlr_base_calc,                                     ' +
    '     ti.valor_desc,                                        ' +
    '     ti.valor_frete,                                       ' +
    '     ti.cfop,                                              ' +
    '     ti.valor_total,                                       ' +
    '     ti.icms,                                              ' +
    '     ti.reducao,                                           ' +
    '     ti.ipi,                                               ' +
    '     ti.vlr_base_calc as base_calc,                        ' +
    '     ti.valor_icms,                                        ' +
    '     ti.valor_ipi,                                         ' +
    '     ti.inf_adic                                           ' +
    ' from t_nota_itens ti,                                     ' +
    '     t_nota_emitidas ne,                                   ' +
    '     t_pessoa p                                            ' +
    ' where 1=1 and ne.cod_nota=ti.cod_nota and                 ' +
    '     p.cpf_cnpj=ne.cpf_cnpj_r_d                            ' +
    '    and cod_pessoa= :doc_cliente                           ' +
    ' order by data_emissao desc                                 ';
var
  JSONValue: TJSONValue;
  Query5: TFDQuery;
begin
  if (Params.ItemsString['VendasProd'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query5 := TFDQuery.Create(nil);
    Query5.Connection := Server_FDConnection;
    TRY
      Query5.Active := FALSE;
      Query5.SQL.Clear;
      Query5.SQL.Text := _SQL;
      Query5.ParamByName('doc_cliente').AsInteger := Params.ItemsString
        ['VendasProd'].AsInteger;
      Query5.Active := True;
      TRY
        // Query5.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('vendasprod', Query5, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query5.Active then
        FreeAndNil(Query5);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsGetVendasReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = ' select Top (50) n.cod_nota,              ' +
    '   n.data_emissao,                        ' +
    '   n.data_saida_entra,                    ' +
    '   n.hora,                                ' +
    '   n.pedido,                              ' +
    '   p.cod_pessoa,                          ' +
    '   n.cpf_cnpj_r_d,                        ' +
    '   p.nome_razao,                          ' +
    '   n.vr_total_nota,                       ' +
    '   n.forma_pgto,                          ' +
    '   n.status,                              ' +
    '   n.nfeaprovada,                         ' +
    '   n.lote,                                ' +
    '   n.protocolonfe                         ' +
    ' from t_nota_emitidas n,                  ' +
    '   t_pessoa p where n.nf_sai_en = 2 and   ' +
    '   p.cpf_cnpj=n.cpf_cnpj_r_d and          ' +
    '   p.cod_pessoa=:doc_cliente              ' +
    ' order by n.data_emissao desc             ';
var
  JSONValue: TJSONValue;
  Query6: TFDQuery;
begin
  if (Params.ItemsString['Vendas'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query6 := TFDQuery.Create(nil);
    Query6.Connection := Server_FDConnection;
    TRY
      Query6.Active := FALSE;
      Query6.SQL.Clear;
      Query6.SQL.Text := _SQL;
      Query6.ParamByName('doc_cliente').AsInteger := Params.ItemsString
        ['Vendas'].AsInteger;
      Query6.Active := True;
      TRY
        // Query6.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('vendas', Query6, True, Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query6.Active then
        FreeAndNil(Query6);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsItensRelatorioReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQLSITUACAO = 'SELECT * FROM t_vendaitemmobile WHERE situacao = :situacao';
  _SQLNOME = 'SELECT * FROM t_vendaitemmobile WHERE vendedor = :vendedor';
var
  JSONValue: TJSONValue;
  qryRelatorio2: TFDQuery;
begin
  if (Params.ItemsString['NomeVendedor'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorio2 := TFDQuery.Create(nil);
    qryRelatorio2.Connection := Server_FDConnection;
    TRY
      qryRelatorio2.Active := FALSE;
      qryRelatorio2.SQL.Clear;
      qryRelatorio2.SQL.Text := _SQLNOME;
      qryRelatorio2.ParamByName('vendedor').AsString := Params.ItemsString
        ['NomeVendedor'].AsString;
      qryRelatorio2.Active := True;
      TRY
        // qryRelatorio2.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatorionomei', qryRelatorio2, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if qryRelatorio2.Active then
        FreeAndNil(qryRelatorio2);
    END;
  end
  else if (Params.ItemsString['Situacao'].AsString.Equals('aprovado')) then
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorio2 := TFDQuery.Create(nil);
    qryRelatorio2.Connection := Server_FDConnection;
    TRY
      qryRelatorio2.Active := FALSE;
      qryRelatorio2.SQL.Clear;
      qryRelatorio2.SQL.Text := _SQLSITUACAO;
      qryRelatorio2.ParamByName('situacao').AsString := Params.ItemsString
        ['Situacao'].AsString;
      qryRelatorio2.Active := True;
      TRY
        // qryRelatorio2.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatorioaprovadoi', qryRelatorio2, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if qryRelatorio2.Active then
        FreeAndNil(qryRelatorio2);
    END;
  end
  else if (Params.ItemsString['Situacao'].AsString.Equals('reprovado')) then
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorio2 := TFDQuery.Create(nil);
    qryRelatorio2.Connection := Server_FDConnection;
    TRY
      qryRelatorio2.Active := FALSE;
      qryRelatorio2.SQL.Clear;
      qryRelatorio2.SQL.Text := _SQLSITUACAO;
      qryRelatorio2.ParamByName('situacao').AsString := Params.ItemsString
        ['Situacao'].AsString;
      qryRelatorio2.Active := True;
      TRY
        // qryRelatorio2.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatorioreprovadoi', qryRelatorio2, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if qryRelatorio2.Active then
        FreeAndNil(qryRelatorio2);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsPedidoItensRelatorioReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'SELECT	REPLICATE (''0'',5 - LEN (ve.controleinterno)) + RTrim (ve.controleinterno)as controleinterno,'
    + '     ve.cpf_cnpj,          ' +
    '     REPLICATE (''0'',5 - LEN (ve.formapagto)) + RTrim (ve.formapagto)as formapagto,'
    + '     ve.vendedor,          ' + '     ve.emissao,           ' +
    '     ve.situacao,          ' + '     it.cod_venda,         ' +
    '     it.cod_prod,          ' + '     it.nomeproduto,       ' +
    '     it.quantidade,        ' + '     it.valor,             ' +
    '     it.desconto,          ' + '     it.total,             ' +
    '     it.unidade,           ' + '     it.situacao as sititem,          ' +
    '     it.vendedor           ' +
    ' FROM t_vendamobile as ve, t_vendaitemmobile as it ' +
    ' WHERE ve.controleinterno = it.cod_venda and ve.situacao = :situacao';

  _SQLNOME =
    'SELECT	REPLICATE (''0'',5 - LEN (ve.controleinterno)) + RTrim (ve.controleinterno)as controleinterno,'
    + '     ve.cpf_cnpj,          ' +
    '     REPLICATE (''0'',5 - LEN (ve.formapagto)) + RTrim (ve.formapagto)as formapagto,        '
    + '     ve.vendedor,          ' + '     ve.emissao,           ' +
    '     ve.situacao,          ' + '     it.cod_venda,         ' +
    '     it.cod_prod,          ' + '     it.nomeproduto,       ' +
    '     it.quantidade,        ' + '     it.valor,             ' +
    '     it.desconto,          ' + '     it.total,             ' +
    '     it.unidade,           ' + '     it.situacao as sititem,          ' +
    '     it.vendedor           ' +
    ' FROM t_vendamobile as ve, t_vendaitemmobile as it ' +
    ' WHERE ve.controleinterno = it.cod_venda and ve.vendedor = :vendedor';
  _SQLTODAS =
    'SELECT	REPLICATE (''0'',5 - LEN (ve.controleinterno)) + RTrim (ve.controleinterno)as controleinterno,'
    + '     ve.cpf_cnpj,          ' +
    '     REPLICATE (''0'',5 - LEN (ve.formapagto)) + RTrim (ve.formapagto)as formapagto,        '
    + '     ve.vendedor,          ' + '     ve.emissao,           ' +
    '     ve.situacao,          ' + '     it.cod_venda,         ' +
    '     it.cod_prod,          ' + '     it.nomeproduto,       ' +
    '     it.quantidade,        ' + '     it.valor,             ' +
    '     it.desconto,          ' + '     it.total,             ' +
    '     it.unidade,           ' + '     it.situacao as sititem,          ' +
    '     it.vendedor           ' +
    ' FROM t_vendamobile as ve, t_vendaitemmobile as it ' +
    ' WHERE ve.controleinterno = it.cod_venda';
var
  JSONValue: TJSONValue;
  qryRelatorioSit: TFDQuery;
begin
  if Params.ItemsString['Situacao'].AsString.Equals('todas') then
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorioSit := TFDQuery.Create(nil);
    qryRelatorioSit.Connection := Server_FDConnection;
    TRY
      qryRelatorioSit.Active := FALSE;
      qryRelatorioSit.SQL.Clear;
      qryRelatorioSit.SQL.Text := _SQLTODAS;
      // qryRelatorioSit.ParamByName('situacao').AsString := Params.ItemsString['Situacao'].AsString;
      qryRelatorioSit.Active := True;
      TRY
        // qryRelatorioSit.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatsituacao', qryRelatorioSit, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if qryRelatorioSit.Active then
        FreeAndNil(qryRelatorioSit);
    END;
  end
  else if not Params.ItemsString['Vendedor'].AsString.Equals(EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorioSit := TFDQuery.Create(nil);
    qryRelatorioSit.Connection := Server_FDConnection;
    TRY
      qryRelatorioSit.Active := FALSE;
      qryRelatorioSit.SQL.Clear;
      qryRelatorioSit.SQL.Text := _SQLNOME;
      qryRelatorioSit.ParamByName('vendedor').AsString := Params.ItemsString
        ['Vendedor'].AsString;
      qryRelatorioSit.Active := True;
      if qryRelatorioSit.RecordCount = 0 then
      begin
        Params.ItemsString['Result'].AsString := 'Erro';
      end
      else
      begin
        TRY
          // qryRelatorioSit.Open;
          JSONValue.JsonMode := Params.JsonMode;
          JSONValue.Encoding := Encoding;
          JSONValue.LoadFromDataset('relatsituacao', qryRelatorioSit, True,
            Params.JsonMode, '');
          Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
        Except
          //
        END;
      end;
    FINALLY
      JSONValue.Free;
      if qryRelatorioSit.Active then
        FreeAndNil(qryRelatorioSit);
    END;
  end
  else
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorioSit := TFDQuery.Create(nil);
    qryRelatorioSit.Connection := Server_FDConnection;
    TRY
      qryRelatorioSit.Active := FALSE;
      qryRelatorioSit.SQL.Clear;
      qryRelatorioSit.SQL.Text := _SQL;
      qryRelatorioSit.ParamByName('situacao').AsString := Params.ItemsString
        ['Situacao'].AsString;
      qryRelatorioSit.Active := True;
      TRY
        // qryRelatorioSit.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatpeditem', qryRelatorioSit, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if qryRelatorioSit.Active then
        FreeAndNil(qryRelatorioSit);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsPedidoRelatorioReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQLSITUACAO = 'SELECT  ' +
    'REPLICATE (''0'',5 - LEN (controleinterno)) + RTrim (controleinterno)as controleinterno,'
    + 'cpf_cnpj,                                                                               '
    + 'REPLICATE (''0'',5 - LEN (formapagto)) + RTrim (formapagto)as formapagto,                   '
    + 'vendedor,                                                                              '
    + 'emissao,                                                                               '
    + 'valor,                                                                                 '
    + 'desconto,                                                                              '
    + 'total,                                                                                 '
    + 'situacao                                                                               '
    + 'FROM t_vendamobile WHERE situacao = :situacao';
  _SQLNOME = 'SELECT  ' +
    'REPLICATE (''0'',5 - LEN (controleinterno)) + RTrim (controleinterno)as controleinterno,'
    + 'cpf_cnpj,                                                                               '
    + 'REPLICATE (''0'',5 - LEN (formapagto)) + RTrim (formapagto)as formapagto,                   '
    + 'vendedor,                                                                              '
    + 'emissao,                                                                               '
    + 'valor,                                                                                 '
    + 'desconto,                                                                              '
    + 'total,                                                                                 '
    + 'situacao                                                                               '
    + 'FROM t_vendamobile WHERE vendedor = :vendedor';
var
  JSONValue: TJSONValue;
  qryRelatorio: TFDQuery;
begin
  if (Params.ItemsString['NomeVendedor'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorio := TFDQuery.Create(nil);
    qryRelatorio.Connection := Server_FDConnection;
    TRY
      qryRelatorio.Active := FALSE;
      qryRelatorio.SQL.Clear;
      qryRelatorio.SQL.Text := _SQLNOME;
      qryRelatorio.ParamByName('vendedor').AsString := Params.ItemsString
        ['NomeVendedor'].AsString;
      qryRelatorio.Active := True;
      if qryRelatorio.RecordCount = 0 then
      begin
        Params.ItemsString['Result'].AsString := 'Erro';
      end
      else
      begin
        TRY
          // qryRelatorioSit.Open;
          JSONValue.JsonMode := Params.JsonMode;
          JSONValue.Encoding := Encoding;
          JSONValue.LoadFromDataset('relatsituacao', qryRelatorio, True,
            Params.JsonMode, '');
          Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
        Except
          //
        END;
      end;
    FINALLY
      JSONValue.Free;
      if qryRelatorio.Active then
        FreeAndNil(qryRelatorio);
    END;
  end
  else
  begin
    JSONValue := TJSONValue.Create;
    qryRelatorio := TFDQuery.Create(nil);
    qryRelatorio.Connection := Server_FDConnection;
    TRY
      qryRelatorio.Active := FALSE;
      qryRelatorio.SQL.Clear;
      qryRelatorio.SQL.Text := _SQLSITUACAO;
      qryRelatorio.ParamByName('situacao').AsString := Params.ItemsString
        ['Situacao'].AsString;
      qryRelatorio.Active := True;
      TRY
        // qryRelatorio.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('relatorioaprovado', qryRelatorio, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if qryRelatorio.Active then
        FreeAndNil(qryRelatorio);
    END;
  end
end;

procedure TServerMethodDM.DWServerEvents1EventsResumoAbateReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = '' +
    'select 																																																'
    +
    '	replicate(''0'', (4-len(cast(ti.cod_animal as varchar))))+cast(ti.cod_animal as varchar)+ '' - '' +																									'
    +
    '	case when ta.classific = '''' then RTRIM(ti.desc_animal) else RTRIM(ti.desc_animal)+ '' '' +ta.classific end as dsc_anm,																			'
    +
    '	td.classe+ '' - ''+td.desc_classe as cls_pes,																																						'
    +
    '	count(ta.cod_pedcom) as tot_qtd, sum(ta.peso_total) as tot_kgs, sum(ta.peso_total)/15 as tot_arb,																									'
    +
    '	sum(ta.peso_total)/count(ta.cod_pedcom)/15 as med_arb																																				'
    +
    'from 																																																	'
    +
    '	t_animal_pesado ta,																																													'
    +
    '	t_pedidocomprapeso td,																																												'
    +
    '	t_pedidocompra tp,																																													'
    +
    '	t_pedidocompraitens ti																																												'
    + 'where ti.cod_pedcom = td.cod_pedcom and td.cod_pedcom = ta.cod_pedcom and ti.cod_animal = td.cod_animal and ti.cod_animal = ta.cod_animal and td.classe = ta.classe_peso and ta.peso_b is not null 	'
    +
    '	and ta.cod_pedcom = tp.cod_pedcom																																									'
    +
    '	and tp.data_abt between :data and :data																																								'
    +
    'group by ti.cod_animal, ti.desc_animal, td.classe, td.desc_classe, ta.classific																														'
    +
    'order by ti.desc_animal,ta.classific, td.classe																																										';

var
  JSONValue: TJSONValue;
  Query3: TFDQuery;
begin
  if (Params.ItemsString['Data'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query3 := TFDQuery.Create(nil);
    Query3.Connection := Server_FDConnection;
    TRY
      Query3.Active := FALSE;
      Query3.SQL.Clear;
      Query3.SQL.Text := _SQL;
      Query3.ParamByName('data').AsString := Params.ItemsString['Data']
        .AsString;
      Query3.Active := True;
      TRY
        // Query3.Open;
        JSONValue.JsonMode := Params.JsonMode;
        JSONValue.Encoding := Encoding;
        JSONValue.LoadFromDataset('resumoabate', Query3, True,
          Params.JsonMode, '');
        Params.ItemsString['Result'].AsString := JSONValue.ToJSON;
      Except
        //
      END;
    FINALLY
      JSONValue.Free;
      if Query3.Active then
        FreeAndNil(Query3);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsSetPedidosItemReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'INSERT INTO T_PEDIDOVENDAITENS (num_item, cod_pedcar, cod_prod, tipo_pes, preco_unit ,quantidade, desconto, tipo_com, comissao)'
  { + 'VALUES (:num_item, :cod_pedcar, :cod_prod, :tipo_pes, :preco_unit , :quantidade, :desconto, :tipo_com, :comissao)'; }
    + 'select :num_item, :cod_pedcar, :cod_prod, :tipo_pes, :preco_unit , :quantidade, :desconto,'
    + 'isnull ((select tipo_com from t_vend_comis where cod_vend = :cod_vend and cod_prod = :cod_prod), 0),'
    + 'isnull ((select comissao from t_vend_comis where cod_vend = :cod_vend and cod_prod = :cod_prod), 0)';

  _SQLBACKUP =
    'INSERT INTO t_vendaitemmobile (controleinterno, cod_prod, cod_venda, nomeproduto, quantidade, valor, desconto, total, unidade, vendedor)'
    + 'VALUES (:controleinterno, :cod_prod, :cod_venda, :nomeproduto, :quantidade, :valor, :desconto, :total, :unidade, :vendedor) ';
var
  sControle, sCod_prod, sCod_venda, sNomeproduto, sQuantidade, sValor,
    sDesconto, sTotal, sUnidade, sSituacao, sComplemento, sVendedor, sTipo_pes,
    sControleinterno, sCodVendedor: String;
  Query: TFDQuery;
  jValidar: TJSONObject;
  jResultado: TJSONObject;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Server_FDConnection;
  Result := EmptyStr;
  try
    if not Params.ItemsString['PedidosItem'].AsString.IsEmpty then
    begin
      jValidar := TJSONObject.ParseJSONValue(Params.ItemsString['PedidosItem']
        .AsString) as TJSONObject;
      try
        // Converte Json para String;
        sControle := (jValidar as TJSONObject).Values['cod_pedcar'].Value;
        sCod_prod := (jValidar as TJSONObject).Values['cod_prod'].Value;
        sQuantidade := (jValidar as TJSONObject).Values['quantidade'].Value;
        sValor := (jValidar as TJSONObject).Values['valor'].Value;
        sTipo_pes := (jValidar as TJSONObject).Values['tipo_pes'].Value;
        sControleinterno := (jValidar as TJSONObject)
          .Values['controleinterno'].Value;
        sCod_venda := (jValidar as TJSONObject).Values['cod_venda'].Value;
        sNomeproduto := (jValidar as TJSONObject).Values['nomeproduto'].Value;
        sCodVendedor := (jValidar as TJSONObject).Values['codvendedor'].Value;
        sVendedor := (jValidar as TJSONObject).Values['vendedor'].Value;
        sTotal := (jValidar as TJSONObject).Values['total'].Value;

        Query.SQL.Clear;
        Query.SQL.Add(_SQL);

        Query.ParamByName('cod_pedcar').AsInteger := StrToInt(sControle);
        Query.ParamByName('cod_prod').AsInteger := StrToInt(sCod_prod);
        Query.ParamByName('quantidade').AsFloat := StrToFloat(sQuantidade);
        Query.ParamByName('preco_unit').AsCurrency :=
          StrToCurr(StringReplace(sValor, '.', ',', [rfReplaceAll]));
        Query.ParamByName('tipo_pes').AsInteger := StrToInt(sTipo_pes);
        Query.ParamByName('num_item').AsInteger :=
          StrToInt(ProxCod('t_pedidovendaitens', 'num_item', '000',
          'cod_pedcar = ' + sControle));
        Query.ParamByName('desconto').AsInteger := 0;
        Query.ParamByName('cod_vend').AsInteger := StrToInt(sCodVendedor);
        Query.ParamByName('cod_prod').AsInteger := StrToInt(sCod_prod);

        Query.ExecSQL;

        Query.SQL.Clear;
        Query.SQL.Add(_SQLBACKUP);

        Query.ParamByName('controleinterno').AsInteger :=
          StrToInt(sControleinterno);
        Query.ParamByName('cod_prod').AsInteger := StrToInt(sCod_prod);
        Query.ParamByName('cod_venda').AsInteger := StrToInt(sCod_venda);
        Query.ParamByName('nomeproduto').AsString := sNomeproduto;
        Query.ParamByName('quantidade').AsFloat := StrToFloat(sQuantidade);
        Query.ParamByName('valor').AsCurrency :=
          StrToCurr(StringReplace(sValor, '.', ',', [rfReplaceAll]));
        Query.ParamByName('desconto').AsCurrency := 0;
        Query.ParamByName('total').AsCurrency :=
          StrToCurr(StringReplace(sTotal, '.', ',', [rfReplaceAll]));
        Query.ParamByName('unidade').AsString := sTipo_pes;
        Query.ParamByName('vendedor').AsString := sVendedor;

        Query.ExecSQL;
        Query.Connection.Commit;
        Params.ItemsString['Result'].AsString := 'Sucesso';
      except
        on E: Exception do
          // raise Exception.Create(e.Message +  'Error Message');
          Params.ItemsString['Result'].AsString := 'Erro1';
      end;
    end
    else
      Params.ItemsString['Result'].AsString := 'Erro0';
  finally
    FreeAndNil(jValidar);
    if Query.Active then
      Query.Close;
    FreeAndNil(Query);
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsSetPedidosReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'INSERT INTO T_PEDIDOVENDA (cod_pedcar, cod_empresa, cod_pedcar_mobile, cod_doc, cod_cliente, tipo_car, cod_vend, status, comissao, cod_prest, valor_comis, data_ped, data_emb, valor_final, situacao)'
    + 'VALUES (:cod_pedcar, :cod_empresa, :cod_pedcar_mobile, :cod_doc, :cod_cliente, :tipo_car, :cod_vend, :status, :comissao, :cod_prest, :valor_comis, :data_ped, :data_emb, :valor_final, :situacao)';
  _SQLPARC =
    'INSERT INTO T_PEDIDOVENDAPARC (cod_pedcar, num_parc, data_venc, valor)' +
    'VALUES (:cod_pedcar, :num_parc, :data_venc, :valor)';

  _SQLDOC = 'SELECT * FROM t_docto_parc where cod_doc = :doc';

  _SQLBACKUP =
    'INSERT INTO t_vendamobile ( controleinterno, cpf_cnpj, formapagto, vendedor, emissao, valor, desconto, total, cod_cliente, cod_ret, data_emb, comissao, latitude, longitude) '
    + 'VALUES (:controleinterno, :cpf_cnpj, :formapagto, :vendedor, :emissao, :valor, :desconto, :total, :cod_cliente, :cod_ret, :data_emb, :comissao, :latitude, :longitude)';

  _SQLSTATUS = 'select status_ped from t_config';
var
  sCod_empresa, sCod_cliente, sStatus, sCod_vend, sData_ped, sData_emb,
    sValor_final, sTipo_car, sSituacao, sCod_Doc, sControle, sCpf_cnpj,
    sVendedor, sComissao, sLatitude, sLongitude: String;
  Query, QryParc, qryBackup, qryStatus: TFDQuery;
  jValidar: TJSONObject;
  jResultado: TJSONObject;
  Prox_cod, { NumParc, NumDias, } i: integer;
  DataPed, DataEmb: TDateTime;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Server_FDConnection;

  QryParc := TFDQuery.Create(nil);
  QryParc.Connection := Server_FDConnection;

  qryBackup := TFDQuery.Create(nil);
  qryBackup.Connection := Server_FDConnection;

  qryStatus := TFDQuery.Create(nil);
  qryStatus.Connection := Server_FDConnection;

  Result := EmptyStr;
  try
    if not Params.ItemsString['Pedidos'].AsString.IsEmpty then
    begin
      jValidar := TJSONObject.ParseJSONValue(Params.ItemsString['Pedidos']
        .AsString) as TJSONObject;
      try

        qryStatus.Active := FALSE;
        qryStatus.SQL.Clear;
        qryStatus.SQL.Add(_SQLSTATUS);
        qryStatus.Active := True;

        if qryStatus.FieldByName('status_ped').AsInteger = 1 then
          sStatus := '1'
        else
          sStatus := '0';

        Prox_cod := StrToInt(ProxCod('t_pedidovenda', 'cod_pedcar',
          '000000', ''));
        // Converte Json para String;
        sCod_empresa := (jValidar as TJSONObject).Values['cod_empresa'].Value;
        sControle := (jValidar as TJSONObject).Values['controleinterno'].Value;
        sCod_Doc := (jValidar as TJSONObject).Values['cod_doc'].Value;
        sCod_cliente := (jValidar as TJSONObject).Values['cod_cliente'].Value;
        // sStatus := '0';
        sCod_vend := (jValidar as TJSONObject).Values['cod_vend'].Value;
        sData_ped := (jValidar as TJSONObject).Values['emissao'].Value;
        sData_emb := (jValidar as TJSONObject).Values['data_emb'].Value;
        sValor_final := (jValidar as TJSONObject).Values['total'].Value;
        sTipo_car := (jValidar as TJSONObject).Values['tipo_car'].Value;
        sSituacao := (jValidar as TJSONObject).Values['situacao'].Value;
        sCpf_cnpj := (jValidar as TJSONObject).Values['cpf_cnpj'].Value;
        sVendedor := (jValidar as TJSONObject).Values['vendedor'].Value;
        sComissao := (jValidar as TJSONObject).Values['comissao'].Value;
        sLatitude := (jValidar as TJSONObject).Values['latitude'].Value;
        sLongitude := (jValidar as TJSONObject).Values['longitude'].Value;

        // DataEmb := StrToDateTime(sData_ped);
        QryParc.SQL.Clear;
        QryParc.SQL.Add(_SQLDOC);
        QryParc.ParamByName('doc').AsInteger := StrToInt(sCod_Doc);
        QryParc.Active := True;
        { if QryParc.RecordCount > 0 then
          begin
          NumParc := QryParc.FieldByName('num_parc').AsInteger;
          NumDias := QryParc.FieldByName('dias_entre_parc').AsInteger;
          end
          else
          begin
          NumParc := 0;
          NumDias := 0;
          end; }

        Query.SQL.Clear;
        Query.SQL.Add(_SQL);

        Query.ParamByName('cod_pedcar').AsInteger := Prox_cod;
        Query.ParamByName('cod_empresa').AsInteger := StrToInt(sCod_empresa);
        Query.ParamByName('cod_pedcar_mobile').AsInteger := StrToInt(sControle);
        Query.ParamByName('cod_doc').AsInteger := StrToInt(sCod_Doc);
        Query.ParamByName('cod_cliente').AsInteger := StrToInt(sCod_cliente);
        Query.ParamByName('tipo_car').AsInteger := StrToInt(sTipo_car);
        Query.ParamByName('cod_vend').AsInteger := StrToInt(sCod_vend);
        Query.ParamByName('status').AsInteger := StrToInt(sStatus);
        Query.ParamByName('comissao').AsInteger := StrToInt(sComissao);
        Query.ParamByName('cod_prest').AsInteger := 1;
        Query.ParamByName('valor_comis').AsFloat := 0;
        Query.ParamByName('data_ped').AsDateTime :=
          StrToDate(FormatDateTime('dd/mm/yyyy', StrToDateTime(sData_ped)));
        Query.ParamByName('data_emb').AsDateTime :=
          StrToDate(FormatDateTime('dd/mm/yyyy', StrToDateTime(sData_emb)));
        // StrToDate(sData_ped);
        Query.ParamByName('valor_final').AsCurrency := 0;
        // StrToCurr(StringReplace(sValor_final, '.', ',', [rfReplaceAll]));
        Query.ParamByName('situacao').AsString := sSituacao;

        Query.ExecSQL;
        Query.Connection.Commit;
        // ShowMessage(Query.SQL.Text);

        qryBackup.SQL.Clear;
        qryBackup.SQL.Add(_SQLBACKUP);

        qryBackup.ParamByName('controleinterno').AsInteger :=
          StrToInt(sControle);
        qryBackup.ParamByName('cpf_cnpj').AsString := sCpf_cnpj;
        qryBackup.ParamByName('formapagto').AsInteger := StrToInt(sCod_Doc);
        qryBackup.ParamByName('vendedor').AsString := sVendedor;
        qryBackup.ParamByName('emissao').AsDateTime := StrToDateTime(sData_ped);
        qryBackup.ParamByName('valor').AsCurrency :=
          StrToCurr(StringReplace(sValor_final, '.', ',', [rfReplaceAll]));
        qryBackup.ParamByName('desconto').AsCurrency := 0;
        qryBackup.ParamByName('total').AsCurrency :=
          StrToCurr(StringReplace(sValor_final, '.', ',', [rfReplaceAll]));
        qryBackup.ParamByName('cod_cliente').AsInteger :=
          StrToInt(sCod_cliente);
        qryBackup.ParamByName('cod_ret').AsInteger := Prox_cod;
        qryBackup.ParamByName('data_emb').AsDateTime :=
          StrToDateTime(sData_emb);
        qryBackup.ParamByName('comissao').AsInteger := StrToInt(sComissao);
        qryBackup.ParamByName('latitude').AsString := sLatitude;
        qryBackup.ParamByName('longitude').AsString := sLongitude;

        qryBackup.ExecSQL;
        qryBackup.Connection.Commit;

        Query.SQL.Clear;
        Query.SQL.Add('select cod_pedcar, num_parc, data_venc, valor ');
        Query.SQL.Add
          ('from t_pedidovendaparc where cod_pedcar = cod_pedcar and cod_pedcar = :cod_pedcar');
        Query.ParamByName('cod_pedcar').AsInteger := Prox_cod;
        Query.Open();

        // Query.ParamByName('cod_pedcar').AsInteger := Prox_cod;
        // Query.ParamByName('num_parc').AsInteger := 1;
        // Query.ParamByName('data_venc').AsDateTime := Date;
        // // StrToDate(sData_ped);
        // Query.ParamByName('valor').AsFloat := 0;

        // for i := 1 to NumParc do
        QryParc.First;
        if QryParc.IsEmpty then
        begin
          Query.Insert;
          Query.FieldByName('cod_pedcar').AsInteger := Prox_cod;
          Query.FieldByName('num_parc').AsInteger := 1;
          Query.FieldByName('data_venc').Value :=
            StrToDate(FormatDateTime('dd/mm/yyyy', StrToDateTime(sData_ped)));
          Query.FieldByName('valor').AsFloat := 0;
          Query.Post;

        end
        else
          while not QryParc.Eof do
          begin
            Query.Insert;
            Query.FieldByName('cod_pedcar').AsInteger := Prox_cod;
            Query.FieldByName('num_parc').AsInteger :=
              QryParc.FieldByName('num_parc').AsInteger;
            Query.FieldByName('data_venc').Value :=
              IncDay(StrToDate(FormatDateTime('dd/mm/yyyy',
              StrToDateTime(sData_ped))), QryParc.FieldByName('qtd_dias')
              .AsInteger);
            Query.FieldByName('valor').AsFloat := 0;
            Query.Post;
            QryParc.Next;
          end;

        Params.ItemsString['Result'].AsString := 'Sucesso';
        Params.ItemsString['Cod'].AsString := IntToStr(Prox_cod);
      except
        on E: Exception do
          // raise Exception.Create(e.Message +  'Error Message');
          Params.ItemsString['Result'].AsString := 'Erro1';
      end;
    end
    else
      Params.ItemsString['Result'].AsString := 'Erro0';
  finally
    FreeAndNil(jValidar);
    if Query.Active then
      Query.Close;
    FreeAndNil(Query);
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsUpdateItemReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'UPDATE T_VENDAITEMMOBILE' + ' SET situacao = :situacao ' +
    ' WHERE controleinterno = :controleinterno and vendedor = :vendedor ';

  _SQL2 = 'UPDATE T_VENDAITEMMOBILE' +
    ' SET situacao = :situacao , complemento = :complemento' +
    ' WHERE controleinterno = :controleinterno and vendedor = :vendedor ';
var
  JSONValue: TJSONValue;
  Query1: TFDQuery;
begin
  if (Params.ItemsString['Complemento'].AsString.Equals(EmptyStr)) then
  begin
    JSONValue := TJSONValue.Create;
    Query1 := TFDQuery.Create(nil);
    Query1.Connection := Server_FDConnection;
    TRY
      try
        Query1.Active := FALSE;
        Query1.SQL.Clear;
        Query1.SQL.Add(_SQL);
        Query1.ParamByName('situacao').AsString :=
          QuotedStr(Params.ItemsString['Situacao'].AsString);
        Query1.ParamByName('controleinterno').AsInteger :=
          Params.ItemsString['CI'].AsInteger;
        Query1.ParamByName('vendedor').AsString := Params.ItemsString
          ['Vendedor'].AsString;
        Query1.ExecSQL;
      except
        Params.ItemsString['Result'].AsString := 'Erro';
      end;
    FINALLY
      Params.ItemsString['Result'].AsString := 'Sucesso';
      JSONValue.Free;
      if Query1.Active then
        FreeAndNil(Query1);
    END;
  end
  else
  begin
    JSONValue := TJSONValue.Create;
    Query1 := TFDQuery.Create(nil);
    Query1.Connection := Server_FDConnection;
    TRY
      begin
        TRY
          Query1.Active := FALSE;
          Query1.SQL.Clear;
          Query1.SQL.Add(_SQL2);
          Query1.ParamByName('situacao').AsString := Params.ItemsString
            ['Situacao'].AsString;
          // QuotedStr(Params.ItemsString['Situacao'].AsString);
          Query1.ParamByName('complemento').AsString := Params.ItemsString
            ['Complemento'].AsString;
          // QuotedStr(Params.ItemsString['Complemento'].AsString);
          Query1.ParamByName('controleinterno').AsInteger :=
            Params.ItemsString['CI'].AsInteger;
          Query1.ParamByName('vendedor').AsString := Params.ItemsString
            ['Vendedor'].AsString;
          Query1.ExecSQL;
        Except
          Params.ItemsString['Result'].AsString := 'Erro';
        END;
      end;
    FINALLY
      Params.ItemsString['Result'].AsString := 'Sucesso';
      JSONValue.Free;
      if Query1.Active then
        FreeAndNil(Query1);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsUpdatePedidoReplyEvent
  (var Params: TDWParams; var Result: string);
const
  _SQL = 'UPDATE T_VENDAMOBILE                      ' +
    ' SET situacao = :situacao            ' +
    ' WHERE controleinterno = :CONTROLEINTERNO and vendedor = :vendedor';
var
  JSONValue: TJSONValue;
  Query4: TFDQuery;
begin
  if (Params.ItemsString['Situacao'].AsString <> EmptyStr) then
  begin
    JSONValue := TJSONValue.Create;
    Query4 := TFDQuery.Create(nil);
    Query4.Connection := Server_FDConnection;
    TRY
      TRY
        Query4.Active := FALSE;
        Query4.SQL.Clear;
        Query4.SQL.Add(_SQL);
        Query4.ParamByName('situacao').AsString := Params.ItemsString
          ['Situacao'].AsString;
        Query4.ParamByName('CONTROLEINTERNO').AsInteger :=
          Params.ItemsString['CI'].AsInteger;
        Query4.ParamByName('vendedor').AsString := Params.ItemsString
          ['Vendedor'].AsString;
        Query4.ExecSQL;
      Except
        Params.ItemsString['Result'].AsString := 'Erro';
      END;
    FINALLY
      Params.ItemsString['Result'].AsString := 'Sucesso';
      JSONValue.Free;
      if Query4.Active then
        FreeAndNil(Query4);
    END;
  end;
end;

procedure TServerMethodDM.DWServerEvents1EventsValidarReplyEvent
  (var Params: TDWParams; var Result: string);
begin
  if (Params.ItemsString['Entrada'] <> nil) then
    Params.ItemsString['Result'].AsString :=
      ValidarUsuario(Params.ItemsString['Entrada'].AsString);
end;

function TServerMethodDM.iif(Expressao, ParteTRUE, ParteFALSE: Variant)
  : Variant;
begin
  if (Expressao) then
    Result := ParteTRUE
  else
    Result := ParteFALSE;
end;

function TServerMethodDM.ProxCod(Tabela, Campo, Formato,
  Condicao: String): String;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Server_FDConnection;
  try
    with Query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select max(' + Campo + ') as inc_codigo from ' + Tabela);
      if (Condicao <> '') then
        SQL.Add('where ' + Condicao);
      Open;
      if (FieldByName('inc_codigo').AsString = '') then
        Result := iif(Formato = '', 1, FormatFloat(Formato, 1))
      else
        Result := iif(Formato = '', FieldByName('inc_codigo').AsInteger + 1,
          FormatFloat(Formato, FieldByName('inc_codigo').AsInteger + 1));
    end;
  finally
    if Query.Active then
      Query.Close;
    FreeAndNil(Query);
  end;

end;

function TServerMethodDM.ValidarUsuario(JSON: String): String;
const
  _SQL = 'SELECT * from t_usuarios where usuario like %s and senha like %s;';
var
  sUsuario: String;
  sSenha: String;
  Query: TFDQuery;
  jValidar: TJSONObject;
  jResultado: TJSONObject;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Server_FDConnection;
  Result := EmptyStr;
  jValidar := TJSONObject.ParseJSONValue(JSON) as TJSONObject;
  try
    try
      // Converte Json para String;
      sUsuario := (jValidar as TJSONObject).Values['usuario'].Value;
      sSenha := (jValidar as TJSONObject).Values['senha'].Value;

      // Pesquisa no banco
      Query.Active := FALSE;
      Query.SQL.Clear;
      Query.SQL.Text := Format(_SQL, [QuotedStr(sUsuario), QuotedStr(sSenha)]);
      Query.Active := True;

      // encontrou o usuario
      if not(Query.IsEmpty) then
      begin
        jResultado := TJSONObject.Create;
        jResultado.AddPair('resultado', 'sucesso');
        jResultado.AddPair('codigo_mensagem', '200');
        jResultado.AddPair('mensagem', ' ');
        jResultado.AddPair('cod_vendedor',
          IntToStr(Query.FieldByName('cod_vend').AsInteger));

        Result := jResultado.ToString();
      end
      // Não encontrou o usuario
      else
      begin
        jResultado := TJSONObject.Create;
        jResultado.AddPair('resultado', 'aviso');
        jResultado.AddPair('codigo_mensagem', '300');
        jResultado.AddPair('mensagem', 'Usuário e/ou senha inválidos .');
        jResultado.AddPair('cod_vendedor',
          IntToStr(Query.FieldByName('cod_vend').AsInteger));

        Result := jResultado.ToString();
      end;
    except
      on E: Exception do
        // raise Exception.Create(e.Message +  'Error Message');
    end;
  finally
    FreeAndNil(jValidar);
    if Query.Active then
      Query.Close;
    FreeAndNil(Query);
  end;
end;

END.
