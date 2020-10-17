unit Model.Pedido;

interface

uses
  Controller.Connection,
  Data.DB,
  Data.Win.ADODB,
  SysUtils,
  DateUtils,
  System.Generics.Collections;

type
  ETipoOperacao = (toEntrada, toSaida);

  TItemPedido = class(TObject)
  private
    FCodigo: Integer;
    FCodProduto: Integer;
    FCodPedido: Integer;
    FQuantidade: Double;
    FValorUnitario: Double;
    FTotalItem: Double;

    procedure Inserir();
    procedure Alterar();
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property CodProduto: Integer read FCodProduto write FCodProduto;
    property CodPedido: Integer read FCodPedido write FCodPedido;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property TotalItem: Double read FTotalItem;

    procedure Gravar();
    procedure Deletar();
    procedure Totalizar();

    constructor Create(ACodigo: Integer); overload;
  end;

  TPedido = class(TObject)
  private
    FCodigo: Integer;
    FReferencia: String;
    FEmissao: TDate;
    FCodCliente: Integer;
    FOperacao: ETipoOperacao;
    FTotalPedido: Double;
    FItens: TObjectList<TItemPedido>;

    procedure Inserir();
    procedure Alterar();
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Referencia: String read FReferencia write FReferencia;
    property Emissao: TDate read FEmissao write FEmissao;
    property CodCliente: Integer read FCodCliente write FCodCliente;
    property Operacao: ETipoOperacao read FOperacao write FOperacao;
    property TotalPedido: Double read FTotalPedido;
    property Itens: TObjectList<TItemPedido> read FItens write FItens;

    procedure Gravar();
    procedure Deletar();
    procedure Totalizar();

    constructor Create(ACodigo: Integer); overload;
    constructor Create(); overload;
  end;

implementation

{ TItemPedido }

procedure TItemPedido.Alterar;
var
  TbItemPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbItemPedido := TADOQuery.Create(nil);
  TbItemPedido.Connection := Conexao;
  Conexao.Conectar();

  TbItemPedido.SQL.Text := 'UPDATE Itens SET ' +
                           'CodProduto = '    + Self.FCodProduto.ToString()    + ', ' +
                           'CodPedido = '     + Self.FCodPedido.ToString()     + ', ' +
                           'Quantidade = '    + Self.FQuantidade.ToString()    + ', ' +
                           'ValorUnitario = ' + Self.FValorUnitario.ToString() + ', ' +
                           'ValorTotal = '     + Self.FTotalItem.ToString()     + #13 +
                           'WHERE Codigo = '  + Self.FCodigo.ToString()        + ';';
  TbItemPedido.ExecSQL();

  FreeAndNil(TbItemPedido);
end;

constructor TItemPedido.Create(ACodigo: Integer);
var
  TbItemPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbItemPedido := TADOQuery.Create(nil);
  TbItemPedido.Connection := Conexao;
  Conexao.Conectar();

  TbItemPedido.SQL.Text := 'SELECT * FROM Itens WHERE Codigo = ' + IntToStr(ACodigo);
  TbItemPedido.Open();

  Self.FCodigo := TbItemPedido.FieldByName('Codigo').AsInteger;
  Self.FCodProduto := TbItemPedido.FieldByName('CodProduto').AsInteger;
  Self.FCodPedido := TbItemPedido.FieldByName('CodPedido').AsInteger;
  Self.FQuantidade := TbItemPedido.FieldByName('Quantidade').AsFloat;
  Self.FValorUnitario := TbItemPedido.FieldByName('ValorUnitario').AsFloat;
  Self.FTotalItem := TbItemPedido.FieldByName('ValorTotal').AsFloat;

  FreeAndNil(TbItemPedido);
end;

procedure TItemPedido.Deletar;
var
  TbItemPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbItemPedido := TADOQuery.Create(nil);
  TbItemPedido.Connection := Conexao;
  Conexao.Conectar();

  TbItemPedido.SQL.Text := 'SELECT * FROM Itens WHERE Codigo = ' + IntToStr(Self.FCodigo);
  TbItemPedido.Open();

  TbItemPedido.Delete();

  FreeAndNil(TbItemPedido);
end;

procedure TItemPedido.Gravar;
begin
  if Self.FCodigo > 0 then
  begin
    Self.Alterar()
  end
  else
  begin
    Self.Inserir();
  end;
end;

procedure TItemPedido.Inserir;
var
  TbItemPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbItemPedido := TADOQuery.Create(nil);
  TbItemPedido.Connection := Conexao;
  Conexao.Conectar();

  TbItemPedido.SQL.Text := 'INSERT INTO Itens (CodProduto, CodPedido, Quantidade, ValorUnitario, ValorTotal) Values (' +
                           Self.FCodProduto.ToString()    + ', ' +
                           Self.FCodPedido.ToString()     + ', ' +
                           Self.FQuantidade.ToString()    + ', ' +
                           Self.FValorUnitario.ToString() + ', ' +
                           Self.FTotalItem.ToString() + ');' + #13 +
                           'SELECT SCOPE_IDENTITY() AS Codigo;';
  TbItemPedido.Open();

  Self.FCodigo := TbItemPedido.FieldByName('Codigo').AsInteger;

  FreeAndNil(TbItemPedido);
