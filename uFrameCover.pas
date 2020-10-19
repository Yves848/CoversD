unit uFrameCover;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, IdComponent, JPEG, PNGImage, GIFImg,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, acImage, Vcl.ComCtrls, acProgressBar, sPanel, sFrameAdapter, Vcl.StdCtrls, sLabel,
  xSuperObject, IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding, KryptoGlowLabel;

type
  tREfreshCell0 = procedure(fPos: Integer) of object;

  tDownloadThread = class(TThread)
  private
    fMax: Integer;
    fPos: Integer;
    fCol: Integer;
    fRow: Integer;
    fUrl: String;
    fRefresh: tREfreshCell0;
    fImage1: tsImage;
    procedure downloadImage(sUrl: string);
  protected
    procedure Execute; override;
  public
    procedure onWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    constructor create(aUrl: String; aImage: tsImage; CallBack: tREfreshCell0); reintroduce;
  end;

  tFrameCover = class(TFrame)
    sPnCCoverSearch: TsPanel;
    sPB1: TsProgressBar;
    sImage1: tsImage;
    sFrameAdapter1: TsFrameAdapter;
    sLabel1: TKryptoGlowLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    sUrl: String;
    procedure StartDownload;
    procedure refreshPB(aPos: Integer);
  end;

implementation

{$R *.dfm}

constructor tDownloadThread.create(aUrl: String; aImage: tsImage; CallBack: tREfreshCell0);
begin
  inherited create(true);
  FreeOnTerminate := true;
  fImage1 := aImage;
  fUrl := aUrl;
  fRefresh := CallBack;
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
      // fGrid.AddPicture(fCol, fRow, Picture, false, tStretchMode.Shrink, 2, haCenter, vaCenter);
      fImage1.Picture.Assign(Picture);
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
    fRefresh(-1);
  end;
  if not terminated then
    terminate;
end;

procedure tDownloadThread.Execute;
begin
  inherited;
  downloadImage(fUrl);
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
  fRefresh(p);
end;

procedure tDownloadThread.onWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  fMax := AWorkCountMax;
  fPos := 0;
end;

procedure tDownloadThread.onWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  aFrame: tFrameCover;
begin
  fPos := 0;
end;

{ tFrameCover }

procedure tFrameCover.refreshPB(aPos: Integer);
begin
  if aPos = -1 then
  begin
    sPB1.Visible := false;
    if self.Name = 'aFrameCover1' then
    begin
      sImage1.OnClick(sImage1);
    end;
  end
  else
    sPB1.Position := aPos;
end;

procedure tFrameCover.StartDownload;
var
  aDownloadTh: tDownloadThread;
begin
  sPB1.Visible := true;
  aDownloadTh := tDownloadThread.create(sUrl, sImage1, refreshPB);
  aDownloadTh.FreeOnTerminate := true;
  aDownloadTh.Start;
end;

end.
