unit uSincronizacao;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  uFrmBase,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.ScrollBox,
  FMX.Memo,
  uAguarde,
  FireDAC.Comp.Client,
  uDWJSONObject,
  FMX.TabControl,
  FMX.Ani,
  uFraAnimacao,
  FMX.Edit,
  System.DateUtils,
  Loading,
  G2Mobile.Model.Clientes,
  uLibraryAndroid,
  G2Mobile.Model.CamaraFria,
  G2Mobile.Model.FormaPagamento,
  G2Mobile.Model.Usuarios,
  G2Mobile.Model.TitulosCliente, G2Mobile.Model.Produtos,
  G2Mobile.Model.ExportarPedidos;

type
  TFrmSinc = class(TFrmBase)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Image1: TImage;
    lbl_cliente: TLabel;
    Layout6: TLayout;
    rect_barra_cliente_fundo: TRoundRect;
    rect_barra_cliente: TRoundRect;
    lbl_cliente_msg: TLabel;
    Layout7: TLayout;
    Layout8: TLayout;
    Image2: TImage;
    lbl_produto: TLabel;
    Layout9: TLayout;
    rect_barra_produto_fundo: TRoundRect;
    rect_barra_produto: TRoundRect;
    lbl_produto_msg: TLabel;
    Layout10: TLayout;
    Layout11: TLayout;
    Image3: TImage;
    lbl_pedido: TLabel;
    Layout12: TLayout;
    rect_barra_pedido_fundo: TRoundRect;
    rect_barra_pedido: TRoundRect;
    lbl_pedido_msg: TLabel;
    Layout13: TLayout;
    rect_btn_sinc: TRectangle;
    rect_btn_sinc_barra: TRectangle;
    lbl_btn_sinc: TLabel;
    Rectangle1: TRectangle;
    ToolBar1: TToolBar;
    Label3: TLabel;
    Button1: TButton;
    lytSinc: TLayout;
    lytOpcoes: TLayout;
    lytBtnSincronizar: TLayout;
    rctAguarde: TRectangle;
    Label1: TLabel;
    FraAnimacao1: TFraAnimacao;
    memoLogSincronia: TMemo;
    VertScrollBox1: TVertScrollBox;
    Layout14: TLayout;
    rctSinc: TRectangle;
    lblSinc: TLabel;
    Layout15: TLayout;
    Layout16: TLayout;
    lblInfoTitle: TLabel;
    Image4: TImage;
    GridPanelLayout1: TGridPanelLayout;
    btnSincFotos: TLayout;
    Label2: TLabel;
    lbl_clienteimp: TLabel;
    img_cliente: TImage;
    Layout19: TLayout;
    Label4: TLabel;
    lbl_formapgtoimp: TLabel;
    img_formapag: TImage;
    img_certo: TImage;
    img_error: TImage;
    Layout23: TLayout;
    Layout21: TLayout;
    Label6: TLabel;
    lbl_prodimp: TLabel;
    img_prod: TImage;
    Layout20: TLayout;
    Line1: TLine;
    Line6: TLine;
    Line8: TLine;
    Line9: TLine;
    Layout18: TLayout;
    Line2: TLine;
    lbl_porta: TLabel;
    lbl_Ip: TLabel;
    Label7: TLabel;
    Line3: TLine;
    lay_Detalhes: TLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout22: TLayout;
    memo_Detalhes: TMemo;
    Label9: TLabel;
    rct_FechaDetalhes: TRectangle;
    Label10: TLabel;
    rct_Detalhes: TRectangle;
    Label11: TLabel;
    Layout24: TLayout;
    Layout17: TLayout;
    btn_Fotos: TRectangle;
    Label12: TLabel;
    img_pedidos: TImage;
    lbl_ped_exp: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure rct_FechaDetalhesClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn_FotosClick(Sender: TObject);
  private const
    // Qts tentativas de sincronia deve fazer ate disparar o erro
    CLimitError = 3;
    // Especifica a qnt par trazer nos pacotes de cada requisicao
    CShowProdutoFoto = 100;
    procedure AddLogSincronia(const AMsg: string; const AClearLog: Boolean = False);
    procedure AguardeShow(const AMsg: string);
    procedure AguardeHide();
    procedure AguardeChangeMessage(const AMsg: string);
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarDados(AFrame: TFrame; ACont: Integer); overload;
    procedure CarregarFotos(AFrame: TFrame; ACont: Integer); overload;

    Procedure importCliente(DataSet: TFDMemTable); //
    Procedure ImportResumoVendedor(DataSet: TFDMemTable);
    procedure importProdutos(DataSet: TFDMemTable);
    Procedure SincCD(DataSet: TFDMemTable);
    Procedure importFormapagto(DataSet: TFDMemTable);
    procedure importUsuarios(DataSet: TFDMemTable); //
    procedure SincImportParametro(DataSet: TFDMemTable);
    procedure SincImportTitulo(DataSet: TFDMemTable);
    function exportPedido: string;
    procedure ImportPedidoFinalizado(DataSet: TFDMemTable);

  end;

