unit uFileFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sFrameAdapter, Vcl.ExtCtrls, sSplitter, Vcl.StdCtrls, sEdit, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, sComboEdit, acPopupCtrls;

type
  TFrame2 = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sEdit1: TsEdit;
    sSplitter1: TsSplitter;
    sEdit2: TsEdit;
    sPopupBox1: TsPopupBox;
    sSplitter2: TsSplitter;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation
uses
   uRegEx;
{$R *.dfm}

end.
