object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Listagem de Pedidos'
  ClientHeight = 649
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 798
    Height = 586
    Align = alClient
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 586
    Width = 798
    Height = 63
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      798
      63)
    object btnNew: TButton
      Left = 681
      Top = 12
      Width = 100
      Height = 41
      Anchors = [akRight, akBottom]
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNewClick
    end
    object btnRemove: TButton
      Left = 14
      Top = 6
      Width = 100
      Height = 41
      Anchors = [akLeft, akBottom]
      Caption = 'Remover'
      TabOrder = 1
      OnClick = btnRemoveClick
    end
  end
end
