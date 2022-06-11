unit uMainController;

interface

uses
  System.SysUtils, VCL.Grids,
  uPedidoDAO;

type TMainController = class
  private
    FDao: TPedidoDAO;
  public
    function LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;
    function Delete(AId: integer; var AMsg: string): boolean;
    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TMainController }

constructor TMainController.Create;
begin
  FDao := TPedidoDao.Create();
end;


destructor TMainController.Destroy;
begin
  FreeAndNil(FDao);
  inherited;
end;

function TMainController.LoadAll(var AStringGrid: TStringGrid; paramstr: string): boolean;
begin
  FDao.LoadAll(AStringGrid, paramstr);
end;

function TMainController.Delete(AId: integer; var AMsg: string): boolean;
begin
  AMsg := 'Erro ao Deletar pedido';
  Result := FDao.Delete(AId);

  if Result then
    AMsg := '';
end;

end.
