unit Model.Cliente;

interface

uses
  Controller.Connection,
  Data.DB,
  Data.Win.ADODB,
  SysUtils,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  System.JSON;

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: String;
    FCEP: String;
    FLogradouro: String;
    FComplemento: String;
    FBairro: String;
    FCidade: String;
    FUF: String;
    FCodIBGE: Integer;

    procedure Inserir();
    procedure Alterar();
  public
    property Codigo: Integer read FCodigo;
    property Nome: String read FNome write FNome;
    property CEP: String read FCEP write FCEP;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
    property CodIBGE: Integer read FCodIBGE write FCodIBGE;

    procedure Gravar();
    procedure Deletar();
    procedure PreencherEnderecoPorCEP(ACEP : String = '');

    constructor Create(ACodigo: Integer); overload;
  end;

implementation

{ TCliente }

procedure TCliente.Alterar;
var
  TbCliente: TADOQuery;
  Conexao: TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbCliente := TADOQuery.Create(nil);
  TbCliente.Connection := Conexao;
  Conexao.Conectar();

  TbCliente.SQL.Text := 'UPDATE Clientes SET ' +
                        'Nome = '         + QuotedStr(Self.FNome)        + ', ' +
                        'CEP = '          + QuotedStr(Self.FCEP)         + ', ' +
                        'Logradouro = '   + QuotedStr(Self.FLogradouro)  + ', ' +
                        'Complemento = '  + QuotedStr(Self.FComplemento) + ', ' +
                        'Bairro = '       + QuotedStr(Self.FBairro)      + ', ' +
                        'Cidade = '       + QuotedStr(Self.FCidade)      + ', ' +
                        'UF = '           + QuotedStr(Self.FUF)          + ', ' +
                        'CodIBGE = '      + Self.FCodIBGE.ToString()     + #13  +
                        'WHERE Codigo = ' + Self.FCodigo.ToString() + ';';
  TbCliente.ExecSQL();

  FreeAndNil(TbCliente);
end;

constructor TCliente.Create(ACodigo: Integer);
var
  TbCliente: TADOQuery;
  Conexao: TConexao;
begin
  inherited Create();
  Conexao := TConexao.ObterInstancia();
  TbCliente := TADOQuery.Create(nil);
  TbCliente.Connection := Conexao;
  Conexao.Conectar();

  TbCliente.SQL.Text := 'SELECT * FROM Clientes WHERE Codigo = ' + IntToStr(ACodigo);
  TbCliente.Open();

  Self.FCodigo      := TbCliente.FieldByName('Codigo').AsInteger;
  Self.FNome        := TbCliente.FieldByName('Nome').AsString;
  Self.FCEP         := TbCliente.FieldByName('CEP').AsString;
  Self.FLogradouro  := TbCliente.FieldByName('Logradouro').AsString;
  Self.FComplemento := TbCliente.FieldByName('Complemento').AsString;
  Self.FBairro      := TbCliente.FieldByName('Bairro').AsString;
  Self.FCidade      := TbCliente.FieldByName('Cidade').AsString;
  Self.FUF          := TbCliente.FieldByName('UF').AsString;
  Self.FCodIBGE     := TbCliente.FieldByName('CodIBGE').AsInteger;

  FreeAndNil(TbCliente);
end;

procedure TCliente.Deletar;
var
  TbCliente: TADOQuery;
  Conexao: TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbCliente := TADOQuery.Create(nil);
  TbCliente.Connection := Conexao;

  TbCliente.SQL.Text := 'SELECT * FROM Clientes WHERE Codigo = ' + FCodigo.ToString();
  TbCliente.Open();

  TbCliente.Delete();

  FreeAndNil(TbCliente);
end;

procedure TCliente.Gravar;
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

procedure TCliente.Inserir;
var
  TbCliente: TADOQuery;
  Conexao: TConexao;
begin
  Conexao := TConexao.ObterInstancia();
  TbCliente := TADOQuery.Create(nil);
  TbCliente.Connection := Conexao;
  Conexao.Conectar();

  TbCliente.SQL.Text := 'INSERT INTO Clientes (Nome, CEP, Logradouro, Complemento, Bairro, Cidade, UF, CodIBGE) VALUES (' +
                        QuotedStr(Self.FNome) + ', ' +
                        QuotedStr(Self.FCEP) + ', ' +
                        QuotedStr(Self.FLogradouro) + ', ' +
                        QuotedStr(Self.FComplemento) + ', ' +
                        QuotedStr(Self.FBairro) + ', ' +
                        QuotedStr(Self.FCidade) + ', ' +
                        QuotedStr(Self.FUF) + ', ' +
                        Self.FCodIBGE.ToString() + ');' + #13 +
                        'SELECT SCOPE_IDENTITY() AS Codigo;';
  TbCliente.Open();

  Self.FCodigo := TbCliente.FieldByName('Codigo').AsInteger;

  FreeAndNil(TbCliente);
end;

procedure TCliente.PreencherEnderecoPorCEP(ACEP: String);
var
  IdHTTP: TIdHTTP;
  IOHandler: TIdSSLIOHandlerSocketOpenSSL;
  CEPConsultar: String;
  JSON: TJSONObject;
begin
  IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IOHandler.SSLOptions.SSLVersions := [sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
  IdHTTP := TIdHTTP.Create(nil);
  IdHTTP.IOHandler := IOHandler;
  IdHTTP.Request.Clear();
  IdHTTP.Request.CustomHeaders.Clear();

  if ACEP = '' then
  begin
    CEPConsultar := Self.FCEP;
  end
  else
  begin
    CEPConsultar := ACEP;
  end;

  try
    JSON := TJSONObject.ParseJSONValue(IdHTTP.Get('https://viacep.com.br/ws/' + CEPConsultar + '/json/')) as TJSONObject;
    Self.FLogradouro := JSON.GetValue('logradouro').Value;
    Self.FComplemento := JSON.GetValue('complemento').Value;
    Self.FBairro := JSON.GetValue('bairro').Value;
    Self.FCidade := JSON.GetValue('localidade').Value;
    Self.FUF := JSON.GetValue('uf').Value;
    Integer.TryParse(JSON.GetValue('ibge').Value, Self.FCodIBGE);
  except
    raise Exception.Create('Erro ao consultar CEP! Verifique se o CEP informado está correto!');
  end;

  FreeAndNil(IdHTTP);
  FreeAndNil(IOHandler);
  FreeAndNil(JSON);
end;

end.