var
  FrmSinc: TFrmSinc;

implementation

{$R *.fmx}

uses
  uDmDados,
  uFrmInicio,
  uFrmMain,
  System.JSON,
  FMX.VirtualKeyboard,
  FMX.Platform,
  System.JSON.Readers,
  System.JSON.Types,
  System.NetEncoding,
  Data.DB,
  uDataBase,
  uRESTDWPoolerDB,
  FireDAC.Stan.Error,
  FireDAC.Comp.DataSet,
  FMX.ZDeviceInfo,
  uFrmUtilFormate,
  G2Mobile.Model.Parametro,
  G2Mobile.Model.ResumoVendedorClientes,
  G2Mobile.Model.ResumoVendedorItens;

procedure TFrmSinc.Rectangle2Click(Sender: TObject);
var
  Cont: Integer;
begin
  inherited;
  memo_Detalhes.Lines.Clear;
  img_error.Visible := False;
  img_certo.Visible := False;

  lbl_clienteimp.Text := EmptyStr;
  lbl_prodimp.Text := EmptyStr;
  lbl_formapgtoimp.Text := EmptyStr;
  lbl_ped_exp.Text := EmptyStr;

  if verificaConexao then
    CarregarDados(FraAnimacao1, Cont);

end;

procedure TFrmSinc.btn_FotosClick(Sender: TObject);
var
  Cont: Integer;
begin
  if verificaConexao then
  begin
    CarregarFotos(FraAnimacao1, Cont);
  end;
end;

procedure TFrmSinc.CarregarDados(AFrame: TFrame; ACont: Integer);
var
  LThread: TThread;
begin
  AguardeShow('Por favor, aguarde!');
  AddLogSincronia('', true);

  LThread := TThread.CreateAnonymousThread(
    procedure
    var
      DataSet: TFDMemTable;
    begin
      try

        DataSet := TFDMemTable.Create(self);
        try
          AguardeChangeMessage('Parametros...');
          SincImportParametro(DataSet);
{$IFDEF ANDROID}
          if TModelParametros.new.VerificaTablet then
{$ENDIF}
          begin
            AguardeChangeMessage('Usuarios...');
            importUsuarios(DataSet);

            AguardeChangeMessage('Resumo Vendedor...');
            ImportResumoVendedor(DataSet);

            AguardeChangeMessage('Camara Fria...');
            SincCD(DataSet);

            AguardeChangeMessage('Titulos Cliente...');
            SincImportTitulo(DataSet);

            AguardeChangeMessage('Clientes...');
            importCliente(DataSet);

            AguardeChangeMessage('Produtos...');
            importProdutos(DataSet);

            AguardeChangeMessage('Formas de Pagamento...');
            importFormapagto(DataSet);

            AguardeChangeMessage('Exportando Pedidos...');
            exportPedido;

            AguardeChangeMessage('Atualizando Pedidos...');
            ImportPedidoFinalizado(DataSet);

          end
{$IFDEF ANDROID}
          else
          begin

            memo_Detalhes.Lines.Add('Erro ao Sincronizar');
            memo_Detalhes.Lines.Add('Dispositivo Bloqueado, procure seu supervisor!');
            memo_Detalhes.Lines.Add(StringOfChar('-', 70));

            img_cliente.Bitmap := img_error.Bitmap;
            img_formapag.Bitmap := img_error.Bitmap;
            img_prod.Bitmap := img_error.Bitmap;
            img_pedidos.Bitmap := img_error.Bitmap;

          end;
{$ENDIF}
        finally
          FreeAndNil(DataSet);
        end;

      finally
        AguardeHide;

      end;
    end);
  LThread.FreeOnTerminate := true;
  LThread.Start;

