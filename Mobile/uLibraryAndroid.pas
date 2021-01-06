unit uLibraryAndroid;

interface

uses
{$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText, Androidapi.Helpers,
  Androidapi.JNI.Telephony, Androidapi.JNI.Provider, Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes, Androidapi.JNI.Os, Androidapi.JNI.App,
{$ENDIF}
{$IFDEF IOS}
  iOSApi.UIKit,
  iOSApi.Foundation,
  Macapi.Helpers,
{$ENDIF}
  System.SysUtils, MobilePermissions.Component, FMX.ZDeviceInfo;

function GetIMEI: string;
procedure PermissaoAparelho;

implementation

uses
  System.Sensors.Components;

function GetIMEI: string;
var
  di:     TZDeviceInfo;
  tablet: string;
begin
  try
    di     := TZDeviceInfo.Create;
    result := di.DeviceID;
  finally
    di.Free;
  end;

end;

procedure PermissaoAparelho;
var
  MobilePermissions1: TMobilePermissions;
begin

  MobilePermissions1 := TMobilePermissions.Create(nil);

  try
    MobilePermissions1.Dangerous.AccessFineLocation   := True;
    MobilePermissions1.Dangerous.AccessCoarseLocation := True;
    MobilePermissions1.Dangerous.ReadPhoneState       := True;
    MobilePermissions1.Apply;

  finally
    FreeAndNil(MobilePermissions1)
  end;
end;

end.
