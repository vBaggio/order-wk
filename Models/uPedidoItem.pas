unit uPedidoItem;

interface

uses
  System.SysUtils,
  uProduto;

type TPedidoItem  = class
  private
    FId: integer;
    FSeq: integer;
    FProduto: TProduto;
    FQuantidade: double;
    FUnitario: double;

    function FCalcTotal: double;
  public
    property Id: integer         read FId;
    property Seq: integer        read FSeq         write FSeq;
    property Produto: TProduto   read FProduto     write FProduto;
    property Quantidade: double  read FQuantidade  write FQuantidade;
    property Unitario: double    read FUnitario    write FUnitario;
    property Total: double       read FCalcTotal;
    constructor Create(AId: integer = 0);
    destructor Destroy; override;
end;

implementation

{ TPedidoItem }

constructor TPedidoItem.Create(AId: integer = 0);
begin
  FId := Aid;
  FProduto := TProduto.Create;
  FQuantidade := 0;
  FUnitario := 0.00;
  FSeq := 0;
end;

destructor TPedidoItem.Destroy;
begin
  FreeAndNil(FProduto);
  inherited;
end;

function TPedidoItem.FCalcTotal: double;
begin
  Result := FQuantidade * FUnitario;
end;

end.
