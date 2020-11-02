unit uFrmPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,System.IOUtils,Dateutils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sFrameAdapter, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sSplitter, sButton,
  AdvSmoothLedLabel, AdvGlassButton, acImage, acPNG, sLabel, acFontStore, System.ImageList, Vcl.ImgList, acAlphaImageList, JvExControls, JvScrollText,
  sSpeedButton, sScrollBox, Vcl.ComCtrls, sTrackBar,BASS, BassFlac,Spectrum3DLibraryDefs, bass_aac, utypes, sListBox;

type
  tUpdatePlayingInfos = procedure of object;
  tTerminate = procedure of Object;

  tPlayingThread = class(TThread)
  private
    fUpdatePlayingInfos : tUpdatePlayingInfos;
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    constructor create(updateCallBack : tUpdatePlayingInfos); reintroduce;

  end;


  TfrmPlayer = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sPanel1: TsPanel;
    sSplitter1: TsSplitter;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    sFontStore1: TsFontStore;
    sIconsOff: TsCharImageList;
    sIconsOn: TsCharImageList;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sImage4: TsImage;
    sImage5: TsImage;
    sImage6: TsImage;
    sPanel10: TsPanel;
    sPNIcons: TsPanel;
    sPnCounter: TsPanel;
    sLabel1: TsLabel;
    JvScrollText1: TJvScrollText;
    sImgNext: TsImage;
    sImgStop: TsImage;
    sImgPlay: TsImage;
    sImgPause: TsImage;
    sImgPrevious: TsImage;
    sTrackBar1: TsTrackBar;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    sListBox1: TsListBox;
    sPanel6: TsPanel;
    sIconsButtons: TsCharImageList;
    sPanel7: TsPanel;
    procedure sImgPreviousMouseEnter(Sender: TObject);
    procedure sImgPreviousMouseLeave(Sender: TObject);
    procedure sImgPauseMouseEnter(Sender: TObject);
    procedure sImgPauseMouseLeave(Sender: TObject);
    procedure sImgPlayMouseEnter(Sender: TObject);
    procedure sImgPlayMouseLeave(Sender: TObject);
    procedure sImgStopMouseEnter(Sender: TObject);
    procedure sImgStopMouseLeave(Sender: TObject);
    procedure sImgNextMouseEnter(Sender: TObject);
    procedure sImgNextMouseLeave(Sender: TObject);
    procedure sImgStopClick(Sender: TObject);
    procedure sImgPlayClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Channel: HStream;
    pPlayingThread : tPlayingThread;
    procedure init;
    function  deInit : integer;
    procedure PlayStream(FileName: String);
    Procedure UpdatePlatingInfos;
    procedure Stop;
  end;

var
  Sprectrum3D: Pointer;
  Params: TSpectrum3D_CreateParams;
  Settings: TSpectrum3D_Settings;
  
implementation

{$R *.dfm}

Procedure CopyFile(sFile : String);
var
  sTempFileName : String;
  sFileIn,
  sFileOut : tFileStream;
begin
   sTempFileName := tPath.Combine(tPath.GetTempPath, 'temp.mp3');
   sFileIn := tFileStream.Create(sFile, fmopenRead+fmShareDenyWrite);
   sFileOut := tFileStream.Create(sTempFileName,fmOpenReadWrite + fmCreate);
   sFileOut.CopyFrom(sFileIn,sFileIn.Size);
   sFileOut.Free;
   sFileIn.Free;
end;



procedure StreamEndCallback(handle: HSYNC; Channel, data: DWORD; user: Pointer); stdcall;
begin
  //fMain.PlayNextTrack(nil);
end;


function TfrmPlayer.deInit : integer;
begin

  pPlayingThread.Terminate;
  while not pPlayingThread.Terminated do
    Application.ProcessMessages;
  //pPlayingThread.Free;
  ZeroMemory(@Params, SizeOf(TSpectrum3D_CreateParams));
  result := 0;
end;

procedure TfrmPlayer.init;
var
  Volume: Single;
  ReleaseCodeString: string;
  SerialNumber: Longint;
begin
  BASS_Init(-1, 44100, 0, self.handle, 0);
  ZeroMemory(@Params, SizeOf(TSpectrum3D_CreateParams));
  Params.ParentHandle := sPanel5.handle;
  Params.AntiAliasing := 4;
  Sprectrum3D := Spectrum3D_Create(@Params);
  Spectrum3D_GetParams(Sprectrum3D, @Settings);
  Settings.ShowGridLines := false;
  Settings.ShowText := false;
  Spectrum3D_SetParams(Sprectrum3D, @Settings);
  pPlayingThread := tPlayingThread.create(UpdatePlatingInfos);
  pPlayingThread.Start;
  //sImgPrevious.Images := sIconsButtons;
  //sImgPrevious.ImageIndex := 2;
  sImgPrevious.Refresh;
  sImgNext.Refresh;
  sImgStop.Refresh;
  sImgPlay.Refresh;
  sImgPause.Refresh;

end;

