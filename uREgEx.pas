unit uREgEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uTypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, Vcl.Buttons, sBitBtn, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sComboEdit, sComboBox, sSpeedButton, System.RegularExpressions, sLabel, sEdit, acPopupCtrls, xSuperObject;

type
  TfRegEx = class(TForm)
    sPanel1: TsPanel;
    sCBField: TsComboBox;
    sCBSeperators: TsComboBox;
    sCBCounters: TsComboBox;
    sBtnFields: TsSpeedButton;
    sBtnSeparators: TsSpeedButton;
    sBtnCounters: TsSpeedButton;
    procedure sBtnFieldsClick(Sender: TObject);
    procedure sBtnSeparatorsClick(Sender: TObject);
    procedure sBtnCountersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    Procedure FillCombos;
  public
    { Déclarations publiques }
    sEdit: TsPopupBox;
    function replace(const Match: tMatch; sRes: String): string;
  end;

var
  fRegEx: TfRegEx;
  i: Integer;

implementation

{$R *.dfm}

procedure TfRegEx.FillCombos;
var
  Json: tSuperObject;
  i: Integer;
  aFields: ISuperArray;
  aObject: iSuperObject;
  pExpr: tExpr;

  procedure FillCombo(sKey: String; sCombo: TsComboBox);
  begin
    sCombo.Clear;
    aFields := Json.A[sKey];
    i := 0;
    while i <= aFields.Length - 1 do
    begin
      aObject := aFields.O[i];
      pExpr := tExpr.Create;
      pExpr.sExpr := aObject.S['RegEx'];
      dExpressions.Add(aObject.S['Name'], pExpr);
      sCombo.AddItem(aObject.S['Name'], Nil);
      inc(i);
    end;
    sCombo.ItemIndex := 0;
  end;

begin

  Json := tSuperObject.ParseFile('patterns.json');
  FillCombo('Fields',sCBField);
  FillCombo('Separators',sCBSeperators);
  FillCombo('Counters',sCBCounters);



end;

procedure TfRegEx.FormCreate(Sender: TObject);
begin
  FillCombos;
end;

function TfRegEx.replace(const Match: tMatch; sRes: String): string;
begin
  result := sRes;
end;

procedure TfRegEx.sBtnFieldsClick(Sender: TObject);
var
  iCaret: Integer;
  sString: String;
begin
  iCaret := sEdit.SelStart;
  sString := sEdit.Text;
  if iCaret = Length(sEdit.Text) then
    sString := sString + sCBField.Text
  else
    insert(sCBField.Text, sString, iCaret + 1);
  sEdit.Text := sString;
  sEdit.SelStart := iCaret + Length(sCBField.Text);
end;

procedure TfRegEx.sBtnSeparatorsClick(Sender: TObject);
var
  iCaret: Integer;
  sString: String;
begin
  iCaret := sEdit.SelStart;
  sString := sEdit.Text;
  if iCaret = Length(sEdit.Text) then
    sString := sString + sCBSeperators.Text
  else
    insert(sCBSeperators.Text, sString, iCaret + 1);
  sEdit.Text := sString;
  sEdit.SelStart := iCaret + Length(sCBSeperators.Text);

end;

procedure TfRegEx.sBtnCountersClick(Sender: TObject);
var
  iCaret: Integer;
  sString: String;
begin
  iCaret := sEdit.SelStart;
  sString := sEdit.Text;
  if iCaret = Length(sEdit.Text) then
    sString := sString + sCBCounters.Text
  else
    insert(sCBCounters.Text, sString, iCaret + 1);
  sEdit.Text := sString;
  sEdit.SelStart := iCaret + Length(sCBCounters.Text);

end;

end.
