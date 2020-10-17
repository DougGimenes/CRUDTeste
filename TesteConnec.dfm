object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSOLEDBSQL.1;Integrated Security=SSPI;Persist Security ' +
      'Info=False;User ID="";Initial Catalog=Agrotis;Data Source=DOUGLA' +
      'S-PC\TESTEAGROTIS;Initial File Name="";Server SPN="";Authenticat' +
      'ion="";Access Token=""'
    Provider = 'MSOLEDBSQL.1'
    Left = 32
    Top = 16
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 88
    Top = 56
  end
end
