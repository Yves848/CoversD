unit uFrmPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IOUtils, Dateutils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sFrameAdapter, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sSplitter, sButton,
  AdvSmoothLedLabel, AdvGlassButton, acImage, acPNG, sLabel, acFontStore, System.ImageList, Vcl.ImgList, acAlphaImageList, JvExControls, JvScrollText,
  sSpeedButton, sScrollBox, Vcl.ComCtrls, sTrackBar, BASS, BassFlac, Spectrum3DLibraryDefs, bass_aac, utypes, sListBox, XSuperObject, sDialogs;

type
  tUpdatePlayingInfos = procedure of object;
  tUpdatePlayingStatus = procedure of object;

  tPlayingThread = class(TThread)
  private
    fUpdatePlayingInfos: tUpdatePlayingInfos;
    fUpdatePlayingStatus: tUpdatePlayingStatus;
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    constructor create(updateCallBack: tUpdatePlayingInfos; updPlayingStatus: tUpdatePlayingStatus); reintroduce;

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
    sImgStopped: TsImage;
    sImgPlaying: TsImage;
    sImgPaused: TsImage;
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
    slbPlayList: TsListBox;
    sPanel6: TsPanel;
    sIconsButtons: TsCharImageList;
    sPanel7: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sOpenDialog1: TsOpenDialog;
    sSaveDialog1: TsSaveDialog;
    Timer1: TTimer;
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
    procedure FrameResize(Sender: TObject);
    procedure FrameAlignPosition(Sender: TWinControl; Control: TControl; var NewLeft, NewTop, NewWidth, NewHeight: Integer; var AlignRect: TRect;
      AlignInfo: TAlignInfo);
    procedure sButton1Click(Sender: TObject);
    procedure sImgNextClick(Sender: TObject);
    procedure sImgPauseClick(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Déclarations privées }
    fCurTrack: String;
  public
    { Déclarations publiques }
    Channel: HStream;
    pPlayingThread: tPlayingThread;
    OldStatus: Integer;
    property curTrack: String read fCurTrack write fCurTrack;
    procedure init;
    function deInit: Integer;
    procedure PlayStream(FileName: String);
    Procedure UpdatePlatingInfos;
    procedure Stop;
    procedure loadPlaylist;
    procedure savePlaylist;
    procedure clearPlaylist;
    procedure PlayNextTrack(Sender: TObject); overload;
    procedure PlayNextTrack; overload;
    procedure PlayPrevTrack;
    procedure MPlayPrevious(var Msg: TMessage); Message WM_PLAY_PREVIOUS;
    procedure MPlayNext(var Msg: TMessage); Message WM_PLAY_NEXT;
    procedure MPlay(var Msg: TMessage); Message WM_PLAY;
    procedure MPause(var Msg: TMessage); Message WM_PAUSE;
    procedure MStop(var Msg: TMessage); Message WM_STOP;
    procedure updatePlayingStatus;

  end;

var
  Sprectrum3D: Pointer;
  Params: TSpectrum3D_CreateParams;
  Settings: TSpectrum3D_Settings;
  stime: tDateTime;

implementation

{$R *.dfm}

function CopyFile(sFile: String): string;
var
  sFileIn, sFileOut: tFileStream;
begin
  result := tPath.Combine(tPath.GetTempPath, 'temp.mp3');
  sFileIn := tFileStream.create(sFile, fmopenRead + fmShareDenyWrite);
  sFileOut := tFileStream.create(result, fmOpenReadWrite + fmCreate);
  sFileOut.CopyFrom(sFileIn, sFileIn.Size);
  sFileOut.Free;
  sFileIn.Free;
end;

procedure StreamEndCallback(handle: HSYNC; Channel, data: DWORD; user: Pointer); stdcall;
begin
  // fMain.PlayNextTrack(nil);
end;

procedure TfrmPlayer.clearPlaylist;
var
  index: Integer;
begin
  index := 0;
  while index <= slbPlayList.Items.Count - 1 do
  begin
    if slbPlayList.Items.objects[index] <> nil then
    begin
      tMediaFile(slbPlayList.Items.objects[index]).Destroy;
    end;
    inc(Index);
  end;
  slbPlayList.Clear;
end;

function TfrmPlayer.deInit: Integer;
begin

  ZeroMemory(@Params, SizeOf(TSpectrum3D_CreateParams));
  result := 0;
end;

procedure TfrmPlayer.FrameAlignPosition(Sender: TWinControl; Control: TControl; var NewLeft, NewTop, NewWidth, NewHeight: Integer;
  var AlignRect: TRect; AlignInfo: TAlignInfo);
begin
  slbPlayList.Items.Add('AlignPosition');
