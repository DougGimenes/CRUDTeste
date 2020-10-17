unit View.Pedido;

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
  Model.Pedido,
  Model.Cliente,
  Model.Produto,
  View.ConsultaClientes,
  System.Generics.Collections,
  View.ConsultaProdutos, 
  Vcl.ComCtrls, 
  Data.DB, 
  Vcl.Grids, 
  Vcl.DBGrids,
  FireDAC.Stan.Intf, 
  FireDAC.Stan.Option, 
  FireDAC.Stan.Param,
  FireDAC.Stan.Error, 
  FireDAC.DatS, 
  FireDAC.Phys.Intf, 
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, 
  FireDAC.Comp.Client,
  View.ConsultaPedido;

type
  TFraPedido = class(TFraBase)
    PnlCampos: TPanel;
    LedReferencia: TLabeledEdit;
    LedNumPedido: TLabeledEdit;
    LedNomeCliente: TLabeledEdit;
    CmbOperacao: TComboBox;
    DtpEmissao: TDateTimePicker;
    LblEmissao: TLabel;
    LblTipoOperacao: TLabel;
    BtnConsultarCliente: TButton;
    LedProduto: TLabeledEdit;
    DbgItens: TDBGrid;
    LedPrecoUnitario: TLabeledEdit;
    PnlItens: TPanel;
    PnlBotoesItens: TPanel;
    BtnNovoItem: TButton;
    BtnAlterarItem: TButton;
    BtnConsultarProduto: TButton;
    BtnExcluirItem: TButton;
    BtnCancelarItem: TButton;
    BtnGravarItem: TButton;
    LedQuantidade: TLabeledEdit;
    LedValorTotal: TLabeledEdit;
    MtbItens: TFDMemTable;
    DsItens: TDataSource;
    MtbItensCodItem: TIntegerField;
    MtbItensNomeProd: TStringField;
    MtbItensPrecoUnit: TFloatField;
    MtbItensQtde: TFloatField;
    MtbItensPrecoFinal: TFloatField;
    MtbItensCodProd: TIntegerField;
    LedTotalPedido: TLabeledEdit;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnNovoItemClick(Sender: TObject);
    procedure BtnAlterarItemClick(Sender: TObject);
    procedure BtnExcluirItemClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarItemClick(Sender: TObject);
    procedure BtnGravarItemClick(Sender: TObject);
    procedure BtnConsultarProdutoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure LedQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure BtnConsultarClienteClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    PedidoAtual: TPedido;
    Cliente: TCliente;
    ItemAtual: TItemPedido;
    EditandoItem: Boolean;
    ItensRemovidos: TObjectList<TItemPedido>;

    procedure PreencherTela();
    procedure PreencherCamposItem();
    procedure EsvaziarCamposItem();
    procedure TratarEdicao(AEditando: Boolean);
    procedure TratarEdicaoItens(AEditando: Boolean);
    procedure PreencherPedido();
    procedure PreencherItem();
  public
    { Public declarations }
  end;

var
  FraPedido: TFraPedido;

implementation

{$R *.dfm}

{ TFraPedido }

procedure TFraPedido.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  Self.TratarEdicao(True);
  Self.ItensRemovidos := TObjectList<TItemPedido>.Create();
end;

procedure TFraPedido.BtnAlterarItemClick(Sender: TObject);
begin
  inherited;
  Self.PreencherCamposItem();
  Self.TratarEdicaoItens(True);

  if Self.MtbItensCodItem.AsInteger > 0 then
  begin
    Self.ItemAtual := TItemPedido.Create(Self.MtbItensCodItem.AsInteger);
  end
  else
  begin
    Self.ItemAtual := TItemPedido.Create();
  end;

  Self.EditandoItem := True;
end;

procedure TFraPedido.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraPedido.BtnCancelarItemClick(Sender: TObject);
begin
  inherited;
  Self.EsvaziarCamposItem();
  Self.TratarEdicaoItens(False);
end;

procedure TFraPedido.BtnConsultarClick(Sender: TObject);
var
  ConsPedido: TFrmConsultaPedido;
begin
  inherited;
  ConsPedido := TFrmConsultaPedido.Create(Self);
  try
    ConsPedido.ShowModal();
    if ConsPedido.Consultou then
    begin
      Self.PedidoAtual := ConsPedido.ObjetoConsultado;
      Self.PreencherTela();
      Self.TratarEdicao(False);
    end;
  finally
    FreeAndNil(ConsPedido);
  end;
end;

procedure TFraPedido.BtnConsultarClienteClick(Sender: TObject);
var
  ConsCliente: TFrmConsultaCliente;
