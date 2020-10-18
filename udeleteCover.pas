unit udeleteCover;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, uTypes, JclPCRE, sScrollBox;

type
  TfDeleteCover = class(TForm)
    sButton1: TsButton;
    sSB1: TsScrollBox;
    sButton2: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
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
    fREgExFrame.Top := 64000;
    //fRegExFrame.align := alTop;
    fRegExFrame.Parent := sSB1;
    sSb1.SkinData.EndUpdate(True);
end;



procedure TfDeleteCover.sButton2Click(Sender: TObject);
var
  iCount : Integer;
  aFrame : tFrame2;
begin
    if (ssB1.FindChildControl('FrameFile2') <> Nil) then
    begin
      tFrame2(ssB1.FindChildControl('FrameFile2')).sEdit1.Text := 'Coucou';
    end;
end;

end.