end;

procedure TfrmPlayer.FrameResize(Sender: TObject);
begin
  // slbPlayList.Items.Add('resize');
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
  OldStatus := -1;

end;

procedure TfrmPlayer.PlayNextTrack;
begin

end;

procedure TfrmPlayer.PlayPrevTrack;
var
  index: Integer;
begin
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
    index := slbPlayList.ItemIndex;
    dec(index);
    if index < 0 then
      index := slbPlayList.Items.Count - 1;

    slbPlayList.ItemIndex := index;

    BASS_ChannelStop(Channel);
    PlayStream(tMediaFile(slbPlayList.Items.objects[slbPlayList.ItemIndex]).Tags.FileName);
  end;
end;

procedure TfrmPlayer.PlayNextTrack(Sender: TObject);
var
  index: Integer;
begin
  if (BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING) or (Sender = nil) then
  begin
    if slbPlayList.Items.Count > 0 then
    begin
      index := slbPlayList.ItemIndex;
      inc(index);
      if index > slbPlayList.Items.Count - 1 then
        index := 0;
      slbPlayList.ItemIndex := index;
      BASS_ChannelStop(Channel);
      // updatePlayingInfos(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
      PlayStream(tMediaFile(slbPlayList.Items.objects[slbPlayList.ItemIndex]).Tags.FileName);
    end;
  end;
end;

procedure TfrmPlayer.PlayStream(FileName: String);
var
  sTempFileName: String;
