unit uPedidoDAO;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  VCL.Grids,
  uBaseDAO, uConnection, uPedido, uCliente;

  type TPedidoDAO = class(TInterfacedObject, iBaseDao)
    private
      Query: TFDQuery;
      function getQuery: TFDQuery;
    public
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

function TPedidoDAO.getQuery: TFDQuery;
begin
  Result := TMyConnection.GetQuery;
end;

end.
