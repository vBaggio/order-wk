unit uProdutoDao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  VCL.Grids,
  uBaseDAO, uConnection, uProduto;


type TProdutoDao = class(TInterfacedObject, iBaseDao)
  private
    Query: TFDQuery;
    function getQuery: TFDQuery;
  public
    function Load(AProduto: TProduto; AId: integer): boolean;
    function LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;

    constructor Create;
    destructor Destroy; override;
end;

implementation


{ TProdutoDao }

constructor TProdutoDao.Create;
begin
  inherited;
end;

destructor TProdutoDao.Destroy;
begin
  inherited;
end;

function TProdutoDao.getQuery: TFDQuery;
begin
  Result := TMyConnection.GetQuery;
end;

function TProdutoDao.LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;

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
      SQL.Add('SELECT * FROM produtos');

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
        Cells[0, i] := FieldByName('idprodutos').AsString;
        Cells[1, i] := FieldByName('descricao').AsString;
        Cells[2, i] := formatfloat('###,###,###,##0.00', FieldByName('venda').AsFloat);

        Next;
        Inc(i);
      end;

      Result := True;
    end;

  finally
    FreeAndNil(Query);
  end;
end;

function TProdutoDao.Load(AProduto: TProduto; AId: integer): boolean;
begin
  Result := False;

  try
    Query := getQuery;

    with Query, AProduto do
    begin
      SQL.Add('SELECT * FROM produtos WHERE idprodutos = &id');
      MacroByName('id').AsInteger := AId;

      Open;

      if not (RecordCount > 0) then
        Exit;

      Id        := AId;
      Descricao := FieldByName('descricao').AsString;
      Venda     := FieldByName('venda').AsFloat;

      Result := True;

      Close;

    end;

  finally
    FreeAndNil(Query);
  end;

end;

end.
