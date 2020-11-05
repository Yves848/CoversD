unit ufrmLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, acAlphaImageList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sMemo,
  Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TfrmLog = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    mLog: TsMemo;
    sbbClear: TsBitBtn;
    sCharImageList1: TsCharImageList;
    procedure sbbClearClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function add(sLog : String) : Integer; overload;
    function add(sFunc : String; sLog : String) : Integer; overload;
    function addToLog(sLog : String) : Integer;
  end;

implementation

{$R *.dfm}

function TfrmLog.add(sLog: String): Integer;
begin
    result := addToLog(sLog);
end;

function TfrmLog.add(sFunc, sLog: String): Integer;
var
  sLine : String;
begin
   sLine := format('[%s] %s',[sFunc,sLog]);
   result := add(sLine);
end;

function TfrmLog.addToLog(sLog: String): Integer;
var
  sLine : String;
  sDate : String;
begin
    sDate := formatdatetime('hh:mm:ss:zzz',now);
    sLine := format('%s - %s',[sDate,sLog]);
    mLog.Lines.Add(sLine);
end;

procedure TfrmLog.sbbClearClick(Sender: TObject);
begin
  mLog.Clear;
end;

end.
