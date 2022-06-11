unit fMainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  uMainController;

type
  TfrmMain = class(TForm)
    pnlFooter: TPanel;
    btnNew: TButton;
    btnRemove: TButton;
    stgPedidos: TStringGrid;
    btnEdit: TButton;
    procedure btnNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEditClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    FController: TMainController;
    procedure AtualizarGrid;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  fPedidoView, fSelProdutoView, fSelClienteView;

procedure TfrmMain.AtualizarGrid;
begin
  FController.LoadAll(stgPedidos);

  with stgPedidos do
  begin
    ColCount := 4;
    Cells[0,0] := 'Num.';
    Cells[1,0] := 'Cliente';
    Cells[2,0] := 'Emissão';
    Cells[3,0] := 'Total';
    ColWidths[0] := 30;
    ColWidths[1] := 400;
    ColWidths[2] := 100;
    ColWidths[3] := 80;

    setFocus;
  end;
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
begin
  call_frmPedido(strToInt(stgPedidos.Cells[0, stgPedidos.Row]));
  AtualizarGrid;
end;

procedure TfrmMain.btnNewClick(Sender: TObject);
begin
  call_frmPedido;
  AtualizarGrid;
end;

procedure TfrmMain.btnRemoveClick(Sender: TObject);
var
  msg: string;
begin
  if MessageDlg('Deseja Excluir o pedido ' + stgPedidos.Cells[0, stgPedidos.Row] + ' ?' , mtConfirmation, [mbOK, mbCancel], 0) = mrOk then

  if not FController.Delete(strToInt(stgPedidos.Cells[0, stgPedidos.Row]), msg) then
    ShowMessage(msg)
  else
    AtualizarGrid;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FController);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  FController := TMainController.Create;

  AtualizarGrid;
end;

end.
