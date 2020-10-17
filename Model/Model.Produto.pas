unit Model.Produto;

interface

uses
  Controller.Connection,
  Data.DB,
  Data.Win.ADODB,
  SysUtils;

type
  TProduto = class(TObject)
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Double;

    procedure Inserir();
    procedure Alterar();
  public
    property Codigo: Integer read FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;

    procedure Gravar();
    procedure Deletar();

    constructor Create(ACodigo : Integer); overload;
  end;

implementation

{ TProduto }

procedure TProduto.Alterar;
var
  TbProduto: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbProduto := TADOQuery.Create(nil);
  TbProduto.Connection := Conexao;
  Conexao.Conectar();

  TbProduto.SQL.Text := 'UPDATE Produtos SET ' +
                        'Descricao = '    + QuotedStr(Self.FDescricao)  + ', ' +
                        'Preco = '        + Self.FPrecoVenda.ToString() + #13  +
                        'WHERE Codigo = ' + Self.FCodigo.ToString() + ';';
  TbProduto.ExecSQL();

  FreeAndNil(TbProduto);
end;

constructor TProduto.Create(ACodigo : Integer);
var
  TbProduto: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbProduto := TADOQuery.Create(nil);
  TbProduto.Connection := Conexao;
  Conexao.Conectar();

  TbProduto.SQL.Text := 'SELECT * FROM Produtos WHERE Codigo = ' + IntToStr(ACodigo);
  TbProduto.Open();

  Self.FCodigo     := TbProduto.FieldByName('Codigo').AsInteger;
  Self.FDescricao  := TbProduto.FieldByName('Descricao').AsString;
  Self.FPrecoVenda := TbProduto.FieldByName('Preco').AsFloat;

  FreeAndNil(TbProduto);
end;

procedure TProduto.Deletar;
var
  TbProduto: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbProduto := TADOQuery.Create(nil);
  TbProduto.Connection := Conexao;

  TbProduto.SQL.Text := 'SELECT * FROM Produtos WHERE Codigo = ' + FCodigo.ToString();
  TbProduto.Open();

  TbProduto.Delete();
end;

procedure TProduto.Gravar;
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

procedure TProduto.Inserir;
var
  TbProduto: TADOQuery;
  Conexao : TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbProduto := TADOQuery.Create(nil);
  TbProduto.Connection := Conexao;
  Conexao.Conectar();

  TbProduto.SQL.Text := 'INSERT INTO Produtos (Descricao, Preco) VALUES (' +
                        QuotedStr(Self.FDescricao) + ', ' +
                        Self.FPrecoVenda.ToString  + ');' + #13 +
                        'SELECT SCOPE_IDENTITY() AS Codigo;';
  TbProduto.Open();

  Self.FCodigo := TbProduto.FieldByName('Codigo').AsInteger;
end;

end.
