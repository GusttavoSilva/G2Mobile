unit uFrmPreCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, DateUtils,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.Layouts,
  {MultiDetailAppearanceU,} FMX.Objects,
  FMX.ListBox,
FMX.Edit, FMX.Controls.Presentation,
  FMX.TabControl, uDmDados, System.UIConsts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ScrollBox, FMX.Memo,
  FMX.DateTimeCtrls, FMX.ListView, FMX.Gestures,  FMX.ExtCtrls,
  uConfiguracao, FMX.Colors, System.Actions, FMX.ActnList,
  FMX.Effects, FMX.Filter.Effects, IdGlobal, FMX.Ani,
  uRESTDWPoolerDB, FMX.MultiView, uFraAnimacao, System.Math.Vectors,
  FMX.Controls3D, FMX.Layers3D, System.Sensors, System.Sensors.Components,
  FMX.MediaLibrary.Actions, FMX.StdActns;

type
  TFrmPreCad = class(TFrmBase)
    FraAnimacao1: TFraAnimacao;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    tb_Base: TTabControl;
    ti_PreCad: TTabItem;
    Rectangle1: TRectangle;
    rct_Bairro: TRectangle;
    ed_Bairro: TEdit;
    rct_Celular: TRectangle;
    ed_celular: TEdit;
    rct_CEP: TRectangle;
    ed_CEP: TEdit;
    rct_Contato: TRectangle;
    ed_Contato: TEdit;
    rct_CPFCNPJ: TRectangle;
    ed_CPFCNPJ: TEdit;
    rct_Email: TRectangle;
    ed_Email: TEdit;
    rct_Endereco: TRectangle;
    ed_Endereco: TEdit;
    rct_Nome: TRectangle;
    ed_Nome: TEdit;
    lytAddItem: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    Layout10: TLayout;
    rctCancelar: TRectangle;
    lblCancelar: TLabel;
    ti_PreCadView: TTabItem;
    Layout2: TLayout;
    Image1: TImage;
    lv_Cliente: TListView;
    ed_Pesquisa: TEdit;
    Line9: TLine;
    Line10: TLine;
    bt_BuscaCliente: TButton;
    layout_menu: TLayout;
    Rectangle6: TRectangle;
    Layout5: TLayout;
    Rectangle7: TRectangle;
    lbl_menu_camera: TLabel;
    Image4: TImage;
    lbl_menu_lib: TLabel;
    Image5: TImage;
    Line4: TLine;
    Layout6: TLayout;
    Rectangle8: TRectangle;
    lbl_menu_cancelar: TLabel;
    bt_Salvar: TRectangle;
    Label1: TLabel;
    lysalvar: TLayout;
    Layout3: TLayout;
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure rctAddItemClick(Sender: TObject);
    procedure lblCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img_PreCadClick(Sender: TObject);
    procedure bt_BuscaClienteClick(Sender: TObject);
    procedure lv_ClienteItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure lbl_menu_libClick(Sender: TObject);
    procedure lbl_menu_cameraClick(Sender: TObject);
    procedure img_fotoClick(Sender: TObject);
    procedure lbl_menu_cancelarClick(Sender: TObject);
    procedure ActFotoLibraryDidFinishTaking(Image: TBitmap);
    procedure ActFotoCameraDidFinishTaking(Image: TBitmap);

  private
    FLatitude:  Double;
    FLongitude: Double;
    procedure SetLatitude(const Value: Double);
    procedure SetLongitude(const Value: Double);
    property Latitude: Double read FLatitude write SetLatitude;
    property Longitude: Double read FLongitude write SetLongitude;
    procedure ValidarGravar;
    procedure LimpaCampos;
    procedure Consulta_Cliente(busca: string; pagina: integer);
    procedure Add_Cliente_Lista(codigo, nome, telefone, email: string);
{$IFDEF ANDROID}
    {
      FPermissionCamera, FPermissionReadExternalStorage, FPermissionWriteExternalStorage: string;
      procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
      procedure TakePicturePermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
      procedure LibraryPermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
    }
{$ENDIF}
    { Private declarations }
  public
  end;

