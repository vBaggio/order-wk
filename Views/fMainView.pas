unit fMainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type
  TfrmMain = class(TForm)
    DBGrid1: TDBGrid;
    pnlFooter: TPanel;
    btnNew: TButton;
    btnRemove: TButton;
    procedure btnNewClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  fPedidoView, fSelProdutoView, fSelClienteView;

procedure TfrmMain.btnNewClick(Sender: TObject);
begin
  call_frmPedido;
end;

procedure TfrmMain.btnRemoveClick(Sender: TObject);
begin
  call_SelectCli;
end;

end.
