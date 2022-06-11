unit fSelClienteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  uSelClienteController;

type
  TfrmSelectCli = class(TForm)
    pnlFooter: TPanel;
    btnConfirm: TButton;
    btnCancel: TButton;
    stgClientes: TStringGrid;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure stgClientesDblClick(Sender: TObject);
    procedure stgClientesKeyPress(Sender: TObject; var Key: Char);
  private
    FId: integer;
    FController: TSelClienteController;
  public
    { Public declarations }
  end;

var
  frmSelectCli: TfrmSelectCli;
  function call_SelectCli: integer;
implementation

{$R *.dfm}

function call_SelectCli: integer;
begin
  try
    frmSelectCli := TfrmSelectCli.Create(nil);
    frmSelectCli.FId := 0;
    frmSelectCli.ShowModal;
    Result := frmSelectCli.FId;
  finally
    FreeAndNil(frmSelectCli);
  end;
end;

procedure TfrmSelectCli.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelectCli.btnConfirmClick(Sender: TObject);
begin
  FId := strToIntDef(stgClientes.Cells[0, stgClientes.Row], 0);
  Close;
end;

procedure TfrmSelectCli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FController);
end;

procedure TfrmSelectCli.FormCreate(Sender: TObject);
begin
  FController :=  TSelClienteController.Create();
end;

procedure TfrmSelectCli.FormShow(Sender: TObject);
begin

  FController.LoadAll(stgClientes, '');

  with stgClientes do
  begin
    ColCount := 4;
    Cells[0,0] := 'ID';
    Cells[1,0] := 'Nome';
    Cells[2,0] := 'Cidade';
    Cells[3,0] := 'UF';
    ColWidths[0] := 30;
    ColWidths[1] := 140;
    ColWidths[2] := 120;
    ColWidths[3] := 30;

    setFocus;
  end;

end;

procedure TfrmSelectCli.stgClientesDblClick(Sender: TObject);
begin
  btnConfirm.Click;
end;

procedure TfrmSelectCli.stgClientesKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnConfirm.Click;
end;

end.