var
  FrmPreCad: TFrmPreCad;

implementation

uses
//  ksLoadingIndicator,
   uFrmMain, uFrmInicio, uAguarde,
  FMX.VirtualKeyboard, FMX.Platform, FireDAC.Comp.Client,
  Data.DB, uLibrary;
// , FMX.Helpers.Android, FMX.Platform.Android;

procedure TFrmPreCad.FormCreate(Sender: TObject);
begin
  inherited;
  // tb_Base.ActiveTab := ti_PreCadView;
  // bt_BuscaClienteClick(self);
end;

procedure TFrmPreCad.img_fotoClick(Sender: TObject);
const
  _SQLPRECADFOTO = 'UPDATE CLIENTE_PRECAD SET ' + 'foto =:foto where CPFCNPJ=:CPFCNPJ';
begin
  inherited;
{$IFDEF MSWINDOWS}
  if OpenDialog.Execute then
    img_foto.Bitmap.LoadFromFile(OpenDialog.FileName);

  exit;
{$ENDIF}
  layout_menu.Visible := true;
  // LimpaCampos;
end;

procedure TFrmPreCad.img_PreCadClick(Sender: TObject);
begin
  inherited;
  tb_Base.ActiveTab := ti_PreCad;
end;

procedure TFrmPreCad.lblCancelarClick(Sender: TObject);
begin
  inherited;
  LimpaCampos;
end;

