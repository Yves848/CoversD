unit uLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel;

type
  TfLog = class(TForm)
    sPnMain: TsPanel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fLog: TfLog;

implementation

{$R *.dfm}

end.
