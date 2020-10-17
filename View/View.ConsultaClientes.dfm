inherited FrmConsultaCliente: TFrmConsultaCliente
  Caption = 'Consulta de Clientes'
  ClientWidth = 650
  ExplicitWidth = 666
  PixelsPerInch = 96
  TextHeight = 18
  inherited PnlMain: TPanel
    Width = 650
    inherited DbgConsulta: TDBGrid
      Width = 629
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 600
          Visible = True
        end>
    end
    inherited EdtConsulta: TEdit
      Width = 629
    end
  end
  inherited QryConsulta: TADOQuery
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
  end
end
