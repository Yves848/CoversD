program Covers;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  uTypes in 'uTypes.pas',
  utags in 'utags.pas' {Form2},
  Vcl.Themes,
  Vcl.Styles,
  uSelectDirectory in 'uSelectDirectory.pas' {fSelectDirectory};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfSelectDirectory, fSelectDirectory);
  Application.Run;
end.
