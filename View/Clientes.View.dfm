inherited FraClientes: TFraClientes
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
    object LedUF: TLabeledEdit
      Left = 2
      Top = 356
      Width = 150
      Height = 30
      EditLabel.Width = 25
      EditLabel.Height = 22
      EditLabel.Caption = 'UF'
      TabOrder = 0
    end
    object LedCidade: TLabeledEdit
      Left = 2
      Top = 247
      Width = 350
      Height = 30
      EditLabel.Width = 61
      EditLabel.Height = 22
      EditLabel.Caption = 'Cidade'
      TabOrder = 1
    end
    object LedNome: TLabeledEdit
      Left = 2
      Top = 24
      Width = 350
      Height = 30
      EditLabel.Width = 51
      EditLabel.Height = 22
      EditLabel.Caption = 'Nome'
      TabOrder = 2
    end
    object LedCEP: TLabeledEdit
      Left = 2
      Top = 80
      Width = 173
      Height = 30
      EditLabel.Width = 40
      EditLabel.Height = 22
      EditLabel.Caption = 'CEP'
      NumbersOnly = True
      TabOrder = 3
    end
    object LedLogradouro: TLabeledEdit
      Left = 1
      Top = 135
      Width = 351
      Height = 30
      EditLabel.Width = 98
      EditLabel.Height = 22
      EditLabel.Caption = 'Logradouro'
      TabOrder = 4
    end
    object LedComplemento: TLabeledEdit
      Left = 2
      Top = 190
      Width = 350
      Height = 30
      EditLabel.Width = 120
      EditLabel.Height = 22
      EditLabel.Caption = 'Complemento'
      TabOrder = 5
    end
    object LedBairro: TLabeledEdit
      Left = 2
      Top = 300
      Width = 350
      Height = 30
      EditLabel.Width = 50
      EditLabel.Height = 22
      EditLabel.Caption = 'Bairro'
      TabOrder = 6
    end
    object LedCodIBGE: TLabeledEdit
      Left = 202
      Top = 356
      Width = 150
      Height = 30
      EditLabel.Width = 141
      EditLabel.Height = 22
      EditLabel.Caption = 'C'#243'digo do IBGE'
      TabOrder = 7
    end
    object BtnCEP: TButton
      Left = 192
      Top = 80
      Width = 160
      Height = 30
      Caption = 'Consultar CEP'
      TabOrder = 8
      OnClick = BtnCEPClick
    end
  end
end
