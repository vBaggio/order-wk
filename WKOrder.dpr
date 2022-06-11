program WKOrder;

uses
  Vcl.Forms,
  fMainView in 'Views\fMainView.pas' {frmMain},
  uConnection in 'DAO\uConnection.pas',
  fPedidoView in 'Views\fPedidoView.pas' {frmPedido},
  uCliente in 'Models\uCliente.pas',
  uProduto in 'Models\uProduto.pas',
  uSelClienteController in 'Controllers\uSelClienteController.pas',
  uPedido in 'Models\uPedido.pas',
  uPedidoItem in 'Models\uPedidoItem.pas',
  uProdutoDAO in 'DAO\uProdutoDAO.pas',
  fSelProdutoView in 'Views\fSelProdutoView.pas' {frmSelectProd},
  fSelClienteView in 'Views\fSelClienteView.pas' {frmSelectCli},
  uSelProdutoController in 'Controllers\uSelProdutoController.pas',
  uClienteDao in 'DAO\uClienteDao.pas',
  uBaseDAO in 'DAO\uBaseDAO.pas',
  uPedidoController in 'Controllers\uPedidoController.pas',
  uPedidoDAO in 'DAO\uPedidoDAO.pas',
  uMainController in 'Controllers\uMainController.pas',
  uVerificarTabelas in 'DAO\uVerificarTabelas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TVerificarTabelas.VerificarTabelas;

  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
