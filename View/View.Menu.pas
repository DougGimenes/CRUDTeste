unit View.Menu;

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
  Model.Cliente,
  Controller.Connection,
  View.FrameBase,
  Vcl.ExtCtrls,
  Clientes.View,
  View.Produtos,
  View.Pedido, Vcl.Imaging.pngimage;

type
  TFrmMenu = class(TForm)
    PnlFrame: TPanel;
    PnlBotoesMenu: TPanel;
    BimPedidos: TImage;
    BimProdutos: TImage;
    BimClientes: TImage;
    BimSair: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BimClientesClick(Sender: TObject);
    procedure BimPedidosClick(Sender: TObject);
    procedure BimProdutosClick(Sender: TObject);
    procedure BimSairClick(Sender: TObject);

  private
    Frame : TFraBase;
    procedure AbrirFrame(AFrame: TFraBase);
    procedure Fechar();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

procedure TFrmMenu.AbrirFrame(AFrame: TFraBase);
begin
  if Self.Frame <> nil then
  begin
    FreeAndNil(Self.Frame);
  end;

  Self.Frame := AFrame;
  Self.Frame.Parent := Self.PnlFrame;
  Self.Frame.Name := 'Frame';
end;

procedure TFrmMenu.BimClientesClick(Sender: TObject);
begin
  Self.AbrirFrame(TFraClientes.Create(Self));
end;

procedure TFrmMenu.BimPedidosClick(Sender: TObject);
begin
  Self.AbrirFrame(TFraPedido.Create(Self));
end;

procedure TFrmMenu.BimProdutosClick(Sender: TObject);
begin
  Self.AbrirFrame(TFraProdutos.Create(Self));
end;

procedure TFrmMenu.BimSairClick(Sender: TObject);
begin
  Self.Fechar();
end;

procedure TFrmMenu.Fechar;
begin
  if Application.MessageBox('Deseja fechar o sistema? Qualquer coisa não salva será perdida!', 'CRUD Teste', MB_YESNO) = 6 then
  begin
    Self.Close();
  end;
end;

procedure TFrmMenu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Escape then
  begin
    Self.Fechar();
  end;
end;

end.
