unit fPedidoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.ComCtrls,

  uPedidoController, uProduto;

type
  TfrmPedido = class(TForm)
    pnlFooter: TPanel;
    btnGravar: TButton;
    pnlHeader: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnGravarItem: TButton;
    Label2: TLabel;
    btnCancel: TButton;
    edtNomeCli: TEdit;
    Label7: TLabel;
    edtIdCli: TEdit;
    SpeedButton1: TSpeedButton;
    btnIdProd: TSpeedButton;
    edtTotalItem: TMaskEdit;
    edtUnit: TMaskEdit;
    edtQtde: TMaskEdit;
    edtIdProd: TEdit;
    edtDesc: TEdit;
    Label1: TLabel;
    Label8: TLabel;
    edtEmis: TDateTimePicker;
    edtTotalPed: TMaskEdit;
    Label9: TLabel;
    grdItens: TDBGrid;
    dsItens: TDataSource;
    mtbItens: TFDMemTable;
    mtbItensNumItem: TIntegerField;
    mtbItensIdProd: TIntegerField;
    mtbItensDescricao: TStringField;
    mtbItensQtde: TFloatField;
    mtbItensVlrUn: TFloatField;
    mtbItensTotalItem: TFloatField;
    btnCancelItem: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtIdCliExit(Sender: TObject);
    procedure edtEmisExit(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIdProdClick(Sender: TObject);
    procedure edtIdProdExit(Sender: TObject);
    procedure edtIdProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnitKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnitChange(Sender: TObject);
    procedure edtQtdeChange(Sender: TObject);
    procedure btnCancelItemClick(Sender: TObject);
    procedure btnGravarItemClick(Sender: TObject);
  private
    FController: TPedidoController;

    procedure LimparEditsProd;
    procedure AtualizarTela;

    procedure AdicionarItem;
    procedure AtualizarItem;
    procedure DeletarItem;

  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;
  procedure call_frmPedido;

implementation

{$R *.dfm}

uses
  fSelProdutoView, fSelClienteView;

procedure call_frmPedido;
begin
  try
    frmPedido := TfrmPedido.Create(nil);

    frmPedido.ShowModal;

  finally
    FreeAndNil(frmPedido);
  end;
end;

procedure TfrmPedido.LimparEditsProd;
begin
  edtQtde.Text := '0,00';
  edtUnit.Text := '0,00';
  edtIdProd.Text := '';
  edtDesc.Text := '';
end;

procedure TfrmPedido.AtualizarTela;
begin
  FController.renderizarGrid(mtbItens);

  edtTotalPed.Text := formatfloat('###,###,###,##0.00', FController.Pedido.Total);
  edtIdCli.Text    := intToStr(FController.Pedido.Cliente.Id);
  edtNomeCli.Text  := FController.Pedido.Cliente.Nome;
  edtEmis.DateTime := FController.Pedido.Emis;

  LimparEditsProd;
end;

procedure TfrmPedido.AdicionarItem;
var
  IdProd: integer;
  Qtde, VlrUnit: double;
  msg: string;
begin
  IdProd := strToIntDef(edtIdProd.Text, 0);
  Qtde := strToFloatDef(edtQtde.Text, 0);
  VlrUnit := strToFloatDef(edtUnit.Text, 0);

  try
    if not FController.AdicionarItem(IdProd, Qtde, VlrUnit, msg) then
    begin
      ShowMessage(msg);
    end;

  finally
    AtualizarTela;
  end;

end;

procedure TfrmPedido.AtualizarItem;
begin

end;

procedure TfrmPedido.DeletarItem;
var msg: string;
begin
    if not mtbItensNumItem.IsNull then

    if MessageDlg('Deseja Excluir o item ' + mtbItensNumItem.AsString + ' ?' , mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
    begin

      try
        if not FController.DeletarItem(mtbItensNumItem.AsInteger, msg) then
          ShowMessage(msg);
      finally
        AtualizarTela;
      end;

    end;
end;

procedure TfrmPedido.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedido.btnCancelItemClick(Sender: TObject);
begin
  LimparEditsProd;
end;

procedure TfrmPedido.btnGravarItemClick(Sender: TObject);
begin
  AdicionarItem;
end;

procedure TfrmPedido.btnIdProdClick(Sender: TObject);
var
  chave: integer;
begin

  chave := call_SelectProd;

  if chave <= 0 then
    Exit;

  edtIdProd.Text := intToStr(chave);

  edtIdProd.OnExit(sender);
end;

procedure TfrmPedido.edtEmisExit(Sender: TObject);
begin
  if not FController.setEmis(edtEmis.DateTime) then
    edtEmis.DateTime := Now;
end;

procedure TfrmPedido.edtIdCliExit(Sender: TObject);
begin
  if not FController.setCliente(StrToIntDef(edtIdCli.Text, 0)) then
  begin
    //msg erro
  end;

  edtNomeCli.Text := FController.Pedido.Cliente.Nome;
end;

procedure TfrmPedido.edtIdProdExit(Sender: TObject);
var Id: integer;
begin

  Id := strToIntDef(edtIdProd.Text, 0);

  if (Id > 0) then
    edtDesc.Text := FController.procurarProd(Id);

end;

procedure TfrmPedido.edtIdProdKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
    key := #0;
end;

procedure TfrmPedido.edtQtdeChange(Sender: TObject);
begin
  edtTotalItem.Text := formatfloat('###,###,###,##0.00', strToFloatDef(edtQtde.Text, 0) * strToFloatDef(edtUnit.Text, 0));
end;

procedure TfrmPedido.edtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0'..'9', '.', #8, #9])) OR ( (Key = '.') and (pos('.',TEdit(Sender).Text)>0) ) then
    Key := #0;
end;

procedure TfrmPedido.edtUnitChange(Sender: TObject);
begin
  edtTotalItem.Text := formatfloat('###,###,###,##0.00', strToFloatDef(edtQtde.Text, 0) * strToFloatDef(edtUnit.Text, 0));
end;

procedure TfrmPedido.edtUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0'..'9', ',', #8, #9])) OR ( (Key = ',') and (pos(',',TEdit(Sender).Text)>0) ) then Key := #0;
end;

procedure TfrmPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if not (MessageDlg('Sair sem Salvar ?' , mtConfirmation, [mbOK, mbCancel], 0) = mrOk) then
    Abort;

  FreeAndNil(FController);
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  FController := TPedidoController.Create;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  AtualizarTela;
end;

procedure TfrmPedido.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    DeletarItem;
  end;
end;

procedure TfrmPedido.SpeedButton1Click(Sender: TObject);
var
  chave: integer;
begin

  chave := call_SelectCli;

  if chave <= 0 then
    Exit;

  edtIdCli.Text := intToStr(chave);

  edtIdCli.OnExit(sender);

end;

end.