end;

procedure TFrmSinc.importUsuarios(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try
    TModelUsuarios.new.LimpaTabelaUser.BuscaUserServidor(DataSet).PopulaUserSqLite(DataSet);
    DmDados.ConexaoInterna.Commit;

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      ShowMessage('[ERROR] Falha ao importar Usuarios!' + sLineBreak + E.Message);
    end;

  end;
end;

procedure TFrmSinc.CarregarFotos(AFrame: TFrame; ACont: Integer);
var
  LThread: TThread;
begin
  AguardeShow('Por favor, aguarde!');
  AddLogSincronia('', true);
  LThread := TThread.CreateAnonymousThread(
    procedure
    var
      DataSet: TFDMemTable;
    begin
      try
        AguardeChangeMessage('Fotos...');
        try
          DataSet := TFDMemTable.Create(self);
          AguardeChangeMessage('Fotos...');
          TModelProdutos.new.LimpaTabelaProdFoto.BuscaFotoProdServidor(DataSet).PopulaFotosProdSqLite(DataSet);
        finally
          FreeAndNil(DataSet);
        end;
      finally
        AguardeHide;
      end;
    end);
  LThread.FreeOnTerminate := true;
  LThread.Start;

end;

procedure TFrmSinc.Button1Click(Sender: TObject);
begin
  inherited;
  FrmMain.MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
end;

procedure TFrmSinc.Button2Click(Sender: TObject);
begin
  inherited;
  lay_Detalhes.Visible := true;
end;

procedure TFrmSinc.ImportPedidoFinalizado(DataSet: TFDMemTable);
begin

  DmDados.ConexaoInterna.StartTransaction;
  try

    TModelExportPedido.new.DeleteItemAtualizado.VerificaPedidosSincronizadosSqlite.BuscaInfoAtualizadaServidor(DataSet)
      .GravaInfoAtulizadoPedidoSqlite(DataSet);

    DmDados.ConexaoInterna.Commit;

    memo_Detalhes.Lines.Add('[OK] Pedidos atualizados com sucesso!');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao atualizar pedidos!');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;
end;

procedure TFrmSinc.rct_FechaDetalhesClick(Sender: TObject);
begin
  inherited;
  lay_Detalhes.Visible := False;
end;

procedure TFrmSinc.AddLogSincronia(const AMsg: string; const AClearLog: Boolean);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      if (AClearLog) then
        memoLogSincronia.Lines.Clear
      else
        memoLogSincronia.Lines.Add(AMsg);
    end);
end;

procedure TFrmSinc.AguardeChangeMessage(const AMsg: string);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      TAguarde.ChangeMessage(AMsg);
    end);
end;

procedure TFrmSinc.AguardeHide;
begin
  // Forcamos o Hide do Aguarde para o Application executar
  TThread.Synchronize(nil,
    procedure
    begin
      TAguarde.Hide;
    end);
end;

procedure TFrmSinc.AguardeShow(const AMsg: string);
begin
  // Forcamos a apresentacao do Aguarde para o Application executar
  TThread.Synchronize(nil,
    procedure
    begin
      TAguarde.Show(Application.MainForm, AMsg, 'Sincronizando...');
    end);
end;

function TFrmSinc.exportPedido: string;
const
  _SQLVenda = 'SELECT * FROM   venda WHERE situacao = :situacao and sincronizado = :sincronizado ';
  _SQLItem  = 'SELECT * FROM   venditem WHERE chave = :chave  ';

