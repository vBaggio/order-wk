unit uConnection;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait;

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
  end;

  const
    CONN_IP     :string = '127.0.0.1';
    CONN_PORT   :string = '3306';
    CONN_USER   :string = 'root';
    CONN_PASSWD :string = 'dbpass';
    CONN_DBNAME :string = 'wk-order';

implementation

{ TConexao }

procedure TMyConnection.SetupConnection;
var filepath: string;
begin
    FConn.Connected := False;

    FConn.Params.DriverID := 'MYSQL';

    FConn.Params.Add('Server=' + CONN_IP);

    FConn.Params.Database := CONN_DBNAME;
    FConn.Params.UserName := CONN_USER;
    FConn.Params.Password := CONN_PASSWD;
    FConn.LoginPrompt     := False;

    FConn.Connected := True;
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


end.
