inherited FraProdutos: TFraProdutos
  inherited PnlBotoes: TPanel
    inherited BtnNovo: TButton
      OnClick = BtnNovoClick
    end
    inherited BtnAlterar: TButton
      Enabled = False
      OnClick = BtnAlterarClick
    end
    inherited BtnConsultar: TButton
      OnClick = BtnConsultarClick
    end
    inherited BtnExcluir: TButton
      Enabled = False
      OnClick = BtnExcluirClick
    end
    inherited BtnCancelar: TButton
      Enabled = False
      OnClick = BtnCancelarClick
    end
    inherited BtnGravar: TButton
      Enabled = False
      OnClick = BtnGravarClick
    end
  end
  object PnlCampos: TPanel
    Left = 155
    Top = 55
    Width = 360
    Height = 461
    BevelOuter = bvNone
    Caption = 'PnlCampos'
    Enabled = False
    ShowCaption = False
    TabOrder = 1
    object LedNome: TLabeledEdit
      Left = 5
      Top = 48
      Width = 350
      Height = 30
      EditLabel.Width = 86
      EditLabel.Height = 22
      EditLabel.Caption = 'Descri'#231#227'o'
      TabOrder = 0
    end
    object LedPrecoVenda: TLabeledEdit
      Left = 5
      Top = 105
      Width = 173
      Height = 30
      EditLabel.Width = 137
      EditLabel.Height = 22
      EditLabel.Caption = 'Pre'#231'o de Venda'
      TabOrder = 1
      OnKeyPress = LedPrecoVendaKeyPress
    end
  end
end
