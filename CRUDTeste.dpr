program CRUDTeste;

uses
  Vcl.Forms,
  SysUtils,
  WinApi.Windows,
  View.Menu in 'View\View.Menu.pas' {FrmMenu},
  Model.Cliente in 'Model\Model.Cliente.pas',
  Model.Pedido in 'Model\Model.Pedido.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Controller.Connection in 'Connection\Controller.Connection.pas',
  View.Conexao in 'View\View.Conexao.pas' {FrmConexao},
  View.FrameBase in 'View\View.FrameBase.pas' {FraBase: TFrame},
  Clientes.View in 'View\Clientes.View.pas' {FraClientes: TFrame},
  View.ConsultaBase in 'View\View.ConsultaBase.pas' {FrmConsultaBase},
  View.ConsultaClientes in 'View\View.ConsultaClientes.pas' {FrmConsultaCliente},
  View.Produtos in 'View\View.Produtos.pas' {FraProdutos: TFrame},
  View.ConsultaProdutos in 'View\View.ConsultaProdutos.pas' {FrmConsultaProdutos},
  View.Pedido in 'View\View.Pedido.pas' {FraPedido: TFrame},
  View.ConsultaPedido in 'View\View.ConsultaPedido.pas' {FrmConsultaPedido};

{$R *.res}
var
  Conexao: TConexao;
  ArqConexao: TextFile;
  StringConexao: String;
begin
  Conexao := TConexao.ObterInstancia();

  if FileExists(ExtractFilePath(Application.ExeName) + 'Conexao.config') then
  begin
    AssignFile(ArqConexao, ExtractFilePath(Application.ExeName) + 'Conexao.config');

    Reset(ArqConexao);
    while not Eof(ArqConexao) do
    begin
      ReadLn(ArqConexao, StringConexao);
    end;
    CloseFile(ArqConexao);
  end
  else
  begin
    FrmConexao := TFrmConexao.Create(nil);
    try
      FrmConexao.ShowModal();
      if FrmConexao.Gravou then
      begin
        StringConexao := FrmConexao.ConexaoGerada;
      end
      else
      begin
        Application.MessageBox('A conexão com o banco de dados não está determinada.', 'CRUD Teste');
        Exit();
      end;
    finally
      FreeAndNil(FrmConexao);
    end;
  end;

  if Conexao.Conectar(StringConexao) then
  begin
    Application.Initialize();
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFrmMenu, FrmMenu);
    Application.Run();
  end
  else
  begin
    if Application.MessageBox('Erro de conexão! É impossivel proseguir!' + #13 + 'Deseja excluir o arquivo de conexão?', 'CRUD Teste', MB_YESNO) = 6 then
    begin
      if FileExists(ExtractFilePath(Application.ExeName) + 'Conexao.config') then
      begin
        DeleteFile(PChar(ExtractFilePath(Application.ExeName) + 'Conexao.config'));
      end;
    end;
  end;
end.
