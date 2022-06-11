unit uPedidoDAO;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  VCL.Grids, System.Generics.Collections,
  uBaseDAO, uConnection, uPedido, uPedidoItem, uCliente, uClienteDAO, uProduto, uProdutoDAO;

  type TPedidoDAO = class(TInterfacedObject, iBaseDao)
    private
      FClienteDAO: TClienteDao;
      FProdutoDAO: TProdutoDao;
      Query: TFDQuery;
      Conn: TFDConnection;
      function getQuery: TFDQuery;
    public
      //function LoadAll(paramstr: string = ''): TObjectList<TPedido>;
      function Save(APedido: TPedido): boolean;
      function Load(APedido: TPedido; AId: integer): boolean;
      function Delete(AId: integer): boolean;
      function LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;
      function gerarId(): integer;
      constructor Create;
      destructor Destroy; override;

  end;


implementation

{ TPedidoDAO }

constructor TPedidoDAO.Create;
begin
  inherited;
end;

destructor TPedidoDAO.Destroy;
begin
  inherited;
end;

function TPedidoDAO.gerarId: integer;
begin
  Conn := TMyConnection.GetConn;
  Result := Conn.ExecSQLScalar('SELECT COALESCE(MAX(idpedidos), 0) + 1 FROM pedidos');
end;

function TPedidoDAO.getQuery: TFDQuery;
begin
  Result := TMyConnection.GetQuery;
end;

function TPedidoDAO.Load(APedido: TPedido; AId: integer): boolean;
begin
  Result := False;

  try
    Query := getQuery;
    FClienteDAO := TClienteDAO.Create;
    FProdutoDAO := TProdutoDAO.Create;

    with Query, APedido do
    begin
      SQL.Add('SELECT * FROM pedidos WHERE idpedidos = &id');
      MacroByName('id').AsInteger := AId;

      Open;

      if not (RecordCount > 0) then
        Exit;

      Emis := FieldByName('Emis').AsDateTime;

      Cliente := TCliente.Create(FieldByName('idclientes').AsInteger);
      if (FieldByName('idclientes').AsInteger > 0) and (not FClienteDAO.Load(Cliente, FieldByName('idclientes').AsInteger)) then
        Exit;

      Query.Close;
      Query.SQL.Clear;

      SQL.Add('SELECT * FROM peditens WHERE idpedidos = &id');
      MacroByName('id').AsInteger := AId;

      Open;

      var i: integer;
      var Item: TPedidoItem;
      for i := 0 to RecordCount - 1 do
      begin
        Item := TPedidoItem.Create();
        with Item do
        begin
          Seq := FieldByName('idpeditens').AsInteger;
          Quantidade := FieldByName('quantidade').AsFloat;
          Unitario   := FieldByName('unitario').AsFloat;

          Produto := TProduto.Create(FieldByName('idprodutos').AsInteger);
          if not FProdutoDAO.Load(Produto,FieldByName('idprodutos').AsInteger) then
          begin
            //validar
          end;

          APedido.AddItem(Item);
        end;
      end;

      Result := True;

      Close;

    end;

  finally
    FreeAndNil(FProdutoDAO);
    FreeAndNil(FClienteDAO);
    FreeAndNil(Query);
  end;

end;

function TPedidoDAO.LoadAll(var AStringGrid: TStringGrid; paramstr: string): boolean;

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
      SQL.Add('SELECT P.*, C.nome FROM pedidos P ');
      SQL.Add('LEFT JOIN clientes C              ');
      SQL.Add('ON P.idclientes = c.idclientes    ');

      if paramstr > '' then
      SQL.Add('WHERE ' + paramstr                 );

      SQL.Add('ORDER BY idpedidos                ');

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
        Cells[0, i] := FieldByName('idpedidos').AsString;
        Cells[1, i] := FieldByName('nome').AsString;
        Cells[2, i] := FormatDateTime('dd/MM/yyyy', FieldByName('emis').AsDateTime);
        Cells[3, i] := FormatFloat('###,###,###,##0.00', FieldByName('total').AsFloat);

        Next;
        Inc(i);
      end;

      Result := True;
    end;

  finally
    FreeAndNil(Query);
  end;
end;
function TPedidoDAO.Save(APedido: TPedido): boolean;
var
  Item: TPedidoItem;
  MyID: integer;
begin
  try
    try
      Conn := TMyConnection.GetConn;

      Conn.StartTransaction;

        if APedido.Id = 0 then
        begin
           MyID := gerarId;

           Conn.ExecSQL(
              'INSERT INTO pedidos                       ' +
              ' (idpedidos, emis, idclientes, total)     ' +
              'VALUES                                    ' +
              ' (:idpedidos, :emis, :idclientes, :total) ' ,
                [MyID, APedido.Emis, APedido.Cliente.Id, APedido.Total]
           );
        end
        else
        begin
          MyID := APedido.Id;

          Conn.ExecSQL(
            'UPDATE pedidos SET                                        ' +
            ' emis = :emis , idclientes = :idclientes , total = :total ' +
            'WHERE                                                     ' +
            ' idpedidos = :idpedidos                                   ' ,
              [APedido.Emis, APedido.Cliente.Id, APedido.Total, MyID]
           );

        end;


        Conn.ExecSQL('Delete FROM peditens WHERE idpedidos = ' + intToStr(MyID));

        for Item in APedido.Itens do
        begin
          Conn.ExecSQL(
             'INSERT INTO peditens                                       ' +
             ' (idpeditens, idpedidos, idprodutos, unitario, total)      ' +
             'VALUES                                                     ' +
             ' (:idpeditens, :idpedidos, :idprodutos, :unitario, :total) ' ,
               [Item.Seq, MyID, Item.Produto.Id, Item.Unitario, Item.Total]
          );

        end;

      Conn.Commit;

      Result := True;
    except
      Conn.Rollback;
    end;

  finally
  end;

end;

function TPedidoDAO.Delete(AId: integer): boolean;
begin
  try
    try
      Conn := TMyConnection.GetConn;

      Conn.StartTransaction;

      Conn.ExecSQL('Delete FROM peditens WHERE idpedidos = ' + intToStr(AId));
      Conn.ExecSQL('Delete FROM pedidos  WHERE idpedidos = ' + intToStr(AId));

      Conn.Commit;
      Result := True;
    except
      Conn.Rollback;
    end;
  finally

  end;
end;

end.