procedure TfrmPlayer.PlayStream(FileName: String);
var
   sTempFileName : String;
begin
  BASS_StreamFree(Channel);

  CopyFile(FileNAme);
  sTempFileName := tPath.Combine(tPath.GetTempPath, 'temp.mp3');
  if uppercase(tpath.GetExtension(sTempFileName)) = '.MP3' then
    Channel := BASS_StreamCreateFile(false, PChar(sTempFileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else if (uppercase(tpath.GetExtension(sTempFileName)) = '.M4A') or (uppercase(tpath.GetExtension(FileName)) = '.MP4') then
    Channel := BASS_AAC_StreamCreateFile(false, PChar(sTempFileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else
    Channel := BASS_FLAC_StreamCreateFile(false, PChar(sTempFileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);

  // * Set an end sync which will be called when playback reaches end to play the next song
  BASS_ChannelSetSync(Channel, BASS_SYNC_END, 0, @StreamEndCallback, 0);
  JvScrollText1.Items.Clear;
  JvScrollText1.Items.Add(FileName+'  ');



  //TrackBar1.Max := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);
  // * Start playback
  //updatePlayingInfos(FileName);

  Spectrum3D_SetChannel(Sprectrum3D, Channel);
  // * Start playing and visualising
  BASS_ChannelPlay(Spectrum3D_GetChannel(Sprectrum3D), True);
  //sLabel5.Caption := inttostr(BASS_ChannelGetLength(Channel, BASS_POS_BYTE));
  if pPlayingThread.Suspended then
    pPlayingThread.Start;
end;



procedure TfrmPlayer.sImgNextMouseEnter(Sender: TObject);
begin
  sImgNext.ImageIndex := 8;
end;

procedure TfrmPlayer.sImgNextMouseLeave(Sender: TObject);
begin
  sImgNext.ImageIndex := 3;
end;

procedure TfrmPlayer.sImgStopClick(Sender: TObject);
begin
   BASS_ChannelStop(Channel);
end;

procedure TfrmPlayer.sImgStopMouseEnter(Sender: TObject);
begin
  sImgStop.ImageIndex := 9;
end;

procedure TfrmPlayer.sImgStopMouseLeave(Sender: TObject);
begin
  sImgStop.ImageIndex := 4;
end;



procedure TfrmPlayer.Stop;
begin
  BASS_ChannelStop(Channel);
end;

procedure TfrmPlayer.sImgPlayClick(Sender: TObject);
begin
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
     BASS_ChannelPause(channel);
  end
  else
  begin
     BASS_ChannelPlay(Channel,false);
  end;

end;

procedure TfrmPlayer.sImgPlayMouseEnter(Sender: TObject);
begin
  sImgPlay.ImageIndex := 5;
end;

procedure TfrmPlayer.sImgPlayMouseLeave(Sender: TObject);
begin
  sImgPlay.ImageIndex := 0;
end;

procedure TfrmPlayer.sImgPauseMouseEnter(Sender: TObject);
begin
  sImgPause.ImageIndex := 6;
end;

procedure TfrmPlayer.sImgPauseMouseLeave(Sender: TObject);
begin
  sImgPause.ImageIndex := 1;
end;

procedure TfrmPlayer.sImgPreviousMouseEnter(Sender: TObject);
begin
  sImgPrevious.ImageIndex := 7;
end;

procedure TfrmPlayer.sImgPreviousMouseLeave(Sender: TObject);
begin
  sImgPrevious.ImageIndex := 2;
end;

procedure TfrmPlayer.UpdatePlatingInfos;
var
  Level: Cardinal;
  LeftLevel: Word;
  RightLevel: Word;
  Volume: Single;
  iPos : integer;
  aTime : double;
  minutes,
  seconds : integer;
begin
  Level := BASS_ChannelGetLevel(Channel);
  // * Separate L & R channel
  LeftLevel := LoWord(Level);
  RightLevel := HiWord(Level);
  // * Set the VUs
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
     iPos := BASS_ChannelGetPosition(Channel, BASS_POS_BYTE);
     aTime := BASS_ChannelBytes2Seconds(Channel,iPos);
     if BASS_ErrorGetCode = BASS_OK then
     begin
        seconds := round(aTime);
        if Seconds > 59 then
        begin
          minutes := (Seconds div 60);
          seconds := seconds - (Minutes * 60);
        end;
        sLabel1.Caption := format('%.2d:%.2d',[minutes,seconds]);
     end;
  end;
end;

{ tPlayingThread }

constructor tPlayingThread.create(updateCallBack : tUpdatePlayingInfos);
begin
    //
    inherited create(true);
    fUpdatePlayingInfos := updateCallBAck;
    FreeOnTerminate := true;
end;

procedure tPlayingThread.DoTerminate;
begin
  //fUpdatePlayingInfos := Nil;
  inherited;
end;

procedure tPlayingThread.Execute;
begin
  inherited;
  while not terminated do
  begin
    fUpdatePlayingInfos;
    Application.ProcessMessages;
  end;
end;

end.