var
  QSinc6, qrySinc, Queryparam, qryItensLocal    : TFDQuery;
  i, countItem, ContPed, PedidosOk, PedidosError: Integer;
  cpf_cnpj, obs                                 : string;
begin
  PedidosOk := 0;
  PedidosError := 0;

  QSinc6 := TFDQuery.Create(nil);
  QSinc6.Connection := DmDados.ConexaoInterna;

  qryItensLocal := TFDQuery.Create(nil);
  qryItensLocal.Connection := DmDados.ConexaoInterna;

  Queryparam := TFDQuery.Create(nil);
  Queryparam.Connection := DmDados.ConexaoInterna;

  qrySinc := TFDQuery.Create(nil);
  qrySinc.Connection := DmDados.ConexaoInterna;
  TRY
    QSinc6.Active := False;
    QSinc6.SQL.Clear;
    QSinc6.SQL.Add(_SQLVenda);
    QSinc6.ParamByName('situacao').AsInteger := 0;
    QSinc6.ParamByName('sincronizado').AsInteger := 0;
    if CodVend <> 0 then
    begin
      QSinc6.SQL.Add(' and cod_vendedor = :cod_vend ');
      QSinc6.ParamByName('cod_vend').AsInteger := CodVend;
    end;
    QSinc6.Active := true;
    QSinc6.First;

    if not DmDados.RESTDWDataBase1.Active then
      DmDados.RESTDWDataBase1.Active := true;

    if (QSinc6.RecordCount = 0) then
    begin
      lbl_ped_exp.Text := 'Erro: ' + '0000' + ' / OK: ' + '0000' + ' / Total: ' + '0000';
      img_pedidos.Bitmap := img_certo.Bitmap;
    end;
    for i := 0 to QSinc6.RecordCount - 1 do
    begin

      qryItensLocal.Active := False;
      qryItensLocal.SQL.Clear;
      qryItensLocal.SQL.Add(_SQLItem);
      qryItensLocal.ParamByName('chave').AsString := QSinc6.FieldByName('chave').AsString;
      qryItensLocal.Active := true;
      qryItensLocal.First;

      // if QSinc6.FieldByName('cpf_cnpj').AsString = '' then
      // cpf_cnpj := ''
      // else
      // cpf_cnpj := QSinc6.FieldByName('cpf_cnpj').AsString;

      if QSinc6.FieldByName('obs').AsString = '' then
        obs := ''
      else
        obs := QSinc6.FieldByName('obs').AsString;

      DmDados.rdwSQL.Close;
      DmDados.rdwSQL.SQL.Clear;
      // INSERT CABEÇALHO
      DmDados.rdwSQL.SQL.Add('begin transaction set xact_abort on begin try INSERT INTO T_VENDAMOBILE ' +
        '( formapagto, cod_user, emissao, valor, desconto, total, situacao, latitude, longitude, cod_cliente, ' +
        ' cod_ret, data_emb, comissao, cod_vendedor, obs, chave, aprovacao, export, cod_camara, dt_sinc, id_tablet) VALUES ');

      DmDados.rdwSQL.SQL.Add('( ' + QSinc6.FieldByName('formapagto').AsString + ', ' + QSinc6.FieldByName('cod_user')
        .AsString + ', ' + QuotedStr(QSinc6.FieldByName('emissao').AsString) + ', ' +
        StringReplace(QSinc6.FieldByName('total').AsString, ',', '.', [rfReplaceAll]) + ', ' +
        StringReplace(QSinc6.FieldByName('desconto').AsString, ',', '.', [rfReplaceAll]) + ', ' +
        StringReplace(QSinc6.FieldByName('total').AsString, ',', '.', [rfReplaceAll]) + ', ' +
        QSinc6.FieldByName('situacao').AsString + ', ' + QuotedStr(QSinc6.FieldByName('latitude').AsString) + ', ' +
        QuotedStr(QSinc6.FieldByName('longitude').AsString) + ', ' + QSinc6.FieldByName('cod_cliente').AsString +
        ', 0, ' + QuotedStr(QSinc6.FieldByName('data_emb').AsString) + ', ' + QSinc6.FieldByName('comissao').AsString +
        ', ' + QSinc6.FieldByName('cod_vendedor').AsString + ', ' + QuotedStr(obs) + ', ' +
        QuotedStr(QSinc6.FieldByName('chave').AsString) + ', 1, 0, ' + QSinc6.FieldByName('cod_camara').AsString + ', '
        + QuotedStr(FormatDateTime('dd/mm/yyyy hh:MM:ss', Parametros('dt_sinc'))) + ', ' +
        QuotedStr(Parametros('id_tablet')) + ')');

      DmDados.rdwSQL.SQL.Add('');

      // INSERT ITENS
      DmDados.rdwSQL.SQL.Add('  INSERT INTO T_VENDAITEMMOBILE ' +
        ' (cod_prod, quantidade, unidade, valor, total, chave, export, desconto) VALUES ');

      for countItem := 0 to qryItensLocal.RecordCount - 1 do
      begin
        DmDados.rdwSQL.SQL.Add('( ' + qryItensLocal.FieldByName('cod_prod').AsString + ', ' +
          qryItensLocal.FieldByName('quantidade').AsString + ', ' + qryItensLocal.FieldByName('unidade').AsString + ', '
          + StringReplace(qryItensLocal.FieldByName('valor').AsString, ',', '.', [rfReplaceAll]) + ', ' +
          StringReplace(qryItensLocal.FieldByName('total').AsString, ',', '.', [rfReplaceAll]) + ', ' +
          QuotedStr(qryItensLocal.FieldByName('chave').AsString) + ', 0, ' +
          StringReplace(qryItensLocal.FieldByName('desconto').AsString, ',', '.', [rfReplaceAll]) + ')');

        if countItem <> qryItensLocal.RecordCount - 1 then
          DmDados.rdwSQL.SQL.Add(', ');

        qryItensLocal.Next;
      end;

      DmDados.rdwSQL.SQL.Add('');

      DmDados.rdwSQL.SQL.Add('update t_pessoa set dt_visitar = ' + QuotedStr(QSinc6.FieldByName('emissao').AsString) +
        ' where cod_pessoa= ' + QSinc6.FieldByName('cod_cliente').AsString);

      DmDados.rdwSQL.SQL.Add('');

      DmDados.rdwSQL.SQL.Add(' select '''' as errormessage commit end try begin catch ' + ' if xact_state() <> 0 ' +
        ' begin try ' + ' rollback ' +
        ' select ''Linha: ''+convert(varchar(max), error_line())+''. ''+error_message() as errormessage; ' + ' end try '
        + ' begin catch ' + ' end catch ' + ' end catch ');

      DmDados.rdwSQL.Open;

      if DmDados.rdwSQL.FieldByName('errormessage').AsString = '' then
      begin

        PedidosOk := PedidosOk + 1;

        DmDados.rdwSQL.UpdateSQL;

        if QSinc6.IsEmpty then
        begin
          lbl_ped_exp.Text := FormatFloat('0000', QSinc6.RecordCount.ToDouble);
          img_pedidos.Bitmap := img_certo.Bitmap;
        end;

        qrySinc.Close;
        qrySinc.SQL.Clear;
        qrySinc.ExecSQL('UPDATE venda SET sincronizado = 1 WHERE chave = ' +
          QuotedStr(QSinc6.FieldByName('chave').AsString));

        lbl_ped_exp.Text := 'Erro: ' + FormatFloat('0000', PedidosError.ToDouble) + ' / OK: ' +
          FormatFloat('0000', PedidosOk.ToDouble) + ' / Total: ' + FormatFloat('0000', QSinc6.RecordCount.ToDouble);
        img_pedidos.Bitmap := img_certo.Bitmap;

      end
      else
      begin

        PedidosError := PedidosError + 1;

        lbl_ped_exp.Text := 'Erro: ' + FormatFloat('0000', PedidosError.ToDouble) + ' / OK: ' +
          FormatFloat('0000', PedidosOk.ToDouble) + ' / Total: ' + FormatFloat('0000', QSinc6.RecordCount.ToDouble);
        img_pedidos.Bitmap := img_certo.Bitmap;
        memo_Detalhes.Lines.Add('Erro Pedido');
        memo_Detalhes.Lines.Add('Cliente: ' + FormatFloat('0000', QSinc6.FieldByName('cod_cliente').AsFloat) + ' Data: '
          + QSinc6.FieldByName('emissao').AsString);
        memo_Detalhes.Lines.Add(WrapText(DmDados.rdwSQL.FieldByName('errormessage').AsString));
        memo_Detalhes.Lines.Add(StringOfChar('-', 70));

      end;
      QSinc6.Next;
    end;

  FINALLY

    if QSinc6.Active then
      FreeAndNil(QSinc6);

    if qrySinc.Active then
      FreeAndNil(qrySinc);

    if DmDados.rdwSQL.Active then
      DmDados.rdwSQL.Active := False;
  END;
end;

procedure TFrmSinc.FormCreate(Sender: TObject);
begin
  inherited;
  lay_Detalhes.Visible := False;
  img_error.Visible := False;
  img_certo.Visible := False;
  lbl_clienteimp.Text := EmptyStr;
  lbl_prodimp.Text := EmptyStr;
  lbl_formapgtoimp.Text := EmptyStr;
  lbl_ped_exp.Text := EmptyStr;

  conectarservidor;
  lbl_Ip.Text := lbl_Ip.Text + ' ' + IpSrv;
  lbl_porta.Text := lbl_porta.Text + ' ' + PortaSrv;

end;

procedure TFrmSinc.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
  inherited;
{$IFDEF ANDROID}
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (Key = vkHardwareBack) then
  begin
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
    begin
      // botão back pressionado e teclado visivel...
      // (apenas fecha o teclado)
    end
    else
    begin
      // botão back pressionado e teclado não visivel..
      Key := 0;
      FrmMain.MudarCabecalho('Início');
      FrmMain.FormOpen(TFrmInicio);
    end;
  end;
{$ENDIF}
end;

procedure TFrmSinc.SincCD(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try
    TModelCamaraFria.new.LimpaTabelaCamaraFria.BuscaCamaraFriaServidor(DataSet).PopulaCamaraFriaSqLite(DataSet);
    DmDados.ConexaoInterna.Commit;
    memo_Detalhes.Lines.Add('[OK] Camara Fria importada com sucesso!');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao importar Camara Fria!');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;
end;

Procedure TFrmSinc.importCliente(DataSet: TFDMemTable);
var
  qnt_registroCliente: Integer;
begin
  DmDados.ConexaoInterna.StartTransaction;
  try

    TModelClientes.new.LimpaTabelaClientes.BuscaClientesServidor(codUser, CodVend, DataSet)
      .PopulaClientesSqLite(DataSet);
    DmDados.ConexaoInterna.Commit;

    lbl_clienteimp.Text := FormatFloat('0000', DataSet.RecordCount.ToDouble);
    img_cliente.Bitmap := img_certo.Bitmap;

    memo_Detalhes.Lines.Add('[OK] Clientes importados com sucesso!');
    memo_Detalhes.Lines.Add('Total de: ' + FormatFloat('0000', DataSet.RecordCount.ToDouble) +
      ' clientes sincronizado! ');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      lbl_clienteimp.Text := '0000';
      img_cliente.Bitmap := img_error.Bitmap;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao importar Clientes!');
      memo_Detalhes.Lines.Add('Cliente: 0000 clientes sincronizado! ');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;
end;

Procedure TFrmSinc.importFormapagto(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try
    TModelFormaPagamento.new.LimpaTabelaPagamentoPessoa.BuscaPagamentoPessoaServidor(DataSet)
      .PopulaPagamentoPessoaSqLite(DataSet).LimpaTabelaFormaPagamento.BuscaFormaPagamentoServidor(DataSet)
      .PopulaFormaPagamentoSqLite(DataSet);
    DmDados.ConexaoInterna.Commit;

    lbl_formapgtoimp.Text := FormatFloat('0000', DataSet.RecordCount.ToDouble);
    img_formapag.Bitmap := img_certo.Bitmap;

    memo_Detalhes.Lines.Add('[OK] Formas de Pagamento importados com sucesso!');
    memo_Detalhes.Lines.Add('Total de: ' + FormatFloat('0000', DataSet.RecordCount.ToDouble) +
      ' Formas de Pagamento sincronizado! ');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      lbl_formapgtoimp.Text := '0000';
      img_formapag.Bitmap := img_error.Bitmap;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao importar Formas de Pagamento!');
      memo_Detalhes.Lines.Add('Total de: 0000 Formas de Pagamento sincronizado! ');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;

end;

procedure TFrmSinc.importProdutos(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try
    TModelProdutos.new.LimpaTabelaProd.BuscaProdServidor(DataSet).PopulaProdSqLite(DataSet);

    DmDados.ConexaoInterna.Commit;

    lbl_prodimp.Text := FormatFloat('0000', DataSet.RecordCount.ToDouble);
    img_prod.Bitmap := img_certo.Bitmap;

    memo_Detalhes.Lines.Add('[OK] Produtos importados com sucesso!');
    memo_Detalhes.Lines.Add('Total de: ' + FormatFloat('0000', DataSet.RecordCount.ToDouble) +
      ' Produtos sincronizado! ');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      lbl_prodimp.Text := '0000';
      img_prod.Bitmap := img_error.Bitmap;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao importar Produtos!');
      memo_Detalhes.Lines.Add('Total de: 0000 Produtos sincronizado! ');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;

end;

procedure TFrmSinc.ImportResumoVendedor(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try
    TModelResumoVendedorItens.new.LimpaTabelas.BuscaProdVendidosServidor(StartOfTheMonth(Date), EndOfTheMonth(Date),
      CodVend, DataSet).PopulaProdVendidoSqLite(DataSet);

    TModelResumoVendedorClientes.new.LimpaTabelas.BuscaClienteVendidosServidor(StartOfTheMonth(Date),
      EndOfTheMonth(Date), CodVend, DataSet).PopulaClienteVendidoSqLite(DataSet);

    DmDados.ConexaoInterna.Commit;

    memo_Detalhes.Lines.Add('[OK] Informações do vendedor atualizados com sucesso!');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao atualizar informações do vendedor!');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;
end;

procedure TFrmSinc.SincImportParametro(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try
    TModelParametros.new.LimpaTabelaParametros.BuscaParametrosServidor(GetIMEI, DataSet)
      .PopulaParametrosSqLite(DataSet);
    DmDados.ConexaoInterna.Commit;

    memo_Detalhes.Lines.Add('[OK] Parametros importado com sucesso!');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao importar parametro!');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;

end;

procedure TFrmSinc.SincImportTitulo(DataSet: TFDMemTable);
begin
  DmDados.ConexaoInterna.StartTransaction;
  try

    TModelTitulosCliente.new.CodVend(CodVend).DeleteTitulos.BuscaTitulosServidor(DataSet).GravaTitulosSqlite(DataSet);
    TModelTitulosCliente.new.CodVend(CodVend).DeleteItensTitulo.BuscaItensTituloServidor(DataSet)
      .GravaItensTituloSqlite(DataSet);

    DmDados.ConexaoInterna.Commit;

    memo_Detalhes.Lines.Add('[OK] Titulos importado com sucesso!');
    memo_Detalhes.Lines.Add(StringOfChar('-', 70));

  except
    on E: Exception do
    begin
      DmDados.ConexaoInterna.Rollback;
      memo_Detalhes.Lines.Add('[ERROR] Falha ao importar titulos!');
      memo_Detalhes.Lines.Add('Tente sincronizar novamente! ');
      memo_Detalhes.Lines.Add('');
      memo_Detalhes.Lines.Add(WrapText(E.Message));
      memo_Detalhes.Lines.Add(StringOfChar('-', 70));
    end;
  end;
end;

end.
