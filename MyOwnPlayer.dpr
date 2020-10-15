program MyOwnPlayer;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  uTypes in 'uTypes.pas',
  uSearchImage in 'uSearchImage.pas',
  uCoverSearch in 'uCoverSearch.pas' {fCoverSearch},
  uRegister in 'uRegister.pas' {fRegister},
  uni_RegCommon in 'libs\uni_RegCommon.pas',
  udeleteCover in 'udeleteCover.pas' {fDeleteCover},
  uREgEx in 'uREgEx.pas' {fRegEx};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
