unit uCoverSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls,
  sLabel, Vcl.Grids, JvExGrids, JvStringGrid, sEdit, JvComponentBase,
  JvThread, IdComponent, uSearchImage, xSuperObject,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding,
  JPEG, PNGImage, GIFImg, TagsLibrary, utypes, acImage, sButton;

type
  TfCoverSearch = class(TForm)
    sRollOutPanel1: TsRollOutPanel;
    sLabel1: TsLabel;
    seArtist: TsEdit;
    seTitle: TsEdit;
    sLabel2: TsLabel;
    sPanel1: TsPanel;
    sg1: TJvStringGrid;
    thGetImages: TJvThread;
    sPanel2: TsPanel;
    Image1: TsImage;
    bsApply: TsButton;
    Memo1: TMemo;
    procedure thGetImagesExecute(Sender: TObject; Params: Pointer);
    procedure sg1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    artist, title: string;
    procedure StartSearch;
    procedure downloadImage(sUrl: string);
  end;

var
  fCoverSearch: TfCoverSearch;

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

procedure TfCoverSearch.sg1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if sg1.Objects[ACol, ARow] <> nil then
  begin
    if tMediaImg(sg1.Objects[ACol, ARow]).BitMap <> nil then
    begin
      if gdSelected in State then
        sg1.Canvas.Brush.Color := clBlue
      else
        sg1.Canvas.Brush.Color := clWhite;
      sg1.Canvas.FillRect(Rect);
      InflateRect(Rect, -5, -5);
      sg1.Canvas.StretchDraw(Rect, tMediaImg(sg1.Objects[ACol, ARow])
        .BitMap.Graphic)
    end;
  end;
end;

procedure TfCoverSearch.sg1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  aMediaImg: tMediaImg;
begin
  // Display the full-size picture
  if sg1.Objects[ACol, ARow] <> nil then
  begin
    aMediaImg := tMediaImg(sg1.Objects[ACol, ARow]);
    downloadImage(aMediaImg.Link);
  end;

end;

procedure TfCoverSearch.downloadImage(sUrl: string);
var
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: TMemoryStream;
  jpgImg: TJPEGImage;
  BitMap: TBitmap;
begin
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP1 := TIdHTTP.Create;
  IdHTTP1.ReadTimeout := 5000;
  IdHTTP1.IOHandler := IdSSL;
  IdHttp1.request.AcceptEncoding:= 'gzip,deflate';
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  try
    MS := TMemoryStream.Create;
    jpgImg := TJPEGImage.Create;
    try
      IdHTTP1.Get(sUrl, MS);
      Application.ProcessMessages;
      MS.Seek(0, soFromBeginning);
      jpgImg.LoadFromStream(MS);
      Image1.Picture.Assign(jpgImg)
    except
      on e: exception do
      begin
         //caption := 'erreur '+e.Message;
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
    begin
      i := 0;
      while i <= jsArray.length - 1 do
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
        pMediaImg := tMediaImg.Create;
        pMediaImg.TNLink := jsArray.O[i].S[GS_THUMBNAILLINK];
        pMediaImg.Link := jsArray.O[i].S[GS_LINK];
        sg1.Objects[Col, row] := pMediaImg;
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
    // aNode := sTVMedias.Selected;

    Col := 0;
    row := 0;

    nbPass := 0;
    while nbPass < 1 do
    begin
      Memo1.Clear;
      Memo1.Lines.Add('Begin : '+formatdatetime('hh:nn:ss:zzz',time));
      aGoogleSearch := tGoogleSearch.Create(artist + ' ' + title,
        (nbPass * 10) + 1);
      jsResult := aGoogleSearch.getImages;
      jsArray := jsResult.A[GS_ITEMS];
      Memo1.Lines.Add('End : '+formatdatetime('hh:nn:ss:zzz',time));
      addToGrid;
      inc(nbPass);
    end;
    thGetImages.Execute(self);
  end;

  procedure TfCoverSearch.thGetImagesExecute(Sender: TObject; Params: Pointer);
  var
    i: Integer;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    MS: TMemoryStream;
    jpgImg: TJPEGImage;
    BitMap: TBitmap;
    sg1: TJvStringGrid;
    Col, row: Integer;
  begin
    //
    IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHTTP1 := TIdHTTP.Create;
    IdHTTP1.ReadTimeout := 250;
    IdHTTP1.IOHandler := IdSSL;
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
                MS := TMemoryStream.Create;
                jpgImg := TJPEGImage.Create;
                IdHTTP1.Get(tMediaImg(sg1.Objects[Col, row]).TNLink, MS);
                Application.ProcessMessages;
                MS.Seek(0, soFromBeginning);
                jpgImg.LoadFromStream(MS);
                tMediaImg(sg1.Objects[Col, row]).BitMap := tPicture.Create;
                tMediaImg(sg1.Objects[Col, row]).BitMap.Assign(jpgImg);
                // resize img
                sg1.Refresh;
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

end.
