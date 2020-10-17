unit View.ConsultaProdutos;

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
  View.ConsultaBase,
  Data.DB,
  Vcl.ExtCtrls,
  Data.Win.ADODB,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Model.Produto;

type
  TFrmConsultaProdutos = class(TFrmConsultaBase)
  private
    { Private declarations }
    FObjetoConsultado: TProduto;

    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TProduto read FObjetoConsultado;
  end;

var
  FrmConsultaProdutos: TFrmConsultaProdutos;

implementation

{$R *.dfm}

{ TFrmConsultaProdutos }

procedure TFrmConsultaProdutos.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TProduto.Create(Self.QryConsulta.FieldByName('Codigo').AsInteger);
end;

function TFrmConsultaProdutos.FormarFiltro: String;
begin
  Result := '(Descricao LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%') +')';
end;

function TFrmConsultaProdutos.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Descricao FROM Produtos' + #13 +
            'WHERE Descricao LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
