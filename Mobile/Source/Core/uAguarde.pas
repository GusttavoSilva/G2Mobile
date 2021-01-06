unit uAguarde;

interface

uses
  System.SysUtils,
  System.UITypes,

  FMX.Types,
  FMX.Controls,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Forms,
  FMX.Effects,
  FMX.Graphics;

type
  TAguarde = class
  private
    class var FAguarde: TRectangle;
    class var FFundo:   TPanel;

    class procedure TrocaCorPFundo(Sender: TObject);
  public
    class procedure ChangeMessage(const AMsg: string);
    class procedure Show(AParent: TFMXObject; AMsg: string = ''; ATitle: string = '');
    class procedure Hide;
  end;

implementation

{ TAguarde }

class procedure TAguarde.ChangeMessage(const AMsg: string);
var
  LLbl: TLabel;
begin
  LLbl := TLabel(FAguarde.FindComponent('lblMessage'));
  if (LLbl <> nil) then
    LLbl.Text := AMsg;
end;

class procedure TAguarde.Hide;
begin
  if (Assigned(FAguarde)) then
  begin
    FFundo.AnimateFloat('opacity', 0);
    FAguarde.AnimateFloat('opacity', 0);

    FFundo.DisposeOf;
    FAguarde.DisposeOf;

    FFundo   := nil;
    FAguarde := nil;
  end;
end;

class procedure TAguarde.Show(AParent: TFMXObject; AMsg, ATitle: string);
begin
  FFundo                    := TPanel.Create(AParent);
  FFundo.Parent             := AParent;
  FFundo.Visible            := true;
  FFundo.Align              := TAlignLayout.Contents;
  FFundo.OnApplyStyleLookup := TrocaCorPFundo;

  FAguarde             := TRectangle.Create(AParent);
  FAguarde.Parent      := AParent;
  FAguarde.Visible     := true;
  FAguarde.Height      := 75;
  FAguarde.Width       := 275;
  FAguarde.XRadius     := 10;
  FAguarde.YRadius     := 10;
  FAguarde.Position.X  := (TForm(AParent).ClientWidth - FAguarde.Width) / 2;
  FAguarde.Position.Y  := (TForm(AParent).ClientHeight - FAguarde.Height) / 2;
  FAguarde.Stroke.Kind := TBrushKind.None;

  if (ATitle.Trim.IsEmpty) then
    ATitle := 'Por favor, aguarde!';
  with TLabel.Create(FAguarde) do
  begin
    Parent        := FAguarde;
    Align         := TAlignLayout.Top;
    Margins.Left  := 10;
    Margins.Top   := 10;
    Margins.Right := 10;
    Height        := 28;
    StyleLookup   := 'embossedlabel';
    Text          := ATitle;
    Trimming      := TTextTrimming.ttCharacter;
  end;

  with TLabel.Create(FAguarde) do
  begin
    Parent         := FAguarde;
    Align          := TAlignLayout.Client;
    Margins.Left   := 10;
    Margins.Top    := 10;
    Margins.Right  := 10;
    Height         := 28;
    Font.Size      := 12;
    Name           := 'lblMessage';
    StyledSettings := [TStyledSetting.ssFamily, TStyledSetting.ssStyle, TStyledSetting.ssFontColor];
    StyleLookup    := 'embossedlabel';
    Text           := AMsg;
    VertTextAlign  := TTextAlign.Leading;
    Trimming       := TTextTrimming.ttCharacter;
  end;

  with TShadowEffect.Create(FAguarde) do
  begin
    Parent  := FAguarde;
    Enabled := true;
  end;

  FFundo.Opacity   := 0;
  FAguarde.Opacity := 0;

  FFundo.Visible   := true;
  FAguarde.Visible := true;

  FFundo.AnimateFloat('opacity', 0.5);
  FAguarde.AnimateFloat('opacity', 1);
  FAguarde.BringToFront;
  if FAguarde.Canfocus then
    FAguarde.SetFocus;
end;

class procedure TAguarde.TrocaCorPFundo(Sender: TObject);
var
  Rectangle: TRectangle;
begin
  Rectangle            := (Sender as TFMXObject).Children[0] as TRectangle;
  Rectangle.Fill.Color := TAlphaColors.Black;
end;

end.
