unit uSelProdutoController;

interface

uses
  System.SysUtils, VCL.Grids,
  uProduto, uProdutoDao;

type TSelProdutoController = class
  private
    FDao : TProdutoDao;
  public
    function LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;
    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TProdutoController }

constructor TSelProdutoController.Create;
begin
  FDao := TProdutoDao.Create();
end;

destructor TSelProdutoController.Destroy;
begin
   FreeAndNil(FDao);
  inherited;
end;

function TSelProdutoController.LoadAll(var AStringGrid: TStringGrid; paramstr: string): boolean;
begin
  FDao.LoadAll(AStringGrid, paramstr);
  Result := True;
end;

end.
