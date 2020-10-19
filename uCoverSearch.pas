unit uCoverSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls,
  sLabel, Vcl.Grids, JvExGrids, JvStringGrid, sEdit, JvComponentBase,
  JvThread, IdComponent, uSearchImage, xSuperObject,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding,
  JPEG, PNGImage, GIFImg, TagsLibrary, utypes, acImage, sButton, AdvUtil, AdvObj, BaseGrid, AdvGrid, IdBaseComponent, sScrollBox;

type

  tREfreshCell0 = procedure(aCol, aRow: Integer) of object;

  tDownloadThread = class(TThread)
  private
    fMax: Integer;
    fPos: Integer;
    fCol: Integer;
    fRow: Integer;
    fGrid: tAdvStringGrid;
    fRefreh: tREfreshCell0;
    procedure downloadImage(sUrl: string);
  protected
    procedure Execute; override;
  public
    procedure onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    constructor create(aCol, aRow: Integer; aGrid: tAdvStringGrid; CallBack: tREfreshCell0); reintroduce;
  end;

  TfCoverSearch = class(TForm)
    sRollOutPanel1: TsRollOutPanel;
    seArtist: TsEdit;
    seTitle: TsEdit;
    sPanel1: TsPanel;
    thGetImages: TJvThread;
    sPanel2: TsPanel;
    Image1: TsImage;
    bsApply: TsButton;
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    sButton1: TsButton;
    sButton2: TsButton;
    sSBCovers: TsScrollBox;
    sPNRow0: TsPanel;
    sPnRow1: TsPanel;
    sPnRow2: TsPanel;
    sBtnNext: TsButton;
    sBtnPrev: TsButton;
    procedure thGetImagesExecute(Sender: TObject; Params: Pointer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure sButton1Click(Sender: TObject);
    procedure bsApplyClick(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sBtnNextClick(Sender: TObject);
    procedure sBtnPrevClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

    { Déclarations privées }
  public
    { Déclarations publiques }
    artist, title: string;
    sFile: String;
    pHandle: tHandle;
    iStart: Integer;
    procedure StartSearch(const start: Integer = 1);
    procedure downloadImage(sUrl: string);
    procedure onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure SaveTags(Sender: TObject);
    procedure refreshCell0(aCol, aRow: Integer);
    procedure removeFrames;
    procedure ImageClick(Sender: TObject);
    procedure GetImage(sNum: String);
  end;

var
  fCoverSearch: TfCoverSearch;
  gCol, gRow: Integer;

implementation

uses
  uFrameCover;
{$R *.dfm}

procedure TfCoverSearch.FormCreate(Sender: TObject);
begin
  if not isRegistered then
  begin
    bsApply.Enabled := isRegistered;
    bsApply.Caption := bsApply.Caption + ' (unregistered)';
  end;
{$IFNDEF DEBUG}
  Memo1.visible := false;
{$ENDIF}
  iStart := 1;
end;

procedure TfCoverSearch.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(seTitle.Focused or seArtist.Focused) then
  begin
    if Key = VK_RIGHT then
      sBtnNextClick(nil);
    if Key = VK_LEFT then
      sBtnPrevClick(nil);
  end;
end;

procedure TfCoverSearch.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not(seTitle.Focused or seArtist.Focused) then
  begin
    case Key of
      '1' .. '9':
        begin
          GetImage(Key);
        end;
    end;
  end;
end;

procedure TfCoverSearch.FormShow(Sender: TObject);
begin
  seArtist.Text := artist;
  seTitle.Text := title;
  sSBCovers.SetFocus;
{$IFDEF DEBUG}
  Memo1.Clear;
{$ENDIF}
  StartSearch;
end;

procedure TfCoverSearch.GetImage(sNum: String);
var
  aComponent: tComponent;
  aFrame: tFrameCover;
begin
  aComponent := sSBCovers.FindComponent('aFrameCover' + sNum);
  if aComponent <> Nil then
  begin
    aFrame := tFrameCover(aComponent);
    ImageClick(aFrame.sImage1);
  end;
end;

procedure TfCoverSearch.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Memo1.Lines.Add(format('Work %d', [AWorkCount]));
end;

procedure TfCoverSearch.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  Memo1.Lines.Add(format('WorkBegin %d', [AWorkCountMax]));
end;

procedure TfCoverSearch.IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  Memo1.Lines.Add('WorkEnd');
end;

procedure TfCoverSearch.ImageClick(Sender: TObject);
var
  aFrame: tFrame;
begin
  if TsImage(Sender).Owner.ClassName = 'tFrameCover' then
  begin
    aFrame := tFrameCover(TsImage(Sender).Owner);
    Memo1.Lines.Add(aFrame.Name);
    Image1.Picture.Assign(TsImage(Sender).Picture);
  end;
end;

procedure TfCoverSearch.onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin

end;

procedure TfCoverSearch.onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin

end;

procedure TfCoverSearch.refreshCell0;
begin
end;

procedure TfCoverSearch.removeFrames;
var
  aFrame: tFrameCover;
  procedure remove(aPanel: TsPanel);
  begin
    while sSBCovers.ComponentCount > 0 do
    begin
      if sSBCovers.Components[0].ClassNameIs('tFrameCover') then
      begin
        aFrame := tFrameCover(sSBCovers.Components[0]);
        aFrame.Free;
      end;
    end;
  end;

begin
  sSBCovers.SkinData.BeginUpdate;
  remove(sPNRow0);
  // remove(sPnRow1);
  // remove(sPnRow2);
  sSBCovers.SkinData.EndUpdate(true);

end;

procedure TfCoverSearch.sButton1Click(Sender: TObject);
begin
  StartSearch(iStart);
end;

procedure TfCoverSearch.sButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfCoverSearch.sBtnNextClick(Sender: TObject);
begin
  Inc(iStart, 10);
  StartSearch(iStart);
end;

procedure TfCoverSearch.sBtnPrevClick(Sender: TObject);
begin
  Dec(iStart, 10);
  if iStart < 1 then
    iStart := 1;
  StartSearch(iStart);
end;

procedure TfCoverSearch.SaveTags(Sender: TObject);
var
  PictureStream: tMemoryStream;
  Description: String;
  MIMEType: String;
  JPEGPicture: TJPEGImage;
  PNGPicture: TPNGImage;
  GIFPicture: TGIFImage;
  BMPPicture: TBitmap;
  Width, Height: Integer;
  NoOfColors: Integer;
  ColorDepth: Integer;
  PictureMagic: Word;
  CoverArtPictureFormat: TTagPictureFormat;
  CoverArt: TCoverArt;
  pMediaFile: tMediaFile;
begin
  // * Clear the cover art data
  MIMEType := '';
  Description := '';
  Width := 0;
  Height := 0;
  ColorDepth := 0;
  NoOfColors := 0;
  CoverArtPictureFormat := TTagPictureFormat.tpfUnknown;

  try

    try
      MIMEType := 'image/jpeg';
      CoverArtPictureFormat := tpfJPEG;
      JPEGPicture := TJPEGImage.create;
      try
        JPEGPicture.Assign(Image1.Picture.Bitmap);
        Width := JPEGPicture.Width;
        Height := JPEGPicture.Height;
        NoOfColors := 0;
        ColorDepth := 24;
      finally
        FreeAndNil(JPEGPicture);
      end;
      PictureStream := tMemoryStream.create;
      Image1.Picture.Bitmap.SaveToStream(PictureStream);
      PictureStream.Position := 0;
      pMediaFile := tMediaFile.create(sFile);
      // * Add the cover art
      CoverArt := pMediaFile.Tags.AddCoverArt('cover');
      CoverArt.CoverType := 3; // * ID3v2 cover type (3: front cover)
      CoverArt.MIMEType := MIMEType;
      CoverArt.Description := Description;
      CoverArt.Width := Width;
      CoverArt.Height := Height;
      CoverArt.ColorDepth := ColorDepth;
      CoverArt.NoOfColors := NoOfColors;
      CoverArt.PictureFormat := CoverArtPictureFormat;
      CoverArt.Stream.CopyFrom(PictureStream, PictureStream.Size);
      pMediaFile.SaveTags;
    finally
      FreeAndNil(PictureStream);
      PostMessage(Application.MainForm.Handle, WM_REFRESH_COVER, 0, 0);
      Close;
    end;
  except

  end;
end;

procedure TfCoverSearch.bsApplyClick(Sender: TObject);
begin
  // SaveTags(Sender);
  PostMessage(Application.MainForm.Handle, WM_REFRESH_COVER, 0, 0);
  Close;
end;

procedure TfCoverSearch.downloadImage(sUrl: string);
var
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: tMemoryStream;
  jpgImg: TJPEGImage;
  Bitmap: TBitmap;
begin
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 15000;
  IdHTTP1.IOHandler := IdSSL;
  IdHTTP1.request.AcceptEncoding := 'gzip,deflate';
  IdHTTP1.onWork := IdHTTP1Work;
  IdHTTP1.onWorkBegin := IdHTTP1WorkBegin;
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  try
    MS := tMemoryStream.create;
    jpgImg := TJPEGImage.create;
    try
      IdHTTP1.Get(sUrl, MS);
      Application.ProcessMessages;
      MS.Seek(0, soFromBeginning);
      jpgImg.LoadFromStream(MS);
      Image1.Picture.Assign(jpgImg)
    except
      on e: exception do
      begin
        Memo1.Lines.Add('erreur ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(MS);
    FreeAndNil(jpgImg);
    IdHTTP1.Free;
    IdSSL.Free;
  end;
end;

procedure TfCoverSearch.StartSearch(const start: Integer);
var
  aGoogleSearch: tGoogleSearch;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  webResult: String;
  pMediaImg: tMediaImg;
  Col, Row: Integer;
  nbPass: Integer;
  Key2: String;
  aFrameCover: tFrameCover;
  aParentPanel: TsPanel;
  iPanelNumber: Integer;

  procedure addToGrid;
  const
    sPanelName = 'sPnRow%d';
  var
    thDownload: tDownloadThread;
  begin
    i := 0;
    Memo1.Lines.Add('addToGrid ' + inttostr(i));
    sSBCovers.SkinData.BeginUpdate;
    while i <= jsArray.length - 1 do
    // while i <= 2 do
    begin

      pMediaImg := tMediaImg.create;
      pMediaImg.TNLink := jsArray.O[i].S[GS_THUMBNAILLINK];
      pMediaImg.Link := jsArray.O[i].S[GS_LINK];


      iPanelNumber := round(i div 3);
      aParentPanel := TsPanel(self.FindComponent(format(sPanelName, [iPanelNumber])));
      aFrameCover := tFrameCover.create(sSBCovers);
      aFrameCover.Name := 'aFrameCover' + inttostr(i + 1);
      aFrameCover.sUrl := jsArray.O[i].S[GS_LINK];
      aFrameCover.sLabel1.Caption := inttostr(i + 1);
      aFrameCover.sImage1.OnClick := ImageClick;
      aFrameCover.Left := 1000;
      aFrameCover.parent := aParentPanel;

      aFrameCover.StartDownload;
      Inc(i);
    end;
    sSBCovers.SkinData.EndUpdate(true);
  end;

begin

  removeFrames;
  sBtnPrev.Enabled := (start > 1);
  Col := 0;
  Row := 0;

  nbPass := 0;
{$IFDEF DEBUG}
  Memo1.Lines.Add(inttostr(nbPass) + ' Begin : ' + formatdatetime('hh:nn:ss:zzz', time));
{$ENDIF}
  Key2 := seTitle.Text;
  if seTitle.BoundLabel.Caption = 'Title' then
    Key2 := Key2 + ' cover';

  aGoogleSearch := tGoogleSearch.create(seArtist.Text + ' ' + Key2, start);
  jsResult := aGoogleSearch.getImages;
  jsArray := jsResult.A[GS_ITEMS];

{$IFDEF DEBUG}
  Memo1.Lines.Add(inttostr(nbPass) + 'End : ' + formatdatetime('hh:nn:ss:zzz', time));
{$ENDIF}
  addToGrid;

end;

procedure TfCoverSearch.thGetImagesExecute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: tMemoryStream;
  jpgImg: TJPEGImage;
  Bitmap: TBitmap;
  sg1: tAdvStringGrid;
  Col, Row: Integer;

begin
  //
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 2500;
  IdHTTP1.IOHandler := IdSSL;
  IdHTTP1.onWorkBegin := onWorkBegin;
  IdHTTP1.onWork := onWork;
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  Row := 0;
  while Row <= sg1.RowCount - 1 do
  begin
    try
      try
        Col := 0;
        while Col <= sg1.ColCount - 1 do
        begin
          if sg1.Objects[Col, Row] <> nil then
          begin
            if tMediaImg(sg1.Objects[Col, Row]).Bitmap = nil then
            begin
              MS := tMemoryStream.create;
              jpgImg := TJPEGImage.create;
              sg1.AddProgress(Col, Row, clGreen, clWhite);
              IdHTTP1.Get(tMediaImg(sg1.Objects[Col, Row]).Link, MS);

              MS.Seek(0, soFromBeginning);
              jpgImg.LoadFromStream(MS);

              tMediaImg(sg1.Objects[Col, Row]).Bitmap := tPicture.create;
              tMediaImg(sg1.Objects[Col, Row]).Bitmap.Assign(jpgImg);
             // resize img
              sg1.Refresh;
              Application.ProcessMessages;
            end;
          end;
          Inc(Col);
        end;
      except
        on e: exception do
        begin
          // sMemo1.Lines.Add('   EXCEPTION: ' + E.Message);
        end;
      end;
      Inc(Row)
    finally
      FreeAndNil(jpgImg);
      FreeAndNil(MS);

    end;

  end;

end;

{ tDownloadThread }

constructor tDownloadThread.create(aCol, aRow: Integer; aGrid: tAdvStringGrid; CallBack: tREfreshCell0);
begin
  inherited create(true);
  FreeOnTerminate := true;
  fCol := aCol;
  fRow := aRow;
  fGrid := aGrid;
  fRefreh := CallBack;
  fGrid.AddProgress(fCol, fRow, clGreen, clWhite);
end;

procedure tDownloadThread.downloadImage(sUrl: string);
var
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: tMemoryStream;
  jpgImg: TJPEGImage;
  Picture: tPicture;
begin
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 5000;
  IdHTTP1.IOHandler := IdSSL;
  IdHTTP1.request.AcceptEncoding := 'gzip,deflate';
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
      Application.ProcessMessages;
      MS.Seek(0, soFromBeginning);
      jpgImg.LoadFromStream(MS);
      Picture := tPicture.create;
      Picture.Bitmap.Assign(jpgImg);
      fGrid.AddPicture(fCol, fRow, Picture, false, tStretchMode.Shrink, 2, haCenter, vaCenter);
    except
      on e: exception do
      begin
        // Memo1.Lines.Add('erreur '+e.Message);
      end;
    end;
  finally
    fGrid.Cells[fCol, fRow] := '';
    fGrid.RemoveProgress(fCol, fRow);
    FreeAndNil(MS);
    FreeAndNil(jpgImg);
    IdHTTP1.Free;
    IdSSL.Free;
    if (fCol = 0) and (fRow = 0) then
    begin
      fRefreh(fCol, fRow);
    end;
    if not terminated then
      terminate;
  end;

end;

procedure tDownloadThread.Execute;
var
  url: string;
begin
  inherited;
  url := tMediaImg(fGrid.Objects[fCol, fRow]).Link;
  downloadImage(url);
  while not terminated do
  begin
    Application.ProcessMessages;
  end;
end;

procedure tDownloadThread.onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  p: Integer;
begin
  p := round(AWorkCount / fMax * 100);
  fGrid.Ints[fCol, fRow] := p;
end;

procedure tDownloadThread.onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  fMax := AWorkCountMax;
  fPos := 0;

end;

procedure tDownloadThread.onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  // Download finished
  fGrid.Ints[fCol, fRow] := 0;

end;

end.
