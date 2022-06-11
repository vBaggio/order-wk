unit uCliente;

interface

type TCliente = class
  private
    FId: integer;
    FNome: string;
    FCidade: string;
    FUF: string;

  public
    property Id: integer      read FId     write FId;
    property Nome: string     read FNome   write FNome;
    property Cidade : string  read FCidade write FCidade;
    property UF: string       read FUF     write FUF;
    constructor Create(AId: integer = 0);

    procedure Reset;
end;

implementation

{ TCliente }

constructor TCliente.Create(AId: integer = 0);
begin
  FId := AId;
  Reset;
end;

procedure TCliente.Reset;
begin
  FNome := '';
  FCidade := '';
  FUF := '';
end;

end.
