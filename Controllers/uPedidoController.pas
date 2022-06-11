unit uPedidoController;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  uCliente, uClienteDao, uPedido, uPedidoDAO, uPedidoItem, uProduto, uProdutoDao;

type TPedidoController = class
  private
    FPedidoDao: TPedidoDao;
    FClienteDao: TClienteDao;
    FProdutoDao: TProdutoDao;

    FPedido: TPedido;

  public
    property Pedido: TPedido read FPedido write FPedido;

    function setCliente(AId: integer): boolean;
    function setEmis(AEmis: TDateTime): boolean;
    procedure renderizarGrid(var AMemTb : TFDMemTable);

    function ProcurarProd(AId: integer): string;

    function AdicionarItem(AIdProd: integer; AQtde, AVlr: double; var AMsg: string): boolean;
    function DeletarItem(ASeq: integer; var AMsg: string): boolean;
    function AtualizarItem(ASeq: integer; AQtde, AVlr: double; var AMsg: string): boolean;

    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TPedidoController }

function TPedidoController.AdicionarItem(AIdProd: integer; AQtde, AVlr: double; var AMsg: string): boolean;
var
  AuxProd : TProduto;
  AuxItem : TPedidoItem;
begin
  AMsg := 'Erro ao adicionar item.';
  Result := False;

  if not (AIdProd > 0) then
  begin
    AMsg := 'Produto Inválido.';
    Exit;
  end;

  if not (AQtde > 0) then
  begin
    AMsg := 'Quantidade Inválida.';
    Exit;
  end;

  if not (AVlr > 0) then
  begin
    AMsg := 'Valor Inválido.';
    Exit;
  end;

  try
    AuxProd := TProduto.Create(AIdProd);
    AuxItem := TPedidoItem.Create;

    if FProdutoDao.Load(AuxProd, AIdProd) then
    begin
      AuxItem.Quantidade := AQtde;
      AuxItem.Unitario := AVlr;
      AuxItem.Produto := AuxProd;

      FPedido.AddItem(AuxItem);

      AMsg := '';
      Result := True;
    end
    else
      AMsg := 'Produto Inválido.';

  finally
    if not Result then
    begin
      FreeAndNil(AuxItem);
      FreeAndNil(AuxProd);
    end;
  end;

end;

function TPedidoController.AtualizarItem(ASeq: integer; AQtde, AVlr: double; var AMsg: string): boolean;
begin
  AMsg := 'Erro ao atualizar item';
  Result := False;
end;

function TPedidoController.DeletarItem(ASeq: integer; var AMsg: string): boolean;
begin
  AMsg := 'Erro deletar item';

  Result := FPedido.RemoverItem(ASeq);

  if Result then
    AMsg := '';
end;

constructor TPedidoController.Create;
begin
  FPedidoDao := TPedidoDao.Create;
  FClienteDao := TClienteDao.Create;
  FProdutoDao := TProdutoDao.Create;

  FPedido := TPedido.Create;

  FPedido.AddItem(TPedidoItem.Create);
  FProdutoDao.Load(FPedido.Itens[0].Produto, 23);
  FPedido.Itens[0].Quantidade := 2.25;
  FPedido.Itens[0].Unitario := FPedido.Itens[0].Produto.Venda;

  FPedido.AddItem(TPedidoItem.Create);
  FProdutoDao.Load(FPedido.Itens[1].Produto, 24);
  FPedido.Itens[1].Quantidade := 4;
  FPedido.Itens[1].Unitario := FPedido.Itens[1].Produto.Venda;

  FClienteDao.Load(FPedido.Cliente, 22);
end;

destructor TPedidoController.Destroy;
begin

  FreeAndNil(FPedido);
  FreeAndNil(FClienteDao);
  FreeAndNil(FPedidoDao);
  FreeAndNil(FProdutoDao);
  inherited;
end;

function TPedidoController.ProcurarProd(AId: integer): string;
var AuxProd: TProduto;
begin
  Result := 'Produto Inválido';

  try
    AuxProd := TProduto.Create;

    if AId = 0 then
      Exit;

    if FProdutoDao.Load(AuxProd, AId) then
      Result := AuxProd.Descricao;

  finally
    FreeAndNil(AuxProd);
  end;

end;

procedure TPedidoController.renderizarGrid(var AMemTb: TFDMemTable);
var
  Item: TPedidoItem;
begin

  AMemTb.DisableControls;

  if not AMemTb.Active then
    AMemTb.Open;

  AMemtb.EmptyDataSet;

  for Item in FPedido.Itens do
  begin
    with AMemTb, Item do
    begin
      Append;
        FieldByName('NumItem').AsInteger  := Seq;
        FieldByName('IdProd').AsInteger   := Produto.Id;
        FieldByName('Descricao').AsString := Produto.Descricao;
        FieldByName('Qtde').AsFloat       := Quantidade;
        FieldByName('VlrUn').AsFloat      := Unitario;
        FieldByName('TotalItem').AsFloat  := Total;
      Post;
    end;
  end;
  
  AMemTb.EnableControls;
  
end;

function TPedidoController.setCliente(AId: integer): boolean;
begin
  try
  
    if AId = Pedido.Cliente.Id then
    begin
      Result := True;
      Exit;
    end;

    Pedido.Cliente.Reset;

    if AId <= 0 then
    begin
      Result := True;
      Exit;
    end;
    
    //procedure validaçoes cliente, ativo, devendo, etc

    Result :=  FClienteDAO.Load(Pedido.Cliente, AId);
    
  except
    Pedido.Cliente.Reset;
    Result := False;
  end;


end;

function TPedidoController.setEmis(AEmis: TDateTime): boolean;
begin
  //validaçoes ??

  Pedido.Emis := AEmis;
  Result := true;
end;

end.
