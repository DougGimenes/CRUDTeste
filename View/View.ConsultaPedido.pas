unit View.ConsultaPedido;

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
  Model.Pedido;

type
  TFrmConsultaPedido = class(TFrmConsultaBase)
  private
    { Private declarations }
    FObjetoConsultado: TPedido;

    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TPedido read FObjetoConsultado write FObjetoConsultado;
  end;

var
  FrmConsultaPedido: TFrmConsultaPedido;

implementation

{$R *.dfm}

{ TFrmConsultaPedido }

procedure TFrmConsultaPedido.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TPedido.Create(Self.QryConsulta.FieldByName('Codigo').AsInteger);
end;

function TFrmConsultaPedido.FormarFiltro: String;
begin
  Result := '(Referencia LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%') +  #13 +
            'OR Cliente LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%') +')';
  { }
end;

function TFrmConsultaPedido.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Referencia FROM Pedidos' + #13 +
            'WHERE Referencia LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
