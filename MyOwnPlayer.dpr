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
  uREgEx in 'uREgEx.pas' {fRegEx},
  uDM1 in 'uDM1.pas' {DM1: TDataModule},
  uRegExFrame in 'uRegExFrame.pas' {Frame1: TFrame},
  uFileFrame in 'uFileFrame.pas' {Frame2: TFrame},
  uFrameCover in 'uFrameCover.pas' {FrameCover: TFrame},
  uFrmPlayer in 'uFrmPlayer.pas' {frmPlayer: TFrame},
  uFormPlayer in 'uFormPlayer.pas' {Form1},
  uLog in 'uLog.pas' {fLog},
  ufrmLog in 'ufrmLog.pas' {frmLog: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