end;

procedure TItemPedido.Totalizar;
begin
  Self.FTotalItem := Self.FValorUnitario * Self.FQuantidade;
end;

{ TPedido }

procedure TPedido.Alterar;
var
  TbPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbPedido := TADOQuery.Create(nil);
  TbPedido.Connection := Conexao;
  Conexao.Conectar();

  TbPedido.SQL.Text := 'UPDATE Pedidos SET ' +
                       'Referencia = '   + QuotedStr(Self.FReferencia)         + ', ' +
                       'Emissao = '      + QuotedStr(DateToStr(Self.FEmissao)) + ', ' +
                       'CodCliente = '   + Self.CodCliente.ToString()          + ', ' +
                       'TipoOperacao = ' + Ord(Self.Operacao).ToString()       + ', ' +
                       'TotalPedido = '  + Self.TotalPedido.ToString()         + #13 +
                       'WHERE Codigo = ' + Self.FCodigo.ToString()             + ';';
  TbPedido.ExecSQL();

  for var Item in Self.Itens do
  begin
    Item.CodPedido := Self.FCodigo;
    Item.Gravar();
  end;

  FreeAndNil(TbPedido);
end;

constructor TPedido.Create(ACodigo: Integer);
var
  TbPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbPedido := TADOQuery.Create(nil);
  TbPedido.Connection := Conexao;
  Conexao.Conectar();

  TbPedido.SQL.Text := 'SELECT * FROM Pedidos WHERE Codigo = ' + IntToStr(ACodigo);
  TbPedido.Open();

  Self.FCodigo      := TbPedido.FieldByName('Codigo').AsInteger;
  Self.FReferencia  := TbPedido.FieldByName('Referencia').AsString;
  Self.FEmissao     := DateOf(TbPedido.FieldByName('Emissao').AsDateTime);
  Self.FCodCliente  := TbPedido.FieldByName('CodCliente').AsInteger;
  Self.FOperacao    := ETipoOperacao(TbPedido.FieldByName('TipoOperacao').AsInteger);
  Self.FTotalPedido := TbPedido.FieldByName('TotalPedido').AsFloat;

  Self.Itens := TObjectList<TItemPedido>.Create();

  TbPedido.Close();
  TbPedido.SQL.Text := 'SELECT Codigo FROM Itens WHERE CodPedido = ' + IntToStr(ACodigo);
  TbPedido.Open();

  TbPedido.First();
  for var I := 0 to TbPedido.RecordCount - 1 do
  begin
    Self.Itens.Add(TItemPedido.Create(TbPedido.FieldByName('Codigo').AsInteger));
    TbPedido.Next();
  end;

  FreeAndNil(TbPedido);
end;

constructor TPedido.Create;
begin
  Self.Itens    := TObjectList<TItemPedido>.Create();
  Self.FEmissao := Date();
end;

procedure TPedido.Deletar;
var
  TbPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbPedido := TADOQuery.Create(nil);
  TbPedido.Connection := Conexao;
  Conexao.Conectar();

  TbPedido.SQL.Text := 'SELECT * FROM Pedidos WHERE Codigo = ' + IntToStr(Self.FCodigo);
  TbPedido.Open();

  TbPedido.Delete();

  for var Item in Self.Itens do
  begin
    Item.Deletar();
  end;

  FreeAndNil(TbPedido);
end;

procedure TPedido.Totalizar();
begin
  Self.FTotalPedido := 0;

  for var Item in Self.FItens do
  begin
    if not (Item.TotalItem > 0) then
    begin
      Item.Totalizar();
    end;
    
    Self.FTotalPedido := Self.FTotalPedido + Item.TotalItem;
  end;
end;

procedure TPedido.Gravar;
begin
  if Self.FCodigo > 0 then
  begin
    Self.Alterar()
  end
  else
  begin
    Self.Inserir();
  end;
end;

procedure TPedido.Inserir;
var
  TbPedido: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbPedido := TADOQuery.Create(nil);
  TbPedido.Connection := Conexao;
  Conexao.Conectar();

  TbPedido.SQL.Text := 'INSERT INTO Pedidos (Referencia, Emissao, CodCliente, TipoOperacao, TotalPedido) Values (' +
                       QuotedStr(Self.FReferencia)         + ', ' +
                       QuotedStr(DateToStr(Self.FEmissao)) + ', ' +
                       Self.FCodCliente.ToString()         + ', ' +
                       Ord(Self.FOperacao).ToString()      + ', ' +
                       Self.FTotalPedido.ToString()        + ');' + #13 +
                       'SELECT SCOPE_IDENTITY() AS Codigo;';
  TbPedido.Open();

  Self.FCodigo := TbPedido.FieldByName('Codigo').AsInteger;

  for var Item in Self.Itens do
  begin
    Item.CodPedido := Self.FCodigo;
    Item.Gravar();
  end;

  FreeAndNil(TbPedido);
end;

end.
