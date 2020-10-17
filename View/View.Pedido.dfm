inherited FraPedido: TFraPedido
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
    Left = 0
    Top = 49
    Width = 670
    Height = 461
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PnlCampos'
    ShowCaption = False
    TabOrder = 1
    object LblEmissao: TLabel
      Left = 330
      Top = 9
      Width = 74
      Height = 22
      Caption = 'Emissao'
    end
    object LblTipoOperacao: TLabel
      Left = 495
      Top = 9
      Width = 84
      Height = 22
      Caption = 'Opera'#231#227'o'
    end
    object LedReferencia: TLabeledEdit
      Left = 180
      Top = 33
      Width = 130
      Height = 30
      EditLabel.Width = 93
      EditLabel.Height = 22
      EditLabel.Caption = 'Refer'#234'ncia'
      TabOrder = 0
    end
    object LedNumPedido: TLabeledEdit
      Left = 30
      Top = 33
      Width = 130
      Height = 30
      EditLabel.Width = 137
      EditLabel.Height = 22
      EditLabel.Caption = 'Num. do Pedido'
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 1
    end
    object LedNomeCliente: TLabeledEdit
      Left = 30
      Top = 97
      Width = 280
      Height = 30
      EditLabel.Width = 59
      EditLabel.Height = 22
      EditLabel.Caption = 'Cliente'
      ReadOnly = True
      TabOrder = 2
    end
    object CmbOperacao: TComboBox
      Left = 495
      Top = 33
      Width = 145
      Height = 30
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'Entrada'
        'Saida')
    end
    object DtpEmissao: TDateTimePicker
      Left = 330
      Top = 33
      Width = 145
      Height = 30
      Date = 44119.000000000000000000
      Time = 0.842564444443269200
      Enabled = False
      TabOrder = 4
    end
    object BtnConsultarCliente: TButton
      Left = 316
      Top = 97
      Width = 165
      Height = 30
      Caption = 'Consultar Cliente'
      TabOrder = 5
      OnClick = BtnConsultarClienteClick
    end
    object PnlItens: TPanel
      Left = 0
      Top = 152
      Width = 670
      Height = 309
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'PnlItens'
      ShowCaption = False
      TabOrder = 6
      object LedPrecoUnitario: TLabeledEdit
        Left = 263
        Top = 84
        Width = 116
        Height = 30
        EditLabel.Width = 119
        EditLabel.Height = 22
        EditLabel.Caption = 'Pre'#231'o Unit'#225'rio'
        ReadOnly = True
        TabOrder = 0
      end
      object LedProduto: TLabeledEdit
        Left = 30
        Top = 84
        Width = 227
        Height = 30
        EditLabel.Width = 67
        EditLabel.Height = 22
        EditLabel.Caption = 'Produto'
        ReadOnly = True
        TabOrder = 1
      end
      object DbgItens: TDBGrid
        Left = 30
        Top = 134
        Width = 610
        Height = 165
        DataSource = DsItens
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -19
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NomeProd'
            Title.Caption = 'Produto'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrecoUnit'
            Title.Alignment = taCenter
            Title.Caption = 'Pre'#231'o Unit.'
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Qtde'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrecoFinal'
            Title.Alignment = taCenter
            Title.Caption = 'Valor Total'
            Width = 115
            Visible = True
          end>
      end
      object PnlBotoesItens: TPanel
        Left = 0
        Top = 0
        Width = 670
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        Caption = 'PnlBotoes'
        ShowCaption = False
        TabOrder = 3
        object BtnNovoItem: TButton
          Left = 10
          Top = 10
          Width = 100
          Height = 30
          Caption = 'Novo'
          Enabled = False
          TabOrder = 0
          OnClick = BtnNovoItemClick
        end
        object BtnAlterarItem: TButton
          Left = 120
          Top = 10
          Width = 100
          Height = 30
          Caption = 'Alterar'
          Enabled = False
          TabOrder = 1
          OnClick = BtnAlterarItemClick
        end
        object BtnConsultarProduto: TButton
          Left = 230
          Top = 10
          Width = 100
          Height = 30
          Caption = 'Consultar'
          Enabled = False
          TabOrder = 2
          OnClick = BtnConsultarProdutoClick
        end
        object BtnExcluirItem: TButton
          Left = 340
          Top = 10
          Width = 100
          Height = 30
          Caption = 'Excluir'
          Enabled = False
          TabOrder = 3
          OnClick = BtnExcluirItemClick
        end
        object BtnCancelarItem: TButton
          Left = 450
          Top = 10
          Width = 100
          Height = 30
          Caption = 'Cancelar'
          Enabled = False
          TabOrder = 4
          OnClick = BtnCancelarItemClick
        end
        object BtnGravarItem: TButton
          Left = 560
          Top = 10
          Width = 100
          Height = 30
          Caption = 'Gravar'
          Enabled = False
          TabOrder = 5
          OnClick = BtnGravarItemClick
        end
      end
      object LedQuantidade: TLabeledEdit
        Left = 385
        Top = 84
        Width = 116
        Height = 30
        EditLabel.Width = 97
        EditLabel.Height = 22
        EditLabel.Caption = 'Quantidade'
        TabOrder = 4
        OnKeyPress = LedQuantidadeKeyPress
      end
      object LedValorTotal: TLabeledEdit
        Left = 507
        Top = 84
        Width = 133
        Height = 30
        EditLabel.Width = 96
        EditLabel.Height = 22
        EditLabel.Caption = 'Pre'#231'o Final'
        ReadOnly = True
        TabOrder = 5
      end
    end
    object LedTotalPedido: TLabeledEdit
      Left = 495
      Top = 97
      Width = 145
      Height = 30
      EditLabel.Width = 133
      EditLabel.Height = 22
      EditLabel.Caption = 'Total do Pedido'
      ReadOnly = True
      TabOrder = 7
    end
  end
  object MtbItens: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 64
    Top = 400
    object MtbItensCodItem: TIntegerField
      FieldName = 'CodItem'
    end
    object MtbItensNomeProd: TStringField
      FieldName = 'NomeProd'
      Size = 100
    end
    object MtbItensPrecoUnit: TFloatField
      FieldName = 'PrecoUnit'
      DisplayFormat = '#,##0.00'
    end
    object MtbItensQtde: TFloatField
      FieldName = 'Qtde'
      DisplayFormat = '#,##0.00'
    end
    object MtbItensPrecoFinal: TFloatField
      FieldName = 'PrecoFinal'
      DisplayFormat = '#,##0.00'
    end
    object MtbItensCodProd: TIntegerField
      FieldName = 'CodProd'
    end
  end
  object DsItens: TDataSource
    DataSet = MtbItens
    Left = 120
    Top = 400
  end
end
