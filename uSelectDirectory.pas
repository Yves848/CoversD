unit uSelectDirectory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, sTreeView, acShellCtrls, Vcl.ExtCtrls, sPanel, AdvMemo, Vcl.StdCtrls, sButton,
  uTypes, TagsLibrary;

type
  TfSelectDirectory = class(TForm)
    FDConnection1: TFDConnection;
    tMedias: TFDTable;
    tv1: TsShellTreeView;
    sPanel1: TsPanel;
    sButton1: TsButton;
    Memo1: TAdvMemo;
    procedure sButton1Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure BrowsePath(sPath: String);
    Procedure AddToDB(sFile : String);
  public
    { Déclarations publiques }
  end;

var
  fSelectDirectory: TfSelectDirectory;

implementation

{$R *.dfm}

procedure TfSelectDirectory.AddToDB(sFile: String);
var
  sMediaPath,
  sMediaName : String;
  iMediaType : Integer;
begin
   sMediaPath := tPath.GetFullPath(sFile);
   sMediaName := tPath.GetFileName(sFile);
   iMediatype := tMediaUtils.isValidExtension2(sFile);
   tMedias.Append;
   tMedias.FieldByName('mediaPath').AsString := sMediaPath;
   tMedias.FieldByName('mediaName').AsString := sMediaName;
   tMedias.FieldByName('mediaType').AsInteger := iMediaType;
   tMedias.Post;


end;

procedure TfSelectDirectory.BrowsePath(sPath: String);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;

begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(sPath, aSearchOption, nil);
  i := 0;
  tMedias.Open;
  while i <= length(aFiles) - 1 do
  begin
    if tMediaUtils.isValidExtension(aFiles[i]) then
    begin
      AddToDB(aFiles[i]);
      Memo1.Lines.Add(aFiles[i] +' '+ tMediaUtils.getExtension(aFiles[i]));
    end;
    inc(i);
  end;
  tMedias.Close;

end;

procedure TfSelectDirectory.sButton1Click(Sender: TObject);
var
  aNode: TTreeNode;
begin
  Memo1.Lines.Clear;
  if tv1.Selected <> Nil then
  begin
    aNode := tv1.Selected;
    BrowsePath(TacShellFolder(aNode.Data).PathName);

  end;

end;

end.
