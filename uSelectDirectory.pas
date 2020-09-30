unit uSelectDirectory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, sTreeView, acShellCtrls, Vcl.ExtCtrls, sPanel, AdvMemo, Vcl.StdCtrls, sButton,
  uTypes, TagsLibrary, acProgressBar;

type
  TfSelectDirectory = class(TForm)
    FDConnection1: TFDConnection;
    tMedias: TFDTable;
    tv1: TsShellTreeView;
    sPanel1: TsPanel;
    sButton1: TsButton;
    Memo1: TAdvMemo;
    sButton2: TsButton;
    qMedias: TFDQuery;
    qTags: TFDQuery;
    pb1: TsProgressBar;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure BrowsePath(sPath: String);
    Procedure AddToDB(sFile: String);
    function loadTags(sFile: String; aTags: tTags): boolean;
  public
    { Déclarations publiques }
  end;

var
  fSelectDirectory: TfSelectDirectory;

implementation

{$R *.dfm}

procedure TfSelectDirectory.AddToDB(sFile: String);
var
  sMediaPath, sMediaName: String;
  iMediaType: Integer;
begin
  sMediaPath := tPath.GetFullPath(sFile);
  sMediaName := tPath.GetFileName(sFile);
  iMediaType := tMediaUtils.isValidExtension(sFile);
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
    if tMediaUtils.isValidExtension(aFiles[i]) > -1 then
    begin
      AddToDB(aFiles[i]);
    end;
    inc(i);
  end;
  tMedias.Close;

end;

function TfSelectDirectory.loadTags(sFile: String; aTags: tTags): boolean;
begin
  aTags.Clear;
  result := false;
  try
    aTags.ParseCoverArts := true;
    aTags.LoadFromFile(sFile);
    result := true;
  except

  end;
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

procedure TfSelectDirectory.sButton2Click(Sender: TObject);
var
  pMediaFile: tMediaFile;
  i : Integer;
  iCount : integer;
begin

  pMediaFile := tMediaFile.create;
  
  with qMedias do
  begin
    open; 
    last;
    iCount := RecordCount;
    i := 0;
    pb1.Position := 0;
    first;
    while not eof do
    begin
      if loadTags(FieldByName('mediaPAth').AsString, pMediaFile.tags) then
      begin
        //Memo1.Lines.Add(pMediaFile.tags.GetTag('ARTIST') + pMediaFile.tags.GetTag('TITLE'));
        qTags.ParamByName('MediaId').AsInteger := qMedias.FieldByName('id').AsInteger;
        qTags.ParamByName('ARTIST').AsString := pMediaFile.tags.GetTag('ARTIST');
        qTags.ParamByName('TITLE').AsString := pMediaFile.tags.GetTag('TITLE');
        qTags.ParamByName('ALBUM').AsString := pMediaFile.tags.GetTag('ALBUM');
        qTags.ExecSQL;
      end;
      inc(i);
      if (i div 100 = 0) then
      begin
         pb1.Position := round(i / iCount * 100);
         application.ProcessMessages;
      end;
      Next;
    end;
    close;
  end;
end;

end.
