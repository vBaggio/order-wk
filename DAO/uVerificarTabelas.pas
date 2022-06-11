unit uVerificarTabelas;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  System.Classes, VCL.Dialogs, Vcl.Controls, VCL.Forms,
  uConnection;

type TVerificarTabelas = class
  private
    class var Conn: TFDConnection;
    Query: TFDQuery;
  public
    class function VerificarTabelas: boolean;
end;

implementation

{ TVerificarTabelas }

class function TVerificarTabelas.VerificarTabelas: boolean;
var List: TStringList;
begin
  try
    Conn := TMyConnection.GetConn;
    List := TStringList.Create;

    Conn.GetTableNames('','','',List,[osMy],[tkTable], false);

    if List.Count < 4 then
    begin
      if not (MessageDlg('Criar as tabelas ?' , mtConfirmation, [mbOK, mbCancel], 0) = mrOk) then
      begin
        Application.Terminate;
        Exit;
      end;
    end;

    try
      Conn.StartTransaction;

      //Tabela Clientes
      if not (List.IndexOf('clientes') > -1) then
      begin
        Conn.ExecSQL(
          'CREATE TABLE clientes (                  ' +
          'idclientes INT NOT NULL AUTO_INCREMENT,  ' +
          'nome VARCHAR(45) NULL,                   ' +
          'cidade VARCHAR(45) NULL,                 ' +
          'uf VARCHAR(2) NULL,                      ' +
          'PRIMARY KEY (idclientes));               '
        );

        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 01", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 02", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 03", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 04", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 05", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 06", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 07", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 08", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 09", "SÃO PAULO", "SP")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 10", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 11", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 12", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 13", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 14", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 15", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 16", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 17", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 18", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 19", "RIO DE JANEIRO", "RJ")');
        Conn.ExecSQL('INSERT INTO clientes (nome, cidade, uf) VALUES ("Cliente 20", "RIO DE JANEIRO", "RJ")');
      end;

      //Tabela Produtos
      if not (List.IndexOf('produtos') > -1) then
      begin
        Conn.ExecSQL(
          'CREATE TABLE produtos (                     ' +
          '  idprodutos   INT NOT NULL AUTO_INCREMENT, ' +
          '  descricao   VARCHAR(45) NULL,             ' +
          '  venda   DOUBLE NULL,                      ' +
          '  PRIMARY KEY (  idprodutos  ));            '
        );

        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 01",  1.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 02",  2.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 03",  3.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 04",  4.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 05",  5.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 06",  6.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 07",  7.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 08",  8.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 09",  9.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 10", 10.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 11", 11.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 12", 12.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 13", 13.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 14", 14.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 15", 15.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 16", 16.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 17", 17.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 18", 18.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 19", 19.00)');
        Conn.ExecSQL('INSERT INTO produtos (descricao, venda) VALUES ("Produto 20", 20.00)');
      end;

      //Tabela Pedido
      if not (List.IndexOf('pedidos') > -1) then
      begin
        Conn.ExecSQL(
          'CREATE TABLE pedidos (                            ' +
          '  idpedidos INT NOT NULL,                         ' +
          '  emis DATETIME NULL,                             ' +
          '  idclientes INT NULL,                            ' +
          '  total DOUBLE NULL,                              ' +
          '  PRIMARY KEY (idpedidos),                        ' +
          '  INDEX fk_clientes_idx (idclientes ASC) VISIBLE, ' +
          '  CONSTRAINT fk_clientes                          ' +
          '    FOREIGN KEY (idclientes)                      ' +
          '    REFERENCES clientes (idclientes)              ' +
          '    ON DELETE RESTRICT                            ' +
          '    ON UPDATE NO ACTION);                         '
        );
      end;

      //Tabela PedItens
      if not (List.IndexOf('peditens') > -1) then
      begin
        Conn.ExecSQL(
          'CREATE TABLE peditens (                           ' +
          '  idpeditens INT NOT NULL,                        ' +
          '  idpedidos  INT NOT NULL,                        ' +
          '  idprodutos INT NULL,                            ' +
          '  quantidade DOUBLE NULL,                         ' +
          '  unitario   DOUBLE NULL,                         ' +
          '  total DOUBLE NULL,                              ' +
          '  PRIMARY KEY (idpeditens, idpedidos),            ' +
          '  INDEX fk_pedidos_idx (idpedidos ASC) VISIBLE,   ' +
          '  INDEX fk_produtos_idx (idprodutos ASC) VISIBLE, ' +
          '  CONSTRAINT fk_pedidos                           ' +
          '    FOREIGN KEY (idpedidos)                       ' +
          '    REFERENCES pedidos (idpedidos)                ' +
          '    ON DELETE RESTRICT                            ' +
          '    ON UPDATE NO ACTION,                          ' +
          '  CONSTRAINT fk_produtos                          ' +
          '    FOREIGN KEY (idprodutos)                      ' +
          '	REFERENCES produtos (idprodutos)                 ' +
          '	ON DELETE RESTRICT                               ' +
          '    ON UPDATE NO ACTION)                          '
        );
      end;

      Conn.Commit;
    except
      Conn.Rollback;
    end;

  finally
    List.Free;
    FreeAndNil(Query);
  end;

end;

end.