begin
  inherited;
  ConsCliente := TFrmConsultaCliente.Create(Self);
  try
    ConsCliente.ShowModal();
    if ConsCliente.Consultou then
    begin
      Self.Cliente := ConsCliente.ObjetoConsultado;
      Self.LedNomeCliente.Text := ConsCliente.ObjetoConsultado.Nome;
    end;
  finally
    FreeAndNil(ConsCliente);
  end;
end;

procedure TFraPedido.BtnConsultarProdutoClick(Sender: TObject);
var
  ConsProduto: TFrmConsultaProdutos;
begin
  inherited;
  ConsProduto := TFrmConsultaProdutos.Create(Self);
  try
    ConsProduto.ShowModal();
    if ConsProduto.Consultou then
    begin
      Self.ItemAtual.CodProduto  := ConsProduto.ObjetoConsultado.Codigo;
      Self.LedProduto.Text       := ConsProduto.ObjetoConsultado.Descricao;
      Self.LedPrecoUnitario.Text := FormatFloat('#,##0.00', ConsProduto.ObjetoConsultado.PrecoVenda);
    end;
  finally
    FreeAndNil(ConsProduto);
  end;
end;

procedure TFraPedido.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  Self.PedidoAtual.Deletar();
  FreeAndNil(Self.PedidoAtual);
  Self.PedidoAtual := TPedido.Create();
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraPedido.BtnExcluirItemClick(Sender: TObject);
begin
  inherited;
  if Self.MtbItensCodItem.AsInteger > 0 then
  begin
    Self.ItensRemovidos.Add(TItemPedido.Create(Self.MtbItensCodItem.AsInteger));
  end;

  Self.MtbItens.Delete();
end;

procedure TFraPedido.BtnGravarClick(Sender: TObject);
begin
  inherited;
  Self.PreencherPedido();

  if Self.PedidoAtual.Codigo > 0 then
  begin
    for var Item in Self.ItensRemovidos do
    begin
      Item.Deletar();
    end;
  end;

  Self.PedidoAtual.Gravar();
  
  Self.PreencherTela();
  Self.TratarEdicao(False);
end;

procedure TFraPedido.BtnGravarItemClick(Sender: TObject);
begin
  inherited;
  Self.PreencherItem();
  if Self.ItemAtual.Quantidade > 0 then
  begin
    if EditandoItem then
    begin
      Self.MtbItens.Edit();    
    end
    else
    begin
      Self.MtbItens.Append();
    end;

    Self.MtbItensNomeProd.AsString  := Self.LedProduto.Text;
    Self.MtbItensCodProd.AsInteger  := Self.ItemAtual.CodProduto;
    Self.MtbItensPrecoUnit.AsFloat  := Self.ItemAtual.ValorUnitario;
    Self.MtbItensQtde.AsFloat       := Self.ItemAtual.Quantidade;
    Self.MtbItensPrecoFinal.AsFloat := Self.ItemAtual.TotalItem;
      
    Self.MtbItens.Post();

    Self.EsvaziarCamposItem();
    Self.TratarEdicaoItens(False);
  end
  else
  begin
    raise Exception.Create('Quantidade deve ser superior a 0!');
  end;
end;

procedure TFraPedido.BtnNovoClick(Sender: TObject);
begin
  inherited;
  Self.PedidoAtual := TPedido.Create();
  Self.PreencherTela();
  Self.TratarEdicao(True);
end;

procedure TFraPedido.BtnNovoItemClick(Sender: TObject);
begin
  inherited;
  Self.EsvaziarCamposItem();
  Self.TratarEdicaoItens(True);
  Self.ItemAtual := TItemPedido.Create();
  Self.EditandoItem := False;
  Self.BtnConsultarProduto.Click();
end;

procedure TFraPedido.EsvaziarCamposItem;
begin
  Self.LedProduto.Text       := '';
  Self.LedQuantidade.Text    := '0,00';
  Self.LedPrecoUnitario.Text := '0,00';
  Self.LedValorTotal.Text    := '0,00';
end;

procedure TFraPedido.LedQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9',',',#8]) then
  begin
    Key := #0;
  end;
end;

procedure TFraPedido.PreencherCamposItem;
begin
  Self.LedProduto.Text       := Self.MtbItensNomeProd.AsString;
  Self.LedQuantidade.Text    := FormatFloat('#,##0.00', Self.MtbItensQtde.AsFloat);
  Self.LedPrecoUnitario.Text := FormatFloat('#,##0.00', Self.MtbItensPrecoUnit.AsFloat);
  Self.LedValorTotal.Text    := FormatFloat('#,##0.00', Self.MtbItensPrecoFinal.AsFloat);
end;

