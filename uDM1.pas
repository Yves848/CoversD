unit uDM1;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, acAlphaImageList,Vcl.Graphics, VCL.Forms;

type
  TDM1 = class(TDataModule)
    sILTV: TsAlphaImageList;
    sILNoCover: TsAlphaImageList;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function GetNoCoverImage : tBitMap;
  end;

var
  DM1: TDM1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM1 }



{ TDM1 }

function TDM1.GetNoCoverImage : tBitMap;
begin
   result := sILNoCover.CreateBitmap32(0,sILNoCover.Width,sILNoCover.Height);
end;

end.
