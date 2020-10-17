unit View.Produtos;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  View.FrameBase,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Model.Produto,
  View.ConsultaProdutos;

type
  TFraProdutos = class(TFraBase)
    PnlCampos: TPanel;
    LedNome: TLabeledEdit;
    LedPrecoVenda: TLabeledEdit;
    procedure LedPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    ProdutoAtual: TProduto;

    procedure PreencherTela();
    procedure TratarEdicao(AEditando: Boolean);
    procedure PreencherObjeto();
  public
    { Public declarations }
  end;

var
  FraProdutos: TFraProdutos;

implementation

{$R *.dfm}

procedure TFraProdutos.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  Self.TratarEdicao(True);
end;

procedure TFraProdutos.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraProdutos.BtnConsultarClick(Sender: TObject);
var
  ConsProduto: TFrmConsultaProdutos;
begin
  inherited;
  ConsProduto := TFrmConsultaProdutos.Create(Self);
  try
    ConsProduto.ShowModal();
    if ConsProduto.Consultou then
    begin
      Self.ProdutoAtual := ConsProduto.ObjetoConsultado;
      Self.PreencherTela();
      Self.TratarEdicao(False);
    end;
  finally
    FreeAndNil(ConsProduto);
  end;
end;

procedure TFraProdutos.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  Self.ProdutoAtual.Deletar();
  FreeAndNil(Self.ProdutoAtual);
  Self.ProdutoAtual := TProduto.Create();
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraProdutos.BtnGravarClick(Sender: TObject);
begin
  inherited;
  Self.PreencherObjeto();
  Self.ProdutoAtual.Gravar();
  Self.TratarEdicao(False);
end;

procedure TFraProdutos.BtnNovoClick(Sender: TObject);
begin
  inherited;
  Self.ProdutoAtual := TProduto.Create();
  Self.PreencherTela();
  Self.TratarEdicao(True);
end;

procedure TFraProdutos.LedPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9',',',#8]) then
  begin
    Key := #0;
  end;
end;

procedure TFraProdutos.PreencherObjeto;
begin
  Self.ProdutoAtual.Descricao  := Self.LedNome.Text;
  Self.ProdutoAtual.PrecoVenda := StrToFloat(Self.LedPrecoVenda.Text);
end;

procedure TFraProdutos.PreencherTela;
begin
  Self.LedNome.Text       := Self.ProdutoAtual.Descricao;
  Self.LedPrecoVenda.Text := FormatFloat('#,##0.00', Self.ProdutoAtual.PrecoVenda);
end;

procedure TFraProdutos.TratarEdicao(AEditando: Boolean);
begin
  Self.BtnNovo.Enabled      := not AEditando;
  Self.BtnAlterar.Enabled   := not AEditando and (Self.ProdutoAtual.Codigo > 0);
  Self.BtnCancelar.Enabled  := AEditando;
  Self.BtnGravar.Enabled    := AEditando;
  Self.BtnConsultar.Enabled := not AEditando;
  Self.BtnExcluir.Enabled   := not AEditando and (Self.ProdutoAtual.Codigo > 0);

  Self.PnlCampos.Enabled := AEditando;
end;

end.
