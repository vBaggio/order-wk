program WKOrder;

uses
  Vcl.Forms,
  fMain_view in 'Views/fMain_view.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
