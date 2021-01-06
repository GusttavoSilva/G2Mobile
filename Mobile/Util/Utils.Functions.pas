unit Utils.Functions;

interface
uses
  Vcl.ExtCtrls,RTTI, vcl.controls,System.classes,Vcl.StdCtrls, vcl.forms,Generics.collections,
  System.UITypes;


Type
  TGenericObject<T: class> = class
  public
    class function CreateObject: T;
  end;


function Iif(Contition: Boolean; ValueTrue, ValueFalse : Variant):Variant;overload;
procedure LimpaCampos(Container :TCustomControl; Ignorar: array of TComponent);overload;
procedure LimpaCampos(Container :TForm; Ignorar: array of TComponent);overload;
function ZeroEsquerda(pValor: string; pQtd: integer): string;
procedure DesablePanel (var aPanel : TPanel);
procedure EnablePanel (var aPanel : TPanel;  aColor: TColor);

implementation

function Iif(Contition: Boolean; ValueTrue, ValueFalse : Variant):Variant;
begin
  if Contition then
    Result := ValueTrue
  else
    Result := ValueFalse;
end;


procedure LimpaCampos(Container :TCustomControl; Ignorar: array of TComponent);overload;
var
  i: Integer;
  contador: Integer;
  IgnoraComp: Boolean;
  j: Integer;
begin
  for i := 0 to Container.ComponentCount - 1 do
  begin

    IgnoraComp := false;

    for contador := 0 to High(Ignorar) do
    begin
      if Container.Components[i] = Ignorar[contador] then
      begin
        IgnoraComp := true;
        break;
      end;
    end;

    if IgnoraComp then
      Continue;

    if (Container.Components[i] is TEdit) then
    begin
      TEdit(Container.Components[i]).Text := '';
    end
    else if (Container.Components[i] is TMemo) then
    begin
      TMemo(Container.Components[i]).Lines.Clear;
    end
    else if (Container.Components[i] is TComboBox) then
    begin
      TComBoBox(Container.Components[i]).ItemIndex := -1;
    end;

  end;


end;
procedure LimpaCampos(Container :TForm; Ignorar: array of TComponent);overload;
var
  i: Integer;
  contador: Integer;
  IgnoraComp: Boolean;
  j: Integer;
begin
  for i := 0 to Container.ComponentCount - 1 do
  begin

    IgnoraComp := false;

    for contador := 0 to High(Ignorar) do
    begin
      if Container.Components[i] = Ignorar[contador] then
      begin
        IgnoraComp := true;
        break;
      end;
    end;

    if IgnoraComp then
      Continue;

    if (Container.Components[i] is TEdit) then
    begin
      TEdit(Container.Components[i]).Text := '';
    end
    else if (Container.Components[i] is TMemo) then
    begin
      TMemo(Container.Components[i]).Lines.Clear;
    end
    else if (Container.Components[i] is TComboBox) then
    begin
      TComBoBox(Container.Components[i]).ItemIndex := -1;
    end;
  end;
end;
function ZeroEsquerda(pValor: string; pQtd: integer): string;
var
i, vTam: integer;
vAux: string;

begin
  vAux := pValor;
  vTam := length( pValor );
  pValor := '';
  for i := 1 to pQtd - vTam do
    pValor := '0' + pValor;
  vAux := pValor + vAux;
  result := vAux;

end;

procedure DesablePanel (var aPanel : TPanel);
begin
  with aPanel do
  begin
    Enabled := false;
    Color   := $00C7C3BE;
    Cursor  := crNo;
  end;
end;

procedure EnablePanel (var aPanel : TPanel; aColor: TColor);
begin
  with aPanel do
  begin
    Enabled := True;
    Color   := aColor;
    Cursor  := crHandPoint;
  end;
end;

{ TGenericObject<T> }

class function TGenericObject<T>.CreateObject: T;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Value: TValue;
  Obj: TObject;
begin
  // Criando Objeto via RTTI para chamar o envento OnCreate no Objeto
  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(TClass(T));
    Value := Tipo.GetMethod('Create').Invoke(Tipo.AsInstance.MetaclassType, []);
    Result := T(Value.AsObject);
  finally
    Contexto.Free;
  end;

end;


end.
