unit uFrmUtilFormate;

interface

uses
  System.SysUtils,
  System.MaskUtils,
{$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  Androidapi.JNI.Telephony,
  Androidapi.JNI.Provider,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.App,
{$ENDIF}
{$IFDEF IOS}
  iOSApi.UIKit,
  iOSApi.Foundation,
  Macapi.Helpers,
{$ENDIF}
  StrUtils,
  FMX.Dialogs,
  System.UITypes,
  FMX.forms,
  FMX.Types,
  FMX.Edit,
  FMX.ListView,
  FMX.Memo,
  FMX.ListBox,
  FMX.NumberBox,
  FMX.DateTimeCtrls,
  FMX.StdCtrls,
  FMX.SearchBox,

  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdSNTP,
  IdBaseComponent,
  IdUDPClient,
  IdUDPBase,
  FMX.Controls.Presentation,
  FMX.Grid

    ;

Function formatelefone(numtexto: String): String;
function FNUMD(Objeto: TEdit; Texto, VKey: String; Espaco, Decimal: Integer): String;
function DataHoje: TDate;
function StrToFloat_Universal(pText: string): Extended;
procedure FormatarMoeda(Componente: TObject; var Key: Char);
function RemoveAcento(const pText: string): string;
function StrParaDouble(valor: string; QuantZeros: Integer = 2): Double;
// function FormataValor(const pValor: Extended; const pDecimais: Word = 2): string;
procedure LimpaCampos(Form: TForm);

function FormataValor(valor: String; QuantZeros: Integer = 2 { ; Direita: Boolean = true } ): String;
procedure Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1, texto_btn2: string;
  cor_btn1, cor_btn2: Cardinal);

procedure ListViewSearch(AList: TListView);
function FormataDoc(fDoc: String): String;
Function ReturnTimeInternet: TDate;
procedure ClearStringGrid(const Grid: TStringGrid);
function GerarChave: String;
procedure DeleteRow(ARowIndex: Integer; AGrid: TStringGrid);
function verificarStringGridVazia(AGrid: TStringGrid): Boolean;

var
  Device_ID, NomeUsuario: string;
  CodVend, codUser, SuperUser, CodRegistro: Integer;
  sbList: TSearchBox;
  MyGuid: TGUID;

implementation

uses
  Form_Mensagem;

function verificarStringGridVazia(AGrid: TStringGrid): Boolean;
var
  i: Integer;
  valor: string;
begin
  valor := '';
  for i := 0 to Pred(AGrid.RowCount) do
  begin
    valor := valor + AGrid.Cells[2, i];
  end;

  if valor = '' then
    Result := true
  else
    Result := false;
end;

function GerarChave: String;
begin
  if CreateGUID(MyGuid) <> 0 then
    Result := 'Erro ao criar o GUID'
  else
    Result := GUIDToString(MyGuid);

end;

procedure DeleteRow(ARowIndex: Integer; AGrid: TStringGrid);
var
  i, j: Integer;
  MaxRows: Integer;
begin
  with AGrid do
  begin
    MaxRows := RowCount - 1;
    if (ARowIndex = MaxRows) then
      RowCount := RowCount - 1
    else
    begin
      for i := ARowIndex to MaxRows - 1 do
        for j := 0 to ColumnCount - 1 do
          Cells[j, i] := Cells[j, i + 1];

      RowCount := RowCount - 1;
    end;
  end;
  AGrid.UpdateContentSize;

end;

procedure ClearStringGrid(const Grid: TStringGrid);
var
  c, r: Integer;
begin
  for c := 0 to Pred(Grid.ColumnCount) do
    for r := 0 to Pred(Grid.RowCount) do
      Grid.Cells[c, r] := '';

  Grid.RowCount := 0;
end;

Function ReturnTimeInternet: TDate;
Var
  SNTP: TIdSNTP;
begin
  SNTP := TIdSNTP.Create(nil);
  try
    SNTP.Host := 'pool.ntp.br';
    Result := SNTP.DateTime;
  finally
    SNTP.Disconnect;
    SNTP.Free;
  end;
end;

procedure LimpaCampos(Form: TForm);
var
  cont: Integer;
begin
  for cont := 0 To Form.ComponentCount - 1 Do
  begin
    If Form.Components[cont] Is TEdit Then
      TEdit(Form.Components[cont]).Text := EmptyStr;

    If Form.Components[cont] Is TComboBox Then
      TComboBox(Form.Components[cont]).ItemIndex := 0;

    If Form.Components[cont] Is TCheckBox Then
      TCheckBox(Form.Components[cont]).IsChecked := false;

    If Form.Components[cont] Is TNumberBox Then
      TNumberBox(Form.Components[cont]).Text := EmptyStr;

    If Form.Components[cont] Is TMemo Then
      TMemo(Form.Components[cont]).Lines.Clear;

  end;

