unit uRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvBackgrounds, acPNG, Vcl.ExtCtrls, acImage, Vcl.StdCtrls, sLabel, sEdit, sBevel, sButton, sPanel, uni_RegCommon;

type
  TfRegister = class(TForm)
    sImage1: TsImage;
    slSerial: TsLabelFX;
    seSerial: TsEdit;
    sLabelFX1: TsLabelFX;
    seMachine: TsEdit;
    sBevel1: TsBevel;
    sLabelFX2: TsLabelFX;
    seRegister: TsEdit;
    sPanel1: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    procedure sButton2Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fRegister: TfRegister;

implementation

{$R *.dfm}

procedure TfRegister.FormShow(Sender: TObject);
begin
  seMachine.Text := format('%d',[MachineModifier]);
end;

procedure TfRegister.sButton1Click(Sender: TObject);
var
  SerialNum : longint;
begin
  // Validate the serial number
  try
    SerialNum := StrToInt(seSerial.Text);
  except
    MessageDlg('Invalid Serial Number.  Please check your entry and try again.', mtError, [mbOK], 0);
    seSerial.SetFocus;
    seSerial.SelectAll;
    exit;
  end;

  // Validate the release code
  if not IsReleaseCodeValid (seRegister.Text, SerialNum) then begin
    MessageDlg('Invalid Release Code.  Please check your entry and try again.', mtError, [mbOK], 0);
    seRegister.SetFocus;
    seRegister.Text := '';
    exit;
  end else begin
    MessageDlg('Registration complete.', mtInformation, [mbOK], 0);
    SaveRegistrationInformation(seRegister.Text, SerialNum);
    Close;
  end;
  ModalResult := mrOk;
end;

procedure TfRegister.sButton2Click(Sender: TObject);
begin
  ModalREsult := mrCancel;
end;

end.
