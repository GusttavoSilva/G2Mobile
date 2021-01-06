unit UntLib;

interface

uses
  FMX.Objects,
  FMX.Edit,
  FMX.TabControl,
  FMX.Multiview,
  FMX.Forms,
  FMX.Layouts,
  FMX.Types,
  FMX.StdCtrls,
  FMX.VirtualKeyboard,
  FMX.Platform,
  FMX.Controls,

{$IFDEF ANDROID}
  FMX.Platform.Android,
  FMX.Helpers.Android,
  // FMX.Permissions.Android,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  Androidapi.JNI.Telephony,
  Androidapi.JNI.Provider,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Net,
  Androidapi.JNI.App,
{$ENDIF}
  System.StrUtils,
  System.IOUtils,
  System.SysUtils,
  System.RegularExpressions,
  System.Types,
  System.Classes,
  System.Rtti,
  System.UITypes,

  idTCPClient;

// ksTabControl;

type
  TLibrary = class
  private

  public
    class function FormataCurrency(AValue: String; ACasasDecimais: Integer; ABackspaceIsPressedEdtCurrency: Boolean = False): String;
    class function LPad(S: string; Ch: Char; Len: Integer): string; // Insere a quantidade Len de Ch aa esquerda
    class function RPad(S: string; Ch: Char; Len: Integer): string; // Insere a quantidade Len de Ch aa direita
  end;

implementation

{ TLibrary }

class function TLibrary.FormataCurrency(AValue: String; ACasasDecimais: Integer; ABackspaceIsPressedEdtCurrency: Boolean): String;
var
  VAntesSeparador, VDepoisSeparador, VMaiorQue100: String;
  VLength:                                         Integer;
  i:                                               Integer;
begin
  VMaiorQue100 := '';
  if (Pos(',', AValue) <= 0) then
  begin
    AValue := AValue + ',' + RPad('', '0', ACasasDecimais);
  end;

  if not(ABackspaceIsPressedEdtCurrency) then
    if ((Length(AValue)) - (Pos(',', AValue)) < ACasasDecimais) then
    begin
      while ((Length(AValue)) - (Pos(',', AValue)) < ACasasDecimais) do
      begin
        AValue := AValue + '0';
      end;
    end;

  AValue := StringReplace(AValue, ',', '', [rfReplaceAll]);
  AValue := StringReplace(AValue, '.', '', [rfReplaceAll]);

  { Tira os 0 aa esquerda }
  if (TryStrToInt(AValue, i)) then
    AValue := IntToStr(i);

  while (AValue.Length <= ACasasDecimais) do
  begin
    AValue := '0' + AValue;
  end;

  VLength := AValue.Length;

  VAntesSeparador  := LeftStr(AValue, VLength - ACasasDecimais);
  VDepoisSeparador := RightStr(AValue, ACasasDecimais);

  Result := VMaiorQue100 + VAntesSeparador + ',' + VDepoisSeparador;
end;

class function TLibrary.LPad(S: string; Ch: Char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(S);
  if RestLen < 1 then
    Exit;

  Result := S + StringOfChar(Ch, RestLen);
end;

class function TLibrary.RPad(S: string; Ch: Char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(S);
  if RestLen < 1 then
    Exit;
  Result := StringOfChar(Ch, RestLen) + S;
end;

end.
