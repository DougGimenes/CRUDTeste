unit Clientes.View;

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
  Model.Cliente,
  View.ConsultaClientes;

type
  TFraClientes = class(TFraBase)
    PnlCampos: TPanel;
    LedUF: TLabeledEdit;
    LedCidade: TLabeledEdit;
    LedNome: TLabeledEdit;
    LedCEP: TLabeledEdit;
    LedLogradouro: TLabeledEdit;
    LedComplemento: TLabeledEdit;
    LedBairro: TLabeledEdit;
    LedCodIBGE: TLabeledEdit;
    BtnCEP: TButton;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnCEPClick(Sender: TObject);
  private
    { Private declarations }
    ClienteAtual: TCliente;

    procedure PreencherTela();
    procedure TratarEdicao(AEditando: Boolean);
    procedure PreencherObjeto();
  public
    { Public declarations }
  end;

var
  FraClientes: TFraClientes;

implementation

{$R *.dfm}

procedure TFraClientes.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  Self.TratarEdicao(True);
end;

procedure TFraClientes.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraClientes.BtnCEPClick(Sender: TObject);
begin
  inherited;
  Self.PreencherObjeto();
  Self.ClienteAtual.PreencherEnderecoPorCEP();

  Self.PreencherTela();
end;

procedure TFraClientes.BtnConsultarClick(Sender: TObject);
var
  ConsCliente: TFrmConsultaCliente;
begin
  inherited;
  ConsCliente := TFrmConsultaCliente.Create(Self);
  try
    ConsCliente.ShowModal();
    if ConsCliente.Consultou then
    begin
      Self.ClienteAtual := ConsCliente.ObjetoConsultado;
      Self.PreencherTela();
      Self.TratarEdicao(False);
    end;
  finally
    FreeAndNil(ConsCliente);
  end;
end;

procedure TFraClientes.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  Self.ClienteAtual.Deletar();
  FreeAndNil(Self.ClienteAtual);
  Self.ClienteAtual := TCliente.Create();
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraClientes.BtnGravarClick(Sender: TObject);
begin
  inherited;
  Self.PreencherObjeto();
  Self.ClienteAtual.Gravar();
  Self.TratarEdicao(False);
end;

procedure TFraClientes.BtnNovoClick(Sender: TObject);
begin
  inherited;
  Self.ClienteAtual := TCliente.Create();
  Self.PreencherTela();
  Self.TratarEdicao(True);
end;

procedure TFraClientes.PreencherObjeto;
begin
  Self.ClienteAtual.Nome := Self.LedNome.Text;
  Self.ClienteAtual.CEP := Self.LedCEP.Text;
  Self.ClienteAtual.Cidade := Self.LedCidade.Text;
  Self.ClienteAtual.Logradouro := Self.LedLogradouro.Text;
  Self.ClienteAtual.Complemento := Self.LedComplemento.Text;
  Self.ClienteAtual.Bairro := Self.LedBairro.Text;
  Self.ClienteAtual.UF := Self.LedUF.Text;
  Self.ClienteAtual.CodIBGE := StrToInt(Self.LedCodIBGE.Text);
end;

procedure TFraClientes.PreencherTela;
begin
  Self.LedNome.Text        := Self.ClienteAtual.Nome;
  Self.LedCEP.Text         := Self.ClienteAtual.CEP;
  Self.LedCidade.Text      := Self.ClienteAtual.Cidade;
  Self.LedLogradouro.Text  := Self.ClienteAtual.Logradouro;
  Self.LedComplemento.Text := Self.ClienteAtual.Complemento;
  Self.LedBairro.Text      := Self.ClienteAtual.Bairro;
  Self.LedUF.Text          := Self.ClienteAtual.UF;
  Self.LedCodIBGE.Text     := Self.ClienteAtual.CodIBGE.ToString();
end;

procedure TFraClientes.TratarEdicao(AEditando: Boolean);
begin
  Self.BtnNovo.Enabled      := not AEditando;
  Self.BtnAlterar.Enabled   := not AEditando and (Self.ClienteAtual.Codigo > 0);
  Self.BtnCancelar.Enabled  := AEditando;
  Self.BtnGravar.Enabled    := AEditando;
  Self.BtnConsultar.Enabled := not AEditando;
  Self.BtnExcluir.Enabled   := not AEditando and (Self.ClienteAtual.Codigo > 0);

  Self.PnlCampos.Enabled := AEditando;
end;

end.
