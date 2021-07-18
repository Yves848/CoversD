unit uTagEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Types, System.IOUtils,
  System.Threading,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, uSearchImage, Vcl.StdCtrls,
  xSuperObject,
  sListBox, sButton, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, sMemo,
  Vcl.ExtCtrls, sPanel, sSkinProvider, sSkinManager, acPathDialog, System.ImageList, Vcl.ImgList, acAlphaImageList,uFrmCoverSearch, sSplitter;

type

   (*
    *
    * Search callbacks
    *
    *)

  tSearchCallback = procedure(iRow: integer) of object;
  tDisplayStatus = procedure(iCol, iRow: integer; sStatus: integer) of object;
  tGetKey = function(iRow: integer): String of object;
  tSetResults = procedure(iRow: integer; sResults: string) of object;

   (*
    *
    * Download images callbacks
    *
    *)
  tUpdateprogress = procedure(iCol, iRow, percent : integer) of object;

  tSearchThread = class(tThread)
  private
    endSearch: tSearchCallback;
    fOnDisplayStatus: tDisplayStatus;
    fOnGetKey: tGetKey;
    fOnSetResults: tSetResults;
    row: integer;
    GS: tGoogleSearchFree;
    //GS: tGoogleSearch;
    results: string;
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    constructor create(iRow: integer); reintroduce;
    property onDisplayStatus: tDisplayStatus read fOnDisplayStatus
      write fOnDisplayStatus;
    property onGeyKey: tGetKey read fOnGetKey write fOnGetKey;
    property onSetResults: tSetResults read fOnSetResults write fOnSetResults;
  end;

  tDownloadThread = class(tThread)
    fCol : Integer;
    fRow : Integer;
    fProgressCol : Integer;
    fProgressRow : Integer;

    protected
      procedure execute; override;
      procedure doTerminate; override;
    public
      constructor create; reintroduce;
  end;

  tListObj = class(tPersistent)
  public
    sKey: String;
    sResults: tStrings;
    constructor create(pkey: String);
    destructor destroy;
  end;

  TForm2 = class(TForm)
    sButton1: TsButton;
    sg1: TAdvStringGrid;
    btSearch: TsButton;
    sButton3: TsButton;
    sMemo1: TsMemo;
    sPanel1: TsPanel;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sPathDialog1: TsPathDialog;
    sAlphaImageList1: TsAlphaImageList;
    sPnVariable: TsPanel;
    sPanel2: TsPanel;
    sSplitter1: TsSplitter;
    AdvStringGrid1: TAdvStringGrid;
    procedure sButton1Click(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sSplitter1Resize(Sender: TObject);
  private
    { Déclarations privées }
    procedure addToGrid(pkey: String; pObj: tListObj);
    procedure clearGrid;
    procedure AddFolderToGrid(sFolder: String);
    function AddFileToGrid(sFile: String): integer;
  public
    { Déclarations publiques }
    procedure endOfSearch(iRow: integer);
    procedure displayStatus(iCol, iRow: integer; sStatus: integer);
    function getKey(iRow: integer): String;
    procedure SetResults(iRow: integer; results: string);
  end;

var
  Form2: TForm2;
  frmCoverSearch: TfrmCoverSearch;

implementation

{$R *.dfm}
{ tListObj }

constructor tListObj.create(pkey: String);
begin
  inherited create;
  sKey := pkey;
  sResults := tStringList.create;

end;

destructor tListObj.destroy;
begin
  sResults.Free;
  inherited;
end;

procedure TForm2.addToGrid(pkey: String; pObj: tListObj);
var
  i: integer;
begin
  i := sg1.RowCount - 1;
  if sg1.cells[0, i] <> '' then
    sg1.RowCount := sg1.RowCount + 1;
  i := sg1.RowCount - 1;
  sg1.cells[0, i] := pkey;
  sg1.Objects[0, i] := pObj;
  // ListBox1.Items.AddObject(pkey, pObj);
end;

procedure TForm2.clearGrid;
var
  r, c: integer;
begin
  r := 1;
  while r <= sg1.RowCount - 1 do
  begin
    c := 0;
    if sg1.Objects[0, r] <> nil then
      tListObj(sg1.Objects[0, r]).Free;

    while c <= sg1.colCount - 1 do
    begin
      sg1.cells[c, r] := '';
      inc(c);
    end;
    inc(r);
  end;
  sg1.RowCount := 1;

end;

procedure TForm2.displayStatus(iCol, iRow: integer; sStatus: integer);
begin
  // update status
  //sg1.cells[iCol, iRow] := sStatus;
  sg1.AddImageIdx(iCol, iRow, sStatus, haCenter, vaCenter);
  application.ProcessMessages;
end;

procedure TForm2.endOfSearch(iRow: integer);
begin
  sg1.cells[4, iRow] := 'terminé';
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  frmCoverSearch := TfrmCoverSearch.create(Application);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  frmCoverSearch.Parent := sPnVariable;
end;

function TForm2.getKey(iRow: integer): String;
begin
  result := sg1.cells[1, iRow] + ' ' + sg1.cells[2, iRow];
  if trim(result) = '' then
    result := sg1.cells[0, iRow];
end;

procedure TForm2.sButton1Click(Sender: TObject);
var
  pListObj: tListObj;
begin
  if sPathDialog1.Execute then
  begin
    clearGrid;
    AddFolderToGrid(sPathDialog1.Path);
  end;
end;

procedure TForm2.AddFolderToGrid(sFolder: String);
var
  i: integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: boolean;
  sExt: String;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(sFolder, aSearchOption, nil);
  btSearch.enabled := false;
  i := 0;
  while i <= Length(aFiles) - 1 do
  begin
    sExt := tpath.GetExtension(aFiles[i]);
    bAdd := tMediaUtils.isValidExtension(sExt);
    if bAdd then
    begin
      AddFileToGrid(aFiles[i]);
    end;
    inc(i);
  end;

  btSearch.enabled := true;
end;

function TForm2.AddFileToGrid(sFile: String): integer;
var
  ARow: integer;
  pMediaFile: tMediaFile;
  pListObj: tListObj;
begin
  //
  ARow := sg1.RowCount - 1;
  if sg1.cells[0, ARow] <> '' then
  begin
    sg1.RowCount := sg1.RowCount + 1;
    ARow := sg1.RowCount - 1;
  end;
  pListObj := tListObj.create('');

  pMediaFile := tMediaFile.create(sFile);
  try
    sg1.Objects[0, ARow] := pListObj;
    sg1.Objects[1, ARow] := pMediaFile;
    sg1.cells[0, ARow] := tpath.GetFileName(sFile);
    sg1.cells[1, ARow] := pMediaFile.Tags.GetTag('ARTIST');
    sg1.cells[2, ARow] := pMediaFile.Tags.GetTag('TITLE');
    sg1.cells[3, ARow] := pMediaFile.Tags.GetTag('ALBUM');
    result := ARow;

  finally
  end;

  application.ProcessMessages;
end;

procedure TForm2.btSearchClick(Sender: TObject);
var
  r: integer;
  pSearchThread: tSearchThread;
begin

  r := 0;
  while r <= sg1.RowCount - 1 do
  begin
    pSearchThread := tSearchThread.create(r);
    pSearchThread.fOnDisplayStatus := displayStatus;
    pSearchThread.fOnGetKey := getKey;
    pSearchThread.fOnSetResults := SetResults;
    pSearchThread.Start;
    inc(r);
  end;

end;

procedure TForm2.sButton3Click(Sender: TObject);
var
  GlobalMediaFile: tMediaFile;
  iRow : Integer;
begin
  frmCoverSearch.Parent := sPnVariable;
  iRow := sg1.row;
  if sg1.Objects[1, iRow] <> Nil then
    GlobalMediaFile := tMediaFile(sg1.Objects[1, iRow]);
    sMemo1.Clear;
    sMemo1.Lines.Assign(tListObj(sg1.Objects[0, sg1.row]).sResults);

   
end;

procedure TForm2.SetResults(iRow: integer; results: string);
var
  pListObj: tListObj;
begin
  pListObj := tListObj(sg1.Objects[0, iRow]);
  pListObj.sResults.Text := results;
end;

procedure TForm2.sSplitter1Resize(Sender: TObject);
begin
    // resize de cells in grid
end;

{ tSearchThread }

constructor tSearchThread.create(iRow: integer);

begin
  inherited create(true);
  self.FreeOnTerminate := true;
  row := iRow;

end;

procedure tSearchThread.DoTerminate;
begin
  fOnDisplayStatus(4, row, 0);
  GS.Free;
  inherited;
end;

procedure tSearchThread.Execute;
var
  sKey: String;
  xResult: ISuperObject;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  lResults: tStrings;
begin
  inherited;
  fOnDisplayStatus(4, row, 2);
  sKey := fOnGetKey(row);
  //GS := tGoogleSearch.create(sKey, 1);
  GS := tGoogleSearchfree.create;
  fOnDisplayStatus(4, row, 1);
  xResult := GS.getImages(skey);
  jsArray := xResult.A[GS_ITEMS];

  lResults := tStringList.Create;
   while (i <= jsArray.length - 1) do
  begin
    lResults.Add(jsArray.O[i].S[GS_LINK]);
    Inc(i);
  end;

  fOnSetResults(row, lResults.Text);
  terminate;
end;

{ tDownloadThread }

constructor tDownloadThread.create;
begin

end;

procedure tDownloadThread.doTerminate;
begin
  inherited;

end;

procedure tDownloadThread.execute;
begin
  inherited;

end;

end.
