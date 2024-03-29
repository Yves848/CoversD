unit uTagEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Types, System.IOUtils, System.Threading, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, uSearchImage, Vcl.StdCtrls,
  xSuperObject, sListBox, sButton, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, sMemo, IdComponent, JPEG, PNGImage, GIFImg, Vcl.ExtCtrls, sPanel,
  sSkinProvider, sSkinManager, acPathDialog, System.ImageList, Vcl.ImgList,
  acAlphaImageList, uFrmCoverSearch, sSplitter, IdTCPConnection, IdTCPClient,
  IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding, sCheckBox, acSlider,
  CurvyControls;

const
  WM_RESIZE_GRID = WM_USER + 1001;

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
  tPostAction = procedure(sender: tobject) of object;
  tAddToMemo = procedure(sLine : String) of object;

  (*
    *
    * Download images callbacks
    *
  *)
  tUpdateprogress = procedure(iCol, iRow, percent: integer) of object;
  tDisplayPicture = procedure(iCol, iRow: integer; picture: tpicture) of object;
  tTerminate = procedure of object;

  tSearchThread = class(tThread)
  private
    endSearch: tSearchCallback;
    fOnDisplayStatus: tDisplayStatus;
    fOnGetKey: tGetKey;
    fOnSetResults: tSetResults;
    fPostAction: tPostAction;
    fAddToMemo: tAddToMemo;
    fStart: integer;
    row: integer;
    fRowProgress: integer;
    // GS: tGoogleSearchFree;
    GS: tGoogleSearch;
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
    property postAction: tPostAction read fPostAction write fPostAction;
    property startPage: integer read fStart write fStart;
  end;

  tDownloadThread = class(tThread)
    fCol: integer;
    fRow: integer;
    fMax: integer;
    fPos: integer;
    fProgressCol: integer;
    fProgressRow: integer;
    fUpdateProgress: tUpdateprogress;
    fDisplayPicture: tDisplayPicture;
    fTerminate: tTerminate;
    fUrl: String;

  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    procedure onWork(ASender: tobject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: tobject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure onWorkEnd(ASender: tobject; AWorkMode: TWorkMode);
    constructor create(iCol, iRow: integer; pUrl: string); reintroduce;
    property UpdateProgress: tUpdateprogress read fUpdateProgress
      write fUpdateProgress;
    property displayPicture: tDisplayPicture read fDisplayPicture
      write fDisplayPicture;
    property updateRow: integer read fProgressRow write fProgressRow;
    property onTerminate: tTerminate read fTerminate write fTerminate;
    procedure downloadImage(sUrl: string);
  end;

  tListObj = class(tPersistent)
  public
    sKey: String;
    sResults: tStrings;
    page: integer;
    constructor create(pkey: String);
    destructor destroy;
  end;

  TForm2 = class(TForm)
    sButton1: TsButton;
    sg1: TAdvStringGrid;
    btSearch: TsButton;
    btnLoadResults: TsButton;
    sPanel1: TsPanel;
    sPathDialog1: TsPathDialog;
    sAlphaImageList1: TsAlphaImageList;
    sgImg: TAdvStringGrid;
    pnOptionsImages: TsPanel;
    sButton2: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    sgProgress: TAdvStringGrid;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sButton5: TsButton;
    sRollOutPanel1: TsRollOutPanel;
    sCheckBox1: TsCheckBox;
    pnCovers: TsPanel;
    procedure sButton1Click(sender: tobject);
    procedure btSearchClick(sender: tobject);
    procedure btnLoadResultsClick(sender: tobject);
    procedure sSplitter1Resize(sender: tobject);
    procedure FormShow(sender: tobject);
    procedure sButton3Click(sender: tobject);
    procedure sButton2Click(sender: tobject);
    procedure sButton4Click(sender: tobject);
    procedure FormResize(sender: tobject);
    procedure sButton5Click(Sender: TObject);
    procedure sg1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sRollOutPanel2AfterExpand(Sender: TObject);
  private
    { D�clarations priv�es }
    procedure addToGrid(pkey: String; pObj: tListObj);
    procedure clearGrid;
    procedure setGridTitles;
    procedure AddFolderToGrid(sFolder: String);
    function AddFileToGrid(sFile: String): integer;
    procedure clearImgGrid;
    procedure launchSearch(nRow: integer; nStartPage: integer;
      const bPostAction: boolean = false);
  public
    { D�clarations publiques }
    procedure endOfSearch(iRow: integer);
    procedure displayStatus(iCol, iRow: integer; sStatus: integer);
    function getKey(iRow: integer): String;
    procedure SetResults(iRow: integer; results: string);
    Procedure UpdateProgress(iCol, iRow, percent: integer);
    procedure displayPicture(iCol, iRow: integer; aPicture: tpicture);
    procedure terminateDownloadThread;
    procedure resizeGrid(var m: tMessage); Message WM_RESIZE_GRID;
    procedure removeKeyFromStack;
  end;

var
  Form2: TForm2;
  frmCoverSearch: TfrmCoverSearch;
  nbThreads: integer;

implementation

{$R *.dfm}
{ tListObj }
uses
  uTestGrid;

constructor tListObj.create(pkey: String);
begin
  inherited create;
  sKey := pkey;
  sResults := tStringList.create;
  page := 1;
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
  sg1.RowCount := 2;
  setGridTitles;
end;

procedure TForm2.clearImgGrid;
var
  r, c: integer;
begin
  r := 0;
  while r <= sgImg.RowCount - 1 do
  begin
    c := 0;
    while c <= sgImg.colCount - 1 do
    begin
      sgImg.cells[c, r] := '';
      if sgImg.HasPicture(c, r) then
        sgImg.RemovePicture(c, r);
      if sgImg.HasProgress(c, r) then
        sgImg.RemoveProgress(c, r);
      inc(c);
    end;
    inc(r);
  end;
  sgImg.RowCount := 1;

  r := 0;
  while r <= sgProgress.RowCount - 1 do
  begin
    if sgProgress.HasProgress(1, r) then
      sgProgress.RemoveProgress(1, r);
    sgProgress.cells[0, r] := '';
    inc(r)
  end;

  sgProgress.RowCount := 1;

end;

procedure TForm2.displayPicture(iCol, iRow: integer; aPicture: tpicture);
begin
  sgImg.RemoveProgress(iCol, iRow);
  sgImg.AddPicture(iCol, iRow, aPicture, false, tStretchMode.Shrink, 2,
    haCenter, vaCenter);
end;

procedure TForm2.displayStatus(iCol, iRow: integer; sStatus: integer);
begin
  // update status
  // sg1.cells[iCol, iRow] := sStatus;
  sg1.AddImageIdx(iCol, iRow, sStatus, haCenter, vaCenter);
  application.ProcessMessages;
end;

procedure TForm2.endOfSearch(iRow: integer);
begin
  sg1.cells[4, iRow] := 'termin�';
end;

procedure TForm2.FormResize(sender: tobject);
begin
  postmessage(self.handle, WM_RESIZE_GRID, 0, 0);
end;

procedure TForm2.FormShow(sender: tobject);
begin
  postmessage(self.handle, WM_RESIZE_GRID, 0, 0);
end;

function TForm2.getKey(iRow: integer): String;
begin
  result := sg1.cells[1, iRow] + ' ' + sg1.cells[2, iRow];
  if trim(result) = '' then
    result := sg1.cells[0, iRow];
end;

procedure TForm2.launchSearch(nRow, nStartPage: integer;
  const bPostAction: boolean = false);
var
  pSearchThread: tSearchThread;
begin
  pSearchThread := tSearchThread.create(nRow);
  pSearchThread.fOnDisplayStatus := displayStatus;
  pSearchThread.fOnGetKey := getKey;
  pSearchThread.fOnSetResults := SetResults;
  if bPostAction then
    pSearchThread.postAction := btnLoadResultsClick;
  pSearchThread.startPage := nStartPage;
  pSearchThread.Start;
end;

procedure TForm2.resizeGrid(var m: tMessage);
begin
  //sg1.Width := clientWidth div 2;
  pnCovers.Width := clientWidth div 2;
  sSplitter1Resize(Nil);
end;

procedure TForm2.sButton1Click(sender: tobject);
var
  pListObj: tListObj;
begin
  if sPathDialog1.Execute then
  begin
    clearGrid;
    AddFolderToGrid(sPathDialog1.Path);
  end;
end;

procedure TForm2.sButton2Click(sender: tobject);
var
  iRow: integer;
  nStart: integer;
begin
  // load 10 next images
  iRow := sg1.row;
  nStart := tListObj(sg1.Objects[0, iRow]).page;
  if nStart > 1 then
  begin
    dec(nStart, 10);
    tListObj(sg1.Objects[0, iRow]).page := nStart;
    launchSearch(iRow, nStart, true);
  end;

end;

procedure TForm2.sButton3Click(sender: tobject);
var
  iRow: integer;
  nStart: integer;
begin
  // load 10 next images
  iRow := sg1.row;
  nStart := tListObj(sg1.Objects[0, iRow]).page;
  inc(nStart, 10);
  tListObj(sg1.Objects[0, iRow]).page := nStart;
  launchSearch(iRow, nStart, true);
end;

procedure TForm2.sButton4Click(sender: tobject);
begin
  // test resize
  sgProgress.visible := not sgProgress.visible;


end;

procedure TForm2.sButton5Click(Sender: TObject);
var
  pTestGrid : tfTestGrid;
begin
   pTestGrid := tfTestGrid.create(self);
   pTestGrid.ShowModal;
   pTestGrid.Free;
end;

procedure TForm2.setGridTitles;
begin
  sg1.cells[0, 0] := 'File Name';
  sg1.cells[1, 0] := 'Artist';
  sg1.cells[2, 0] := 'Title';
  sg1.cells[3, 0] := 'Genre';
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
    sg1.cells[3, ARow] := pMediaFile.Tags.GetTag('GENRE');
    result := ARow;

  finally
  end;

  application.ProcessMessages;
end;

procedure TForm2.btSearchClick(sender: tobject);
var
  r: integer;
  pSearchThread: tSearchThread;
begin
  //smemo1.Clear;
  r := 1;
  while r <= sg1.RowCount - 1 do
  begin
    launchSearch(r, 1);
    inc(r);
  end;

end;

procedure TForm2.btnLoadResultsClick(sender: tobject);
var
  GlobalMediaFile: tMediaFile;
  iRow: integer;
  pDownloadThread: tDownloadThread;
  i: integer;
  r, c: integer;
  rp: integer;
  sUrl: String;

  procedure getRowProgress;
  var
    cellNotEmpty: boolean;
  begin
    cellNotEmpty := (sgProgress.cells[0, rp] <> '');
    if cellNotEmpty then
    begin
      inc(rp);
      sgProgress.RowCount := sgProgress.RowCount + 1;
    end;
  end;

  procedure getRowCol;
  var
    cellNotEmpty: boolean;
  begin
    cellNotEmpty := (sgImg.HasPicture(c, r) or sgImg.HasProgress(c, r));
    if cellNotEmpty then
    begin
      inc(c);
      if c > 2 then
      begin
        inc(r);
        sgImg.RowCount := sgImg.RowCount + 1;
        c := 0;
      end;
    end;
  end;

begin
  iRow := sg1.row;
  if sg1.Objects[1, iRow] <> Nil then
    GlobalMediaFile := tMediaFile(sg1.Objects[1, iRow]);
  (*
    * Create & launch download threads.
  *)

  // Clear grid;
  clearImgGrid;
  sgProgress.visible := true;
  i := 0; // init url counter
  c := 0; // init column
  r := 0; // init row;
  rp := 0; // init row Progress;
  nbThreads := 0;
  while (i <= tListObj(sg1.Objects[0, sg1.row]).sResults.count - 1) and
    (i <= 9) do
  begin
    // Create new cell(img)
    inc(nbThreads);
    getRowCol;
    getRowProgress;
    sUrl := tListObj(sg1.Objects[0, sg1.row]).sResults[i];
    sgImg.Ints[c, r] := 0;
    sgImg.AddProgress(c, r, clNavy, clWhite);
    sgProgress.AddProgress(1, rp, clNavy, clWhite);
    sgProgress.cells[0, rp] := 'Image ' + inttostr(i + 1);
    pDownloadThread := tDownloadThread.create(c, r, sUrl);
    pDownloadThread.fUpdateProgress := UpdateProgress;
    pDownloadThread.displayPicture := displayPicture;
    pDownloadThread.updateRow := rp;
    pDownloadThread.onTerminate := terminateDownloadThread;
    pDownloadThread.Start;
    inc(i);
  end;

end;

procedure TForm2.SetResults(iRow: integer; results: string);
var
  pListObj: tListObj;
begin
  pListObj := tListObj(sg1.Objects[0, iRow]);
  pListObj.sResults.Text := results;
end;

procedure TForm2.sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := aCol > 0;
end;

procedure TForm2.sg1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

begin
  if key = VK_RETURN then
  begin
    if not (goEditing in sg1.Options) then
    begin
       removeKeyFromStack;
       sg1.Options := sg1.Options - [goRowSelect];
       sg1.Options := sg1.Options + [goEditing];
       sg1.Col := 1;
       sg1.EditMode := true;
       sg1.EditorMode := true;
    end;
  end;
  if key = VK_ESCAPE then
  begin
    if(goEditing in sg1.Options) then
    begin
       removeKeyFromStack;
       sg1.EditMode := false;
       sg1.EditorMode := false;
       sg1.Options := sg1.Options + [goRowSelect];
       sg1.Options := sg1.Options - [goEditing];
    end;
  end;
end;

procedure TForm2.sRollOutPanel2AfterExpand(Sender: TObject);
begin
  sSplitter1Resize(Sender);
end;

procedure TForm2.removeKeyFromStack;
var
  Mgs: TMsg;
begin
  PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TForm2.sSplitter1Resize(sender: tobject);
var
  c, ColWidth: integer;
  cliWidth: integer;
begin
  // resize de cells in grid
  cliWidth := clientWidth - sg1.Width;
  ColWidth := (cliWidth - 36) div 3;
  c := 0;
  sgImg.DefaultRowHeight := (sgImg.Height - 36) div 3;
  while c <= sgImg.colCount - 1 do
  begin
    sgImg.ColWidths[c] := ColWidth;
    inc(c);
  end;
end;

procedure TForm2.terminateDownloadThread;
begin
  dec(nbThreads);
  sgProgress.visible := (nbThreads > 0);
end;

procedure TForm2.UpdateProgress(iCol, iRow, percent: integer);
begin
  // sgImg.Ints[iCol, iRow] := percent;
  sgProgress.Ints[iCol, iRow] := percent;
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
  if assigned(postAction) then
    postAction(nil);

  inherited;
end;

procedure tSearchThread.Execute;
var
  sKey: String;
  xResult: ISuperObject;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: integer;
  lResults: tStrings;

begin
  inherited;
  lResults := tStringList.create;
  fOnDisplayStatus(4, row, 2);
  sKey := fOnGetKey(row);
  sKey := sKey + ' disk cover';

  GS := tGoogleSearch.create(sKey, startPage);
  // GS := tGoogleSearchFree.create;
  fOnDisplayStatus(4, row, 1);
  // xResult := GS.getImages(sKey);
  xResult := GS.getImages;
  jsArray := xResult.A[GS_ITEMS];

  while (i <= jsArray.Length - 1) do
  begin
    lResults.Add(jsArray.O[i].S[GS_LINK]);
    inc(i);
  end;
  GS.Free;
  sleep(1000);
  fOnSetResults(row, lResults.Text);
  terminate;
end;

{ tDownloadThread }

constructor tDownloadThread.create(iCol, iRow: integer; pUrl: string);
begin
  inherited create(true);
  FreeOnTerminate := true;
  fCol := iCol;
  fRow := iRow;
  fUrl := pUrl;

end;

procedure tDownloadThread.DoTerminate;
begin
  inherited;
  if assigned(fTerminate) then
    fTerminate;
end;

procedure tDownloadThread.downloadImage(sUrl: string);
var
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: tMemoryStream;
  jpgImg: TJPEGImage;
  picture: tpicture;
begin

  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 5000;
  IdHTTP1.IOHandler := IdSSL;
  IdHTTP1.Request.Accept :=
    'text/html, image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, image/png, */*';
  IdHTTP1.Request.AcceptEncoding := 'gzip, deflate';
  IdHTTP1.Request.UserAgent := 'Mozilla/5.0';
  IdHTTP1.onWork := onWork;
  IdHTTP1.onWorkBegin := onWorkBegin;
  IdHTTP1.onWorkEnd := onWorkEnd;
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  try
    MS := tMemoryStream.create;
    jpgImg := TJPEGImage.create;
    try
      IdHTTP1.Get(sUrl, MS);
      application.ProcessMessages;
      MS.Seek(0, soFromBeginning);
      jpgImg.LoadFromStream(MS);
      picture := tpicture.create;
      picture.Bitmap.Assign(jpgImg);
      // fGrid.AddPicture(fCol, fRow, Picture, false, tStretchMode.Shrink, 2, haCenter, vaCenter);
      displayPicture(fCol, fRow, picture);
    except
      on e: exception do
      begin
        // Memo1.Lines.Add('erreur '+e.Message);
      end;
    end;
  finally
    FreeAndNil(MS);
    FreeAndNil(jpgImg);
    IdHTTP1.Free;
    IdSSL.Free;
    if not terminated then
      terminate;
  end;

end;

procedure tDownloadThread.Execute;
begin
  inherited;
  fUpdateProgress(1, updateRow, 0);
  downloadImage(fUrl);
  while not terminated do
  begin
    application.ProcessMessages;
  end;
end;

procedure tDownloadThread.onWork(ASender: tobject; AWorkMode: TWorkMode;
  AWorkCount: Int64);

begin
  fPos := round(AWorkCount / fMax * 100);
  // fUpdateProgress(fCol, fRow, fPos);
  fUpdateProgress(1, updateRow, fPos);
end;

procedure tDownloadThread.onWorkBegin(ASender: tobject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  fMax := AWorkCountMax;
  fPos := 0;
  fUpdateProgress(1, fRow, fPos);
end;

procedure tDownloadThread.onWorkEnd(ASender: tobject; AWorkMode: TWorkMode);
begin
  // fUpdateProgress(1, fRow, 0);
end;

end.
