unit uFrmInforSistema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.TabControl;

type
  TFrmInforSistema = class(TFrmBase)
    tabGeral01: TTabControl;
    tab01: TTabItem;
    VertScrollBox1: TVertScrollBox;
    Rectangle1: TRectangle;
    Label1: TLabel;
    lblBuild: TLabel;
    lblVersao: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ToolBar1: TToolBar;
    Label3: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInforSistema: TFrmInforSistema;

implementation

{$R *.fmx}

uses uFrmInicio, uFrmMain, FMX.VirtualKeyboard, FMX.Platform; // , FMX.Helpers.Android, FMX.Platform.Android;

procedure TFrmInforSistema.Button1Click(Sender: TObject);
begin
  inherited;
  // FrmMain.MudarCabecalho('Início');
  FrmMain.FormOpen(TFrmInicio);
end;

procedure TFrmInforSistema.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
  inherited;
{$IFDEF ANDROID}
  if (Key = vkHardwareBack) then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
    begin
      // botão back pressionado e teclado visivel...
      // (fecha o teclado)
    end
    else
    begin
      // botão back pressionado e teclado não visivel..
      FrmMain.FormOpen(TFrmInicio);
      Key := 0;
    end;
  end;
{$ENDIF}
end;

end.
