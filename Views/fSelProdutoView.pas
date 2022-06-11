unit fSelProdutoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  uSelProdutoController;

type
  TfrmSelectProd = class(TForm)
    pnlFooter: TPanel;
    btnConfirm: TButton;
    btnCancel: TButton;
    stgProdutos: TStringGrid;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FId: integer;
    FController: TSelProdutoController;
  public
    { Public declarations }
  end;

var
  frmSelectProd: TfrmSelectProd;
  function call_SelectProd: integer;
implementation

{$R *.dfm}

function call_SelectProd: integer;
begin
  try
    frmSelectProd := TfrmSelectProd.Create(nil);
    frmSelectProd.FId := 0;
    frmSelectProd.ShowModal;
    Result := frmSelectProd.FId;
  finally
    FreeAndNil(frmSelectProd);
  end;
end;

procedure TfrmSelectProd.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelectProd.btnConfirmClick(Sender: TObject);
begin
  FId := strToIntDef(stgProdutos.Cells[0, stgProdutos.Row], 0);
  Close;
end;

procedure TfrmSelectProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FController);
end;

procedure TfrmSelectProd.FormCreate(Sender: TObject);
begin
  FController :=  TSelProdutoController.Create;
end;

procedure TfrmSelectProd.FormShow(Sender: TObject);
begin
  FController.LoadAll(stgProdutos, '');

  with stgProdutos do
  begin
    ColCount := 3;
    Cells[0,0] := 'ID';
    Cells[1,0] := 'Nome';
    Cells[2,0] := 'Venda';
    ColWidths[0] := 40;
    ColWidths[1] := 120;
    ColWidths[2] := 80;

    setFocus;
  end;

end;

end.
