unit uPedido;

interface

uses
  System.Generics.Collections, System.SysUtils,
  uCliente, uPedidoItem;

type TPedido = class
  private
    FId: integer;
    FEmis: TDateTime;
    FItens: TObjectList<TPedidoItem>;
    FCliente: TCliente;
    function FCalcTotal: double;
    procedure recalcSeq;
  public
    property Id       :integer                   read FId;
    property Itens    :TObjectList<TPedidoItem>  read FItens;
    property Emis     :TDateTime                 read FEmis     write FEmis;
    property Cliente  :TCliente                  read FCliente  write FCliente;
    property Total    :double                    read FCalcTotal;

    procedure AddItem(AItem: TPedidoItem);
    function RemoverItem(ASeq: integer): boolean;
    function UpdateItem(ASeq: integer; AQtde, AVlr: double): boolean;


    constructor Create(AId : integer = 0);
    destructor Destroy; override;
end;

implementation

{ TPedido }

constructor TPedido.Create(AId : integer = 0);
begin
  FId := AId;
  FEmis := Now;
  FItens := TObjectList<TPedidoItem>.Create;
  FCliente := TCliente.Create;
end;

destructor TPedido.Destroy;
begin
  FreeAndNil(FItens);
  FreeAndNil(FCliente);
  inherited;
end;

function TPedido.FCalcTotal: double;
var
  Item: TPedidoItem;
  Tot: double;
begin
  Tot := 0;
  for Item in FItens do
    Tot := Tot + Item.Total;

  Result := Tot;
end;

procedure TPedido.recalcSeq;
var
  i: integer;
begin
  for i := 0 to FItens.Count -1 do
  begin
    FItens[i].Seq := i + 1;
  end;

end;

procedure TPedido.AddItem(AItem: TPedidoItem);
begin
  AItem.Seq := FItens.Count + 1;
  FItens.Add(AItem);
end;

function TPedido.RemoverItem(ASeq: integer): boolean;
var i: integer;
begin
  FItens.Delete(ASeq-1);
  recalcSeq;
end;

function TPedido.UpdateItem(ASeq: integer; AQtde, AVlr: double): boolean;
begin
  Result := False;

  if ASeq <= 0 then
    Exit;

  if ASeq > FItens.Count then
    Exit;

  FItens[ASeq-1].Quantidade := AQtde;
  FItens[ASeq-1].Unitario   := AVlr;

  Result := True;

end;

end.
