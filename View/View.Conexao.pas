unit View.Conexao;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Controller.Connection;

type
  TFrmConexao = class(TForm)
    LedServidor: TLabeledEdit;
    LblTitulo: TLabel;
    LedBanco: TLabeledEdit;
    LedLogin: TLabeledEdit;
    LedSenha: TLabeledEdit;
    BtnGravar: TButton;
    procedure BtnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProximoCampo(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FConexaoGerada: String;
    FGravou: Boolean;
    { Private declarations }
  public
    { Public declarations }
    property ConexaoGerada: String read FConexaoGerada;
    property Gravou: Boolean read FGravou;
  end;

var
  FrmConexao: TFrmConexao;

implementation

{$R *.dfm}

{ TFrmConexao }

procedure TFrmConexao.BtnGravarClick(Sender: TObject);
begin
  Self.FConexaoGerada := TConexao.GerarConexao(Self.LedServidor.Text, Self.LedBanco.Text,
                                               Self.LedLogin.Text, Self.LedSenha.Text,
                                               ExtractFilePath(Application.ExeName) + 'Conexao.config');
  Self.FGravou := True;
  Self.Close();
end;

procedure TFrmConexao.FormCreate(Sender: TObject);
begin
  Self.FGravou := False;
  Self.FConexaoGerada := '';
end;

procedure TFrmConexao.ProximoCampo(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
  begin
    perform(wm_nextdlgctl, 0, 0);
  end;
end;

end.
