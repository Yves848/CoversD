unit uRegExFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit, sLabel, Vcl.ExtCtrls, sPanel, sFrameAdapter, acArcControls, sCheckBox,
  sComboBox;

type
  TFrame1 = class(TFrame)
    sCB1: TsComboBox;
    ckRegEx01: TsCheckBox;
    sEP01: TsComboBox;
    sCKReplace01: TsCheckBox;
    sBB1: TsBadgeBtn;
    sFrameAdapter1: TsFrameAdapter;
    sPNReplace01: TsPanel;
    sLabel2: TsLabel;
    sETO01: TsEdit;
    sEFROM01: TsEdit;
    sComboBox2: TsComboBox;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

end.
