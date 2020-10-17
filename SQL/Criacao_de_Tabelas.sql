CREATE TABLE Clientes (
  Codigo int IDENTITY,
  Nome varchar(100) NULL,
  CEP varchar(8) NULL,
  Logradouro varchar(50) NULL,
  Complemento varchar(50) NULL,
  Bairro varchar(50) NULL,
  Cidade varchar(50) NULL,
  UF char(2) NULL,
  CodIBGE int NULL,
  CONSTRAINT PK_Clientes_Codigo PRIMARY KEY CLUSTERED (Codigo)
)
ON [PRIMARY]
GO

CREATE TABLE Produtos (
  Codigo int IDENTITY,
  Descricao varchar(100) NULL,
  Preco float NULL,
  CONSTRAINT PK_Produtos_Codigo PRIMARY KEY CLUSTERED (Codigo)
)
ON [PRIMARY]
GO

CREATE TABLE Pedidos (
  Codigo int IDENTITY,
  Referencia varchar(50) NOT NULL,
  Emissao date NOT NULL,
  CodCliente int NOT NULL,
  TipoOperacao int NOT NULL,
  TotalPedido float NOT NULL,
  CONSTRAINT PK_Pedidos_Codigo PRIMARY KEY CLUSTERED (Codigo)
)
ON [PRIMARY]
GO

ALTER TABLE Pedidos
  ADD CONSTRAINT FK_Pedidos_CodCliente FOREIGN KEY (CodCliente) REFERENCES dbo.Clientes (Codigo)
GO

CREATE TABLE Itens (
  Codigo int IDENTITY,
  CodPedido int NOT NULL,
  CodProduto int NOT NULL,
  Quantidade float NOT NULL,
  ValorUnitario float NOT NULL,
  ValorTotal float NOT NULL,
  CONSTRAINT PK_Itens_Codigo PRIMARY KEY CLUSTERED (Codigo)
)
ON [PRIMARY]
GO

ALTER TABLE Itens
  ADD CONSTRAINT FK_Itens_CodPedido FOREIGN KEY (CodPedido) REFERENCES dbo.Pedidos (Codigo)
GO

ALTER TABLE Itens
  ADD CONSTRAINT FK_Itens_CodProduto FOREIGN KEY (CodProduto) REFERENCES dbo.Produtos (Codigo)
GO