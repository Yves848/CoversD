unit uCoverSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls,
  sLabel, Vcl.Grids, JvExGrids, JvStringGrid, sEdit, JvComponentBase,
  JvThread, IdComponent, uSearchImage, xSuperObject,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding,
  JPEG, PNGImage, GIFImg, TagsLibrary, utypes, acImage, sButton, AdvUtil, AdvObj, BaseGrid, AdvGrid, IdBaseComponent;

type
  tDownloadThread = class(TThread)
  private
    fMax: Integer;
    fPos: Integer;
    fCol: Integer;
    fRow: Integer;
    fGrid: tAdvStringGrid;
    procedure downloadImage(sUrl: string);
  protected
    procedure Execute; override;
  public
    procedure onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    constructor create(aCol, aRow: Integer; aGrid: tAdvStringGrid); reintroduce;
  end;

  TfCoverSearch = class(TForm)
    sRollOutPanel1: TsRollOutPanel;
    sLabel1: TsLabel;
    seArtist: TsEdit;
    seTitle: TsEdit;
    sLabel2: TsLabel;
    sPanel1: TsPanel;
    thGetImages: TJvThread;
    sPanel2: TsPanel;
    Image1: TsImage;
    bsApply: TsButton;
    Memo1: TMemo;
    sg1: tAdvStringGrid;
    IdHTTP1: TIdHTTP;
    sButton1: TsButton;
    procedure thGetImagesExecute(Sender: TObject; Params: Pointer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure sg1ClickCell(Sender: TObject; aRow, aCol: Integer);
    procedure sButton1Click(Sender: TObject);
    procedure bsApplyClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    artist, title: string;
    sFile : String;
    pHandle : tHandle;
    procedure StartSearch;
    procedure downloadImage(sUrl: string);
    procedure onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure SaveTags(Sender: TObject);
  end;

var
  fCoverSearch: TfCoverSearch;
  gCol, gRow: Integer;

implementation

{$R *.dfm}

procedure TfCoverSearch.FormCreate(Sender: TObject);
begin
  if not isRegistered then
  begin
    bsApply.Enabled := isRegistered;
    bsApply.Caption := bsApply.Caption + ' (unregistered)';
  end;

end;

procedure TfCoverSearch.FormShow(Sender: TObject);
begin
  seArtist.Text := artist;
  seTitle.Text := title;
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

procedure TfCoverSearch.onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin

end;

procedure TfCoverSearch.onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin

end;

procedure TfCoverSearch.sButton1Click(Sender: TObject);
begin
  StartSearch;
end;

procedure TfCoverSearch.sg1ClickCell(Sender: TObject; aRow, aCol: Integer);
var
  Picture: tPicture;
begin
  if sg1.Objects[aCol, aRow] <> nil then
  begin
    // downloadImage(tMediaImg(sg1.Objects[aCol,aRow]).Link);
    Picture := sg1.GetPicture(aCol, aRow);
    Image1.Picture.Assign(Picture);
  end;
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
  pMediaFile : tMediaFile;
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
        JPEGPicture.Assign(image1.Picture.Bitmap);
        Width := JPEGPicture.Width;
        Height := JPEGPicture.Height;
        NoOfColors := 0;
        ColorDepth := 24;
      finally
        FreeAndNil(JPEGPicture);
      end;
      PictureStream := tMemorystream.Create;
      Image1.Picture.Bitmap.SaveToStream(PictureStream);
      PictureStream.Position := 0;
      pMediaFile := tMediaFile.Create(sFile);
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
      pMediaFile.Tags.SaveToFile(sFile);
    finally
      FreeAndNil(PictureStream);
      PostMessage(Application.MainForm.Handle, WM_REFRESH_COVER,0,0);
      Close;
    end;
  except

  end;
end;

procedure TfCoverSearch.bsApplyClick(Sender: TObject);
begin
  SaveTags(Sender);
end;

procedure TfCoverSearch.downloadImage(sUrl: string);
var
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: tMemoryStream;
  jpgImg: TJPEGImage;
  BitMap: TBitmap;
begin
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 5000;
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

procedure TfCoverSearch.StartSearch;
var
  aGoogleSearch: tGoogleSearch;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  webResult: String;
  pMediaImg: tMediaImg;
  Col, row: Integer;
  nbPass: Integer;

  procedure addToGrid;
  var
    thDownload: tDownloadThread;
  begin
    i := 0;
    while i <= jsArray.length - 1 do
    // while i <= 2 do
    begin
      if sg1.Objects[Col, row] <> nil then
      begin
        inc(Col);
        if Col > sg1.ColCount - 1 then
        begin
          sg1.RowCount := sg1.RowCount + 1;
          row := sg1.RowCount - 1;
          Col := 0;
        end;
      end;

      pMediaImg := tMediaImg.create;
      pMediaImg.TNLink := jsArray.O[i].S[GS_THUMBNAILLINK];
      pMediaImg.Link := jsArray.O[i].S[GS_LINK];
      sg1.Objects[Col, row] := pMediaImg;
      thDownload := tDownloadThread.create(Col, row, sg1);
      thDownload.Start;
      inc(i);

    end;
  end;

begin
  row := 0;
  while row <= sg1.RowCount - 1 do
  begin
    Col := 0;
    while Col <= sg1.ColCount - 1 do
    begin
      if sg1.Objects[Col, row] <> nil then
      begin
        tMediaImg(sg1.Objects[Col, row]).destroy;
      end;
      inc(Col)
    end;
    inc(row);
  end;

  sg1.Clear;
  sg1.RowCount := 1;
  sg1.ColCount := 3;
  sg1.FixedCols := 0;
  sg1.DefaultColWidth := 250;
  sg1.DefaultRowHeight := 250;
  sg1.ScrollBars := TScrollStyle.ssNone;
  // aNode := sTVMedias.Selected;

  Col := 0;
  row := 0;

  nbPass := 0;
  while nbPass < 1 do
  begin
    Memo1.Clear;
    Memo1.Lines.Add('Begin : ' + formatdatetime('hh:nn:ss:zzz', time));
    aGoogleSearch := tGoogleSearch.create(seArtist.Text + ' ' + seTitle.Text, (nbPass * 10) + 1);
    jsResult := aGoogleSearch.getImages;
    jsArray := jsResult.A[GS_ITEMS];
    Memo1.Lines.Add('End : ' + formatdatetime('hh:nn:ss:zzz', time));
    addToGrid;
    inc(nbPass);
  end;
  // thGetImages.Execute(self);
end;

procedure TfCoverSearch.thGetImagesExecute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: tMemoryStream;
  jpgImg: TJPEGImage;
  BitMap: TBitmap;
  sg1: tAdvStringGrid;
  Col, row: Integer;

begin
  //
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 250;
  IdHTTP1.IOHandler := IdSSL;
  IdHTTP1.onWorkBegin := onWorkBegin;
  IdHTTP1.onWork := onWork;
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  sg1 := TfCoverSearch(Params).sg1;
  row := 0;
  while row <= sg1.RowCount - 1 do
  begin
    try
      try
        Col := 0;
        while Col <= sg1.ColCount - 1 do
        begin
          if sg1.Objects[Col, row] <> nil then
          begin
            if tMediaImg(sg1.Objects[Col, row]).BitMap = nil then
            begin
              MS := tMemoryStream.create;
              jpgImg := TJPEGImage.create;
              sg1.AddProgress(Col, row, clGreen, clWhite);
              IdHTTP1.Get(tMediaImg(sg1.Objects[Col, row]).Link, MS);

              MS.Seek(0, soFromBeginning);
              jpgImg.LoadFromStream(MS);

              tMediaImg(sg1.Objects[Col, row]).BitMap := tPicture.create;
              tMediaImg(sg1.Objects[Col, row]).BitMap.Assign(jpgImg);
              // sg1.AddBitmap(Col, Row,tMediaImg(sg1.Objects[Col, row]).BitMap.Bitmap,false,tCEllHAlign.haCenter, tCellVAlign.vaCenter);
              sg1.AddPicture(Col, row, tMediaImg(sg1.Objects[Col, row]).BitMap, false, tStretchMode.Shrink, 2, haCenter, vaCenter);
              // resize img
              sg1.Refresh;
              Application.ProcessMessages;
            end;
          end;
          inc(Col);
        end;
      except
        on e: exception do
        begin
          // sMemo1.Lines.Add('   EXCEPTION: ' + E.Message);
        end;
      end;
      inc(row)
    finally
      FreeAndNil(jpgImg);
      FreeAndNil(MS);

    end;

  end;

end;

{ tDownloadThread }

constructor tDownloadThread.create(aCol, aRow: Integer; aGrid: tAdvStringGrid);
begin
  inherited create(true);
  FreeOnTerminate := true;
  fCol := aCol;
  fRow := aRow;
  fGrid := aGrid;
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
      Picture.BitMap.Assign(jpgImg);
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
