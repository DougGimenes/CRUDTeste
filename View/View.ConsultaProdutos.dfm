inherited FrmConsultaProdutos: TFrmConsultaProdutos
  Caption = 'Consulta de Produtos'
  PixelsPerInch = 96
  TextHeight = 18
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 500
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'Preco'
          Title.Alignment = taCenter
          Title.Caption = 'Pre'#231'o'
          Width = 100
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    SQL.Strings = (
      'SELECT'
      '  Codigo,'
      '  Descricao,'
      '  STR(Preco, 25, 2) as Preco'
      'FROM Produtos')
  end
end