end;

function FormataDoc(fDoc: String): String;
Var
  vTam, xx: Integer;
  vDoc: String;
begin
  vTam := Length(fDoc);
  For xx := 1 To vTam Do
    If (copy(fDoc, xx, 1) <> '.') And (copy(fDoc, xx, 1) <> '-') And (copy(fDoc, xx, 1) <> '/') Then
      vDoc := vDoc + copy(fDoc, xx, 1);
  fDoc := vDoc;
  vTam := Length(fDoc);
  vDoc := '';
  vDoc := '';
  For xx := 1 To vTam Do
  begin
    vDoc := vDoc + copy(fDoc, xx, 1);
    If vTam = 11 Then
    begin
      If (xx in [3, 6]) Then
        vDoc := vDoc + '.';
      If xx = 9 Then
        vDoc := vDoc + '-';
    end;
    If vTam = 14 Then
    begin
      If (xx in [2, 5]) Then
        vDoc := vDoc + '.';
      If xx = 8 Then
        vDoc := vDoc + '/';
      If xx = 12 Then
        vDoc := vDoc + '-';
    end;
  end;
  Result := vDoc;
end;

procedure ListViewSearch(AList: TListView);
var
  i: Integer;
begin

  AList.SearchVisible := true;
  for i := 0 to AList.Controls.Count - 1 do
    if AList.Controls[i].ClassType = TSearchBox then
    begin
      sbList := TSearchBox(AList.Controls[i]);
      Break;
    end;
  sbList.Height := 0;
  sbList.Visible := false
  // sbList.TextPrompt := 'Digite o que deseja encontrar';
  // sbList.SetFocus;
end;

procedure Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1, texto_btn2: string;
  cor_btn1, cor_btn2: Cardinal);
begin
  if NOT Assigned(Frm_Mensagem) then
    Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);

  with Frm_Mensagem do
  begin
    // Icone...
    if icone = 'ALERTA' then
      img_icone.Bitmap := img_alerta.Bitmap
    else if icone = 'PERGUNTA' then
      img_icone.Bitmap := img_pergunta.Bitmap
    else if icone = 'ERRO' then
      img_icone.Bitmap := img_erro.Bitmap
    else if icone = 'SUCESSO' then
      img_icone.Bitmap := img_sucesso.Bitmap;

    // Tipo mensagem...
    rect_btn2.Visible := false;
    if tipo_mensagem = 'PERGUNTA' then
    begin
      rect_btn1.Width := 102;
      rect_btn2.Width := 102;
      rect_btn1.Align := TAlignLayout.Left;
      rect_btn2.Align := TAlignLayout.Right;

      rect_btn2.Visible := true;
    end
    else
    begin
      rect_btn1.Width := 160;
      rect_btn1.Align := TAlignLayout.Center;
    end;

    // Textos da Mensagem...
    lbl_titulo.Text := titulo;
    lbl_msg.Text := texto_msg;

    // Textos Botoes...
    lbl_btn1.Text := texto_btn1;
    lbl_btn2.Text := texto_btn2;

    // Cor Botoes...
    rect_btn1.Fill.Color := cor_btn1;
    rect_btn2.Fill.Color := cor_btn2;
  end;
end;

(*
  function FormataValor(const pValor: Extended; const pDecimais: Word): string;
  var
  LDecimalSeparator: Char;
  LFormat: string;
  begin
  Result := '';
  if pValor <> 0 then
  begin
  LDecimalSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := ',';
  LFormat := ',0.' + StringOfChar('0', pDecimais);
  Result := FormatFloat(LFormat, pValor, FormatSettings);
  FormatSettings.DecimalSeparator := LDecimalSeparator;
  end
  else
  result := '0,00';
  end;
*)

function StrParaDouble(valor: string; QuantZeros: Integer): Double;
begin
  Result := strtofloat(StringReplace(FormataValor(valor), '.', '', [rfReplaceAll, rfIgnoreCase]));
end;

function FormataValor(valor: String; QuantZeros: Integer { ; Direita: Boolean } ): String;
var
  i: Integer;
  Formato, Sinal: String;
begin
  Result := '';

  if (valor <> '') then
    Sinal := ifthen(copy(valor, 01, 01) = '-', '-', '');

  for i := 0 to Length(valor) do
    if (valor[i] in ['0' .. '9', ',']) then
      Result := Result + valor[i];

  // if (Result = '') and (not Direita) then
  // Result := '0';
  //
  // if (Direita) then
  Formato := '#,##0.' + StringOfChar('0', QuantZeros);
  // else
  // Formato := StringOfChar('0', QuantZeros);

  if (QuantZeros <> 0) then
    valor := '0,' + StringOfChar('0', QuantZeros)
  else
    valor := '';

  try
    if (Result = '') then
      Result := Sinal + valor
    else
      Result := Sinal + FormatFloat(Formato, strtofloat(Result));
  except
    // MessageDlg('Valor inv·lido!', mtError, [mbOK], 0);
    Result := Sinal + valor;
    // Abort;
  end;
