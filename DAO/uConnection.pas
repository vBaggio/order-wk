unit uConnection;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  Vcl.Forms, Vcl.Dialogs, IniFiles;

type
  TMyConnection = class
  private
    class var MyConn : TMyConnection;
    FConn: TFDConnection;
    procedure SetupConnection;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetConn: TFDConnection;
    class function GetQuery: TFDQuery;

    class var CONN_IP:string;
    class var CONN_PORT:string;
    class var CONN_DBNAME:string;
    class var CONN_USER:string;
    class var CONN_PASS:string;
    class procedure LerIni;
  end;

implementation

{ TConexao }


procedure TMyConnection.SetupConnection;
begin
  try
    Self.LerIni;

    FConn.Connected := False;

    FConn.Params.DriverID := 'MYSQL';

    FConn.Params.Add('Server='+ Self.CONN_IP);
    FConn.Params.Add('Port='+ Self.CONN_PORT);
    FConn.Params.Database := Self.CONN_DBNAME;
    FConn.Params.UserName := Self.CONN_USER;
    FConn.Params.Password := Self.CONN_PASS;
    FConn.LoginPrompt     := False;

    FConn.Connected := True;
  except
    ShowMessage('Erro ao conectar com o banco de dados.' + #13 + 'Verifique o arquivo .ini no diretório do executável.');
    Application.Terminate;
  end;
end;

constructor TMyConnection.Create;
begin
  if not Assigned(FConn) then
    FConn := TFDConnection.Create(nil);

  Self.SetupConnection;
end;

destructor TMyConnection.Destroy;
begin
  FConn.Free;

  inherited;
end;

class function TMyConnection.GetConn: TFDConnection;
begin
  if not Assigned(Self.MyConn) then
    Self.MyConn := TMyConnection.Create;

  if not Self.MyConn.FConn.Connected then
    Self.MyConn.SetupConnection;

  Result := Self.MyConn.FConn;
end;

class function TMyConnection.GetQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
  VQuery := TFDQuery.Create(nil);
  VQuery.Connection := Self.GetConn;

  Result := VQuery;
end;


class procedure TMyConnection.LerIni;
var
  ininame: string;
  inifile: TIniFile;
begin
  ininame := ChangeFileExt( Application.ExeName, '.ini' );
  inifile := TIniFile.Create(ininame);

  if not FileExists(ininame) then
  begin
    inifile.WriteString( 'Db', 'IP',     'localhost');
    inifile.WriteString( 'Db', 'PORT',   '3306');
    inifile.WriteString( 'Db', 'DBNAME', 'wk_order');
    inifile.WriteString( 'Db', 'USER',   'root');
    inifile.WriteString( 'Db', 'PASS',   '');
  end;

  try
    Self.CONN_IP     := inifile.ReadString( 'Db', 'IP',     'localhost');
    Self.CONN_PORT   := inifile.ReadString( 'Db', 'PORT',   '3306');
    Self.CONN_DBNAME := inifile.ReadString( 'Db', 'DBNAME', 'wk_order');
    Self.CONN_USER   := inifile.ReadString( 'Db', 'USER',   'root');
    Self.CONN_PASS   := inifile.ReadString( 'Db', 'PASS',   '');
  finally
    inifile.Free;
  end;

end;

end.
