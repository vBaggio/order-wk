object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 421
  ClientWidth = 554
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
    Top = 284
    Width = 554
    Height = 137
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 276
    DesignSize = (
      554
      137)
    object Label3: TLabel
      Left = 24
      Top = 24
      Width = 52
      Height = 13
      Caption = 'ID Produto'
    end
    object Label4: TLabel
      Left = 24
      Top = 80
      Width = 24
      Height = 13
      Caption = 'Qtde'
    end
    object Label5: TLabel
      Left = 104
      Top = 80
      Width = 43
      Height = 13
      Caption = 'Pre'#231'o Un'
    end
    object Label6: TLabel
      Left = 188
      Top = 80
      Width = 49
      Height = 13
      Caption = 'Total Item'
    end
    object Label2: TLabel
      Left = 112
      Top = 24
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object btnIdProd: TSpeedButton
      Left = 83
      Top = 42
      Width = 24
      Height = 24
      OnClick = btnIdProdClick
    end
    object btnGravar: TButton
      Left = 429
      Top = 82
      Width = 107
      Height = 40
      Anchors = [akRight, akBottom]
      Caption = 'Gravar Pedido'
      TabOrder = 0
    end
    object btnGravarItem: TButton
      Left = 280
      Top = 97
      Width = 58
      Height = 25
      Caption = 'Gravar'
      TabOrder = 4
      OnClick = btnGravarItemClick
    end
    object btnCancel: TButton
      Left = 429
      Top = 26
      Width = 107
      Height = 40
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar Pedido'
      TabOrder = 5
      OnClick = btnCancelClick
    end
    object edtTotalItem: TMaskEdit
      Left = 188
      Top = 99
      Width = 86
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 6
      Text = '0,00'
    end
    object edtUnit: TMaskEdit
      Left = 104
      Top = 99
      Width = 80
      Height = 21
      TabOrder = 3
      Text = '0,00'
      OnChange = edtUnitChange
      OnKeyPress = edtUnitKeyPress
    end
    object edtQtde: TMaskEdit
      Left = 24
      Top = 99
      Width = 76
      Height = 21
      TabOrder = 2
      Text = '0,00'
      OnChange = edtQtdeChange
      OnKeyPress = edtUnitKeyPress
    end
    object edtIdProd: TEdit
      Left = 24
      Top = 43
      Width = 59
      Height = 21
      TabOrder = 1
      OnExit = edtIdProdExit
      OnKeyPress = edtIdProdKeyPress
    end
    object edtDesc: TEdit
      Left = 112
      Top = 43
      Width = 286
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 7
    end
    object btnCancelItem: TButton
      Left = 340
      Top = 97
      Width = 58
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 8
      OnClick = btnCancelItemClick
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 65
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      554
      65)
    object Label7: TLabel
      Left = 113
      Top = 13
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object SpeedButton1: TSpeedButton
      Left = 83
      Top = 31
      Width = 24
      Height = 24
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      Left = 11
      Top = 13
      Width = 47
      Height = 13
      Caption = 'ID Cliente'
    end
    object Label8: TLabel
      Left = 312
      Top = 13
      Width = 64
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Data Emiss'#227'o'
      ExplicitLeft = 370
    end
    object Label9: TLabel
      Left = 429
      Top = 13
      Width = 24
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Total'
      ExplicitLeft = 487
    end
    object edtNomeCli: TEdit
      Left = 114
      Top = 32
      Width = 192
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 0
    end
    object edtIdCli: TEdit
      Left = 11
      Top = 32
      Width = 72
      Height = 21
      ReadOnly = True
      TabOrder = 1
      OnExit = edtIdCliExit
    end
    object edtEmis: TDateTimePicker
      Left = 313
      Top = 32
      Width = 106
      Height = 21
      Anchors = [akTop, akRight]
      Date = 44722.000000000000000000
      Time = 0.011461990739917380
      TabOrder = 2
      OnExit = edtEmisExit
    end
    object edtTotalPed: TMaskEdit
      Left = 430
      Top = 32
      Width = 106
      Height = 21
      Anchors = [akTop, akRight]
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
    end
  end
  object grdItens: TDBGrid
    Left = 0
    Top = 65
    Width = 554
    Height = 219
    Align = alClient
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = grdItensKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'NumItem'
        Title.Caption = 'Num.'
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdProd'
        Title.Caption = 'ID Produto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 197
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Qtde'
        Title.Caption = 'Qtde.'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VlrUn'
        Title.Caption = 'Vlr. Un.'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TotalItem'
        Title.Caption = 'Vlr. Item'
        Width = 60
        Visible = True
      end>
  end
  object dsItens: TDataSource
    DataSet = mtbItens
    Left = 48
    Top = 128
  end
  object mtbItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 96
    Top = 128
    object mtbItensNumItem: TIntegerField
      FieldName = 'NumItem'
    end
    object mtbItensIdProd: TIntegerField
      FieldName = 'IdProd'
    end
    object mtbItensDescricao: TStringField
      FieldName = 'Descricao'
    end
    object mtbItensQtde: TFloatField
      FieldName = 'Qtde'
      DisplayFormat = '#########.##'
    end
    object mtbItensVlrUn: TFloatField
      FieldName = 'VlrUn'
      DisplayFormat = '########0.00'
      currency = True
    end
    object mtbItensTotalItem: TFloatField
      FieldName = 'TotalItem'
      DisplayFormat = '########0.00'
      currency = True
    end
  end
end
