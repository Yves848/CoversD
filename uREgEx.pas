unit uREgEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, Vcl.Buttons, sBitBtn, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sComboEdit, sComboBox, sSpeedButton,System.RegularExpressions, sLabel, sEdit,acPopupCtrls;

type
  TfRegEx = class(TForm)
    sPanel1: TsPanel;
    sComboBox1: TsComboBox;
    sComboBox2: TsComboBox;
    sComboBox3: TsComboBox;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sComboBox4: TsComboBox;
    sSpeedButton4: TsSpeedButton;
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    sEdit : TsPopupBox;
    function replace(const Match : tMatch; sRes : String): string;
  end;

var
  fRegEx: TfRegEx;
  i : Integer;

implementation

{$R *.dfm}



function TfRegEx.replace(const Match: tMatch; sRes : String): string;
begin
    result := sRes;
end;

procedure TfRegEx.sSpeedButton1Click(Sender: TObject);
var
  iCaret : Integer;
  sString : String;
begin
  iCaret := sEdit.SelStart;
  sString := sEdit.Text;
  if iCaret =  length(sEdit.Text) then
    sString := sString +sCombobox1.Text
  else
     insert(sCombobox1.Text,sString,iCaret+1);
  sEdit.Text := sString;
  sEdit.SelStart := iCaret + length(sCombobox1.Text);
end;

procedure TfRegEx.sSpeedButton2Click(Sender: TObject);
var
  iCaret : Integer;
  sString : String;
begin
  iCaret := sEdit.SelStart;
  sString := sEdit.Text;
  if iCaret =  length(sEdit.Text) then
    sString := sString +sCombobox2.Text
  else
     insert(sCombobox2.Text,sString,iCaret+1);
  sEdit.Text := sString;
  sEdit.SelStart := iCaret + length(sCombobox2.Text);

end;

procedure TfRegEx.sSpeedButton3Click(Sender: TObject);
var
  iCaret : Integer;
  sString : String;
begin
  iCaret := sEdit.SelStart;
  sString := sEdit.Text;
  if iCaret =  length(sEdit.Text) then
    sString := sString +sCombobox3.Text
  else
     insert(sCombobox3.Text,sString,iCaret+1);
  sEdit.Text := sString;
  sEdit.SelStart := iCaret + length(sCombobox3.Text);

end;

end.
