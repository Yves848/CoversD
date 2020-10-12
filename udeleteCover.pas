unit udeleteCover;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, uTypes;

type
  TfDeleteCover = class(TForm)
    sButton1: TsButton;
    procedure sButton1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fDeleteCover: TfDeleteCover;

implementation

{$R *.dfm}

procedure TfDeleteCover.sButton1Click(Sender: TObject);
var
   pMediaFile : TMEdiaFile;
begin
   pMediaFile := tMEdiaFile.Create;

   pMediaFile.tags.ParseCoverArts := False;
   pMEdiaFile.Tags.loadFromFile('e:\MP3\Tubes\TUBES 1997\43. Toni Braxton - Unbreak my heart.mp3');
   pMediaFile.saveTags;

end;

end.
