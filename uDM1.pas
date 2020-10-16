unit uDM1;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, acAlphaImageList;

type
  TDM1 = class(TDataModule)
    sILTV: TsAlphaImageList;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DM1: TDM1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
