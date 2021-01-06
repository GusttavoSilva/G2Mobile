unit uFraAnimacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Ani, FMX.Layouts;

type
  TFraAnimacao = class(TFrame)
    Rectangle1: TRectangle;
    ArcAnimacao: TArc;
    FloatAnimation: TFloatAnimation;
    CircleAnimacao: TCircle;
    Label1: TLabel;
    Layout1: TLayout;
    lblAguarde: TLabel;
    procedure FloatAnimationProcess(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}
{ TFraAnimacao }

procedure TFraAnimacao.FloatAnimationProcess(Sender: TObject);
begin
  FloatAnimation.StartValue := FloatAnimation.StartValue + 30;
end;

end.
