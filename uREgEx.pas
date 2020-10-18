unit uREgEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, Vcl.Buttons, sBitBtn, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sComboEdit, sComboBox, sSpeedButton,System.RegularExpressions, sLabel, sEdit;

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
    seSource: TsEdit;
    seFrom: TsEdit;
    sLResult: TsLabelFX;
    seTo: TsEdit;
    sButton1: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function replace(const Match : tMatch; sRes : String): string;
  end;

var
  fRegEx: TfRegEx;
  i : Integer;

implementation

{$R *.dfm}



procedure TfRegEx.FormActivate(Sender: TObject);
begin
  sButton1.Caption := 'Activate';
end;

procedure TfRegEx.FormShow(Sender: TObject);
begin
   sButton1.caption := 'Show';
end;

function TfRegEx.replace(const Match: tMatch; sRes : String): string;
begin
    result := sRes;
end;

procedure TfRegEx.sButton1Click(Sender: TObject);
var
   regex : tRegEX;
   sSource : String;
   myEval : TMatchEvaluator;
begin
   sSource := seSource.text;
   regex.Create(seFrom.Text);
   //myEval := replace;
   sLResult.caption := regEx.Replace(sSource,seTo.text);
end;

end.
