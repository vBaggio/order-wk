object frmSelectCli: TfrmSelectCli
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Selecionar Cliente'
  ClientHeight = 327
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFooter: TPanel
    Left = 0
    Top = 277
    Width = 339
    Height = 50
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      339
      50)
    object btnConfirm: TButton
      Left = 217
      Top = 11
      Width = 107
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = btnConfirmClick
    end
    object btnCancel: TButton
      Left = 91
      Top = 11
      Width = 107
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 1
      TabStop = False
      OnClick = btnCancelClick
    end
  end
  object stgClientes: TStringGrid
    Left = 0
    Top = 0
    Width = 339
    Height = 277
    Align = alClient
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 0
    OnDblClick = stgClientesDblClick
    OnKeyPress = stgClientesKeyPress
    ColWidths = (
      83
      64
      64)
  end
end
