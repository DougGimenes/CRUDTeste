object FraBase: TFraBase
  Left = 0
  Top = 0
  Width = 670
  Height = 510
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Arial'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object PnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PnlBotoes'
    ShowCaption = False
    TabOrder = 0
    object BtnNovo: TButton
      Left = 10
      Top = 10
      Width = 100
      Height = 30
      Caption = 'Novo'
      TabOrder = 0
    end
    object BtnAlterar: TButton
      Left = 120
      Top = 10
      Width = 100
      Height = 30
      Caption = 'Alterar'
      TabOrder = 1
    end
    object BtnConsultar: TButton
      Left = 230
      Top = 10
      Width = 100
      Height = 30
      Caption = 'Consultar'
      TabOrder = 2
    end
    object BtnExcluir: TButton
      Left = 340
      Top = 10
      Width = 100
      Height = 30
      Caption = 'Excluir'
      TabOrder = 3
    end
    object BtnCancelar: TButton
      Left = 450
      Top = 10
      Width = 100
      Height = 30
      Caption = 'Cancelar'
      TabOrder = 4
    end
    object BtnGravar: TButton
      Left = 560
      Top = 10
      Width = 100
      Height = 30
      Caption = 'Gravar'
      TabOrder = 5
    end
  end
end
