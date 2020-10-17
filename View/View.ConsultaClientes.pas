unit View.ConsultaClientes;

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
  Model.Cliente;

type
  TFrmConsultaCliente = class(TFrmConsultaBase)
  private
    FObjetoConsultado: TCliente;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TCliente read FObjetoConsultado;
  end;

var
  FrmConsultaCliente: TFrmConsultaCliente;

implementation

{$R *.dfm}

{ TFrmConsultaCliente }

procedure TFrmConsultaCliente.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TCliente.Create(Self.QryConsulta.FieldByName('Codigo').AsInteger);
end;

function TFrmConsultaCliente.FormarFiltro: String;
begin
  Result := '(Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%') +')';
end;

function TFrmConsultaCliente.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Nome FROM Clientes' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
