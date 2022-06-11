unit uProduto;

interface

type TProduto = class
  private
    FId: integer;
    FDescricao: string;
    FVenda: double;

  public
    property Id: integer        read FId          write FId;
    property Descricao: string  read FDescricao   write FDescricao;
    property Venda : double     read FVenda       write FVenda;
    constructor Create(AId: integer = 0);
end;

implementation

{ TProduto }

constructor TProduto.Create(AId: integer = 0);
begin
  FId := AId;
  FDescricao := '';
  FVenda := 0.00;
end;

end.

