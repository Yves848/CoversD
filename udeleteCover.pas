unit udeleteCover;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, uTypes, JclPCRE;

type
  TfDeleteCover = class(TForm)
    sButton1: TsButton;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fDeleteCover: TfDeleteCover;

implementation

{$R *.dfm}

end.
