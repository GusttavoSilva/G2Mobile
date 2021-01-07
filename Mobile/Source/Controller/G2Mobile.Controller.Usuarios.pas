unit G2Mobile.Controller.Usuarios;

interface

uses FMX.ListView, System.Classes, Datasnap.DBClient, FireDAC.Comp.Client;

type

  iModelUsuarios = interface
    ['{E83E81C5-7771-41AC-8E6B-E9564A4D5C17}']

    function Usuario(value: String): iModelUsuarios;
    function Senha(value: String): iModelUsuarios;
    function BuscaUserServidor(ADataSet: TFDMemTable): iModelUsuarios;
    function PopulaUserSqLite(ADataSet: TFDMemTable): iModelUsuarios;
    function LimpaTabelaUser: iModelUsuarios;
    function ValidaLogin:iModelUsuarios;
  end;

implementation

end.
