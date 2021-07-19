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
  IdComponent, JPEG, PNGImage, GIFImg,
  Vcl.ExtCtrls, sPanel, sSkinProvider, sSkinManager, acPathDialog,
  System.ImageList, Vcl.ImgList, acAlphaImageList, uFrmCoverSearch, sSplitter,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding;

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
  tPostAction = procedure(sender : tobject) of object;

  (*
    *
    * Download images callbacks
    *
  *)
  tUpdateprogress = procedure(iCol, iRow, percent: integer) of object;
  tDisplayPicture = procedure(iCol, iRow: integer; picture: tpicture) of object;

  tSearchThread = class(tThread)
  private
    endSearch: tSearchCallback;
    fOnDisplayStatus: tDisplayStatus;
    fOnGetKey: tGetKey;
    fOnSetResults: tSetResults;
    fPostAction : tPostAction;
    fStart : Integer;
    row: integer;
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
    property postAction : tPostAction read fPostAction write fPostAction;
    property startPage : integer read fStart write fStart;
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
    fUrl: String;

  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    procedure onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    constructor create(iCol, iRow: integer; pUrl: string); reintroduce;
    property UpdateProgress: tUpdateprogress read fUpdateProgress
      write fUpdateProgress;
    property displayPicture: tDisplayPicture read fDisplayPicture
      write fDisplayPicture;
    procedure downloadImage(sUrl: string);
  end;

  tListObj = class(tPersistent)
  public
    sKey: String;
    sResults: tStrings;
    page : integer;
    constructor create(pkey: String);
    destructor destroy;
  end;

  TForm2 = class(TForm)
    sButton1: TsButton;
    sg1: TAdvStringGrid;
    btSearch: TsButton;
    btnLoadResults: TsButton;
    sPanel1: TsPanel;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sPathDialog1: TsPathDialog;
    sAlphaImageList1: TsAlphaImageList;
    sPnVariable: TsPanel;
    sPanel2: TsPanel;
    sSplitter1: TsSplitter;
    sgImg: TAdvStringGrid;
    pnOptionsImages: TsPanel;
    sButton2: TsButton;
    sButton3: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure btnLoadResultsClick(Sender: TObject);
    procedure sSplitter1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure addToGrid(pkey: String; pObj: tListObj);
    procedure clearGrid;
    procedure AddFolderToGrid(sFolder: String);
    function AddFileToGrid(sFile: String): integer;
    procedure clearImgGrid;
    procedure launchSearch(nRow : Integer; nStartPage : Integer);
  public
    { Déclarations publiques }
    procedure endOfSearch(iRow: integer);
    procedure displayStatus(iCol, iRow: integer; sStatus: integer);
    function getKey(iRow: integer): String;
    procedure SetResults(iRow: integer; results: string);
    Procedure UpdateProgress(iCol, iRow, percent: integer);
    procedure displayPicture(iCol, iRow: integer; aPicture: tpicture);
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
  sg1.RowCount := 1;

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
  sg1.cells[4, iRow] := 'terminé';
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  sPanel2.Width := self.ClientWidth div 2;
end;

function TForm2.getKey(iRow: integer): String;
begin
  result := sg1.cells[1, iRow] + ' ' + sg1.cells[2, iRow];
  if trim(result) = '' then
    result := sg1.cells[0, iRow];
end;

procedure TForm2.launchSearch(nRow, nStartPage: Integer);
var
   pSearchThread : tSearchThread;
begin
    pSearchThread := tSearchThread.create(nRow);
    pSearchThread.fOnDisplayStatus := displayStatus;
    pSearchThread.fOnGetKey := getKey;
    pSearchThread.fOnSetResults := SetResults;
    pSearchThread.postAction := btnLoadResultsClick;
    pSearchThread.startPage := nStartPage;
    pSearchThread.Start;
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

procedure TForm2.sButton3Click(Sender: TObject);
var
   iRow : Integer;
   nStart : Integer;
begin
    // load 10 next images
    iRow := sg1.row;
    nStart := tListObj(sg1.objects[0,iRow]).page;
    inc(nStart,10);
    tListObj(sg1.objects[0,iRow]).page := nStart;
    launchSearch(iRow,nStart);
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
    pSearchThread.startPage := 1;
    pSearchThread.Start;
    inc(r);
  end;

end;

procedure TForm2.btnLoadResultsClick(Sender: TObject);
var
  GlobalMediaFile: tMediaFile;
  iRow: integer;
  pDownloadThread: tDownloadThread;
  i: integer;
  r, c: integer;
  sUrl: String;

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
  i := 0; // init url counter
  c := 0; // init column
  r := 0; // init row;
  while (i <= tListObj(sg1.Objects[0, sg1.row]).sResults.count - 1) and
    (i <= 9) do
  begin
    // Create new cell(img)
    getRowCol;
    sUrl := tListObj(sg1.Objects[0, sg1.row]).sResults[i];
    sgImg.Ints[c, r] := 0;
    sgImg.AddProgress(c, r, clNavy, clWhite);
    pDownloadThread := tDownloadThread.create(c, r, sUrl);
    pDownloadThread.fUpdateProgress := UpdateProgress;
    pDownloadThread.displayPicture := displayPicture;
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

procedure TForm2.sSplitter1Resize(Sender: TObject);
var
  c, ColWidth: integer;
  cliWidth: integer;
begin
  // resize de cells in grid
  cliWidth := ClientWidth - sg1.Width - sSplitter1.Width;
  ColWidth := (cliWidth - 36) div 3;
  c := 0;
  sgImg.DefaultRowHeight := (sgImg.Height - 36) div 3;
  while c <= sgImg.colCount - 1 do
  begin
    sgImg.ColWidths[c] := ColWidth;
    inc(c);
  end;
end;

procedure TForm2.UpdateProgress(iCol, iRow, percent: integer);
begin
  sgImg.Ints[iCol, iRow] := percent;
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
  if assigned(PostAction) then
     PostAction(nil);

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
  skey := skey + ' cover';

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
  IdHTTP1.Request.Accept := 'text/html, image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, image/png, */*';
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
  downloadImage(fUrl);
  while not terminated do
  begin
    application.ProcessMessages;
  end;
end;

procedure tDownloadThread.onWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);

begin
  fPos := round(AWorkCount / fMax * 100);
  fUpdateProgress(fCol, fRow, fPos);

end;

procedure tDownloadThread.onWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  fMax := AWorkCountMax;
  fPos := 0;
  fUpdateProgress(fCol, fRow, fPos);
end;

procedure tDownloadThread.onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  fUpdateProgress(fCol, fRow, 0);
end;

end.
