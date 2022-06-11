unit uClienteDao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  VCL.Grids,
  uBaseDAO, uConnection, uCliente;

type TClienteDao = class(TInterfacedObject, iBaseDao)
  private
    Query: TFDQuery;
    function getQuery: TFDQuery;
  public
    function Load(ACliente: TCliente; AId: integer): boolean;
    function LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;

    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TClienteDao }

constructor TClienteDao.Create;
begin
  inherited;
end;

destructor TClienteDao.Destroy;
begin
  inherited;
end;

function TClienteDao.getQuery: TFDQuery;
begin
  Result := TMyConnection.GetQuery;
end;

function TClienteDao.LoadAll(var AStringGrid: TStringGrid; paramstr: string): boolean;

  procedure ClearAStringGrid;
  var
    i: integer;
  begin
    for I := 0 to AStringGrid.ColCount - 1 do
      AStringGrid.Cols[I].Clear;
  end;

var
  i: integer;
begin
  Result := False;

  try
    Query := getQuery;

    with Query, AStringGrid do
    begin
      SQL.Add('SELECT * FROM clientes');

      if paramstr > '' then
        SQL.Add(' WHERE ' + paramstr);

      Open;

      ClearAStringGrid;

      if not (RecordCount > 0) then
      begin
        RowCount := 2;
        Exit;
      end;

      RowCount := RecordCount + 1;


      First;
      i := 1;
      while not Eof do
      begin
        Cells[0, i] := FieldByName('idclientes').AsString;
        Cells[1, i] := FieldByName('nome').AsString;
        Cells[2, i] := FieldByName('cidade').AsString;
        Cells[3, i] := FieldByName('uf').AsString;

        Next;
        Inc(i);
      end;

      Result := True;
    end;

  finally
    FreeAndNil(Query);
  end;
end;

function TClienteDao.Load(ACliente: TCliente; AId: integer): boolean;
begin
  Result := False;

  try
    Query := getQuery;

    with Query, ACliente do
    begin
      SQL.Add('SELECT * FROM clientes WHERE idclientes = &id');
      MacroByName('id').AsInteger := AId;

      Open;

      if not (RecordCount > 0) then
        Exit;

      Id        := AId;
      Nome      := FieldByName('nome').AsString;
      Cidade    := FieldByName('cidade').AsString;
      UF        := FieldByName('uf').AsString;

      Result := True;

      Close;

    end;

  finally
    FreeAndNil(Query);
  end;

end;

end.