begin
  BASS_StreamFree(Channel);
  curTrack := FileName;
  sTempFileName := CopyFile(FileName);
  if uppercase(tPath.GetExtension(sTempFileName)) = '.MP3' then
    Channel := BASS_StreamCreateFile(false, PChar(sTempFileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else if (uppercase(tPath.GetExtension(sTempFileName)) = '.M4A') or (uppercase(tPath.GetExtension(FileName)) = '.MP4') then
    Channel := BASS_AAC_StreamCreateFile(false, PChar(sTempFileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else
    Channel := BASS_FLAC_StreamCreateFile(false, PChar(sTempFileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);

  // * Set an end sync which will be called when playback reaches end to play the next song
  BASS_ChannelSetSync(Channel, BASS_SYNC_END, 0, @StreamEndCallback, 0);
  JvScrollText1.Items.Clear;
  JvScrollText1.Items.Add(FileName + '  ');

  Spectrum3D_SetChannel(Sprectrum3D, Channel);
  // * Start playing and visualising
  BASS_ChannelPlay(Spectrum3D_GetChannel(Sprectrum3D), True);
  // BASS_ChannelPlay(Channel, True);
  // sLabel5.Caption := inttostr(BASS_ChannelGetLength(Channel, BASS_POS_BYTE));
  // if pPlayingThread.Suspended then
  // pPlayingThread.Start;
end;

procedure TfrmPlayer.loadPlaylist;
var
  i: Integer;
  pMediaFile: tMediaFile;
  Json: ISuperObject;
begin
  if sOpenDialog1.Execute then
  begin
    slbPlayList.Clear;
    i := 0;
    Json := TSuperObject.ParseFile(sOpenDialog1.FileName);
    while i <= Json.a['tracks'].Length - 1 do
    begin
      pMediaFile := tMediaFile.create(Json.a['tracks'].O[i].S['filename']);
      slbPlayList.Items.AddObject(tPath.GetFileNameWithoutExtension(pMediaFile.Tags.FileName), pMediaFile);
      inc(i);
    end;
  end;
end;

procedure TfrmPlayer.MPause(var Msg: TMessage);
begin
  //
end;

procedure TfrmPlayer.MPlay(var Msg: TMessage);
begin
  if Channel <> 0 then
  begin
    if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
      sImgPauseClick(sImgPause)
    else
      sImgPlayClick(sImgPlay);
  end
  else
    sImgPlayClick(sImgPlay);
end;

procedure TfrmPlayer.MPlayNext(var Msg: TMessage);
begin
  sImgNextClick(sImgNext);
end;

procedure TfrmPlayer.MPlayPrevious(var Msg: TMessage);
begin
  //
end;

procedure TfrmPlayer.MStop(var Msg: TMessage);
begin
  sImgStopClick(sImgStop);
end;

procedure TfrmPlayer.savePlaylist;
var
  Json: ISuperObject;
  i: Integer;
  pMediaFile: tMediaFile;
begin
  if sSaveDialog1.Execute then
  begin
    i := 0;
    Json := SO;
    while i <= slbPlayList.Items.Count - 1 do
    begin
      if slbPlayList.Items.objects[i] <> Nil then
      begin
        pMediaFile := tMediaFile(slbPlayList.Items.objects[i]);
        with Json.a['tracks'].O[i] do
        begin
          S['fileName'] := pMediaFile.Tags.FileName;
        end;
      end;
      inc(i);
    end;
    Json.SaveTo(sSaveDialog1.FileName);
  end;
end;

procedure TfrmPlayer.sButton1Click(Sender: TObject);
begin
  loadPlaylist;
end;

procedure TfrmPlayer.sButton3Click(Sender: TObject);
begin
  clearPlaylist;
end;

procedure TfrmPlayer.sImgNextClick(Sender: TObject);
begin
  PlayNextTrack(Sender);
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

procedure TfrmPlayer.Timer1Timer(Sender: TObject);
begin
  UpdatePlatingInfos;
  updatePlayingStatus;
end;

procedure TfrmPlayer.sImgPlayClick(Sender: TObject);
var
  index: Integer;
  sSelected: String;
begin
  Index := slbPlayList.ItemIndex;
  if Index <> -1 then
  begin
    sSelected := tMediaFile(slbPlayList.Items.objects[Index]).Tags.FileName;
    if (Channel = 0) or (BASS_ChannelIsActive(Channel) = BASS_ACTIVE_STOPPED) then
    begin
      // No Channel assigned or playing is stopped;
      PlayStream(sSelected);
    end
    else
    begin
      // Channel already active
      if curTrack <> sSelected then
      begin
        // Not the same Track
        BASS_ChannelStop(Channel);
        playStream(sSelected);
      end
      else
      begin
        BASS_ChannelPlay(Channel, false);
      end;
    end;
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

procedure TfrmPlayer.sImgPauseClick(Sender: TObject);
begin
  BASS_ChannelPause(Channel);
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
  iPos: Integer;
  aTime: double;
  minutes, seconds: Integer;
begin
  Level := BASS_ChannelGetLevel(Channel);
  // * Separate L & R channel
  LeftLevel := LoWord(Level);
  RightLevel := HiWord(Level);
  // * Set the VUs
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
    iPos := BASS_ChannelGetPosition(Channel, BASS_POS_BYTE);
    aTime := BASS_ChannelBytes2Seconds(Channel, iPos);
    if BASS_ErrorGetCode = BASS_OK then
    begin
      seconds := round(aTime);
      if seconds > 59 then
      begin
        minutes := (seconds div 60);
        seconds := seconds - (minutes * 60);
      end;
      sLabel1.Caption := format('%.2d:%.2d', [minutes, seconds]);
    end;
  end;
end;

procedure TfrmPlayer.updatePlayingStatus;
var
  iStatus: Integer;
begin
  iStatus := 0;
  if Channel <> 0 then
  begin
    case BASS_ChannelIsActive(Channel) of
      BASS_ACTIVE_PLAYING:
        iStatus := 1;
      BASS_ACTIVE_PAUSED:
        iStatus := 2;
    end;
  end;

  if OldStatus <> iStatus then
  begin
    OldStatus := iStatus;

    sImgStopped.Images := sIconsOff;
    sImgStopped.ImageIndex := 2;

    sImgPaused.Images := sIconsOff;
    sImgPaused.ImageIndex := 1;

    sImgPlaying.Images := sIconsOff;
    sImgPlaying.ImageIndex := 0;

    case iStatus of
      0:
        begin
          // Stopped
          sImgStopped.Images := sIconsOn;
          sImgStopped.ImageIndex := 5;
        end;
      1:
        begin
          // Playing
          sImgPlaying.Images := sIconsOn;
          sImgPlaying.ImageIndex := 0;
        end;
      2:
        begin
          // Paused
          sImgPaused.Images := sIconsOn;
          sImgPaused.ImageIndex := 1;
        end;
    end;
  end;
end;

{ tPlayingThread }

constructor tPlayingThread.create(updateCallBack: tUpdatePlayingInfos; updPlayingStatus: tUpdatePlayingStatus);
begin
  //
  inherited create(True);
  self.Priority := TThreadPriority.tpHigher;
  fUpdatePlayingInfos := updateCallBack;
  fUpdatePlayingStatus := updPlayingStatus;
  FreeOnTerminate := True;
end;

procedure tPlayingThread.DoTerminate;
begin
  // fUpdatePlayingInfos := Nil;
  inherited;
end;

procedure tPlayingThread.Execute;
begin
  inherited;
  // and (MilliSecondsBetween(now, stime) >= 1000)
  while (not Terminated) do
  begin
    fUpdatePlayingInfos;
    fUpdatePlayingStatus;
    Application.ProcessMessages;
    // stime := now;
  end;
end;

end.
