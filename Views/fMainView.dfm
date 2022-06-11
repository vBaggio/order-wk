object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Listagem de Pedidos'
  ClientHeight = 548
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFooter: TPanel
    Left = 0
    Top = 481
    Width = 725
    Height = 67
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 582
    DesignSize = (
      725
      67)
    object btnNew: TButton
      Left = 581
      Top = 14
      Width = 125
      Height = 41
      Anchors = [akRight, akBottom]
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNewClick
    end
    object btnRemove: TButton
      Left = 319
      Top = 14
      Width = 125
      Height = 41
      Anchors = [akLeft, akBottom]
      Caption = 'Remover Selecionado'
      TabOrder = 1
      OnClick = btnRemoveClick
    end
    object btnEdit: TButton
      Left = 450
      Top = 14
      Width = 125
      Height = 41
      Anchors = [akRight, akBottom]
      Caption = 'Editar Selecionado'
      TabOrder = 2
      OnClick = btnEditClick
    end
  end
  object stgPedidos: TStringGrid
    Left = 0
    Top = 0
    Width = 725
    Height = 481
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitHeight = 586
  end
end
