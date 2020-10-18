unit udeleteCover;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, uTypes, JclPCRE, sScrollBox;

type
  TfDeleteCover = class(TForm)
    sButton1: TsButton;
    sSB1: TsScrollBox;
    procedure sButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    i : Integer;
  end;

var
  fDeleteCover: TfDeleteCover;

implementation
uses
   uFileFrame;
{$R *.dfm}

procedure TfDeleteCover.FormCreate(Sender: TObject);
begin
  i := 2;
end;

procedure TfDeleteCover.sButton1Click(Sender: TObject);
var
   fRegExFrame : tFrame2;
begin
    sSB1.SkinData.BeginUpdate;
    fRegExFrame := tFrame2.Create(self);
    fREgExFrame.Name := format('FrameFile%d',[i]);
    inc(i);
    fRegExFrame.Parent := sSB1;
    sSb1.SkinData.EndUpdate(True);
end;



end.
