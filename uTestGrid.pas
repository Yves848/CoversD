unit uTestGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, sScrollBox,
  Vcl.StdCtrls, sEdit, sButton, sMemo;

const
  sPanelName = 'sPnl%d';
  sFrameName = 'sFrm%d';

type
  TfTestGrid = class(TForm)
    sScrollBox1: TsScrollBox;
    sPanel1: TsPanel;
    sButton1: TsButton;
    sMemo1: TsMemo;
    sButton2: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
  private
    { Déclarations privées }
    function findNextNumForComponent(aPanel: tsPanel; sCompName: String): integer;
    procedure setCoordonates(aComponent: tComponent);
    procedure setParent(aComponent: tComponent);
    function findPanel: TsPanel;
  public
    { Déclarations publiques }
  end;

var
  fTestGrid: TfTestGrid;

implementation

uses
  uGridFrame;
{$R *.dfm}

function TfTestGrid.findNextNumForComponent(aPanel: tsPanel; sCompName: String): integer;

begin
  Result := 1;
   while aPanel.FindComponent(sCompName+inttostr(result)) <> nil do
   begin
   inc(result);
   end;
end;

function TfTestGrid.findPanel: TsPanel;
var
  aPanel: TsPanel;
  i: integer;
begin
  i := 1;
  aPanel := TsPanel(sScrollBox1.FindComponent(format(sPanelName, [i])));
  while true do
  begin
    if aPanel <> nil then
    begin
      // check if there's room
      if aPanel.ComponentCount < 3 then
      begin
        // keep this panel
        break;
      end
      else
      begin
        inc(i);
        aPanel := TsPanel(sScrollBox1.FindComponent(format(sPanelName, [i])));
      end;
    end
    else
    begin
      aPanel := tsPanel.Create(sScrollBox1);
      aPanel.parent := sScrollbox1;
      aPanel.name :=format(sPanelName, [i]);
      aPanel.Height := 240;
      aPanel.top := 1000;
      aPanel.Align := alTop;
      break;
    end;
  end;

  result := aPanel;
end;

procedure TfTestGrid.sButton1Click(Sender: TObject);
var
  pGridFrame: tfGridFrame;
  pnParent: TsPanel;
  iFrmNum : Integer;
begin
  // Find parent (panel)
  pnParent := findPanel;
  iFrmNum := findNextNumForComponent(pnParent,pnParent.Name+'sFrm');
  pGridFrame := tfGridFrame.create(pnParent);
  pGridFrame.parent := pnParent;

  pGridFrame.name := pnParent.Name+format(sFrameName,[iFrmNum]);
  pGridFrame.Align := alLeft;
end;

procedure TfTestGrid.sButton2Click(Sender: TObject);
var
  aPanel: TsPanel;
begin
  aPanel := TsPanel(self.FindComponent(format(sPanelName, [2])));
  sMemo1.Lines.Add(inttostr(aPanel.ComponentCount));
end;

procedure TfTestGrid.setCoordonates(aComponent: tComponent);
begin

end;

procedure TfTestGrid.setParent(aComponent: tComponent);
begin

end;

end.
