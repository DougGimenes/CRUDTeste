inherited FrmConsultaPedido: TFrmConsultaPedido
  Caption = 'Consulta de Pedidos'
  PixelsPerInch = 96
  TextHeight = 18
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Codigo'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Referencia'
          Title.Alignment = taCenter
          Title.Caption = 'Refer'#234'ncia'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cliente'
          Title.Alignment = taCenter
          Width = 215
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotalPedido'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Width = 150
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    SQL.Strings = (
      'SELECT'
      '  *'
      'FROM'
      '  (SELECT'
      '    p.Codigo,'
      '    p.Referencia,'
      '    c.Nome AS Cliente,'
      '    STR(p.TotalPedido, 25, 2) as TotalPedido'
      '  FROM Pedidos AS p'
      
        '    INNER JOIN Clientes AS c ON p.CodCliente = c.Codigo) AS Cons' +
        'ulta')
  end
end
