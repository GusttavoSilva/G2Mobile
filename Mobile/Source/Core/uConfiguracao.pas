unit uConfiguracao;

interface

uses
  FireDac.Comp.Client, IdHashMessageDigest, FMX.TabControl;

Type
  TFuncoes = class
    class procedure ClonarDataSet(const ADataSet: TFDMemTable; const AQuery: TFDQuery);
  end;

  TMudarAba = record
    procedure ClienteInicio(AbaInicial: TChangeTabAction);
  end;

  TBairroSelecionado = record
  private
    FCodigo: integer;
    FNome:   string;
    procedure SetCodigo(const Value: integer);
    procedure SetNome(const Value: string);
  public
    Property Codigo: integer read FCodigo write SetCodigo;
    Property Nome:   string read FNome write SetNome;
  end;

  TUsuario = record
  private
    FCodUsuarioAtual: integer;
    procedure SetCodUsuarioAtual(const Value: integer);
  public
    property CodUsuarioAtual: integer read FCodUsuarioAtual write SetCodUsuarioAtual;
  end;

  TConfiguracao = record
  private
    FDSHostName:       string;
    FTituloJanelaMain: string;
    FRESTContext:      string;
    FDSMethod:         string;
    FNumeroConexao:    integer;
    FDSContext:        string;
    FURLBase:          string;
    FDSPort:           string;
    procedure SetDSContext(const Value: string);
    procedure SetDSHostName(const Value: string);
    procedure SetDSMethod(const Value: string);
    procedure SetDSPort(const Value: string);
    procedure SetNumeroConexao(const Value: integer);
    procedure SetRESTContext(const Value: string);
    procedure SetTituloJanelaMain(const Value: string);
    procedure SetURLBase(const Value: string);
  public
    property URLBase:          string read FURLBase write SetURLBase;
    property DSHostName:       string read FDSHostName write SetDSHostName;
    property DSContext:        string read FDSContext write SetDSContext;
    property RESTContext:      string read FRESTContext write SetRESTContext;
    property DSPort:           string read FDSPort write SetDSPort;
    property DSMethod:         string read FDSMethod write SetDSMethod;
    property NumeroConexao:    integer read FNumeroConexao write SetNumeroConexao;
    property TituloJanelaMain: string read FTituloJanelaMain write SetTituloJanelaMain;

  end;

  TSistema = record
  private
    FEstouNoLogin: Boolean;
    FFormAtual:    string;
    procedure SetEstouNoLogin(const Value: Boolean);
    procedure SetFormAtual(const Value: string);
  public
    property EstouNoLogin: Boolean read FEstouNoLogin write SetEstouNoLogin;
    property FormAtual:    string read FFormAtual write SetFormAtual;
  end;

  TProdutos = record
  private
    FCodigo:   integer;
    FAbaAtual: integer;
    FNome:     string;
    procedure SetCodigo(const Value: integer);
    procedure SetAbaAtual(const Value: integer);
    procedure SetNome(const Value: string);
  public
    property Codigo:   integer read FCodigo write SetCodigo;
    property Nome:     string read FNome write SetNome;
    Property AbaAtual: integer read FAbaAtual write SetAbaAtual;
  end;

procedure MudarTituloPesq(ATexto: string);
procedure MudarTituloPesq2(ATexto: string);
procedure MudarTituloGeral(ATexto: string);
Function MD5Crypt(const Value: string): string;

var
  Configuracao:      TConfiguracao;
  Produtos:          TProdutos;
  Sistema:           TSistema;
  Usuario:           TUsuario;
  BairroSelecionado: TBairroSelecionado;

implementation

uses uFrmMain;

procedure MudarTituloPesq2(ATexto: string);
begin
  // frmMain.lblGeralPesquisas2.Text := ATexto;
end;

procedure MudarTituloPesq(ATexto: string);
begin
  // frmMain.lblGeralPesquisas.Text := ATexto;
end;

procedure MudarTituloGeral(ATexto: string);
begin
  // frmMain.lblTituloGeral.Text := ATexto;
end;

Function MD5Crypt(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  try
    Result := xMD5.HashStringAsHex(Value);
  finally
    xMD5.free;
  end;
end;

{ TProdutos }

procedure TProdutos.SetAbaAtual(const Value: integer);
begin
  FAbaAtual := Value;
end;

procedure TProdutos.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TProdutos.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TSistema }

procedure TSistema.SetEstouNoLogin(const Value: Boolean);
begin
  FEstouNoLogin := Value;
end;

procedure TSistema.SetFormAtual(const Value: string);
begin
  FFormAtual := Value;
end;

{ TFuncoes }

class procedure TFuncoes.ClonarDataSet(const ADataSet: TFDMemTable; const AQuery: TFDQuery);
begin

  if ADataSet.Active then
  begin
    ADataSet.EmptyDataSet;
  end;

  ADataSet.AppendData(AQuery, True);
end;

{ TConfiguracao }

procedure TConfiguracao.SetDSContext(const Value: string);
begin
  FDSContext := Value;
end;

procedure TConfiguracao.SetDSHostName(const Value: string);
begin
  FDSHostName := Value;
end;

procedure TConfiguracao.SetDSMethod(const Value: string);
begin
  FDSMethod := Value;
end;

procedure TConfiguracao.SetDSPort(const Value: string);
begin
  FDSPort := Value;
end;

procedure TConfiguracao.SetNumeroConexao(const Value: integer);
begin
  FNumeroConexao := Value;
end;

procedure TConfiguracao.SetRESTContext(const Value: string);
begin
  FRESTContext := Value;
end;

procedure TConfiguracao.SetTituloJanelaMain(const Value: string);
begin
  FTituloJanelaMain := Value;
end;

procedure TConfiguracao.SetURLBase(const Value: string);
begin
  FURLBase := Value;
end;

{ TUsuario }

procedure TUsuario.SetCodUsuarioAtual(const Value: integer);
begin
  FCodUsuarioAtual := Value;
end;

{ TBairroSelecionado }

procedure TBairroSelecionado.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TBairroSelecionado.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TMudarAba }

procedure TMudarAba.ClienteInicio(AbaInicial: TChangeTabAction);
begin
end;

end.
