unit fPedidoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.ComCtrls,
  TypInfo,
  uPedidoController, uProduto;

type
  TModoTela = (modoInserir, modoEditar, modoLimpar);

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
    edtNomeCli: TEdit;
    Label7: TLabel;
    edtIdCli: TEdit;
    btnIdCli: TSpeedButton;
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
    pnlControls: TPanel;
    pnlButtons: TPanel;
    btnCancel: TButton;
    procedure btnIdCliClick(Sender: TObject);
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
    procedure btnGravarClick(Sender: TObject);
  private
    FController: TPedidoController;
    Gravado: boolean;
    Editando :integer;

    ModoTela: TModoTela;

    procedure LimparEditsProd;
    procedure ProcessarModo;
    procedure AtualizarTela;

    procedure AdicionarItem;
    procedure AlterarItem;
    procedure AtualizarItem;
    procedure DeletarItem;

  public
    { Public declarations }
  end;

var


  frmPedido: TfrmPedido;
  procedure call_frmPedido(AId: integer = 0);

implementation

{$R *.dfm}

uses
  fSelProdutoView, fSelClienteView;

procedure call_frmPedido(AId: integer = 0);
begin
  try
    try
      frmPedido := TfrmPedido.Create(nil);
      with frmPedido do
      begin
        FController := TPedidoController.Create(AId);
        Gravado := False;
        ModoTela := modoInserir;

        ShowModal;
      end;
    except on E:Exception do
      ShowMessage(E.Message);
    end;

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

procedure TfrmPedido.ProcessarModo;
begin
  //Controls Produto
  edtIdProd.Enabled     := ModoTela in [modoLimpar, modoInserir];
  btnIdProd.Enabled     := ModoTela in [modoLimpar, modoInserir];
  edtQtde.Enabled       := ModoTela in [modoLimpar, modoInserir, modoEditar];
  edtUnit.Enabled       := ModoTela in [modoLimpar, modoInserir, modoEditar];
  btnGravarItem.Enabled := ModoTela in [modoLimpar, modoInserir, modoEditar];
  btnCancelItem.Enabled := ModoTela in [modoLimpar, modoInserir, modoEditar];

  //Grid
  grdItens.Enabled      := ModoTela in [modoLimpar, modoInserir];

  //Cabeçalho
  edtIdCli.Enabled      := ModoTela in [modoLimpar, modoInserir];
  btnIdCli.Enabled      := ModoTela in [modoLimpar, modoInserir];
  edtEmis.Enabled       := ModoTela in [modoLimpar, modoInserir];

  btnGravar.Enabled     := ModoTela in [modoLimpar, modoInserir];
  btnCancel.Enabled     := (FController.Pedido.Cliente.Id <= 0) and (ModoTela in [modoLimpar, modoInserir]);
end;

procedure TfrmPedido.AtualizarTela;
var auxModo: TModoTela;
begin
  auxModo := ModoTela;

  ModoTela := modoLimpar;
  ProcessarModo;

  edtTotalPed.Text := formatfloat('###,###,###,##0.00', FController.Pedido.Total);

  if FController.Pedido.Cliente.Id > 0 then
    edtIdCli.Text := intToStr(FController.Pedido.Cliente.Id)
  else
    edtIdCli.Text := '';

  edtNomeCli.Text  := FController.Pedido.Cliente.Nome;
  edtEmis.DateTime := FController.Pedido.Emis;

  FController.renderizarGrid(mtbItens);

  LimparEditsProd;

  ModoTela := auxModo;
  ProcessarModo;
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
    end
    else
    begin
      AtualizarTela;

      edtIdProd.SetFocus;
    end;
  except
    AtualizarTela;
  end;

end;

procedure TfrmPedido.AlterarItem;
begin
  if ModoTela = modoInserir then
  begin
    edtIdProd.Text := mtbItensIdProd.AsString;
    edtDesc.Text   := mtbItensDescricao.AsString;
    edtQtde.Text   := formatfloat('###,###,###,##0.00', mtbItensQtde.AsFloat);
    edtUnit.Text   := formatfloat('###,###,###,##0.00', mtbItensVlrUn.AsFloat);

    ModoTela := modoEditar;
    ProcessarModo;
    edtQtde.SetFocus;
  end;
end;

procedure TfrmPedido.AtualizarItem;
var
  Qtde, VlrUnit: double;
  msg: string;
begin
  Qtde := strToFloatDef(edtQtde.Text, 0);
  VlrUnit := strToFloatDef(edtUnit.Text, 0);

  try
    if not FController.AtualizarItem(mtbItensNumItem.AsInteger, Qtde, VlrUnit, msg) then
    begin
      ShowMessage(msg);
    end
    else
    begin
      ModoTela := modoInserir;
      
      AtualizarTela;
    end;
  except
    AtualizarTela;
  end;

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
  if ModoTela = modoEditar then
    ModoTela := modoInserir;

  AtualizarTela;
end;

procedure TfrmPedido.btnGravarClick(Sender: TObject);
var msg: string;
begin
  if not FController.GravarPedido(msg) then
    ShowMessage(msg)
  else
  begin
    ShowMessage('O pedido foi salvo'); 
    Gravado := True;
    Close;
  end;
end;

procedure TfrmPedido.btnGravarItemClick(Sender: TObject);
begin
  if ModoTela = modoEditar then
    AtualizarItem
  else
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
  if not FController.setCliente(StrToIntDef(edtIdCli.Text, 0)) and (edtIdCli.Text > '') then
  begin
    ShowMessage('ID do cliente inválido!');
    edtIdCli.Text := '';

    if edtIdCli.CanFocus then
      edtIdCli.SetFocus;
  end;

  edtNomeCli.Text := FController.Pedido.Cliente.Nome;

  if edtNomeCli.Text > '' then
    if edtQtde.CanFocus then
      edtQtde.SetFocus;

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

  if (not Gravado) and (not (MessageDlg('Sair sem Salvar ?' , mtConfirmation, [mbOK, mbCancel], 0) = mrOk)) then
    Abort;

  FreeAndNil(FController);
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  AtualizarTela;

  if (edtIdCli.Text = '') and edtIdCli.CanFocus then
    edtIdCli.SetFocus
  else if edtIdProd.CanFocus then
    edtIdProd.SetFocus;
end;

procedure TfrmPedido.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    DeletarItem;
  end;

  if key = VK_RETURN then
  begin
    AlterarItem;
  end;
end;

procedure TfrmPedido.btnIdCliClick(Sender: TObject);
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
