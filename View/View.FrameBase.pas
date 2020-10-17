unit View.FrameBase;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFraBase = class(TFrame)
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnAlterar: TButton;
    BtnConsultar: TButton;
    BtnExcluir: TButton;
    BtnCancelar: TButton;
    BtnGravar: TButton;
    procedure ProximoCampo(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFraBase }

procedure TFraBase.ProximoCampo(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
  begin
    perform(wm_nextdlgctl, 0, 0);
  end;
end;

end.
