unit uSelClienteController;

interface

uses
  System.SysUtils, VCL.Grids,
  uCliente, uClienteDao;


type TSelClienteController = class
  private
    FDao : TClienteDao;
  public
    function LoadAll(var AStringGrid: TStringGrid; paramstr: string = ''): boolean;
    constructor Create;
    destructor Destroy; override;
end;


implementation

{ TClienteController }

constructor TSelClienteController.Create;
begin
  FDao := TClienteDao.Create();
end;

destructor TSelClienteController.Destroy;
begin
  FreeAndNil(FDao);
  inherited;
end;

function TSelClienteController.LoadAll(var AStringGrid: TStringGrid;
  paramstr: string): boolean;
begin
  FDao.LoadAll(AStringGrid, paramstr);
end;

end.
