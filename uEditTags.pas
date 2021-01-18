unit uEditTags;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, sLabel, sSkinProvider, sSkinManager, acTitleBar, acFloatCtrls,
  Vcl.ComCtrls, sTabControl, sScrollBox, Vcl.Buttons, sSpeedButton,uFrmTagEdit, uFrmPlayList, utypes, sTreeView, acShellCtrls;

const

Cmps: TCmpsArray = (
    // Invisible
    (Caption: 'TagEdits';
     Hint: '';
     GroupIndex: 0;
     FrameType: TFrmTagEdit
     ),

    (Caption: 'PlayList';
     Hint: '';
     ImgIndex: 1;
     GroupIndex: 0;
     FrameType: tFrmPlayList));

type
  TfEditTags = class(TForm)
    sPanel3: TsPanel;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sScrollBox2: TsScrollBox;
    sScrollBox3: TsScrollBox;
    sSplitView1: TsSplitView;
    sShellTreeView1: TsShellTreeView;
    procedure FormCreate(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    OldFrame : integer;
    CurrentFrame : tFrame;
  end;

var
  fEditTags: TfEditTags;

implementation

{$R *.dfm}



procedure TfEditTags.FormCreate(Sender: TObject);
begin
  OldFrame := -1;
end;

procedure TfEditTags.sSpeedButton4Click(Sender: TObject);
var
  idFrame : Integer;
begin
  if OldFrame <> tsSpeedButton(Sender).tag then
  begin
     if CurrentFrame <> Nil then
        FreeAndNil(CurrentFrame);
     OldFrame := tsSpeedButton(Sender).tag;
     CurrentFrame := cmps[OldFrame].FrameType.create(Application);
     CurrentFrame.parent := sScrollBox2;
  end;

end;

end.
