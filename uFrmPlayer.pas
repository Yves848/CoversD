unit uFrmPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sFrameAdapter, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn;

type
  TfrmPlayer = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sPanel1: TsPanel;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

implementation

{$R *.dfm}

end.
