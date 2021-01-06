unit uLibrary;

interface

type
  TLibrary = class
  private
    class var FOnLine: Boolean;
  public
    class property OnLine: Boolean read FOnLine write FOnLine;
  end;

implementation

end.