procedure TFrmPreCad.lbl_menu_cameraClick(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  {
    PermissionsService.RequestPermissions([FPermissionCamera, FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
  }
{$ENDIF}
{$IFDEF IOS}
  ActFotoCamera.ExecuteTarget(Sender);
{$ENDIF}
end;

procedure TFrmPreCad.lbl_menu_cancelarClick(Sender: TObject);
begin
  inherited;
  layout_menu.Visible := false;
end;

procedure TFrmPreCad.lbl_menu_libClick(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  {
    PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], LibraryPermissionRequestResult, DisplayRationale);
  }
{$ENDIF}
{$IFDEF IOS}
  ActFotoLibrary.ExecuteTarget(Sender);
{$ENDIF}
end;

procedure TFrmPreCad.LimpaCampos;
begin
  ed_Bairro.Text    := EmptyStr;
  ed_celular.Text   := EmptyStr;
  ed_CEP.Text       := EmptyStr;
  ed_cidade.Text    := EmptyStr;
  ed_Contato.Text   := EmptyStr;
  ed_CPFCNPJ.Text   := EmptyStr;
  ed_Email.Text     := EmptyStr;
  ed_Endereco.Text  := EmptyStr;
  ed_Nome.Text      := EmptyStr;
  ed_Telefone.Text  := EmptyStr;
  tb_Base.ActiveTab := ti_PreCadView;
end;

procedure TFrmPreCad.bt_BuscaClienteClick(Sender: TObject);
begin
  inherited;
  Consulta_Cliente(ed_Pesquisa.Text, 0);
end;

procedure TFrmPreCad.LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
var
  LDecSeparator, Latitude: String;
  Long, Lat:               Double;
begin
  inherited;
  Latitude := FloatToStr(FLatitude);
  ShowMessage('Lat: ' + Latitude);
  if (Latitude.IsEmpty) then
  begin
//    LDecSeparator                   := FormatSettings.DecimalSeparator;
//    FormatSettings.DecimalSeparator := '.';

    Lat  := NewLocation.Latitude;
    Long := NewLocation.Longitude;
    SetLatitude(Lat);
    SetLongitude(Long);

    ShowMessage('Lat2: ' + Latitude);
  end
  else
    LocationSensor1.Active := false;
end;

procedure TFrmPreCad.lv_ClienteItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt:     TListItemText;
  foto:    TStream;
  QPopula: TFDQuery;
begin
  QPopula            := TFDQuery.Create(nil);
  QPopula.Connection := DmDados.ConexaoInterna;
  with AItem do
  begin
    // Descricao...
    txt := TListItemText(Objects.FindDrawable('codigo'));
    // cod_prod := txt.TagString.ToInteger;

    // Buscar os dados do cliente selecionado...
    QPopula.Active := false;
    QPopula.SQL.Clear;
    QPopula.SQL.Add('SELECT cpfcnpj, nome, endereco, bairro, cidade, estado, cep, telefone, contato, ' +
      ' celular, email, latitude,longitude, status, cod_vendedor, aniversario, formapagamento, limitecred, foto' +
      ' From cliente_precad WHERE codigo =:COD_CLIENTE');
    QPopula.ParamByName('COD_CLIENTE').AsInteger := txt.TagString.ToInteger;
    QPopula.Active                               := true;

    tb_Base.TabIndex := 1;

    if QPopula.RecordCount > 0 then
    begin
      ed_CPFCNPJ.Text             := QPopula.fieldByName('cpfcnpj').AsString;
      ed_Nome.Text                := QPopula.fieldByName('nome').AsString;
      ed_Endereco.Text            := QPopula.fieldByName('endereco').AsString;
      ed_Bairro.Text              := QPopula.fieldByName('bairro').AsString;
      ed_cidade.Text              := QPopula.fieldByName('cidade').AsString;
      cb_Estado.ItemIndex         := QPopula.fieldByName('estado').AsInteger;
      ed_CEP.Text                 := QPopula.fieldByName('cep').AsString;
      ed_Telefone.Text            := QPopula.fieldByName('telefone').AsString;
      ed_Contato.Text             := QPopula.fieldByName('contato').AsString;
      ed_celular.Text             := QPopula.fieldByName('celular').AsString;
      ed_Email.Text               := QPopula.fieldByName('email').AsString;
      ed_Nascimento.Text          := DateTimeToStr(QPopula.fieldByName('aniversario').AsDateTime);
      cb_FormaPagamento.ItemIndex := QPopula.fieldByName('formapagamento').AsInteger;
      ed_Limite.Text              := QPopula.fieldByName('limitecred').AsString;
      if QPopula.fieldByName('foto').AsString <> '' then
      begin
        foto := TStream.Create;
        foto := QPopula.CreateBlobStream(QPopula.fieldByName('FOTO'), TBlobStreamMode.bmRead);
        img_foto.Bitmap.LoadFromStream(foto);
      end
      else
        img_foto.Bitmap := nil;
    end
    else
      ShowMessage('Cliente não encontrado');
  end;
end;

procedure TFrmPreCad.rctAddItemClick(Sender: TObject);
const
  _SQLPRECAD = 'INSERT INTO CLIENTE_PRECAD' +
    '(cpfcnpj, nome, endereco, bairro, cidade, estado, cep, telefone, contato, celular, email, latitude,longitude, status, cod_vendedor, aniversario, formapagamento, limitecred, foto)'
    + 'VALUES' +
    '(:cpfcnpj, :nome, :endereco, :bairro, :cidade, :estado, :cep, :telefone, :contato, :celular, :email, :latitude, :longitude, :status, :cod_vendedor, :aniversario, :formapagamento, :limitecred, :foto)';
  _SQLPRECADFOTO = 'UPDATE CLIENTE_PRECAD SET ' +
    'nome=:nome, endereco=:endereco, bairro=:bairro, cidade=:cidade, estado=:estado, cep=:cep, telefone=:telefone, contato=:contato, ' +
    'celular=:celular, email=:email, latitude=:latitude,longitude=:longitude, status=:status, cod_vendedor=:cod_vendedor, aniversario=:aniversario,'
    + 'formapagamento=:formapagamento, limitecred=:limitecred, foto=:foto where CPFCNPJ=:CPFCNPJ';
  _SQLCONSULTA = 'Select * from CLIENTE_PRECAD ' + 'where CPFCNPJ=:CPFCNPJ';
var
  qryAux1, qry: TFDQuery;
  Lat, Long:    string;
  qryAux2:      TFDQuery;
begin
  inherited;
  ValidarGravar;

  Lat := FloatToStr(FLatitude);

  Long := FloatToStr(FLongitude);
  while Pos(',', Lat) > 0 do
    Lat[Pos(',', Lat)] := '.';
  Lat                  := Lat;

  while Pos(',', Long) > 0 do
    Long[Pos(',', Long)] := '.';
  Long                   := Long;

  qry            := TFDQuery.Create(nil);
  qry.Connection := DmDados.ConexaoInterna;
  qry.Active     := false;
  qry.SQL.Clear;
  qry.SQL.Add(_SQLCONSULTA);
  qry.ParamByName('cpfcnpj').AsString := ed_CPFCNPJ.Text;
  qry.Active                          := true;

  if qry.IsEmpty then
  begin
    qryAux1            := TFDQuery.Create(nil);
    qryAux1.Connection := DmDados.ConexaoInterna;
    try
      qryAux1.Active := false;
      qryAux1.SQL.Clear;
      qryAux1.SQL.Add(_SQLPRECAD);
      qryAux1.ParamByName('cpfcnpj').AsString        := ed_CPFCNPJ.Text;
      qryAux1.ParamByName('nome').AsString           := ed_Nome.Text;
      qryAux1.ParamByName('endereco').AsString       := ed_Endereco.Text;
      qryAux1.ParamByName('bairro').AsString         := ed_Bairro.Text;
      qryAux1.ParamByName('cidade').AsString         := ed_cidade.Text;
      qryAux1.ParamByName('estado').AsInteger        := cb_Estado.ItemIndex;
      qryAux1.ParamByName('cep').AsString            := ed_CEP.Text;
      qryAux1.ParamByName('telefone').AsString       := ed_Telefone.Text;
      qryAux1.ParamByName('contato').AsString        := ed_Contato.Text;
      qryAux1.ParamByName('celular').AsString        := ed_celular.Text;
      qryAux1.ParamByName('email').AsString          := ed_Email.Text;
      qryAux1.ParamByName('latitude').AsString       := Lat;
      qryAux1.ParamByName('longitude').AsString      := Long;
      qryAux1.ParamByName('aniversario').AsString    := ed_Nascimento.Text;
      qryAux1.ParamByName('Status').AsString         := '0';
      qryAux1.ParamByName('cod_vendedor').AsString   := '1';
      qryAux1.ParamByName('formapagamento').AsString := '';
      qryAux1.ParamByName('limitecred').AsString     := '';
      qryAux1.ParamByName('foto').Assign(img_foto.Bitmap);
      qryAux1.ExecSQL;
    finally
      FreeAndNil(qryAux1);
    end;
  end
  else
  begin
    begin
      qryAux2            := TFDQuery.Create(nil);
      qryAux2.Connection := DmDados.ConexaoInterna;
      try
        qryAux2.Active := false;
        qryAux2.SQL.Clear;
        qryAux2.SQL.Add(_SQLPRECADFOTO);
        qryAux2.ParamByName('cpfcnpj').AsString        := ed_CPFCNPJ.Text;
        qryAux2.ParamByName('nome').AsString           := ed_Nome.Text;
        qryAux2.ParamByName('endereco').AsString       := ed_Endereco.Text;
        qryAux2.ParamByName('bairro').AsString         := ed_Bairro.Text;
        qryAux2.ParamByName('cidade').AsString         := ed_cidade.Text;
        qryAux2.ParamByName('estado').AsInteger        := cb_Estado.ItemIndex;
        qryAux2.ParamByName('cep').AsString            := ed_CEP.Text;
        qryAux2.ParamByName('telefone').AsString       := ed_Telefone.Text;
        qryAux2.ParamByName('contato').AsString        := ed_Contato.Text;
        qryAux2.ParamByName('celular').AsString        := ed_celular.Text;
        qryAux2.ParamByName('email').AsString          := ed_Email.Text;
        qryAux2.ParamByName('latitude').AsString       := Lat;
        qryAux2.ParamByName('longitude').AsString      := Long;
        qryAux2.ParamByName('aniversario').AsString    := ed_Nascimento.Text;
        qryAux2.ParamByName('Status').AsString         := '0';
        qryAux2.ParamByName('cod_vendedor').AsString   := '1';
        qryAux2.ParamByName('formapagamento').AsString := '';
        qryAux2.ParamByName('limitecred').AsString     := '';
        qryAux2.ParamByName('foto').Assign(img_foto.Bitmap);
        qryAux2.ExecSQL;
      finally
        FreeAndNil(qryAux2);
      end;
    end;
  end;
  LimpaCampos;
  // DmDados.qryAux.Close;
end;

procedure TFrmPreCad.SetLatitude(const Value: Double);
begin
  FLatitude := Value;
end;

procedure TFrmPreCad.SetLongitude(const Value: Double);
begin
  FLongitude := Value;
end;

procedure TFrmPreCad.ValidarGravar;
begin
  if (ed_Bairro.Text.IsEmpty) or (ed_celular.Text.IsEmpty) or (ed_CEP.Text.IsEmpty) or (ed_cidade.Text.IsEmpty) or (ed_Contato.Text.IsEmpty)
    or (ed_CPFCNPJ.Text.IsEmpty) or (ed_Email.Text.IsEmpty) or (ed_Endereco.Text.IsEmpty) or (ed_Nome.Text.IsEmpty) or
    (ed_Telefone.Text.IsEmpty) or (cb_Estado.ItemIndex = -1) then
  begin
    Abort;
  end;
end;

procedure TFrmPreCad.ActFotoCameraDidFinishTaking(Image: TBitmap);
begin
  inherited;
  img_foto.Bitmap     := Image;
  layout_menu.Visible := false;
end;

procedure TFrmPreCad.ActFotoLibraryDidFinishTaking(Image: TBitmap);
begin
  inherited;
  img_foto.Bitmap     := Image;
  layout_menu.Visible := false;
end;

procedure TFrmPreCad.Add_Cliente_Lista(codigo, nome, telefone, email: string);
var
  item: TListViewItem;
  txt:  TListItemText;
begin
  item := lv_Cliente.items.Add;
  with item do
  begin
    // codigo
    txt           := TListItemText(Objects.FindDrawable('codigo'));
    txt.Text      := codigo;
    txt.TagString := codigo;
    // Nome...
    txt      := TListItemText(Objects.FindDrawable('nome'));
    txt.Text := ' - ' + nome;
    // Cidade...
    txt      := TListItemText(Objects.FindDrawable('email'));
    txt.Text := telefone;
    // Data Ult. Pedido...
    txt      := TListItemText(Objects.FindDrawable('telefone'));
    txt.Text := email;
  end;
end;

procedure TFrmPreCad.Consulta_Cliente(busca: string; pagina: integer);
const
  _SQLPesq = 'select codigo, nome, telefone, email from cliente_precad C';
var
  x:            integer;
  qBuscaPreCad: TFDQuery;
begin
  qBuscaPreCad            := TFDQuery.Create(nil);
  qBuscaPreCad.Connection := DmDados.ConexaoInterna;

  qBuscaPreCad.Active := false;
  qBuscaPreCad.SQL.Clear;
  qBuscaPreCad.SQL.Add(_SQLPesq);
  // if busca <> '' then
  // begin
  // qBuscaPreCad.SQL.Add('WHERE C.NOME = :BUSCA');
  // qBuscaPreCad.Params.ParamByName('BUSCA').Value := busca;
  // end;
  qBuscaPreCad.Active := true;

  // Limpar listagem...
  lv_Cliente.items.Clear;
  lv_Cliente.BeginUpdate;

  // Loop nos pedidos...
  qBuscaPreCad.First;
  for x := 1 to qBuscaPreCad.RecordCount do
  begin
    Add_Cliente_Lista(FormatCurr('00000', qBuscaPreCad.fieldByName('codigo').AsInteger), qBuscaPreCad.fieldByName('nome').AsString,
      qBuscaPreCad.fieldByName('telefone').AsString, qBuscaPreCad.fieldByName('email').AsString);
    qBuscaPreCad.Next;
  end;
  lv_Cliente.EndUpdate;
end;

end.