procedure TFraPedido.PreencherItem;
begin
  ItemAtual.Quantidade    := StrToFloat(Self.LedQuantidade.Text);
  ItemAtual.ValorUnitario := StrToFloat(Self.LedPrecoUnitario.Text);
  ItemAtual.Totalizar();
end;

procedure TFraPedido.PreencherPedido();
var
  Item : TItemPedido;
begin
  Self.PedidoAtual.Referencia := Self.LedReferencia.Text;
  Self.PedidoAtual.Emissao    := Self.DtpEmissao.Date;
  Self.PedidoAtual.Operacao   := ETipoOperacao(Self.CmbOperacao.ItemIndex);
  Self.PedidoAtual.CodCliente := Self.Cliente.Codigo;

  Self.PedidoAtual.Itens.Free();
  Self.PedidoAtual.Itens := TObjectList<TItemPedido>.Create();
  
  Self.MtbItens.First();
  for var I := 0 to Self.MtbItens.RecordCount - 1 do
  begin
    if Self.MtbItensCodItem.AsInteger > 0 then
    begin  
      Item := TItemPedido.Create(Self.MtbItensCodItem.AsInteger);
    end
    else
    begin
      Item := TItemPedido.Create();
    end;

    Item.CodProduto    := Self.MtbItensCodProd.AsInteger;
    Item.Quantidade    := Self.MtbItensQtde.AsFloat;
    Item.ValorUnitario := Self.MtbItensPrecoUnit.AsFloat;

    Self.PedidoAtual.Itens.Add(Item);
    Self.MtbItens.Next();
  end;

  Self.PedidoAtual.Totalizar();
end;

procedure TFraPedido.PreencherTela;
begin
  Self.LedNumPedido.Text  := Self.PedidoAtual.Codigo.ToString();
  Self.LedReferencia.Text := Self.PedidoAtual.Referencia;

  if Self.PedidoAtual.Codigo > 0 then
  begin
    Self.DtpEmissao.Date := Self.PedidoAtual.Emissao;
  end
  else
  begin
    Self.DtpEmissao.Date := Date();  
  end;

  Self.CmbOperacao.ItemIndex := Ord(Self.PedidoAtual.Operacao);
  Self.LedTotalPedido.Text   := Self.PedidoAtual.TotalPedido.ToString();
  
  Self.Cliente := TCliente.Create(Self.PedidoAtual.CodCliente);
  Self.LedNomeCliente.Text := Self.Cliente.Nome;

  Self.MtbItens.EmptyDataSet();
  for var Item in Self.PedidoAtual.Itens do
  begin
    Self.MtbItens.Append();
    Self.MtbItensCodItem.AsInteger  := Item.Codigo;
    Self.MtbItensNomeProd.AsString  := TProduto.Create(Item.CodProduto).Descricao;
    Self.MtbItensPrecoUnit.AsFloat  := Item.ValorUnitario;
    Self.MtbItensQtde.AsFloat       := Item.Quantidade;
    Self.MtbItensPrecoFinal.AsFloat := Item.TotalItem;
    Self.MtbItensCodProd.AsInteger  := Item.CodProduto;
    Self.MtbItens.Post();
  end;

  Self.EsvaziarCamposItem();
end;

procedure TFraPedido.TratarEdicao(AEditando: Boolean);
begin
  Self.BtnNovo.Enabled      := not AEditando;
  Self.BtnAlterar.Enabled   := not AEditando and (Self.PedidoAtual.Codigo > 0);
  Self.BtnCancelar.Enabled  := AEditando;
  Self.BtnGravar.Enabled    := AEditando;
  Self.BtnConsultar.Enabled := not AEditando;
  Self.BtnExcluir.Enabled   := not AEditando and (Self.PedidoAtual.Codigo > 0);

  Self.PnlCampos.Enabled := AEditando;
  Self.LedReferencia.ReadOnly := (Self.PedidoAtual.Codigo > 0);

  Self.PnlItens.Enabled := AEditando;

  Self.TratarEdicaoItens(False);
end;

procedure TFraPedido.TratarEdicaoItens(AEditando: Boolean);
begin
  Self.BtnNovoItem.Enabled         := not AEditando;
  Self.BtnAlterarItem.Enabled      := not AEditando and (Self.MtbItensQtde.AsFloat > 0);
  Self.BtnCancelarItem.Enabled     := AEditando;
  Self.BtnGravarItem.Enabled       := AEditando;
  Self.BtnConsultarProduto.Enabled := AEditando and (not EditandoItem);
  Self.BtnExcluirItem.Enabled      := not AEditando and (Self.MtbItensQtde.AsFloat > 0);

  Self.DbgItens.Enabled := not AEditando;
end;

end.