end;

// Formata n˙mero telefone fixo
Function formatelefone(numtexto: String): String;
begin
  if Length(numtexto) = 11 then
  begin
    Delete(numtexto, ansipos('-', numtexto), 1); // Remove traÁo -
    Delete(numtexto, ansipos('-', numtexto), 1);
    Delete(numtexto, ansipos('(', numtexto), 1); // Remove parenteses  (
    Delete(numtexto, ansipos(')', numtexto), 1); // Remove parenteses  )
    Result := FormatmaskText('\(00\)00000\-0000;0;', numtexto);
  end
  else if Length(numtexto) = 10 then
  begin
    Delete(numtexto, ansipos('-', numtexto), 1); // Remove traÁo -
    Delete(numtexto, ansipos('-', numtexto), 1);
    Delete(numtexto, ansipos('(', numtexto), 1); // Remove parenteses  (
    Delete(numtexto, ansipos(')', numtexto), 1); // Remove parenteses  )
    Result := FormatmaskText('\(00\)0000\-0000;0;', numtexto);
  end;
  // Formata os numero
end;

// fomatar edit caixa eletronico
function FNUMD(Objeto: TEdit; Texto, VKey: String; Espaco, Decimal: Integer): String;
Var
  vChar, vDiv: String;
  i: Integer;
begin
  vDiv := '1';
  For i := 1 to Decimal do
    vDiv := vDiv + '0';

  vChar := copy(Texto, 1, Length(Texto));

  if (vChar = '') or (vChar = '0') then
    vChar := VKey
  else
    vChar := vChar + VKey;

  While (pos(',', vChar) > 0) or (pos('.', vChar) > 0) do
  begin
    Delete(vChar, pos('.', vChar), 1);
    Delete(vChar, pos(',', vChar), 1);
  end;
  Objeto.MaxLength := Espaco;
  Objeto.Text := Format('%*.*n', [Espaco, Decimal, strtofloat(vChar) / StrToInt(vDiv)]);
  Objeto.SelStart := Length(Objeto.Text);
end;

function DataHoje: TDate;
begin
  Result := StrToDate(FormatDateTime('dd/mm/yyyy', Date));
end;

procedure FormatarMoeda(Componente: TObject; var Key: Char);
var
  valor_str: String;
  valor: Double;
begin

  if Componente is TEdit then
  begin
    // Se tecla pressionada È um numero, backspace ou delete...
    if (Key in ['0' .. '9', #8, #9]) then
    begin
      // Salva valor do edit...
      valor_str := TEdit(Componente).Text;

      // Valida vazio...
      if valor_str = EmptyStr then
        valor_str := '0,00';

      // Se valor numerico, insere na string...
      if Key in ['0' .. '9'] then
        valor_str := Concat(valor_str, Key);

      // Retira pontos e virgulas...
      valor_str := Trim(StringReplace(valor_str, '.', '', [rfReplaceAll, rfIgnoreCase]));
      valor_str := Trim(StringReplace(valor_str, ',', '', [rfReplaceAll, rfIgnoreCase]));

      // Inserindo 2 casas decimais...
      valor := StrToFloat_Universal(valor_str);
      valor := (valor / 100);

      // Retornando valor tratado ao edit...
      TEdit(Componente).Text := FormatFloat('###,##0.00', valor);

      // Reposiciona cursor...
      TEdit(Componente).SelStart := Length(TEdit(Componente).Text);
    end;

    // Se nao È key importante, reseta...
    if Not(Key in [#8, #9]) then
      Key := #0;
  end;

end;

function StrToFloat_Universal(pText: string): Extended;
const
  BRAZILIAN_ST = ',';
  AMERICAN_ST  = '.';
var
  lFinalValue: string;

begin

  lFinalValue := StringReplace(pText, '.', '', [rfReplaceAll]);

  Result := StrToFloatDef(lFinalValue, 0, FormatSettings);

end;

function RemoveAcento(const pText: string): string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸Ò˝¿¬ ‘€√’¡…Õ”⁄«‹—›';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
  Text: string;
begin;
  Text := pText;
  for x := 1 to Length(Text) do
    try
      if (pos(Text[x], ComAcento) <> 0) then
        Text[x] := SemAcento[pos(Text[x], ComAcento)];
    except
      on E: Exception do
        raise Exception.Create('Erro no processo!');
    end;

  Result := Text;
end;

end.
