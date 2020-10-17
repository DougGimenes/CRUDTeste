object FrmConexao: TFrmConexao
  Left = 470
  Top = 192
  Caption = 'Configura'#231#227'o de Conex'#227'o'
  ClientHeight = 392
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 22
  object LblTitulo: TLabel
    Left = 50
    Top = 8
    Width = 260
    Height = 49
    Alignment = taCenter
    AutoSize = False
    Caption = 'Configure sua conex'#227'o para prosseguir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object LedServidor: TLabeledEdit
    Left = 50
    Top = 103
    Width = 260
    Height = 30
    EditLabel.Width = 175
    EditLabel.Height = 22
    EditLabel.Caption = 'Servidor SQL Server'
    TabOrder = 0
  end
  object LedBanco: TLabeledEdit
    Left = 50
    Top = 167
    Width = 260
    Height = 30
    EditLabel.Width = 142
    EditLabel.Height = 22
    EditLabel.Caption = 'Banco de Dados'
    TabOrder = 1
  end
  object LedLogin: TLabeledEdit
    Left = 50
    Top = 231
    Width = 260
    Height = 30
    EditLabel.Width = 143
    EditLabel.Height = 22
    EditLabel.Caption = 'Login de Usu'#225'rio'
    TabOrder = 2
  end
  object LedSenha: TLabeledEdit
    Left = 50
    Top = 295
    Width = 260
    Height = 30
    EditLabel.Width = 54
    EditLabel.Height = 22
    EditLabel.Caption = 'Senha'
    PasswordChar = '*'
    TabOrder = 3
  end
  object BtnGravar: TButton
    Left = 50
    Top = 343
    Width = 260
    Height = 41
    Caption = 'Gravar'
    TabOrder = 4
    OnClick = BtnGravarClick
  end
end
