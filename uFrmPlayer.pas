unit uFrmPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,System.IOUtils,Dateutils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sFrameAdapter, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sSplitter, sButton,
  AdvSmoothLedLabel, AdvGlassButton, acImage, acPNG, sLabel, acFontStore, System.ImageList, Vcl.ImgList, acAlphaImageList, JvExControls, JvScrollText,
  sSpeedButton, sScrollBox, Vcl.ComCtrls, sTrackBar,BASS, BassFlac,Spectrum3DLibraryDefs, bass_aac, utypes, sListBox;

type
  tUpdatePlayingInfos = procedure of object;

  tPlayingThread = class(TThread)
  private
    fUpdatePlayingInfos : tUpdatePlayingInfos;
  protected
    procedure Execute; override;
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
    sScrollBox1: TsScrollBox;
    sImage1: TsImage;
    sImage3: TsImage;
    sImage7: TsImage;
    sImage8: TsImage;
    sImage9: TsImage;
    sTrackBar1: TsTrackBar;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    sListBox1: TsListBox;
    sPanel6: TsPanel;
    sIconsButtons: TsCharImageList;
    sLabel2: TsLabel;
    sLabel5: TsLabel;
    procedure sImage9MouseEnter(Sender: TObject);
    procedure sImage9MouseLeave(Sender: TObject);
    procedure sImage8MouseEnter(Sender: TObject);
    procedure sImage8MouseLeave(Sender: TObject);
    procedure sImage7MouseEnter(Sender: TObject);
    procedure sImage7MouseLeave(Sender: TObject);
    procedure sImage3MouseEnter(Sender: TObject);
    procedure sImage3MouseLeave(Sender: TObject);
    procedure sImage1MouseEnter(Sender: TObject);
    procedure sImage1MouseLeave(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Channel: HStream;
    pPlayingThread : tPlayingThread;
    procedure init;
    procedure deInit;
    procedure PlayStream(FileName: String);
    Procedure UpdatePlatingInfos;
  end;

var
  Sprectrum3D: Pointer;
  Params: TSpectrum3D_CreateParams;
  Settings: TSpectrum3D_Settings;


implementation

{$R *.dfm}

{ TfrmPlayer }

procedure StreamEndCallback(handle: HSYNC; Channel, data: DWORD; user: Pointer); stdcall;
begin
  //fMain.PlayNextTrack(nil);
end;

procedure TfrmPlayer.deInit;
begin
  ZeroMemory(@Params, SizeOf(TSpectrum3D_CreateParams));
  //pPlayingThread.Terminate;
  //pPlayingThread.Free;
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
  //pPlayingThread := tPlayingThread.create(UpdatePlatingInfos);
end;

procedure TfrmPlayer.PlayStream(FileName: String);

begin
  BASS_StreamFree(Channel);

  if uppercase(tpath.GetExtension(FileName)) = '.MP3' then
    Channel := BASS_StreamCreateFile(false, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else if (uppercase(tpath.GetExtension(FileName)) = '.M4A') or (uppercase(tpath.GetExtension(FileName)) = '.MP4') then
    Channel := BASS_AAC_StreamCreateFile(false, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else
    Channel := BASS_FLAC_StreamCreateFile(false, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);

  // * Set an end sync which will be called when playback reaches end to play the next song
  BASS_ChannelSetSync(Channel, BASS_SYNC_END, 0, @StreamEndCallback, 0);
  //CurrentPlayingFileName := FileName;
  JvScrollText1.Items.Clear;
  JvScrollText1.Items.Add(Filename+'  ');

  //TrackBar1.Max := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);
  // * Start playback
  //updatePlayingInfos(FileName);

  Spectrum3D_SetChannel(Sprectrum3D, Channel);
  // * Start playing and visualising
  BASS_ChannelPlay(Spectrum3D_GetChannel(Sprectrum3D), True);
  sLabel5.Caption := inttostr(BASS_ChannelGetLength(Channel, BASS_POS_BYTE));
  //pPlayingThread.Start;
end;



procedure TfrmPlayer.sImage1MouseEnter(Sender: TObject);
begin
  sImage1.ImageIndex := 8;
end;

procedure TfrmPlayer.sImage1MouseLeave(Sender: TObject);
begin
  sImage1.ImageIndex := 3;
end;

procedure TfrmPlayer.sImage3MouseEnter(Sender: TObject);
begin
  sImage3.ImageIndex := 9;
end;

procedure TfrmPlayer.sImage3MouseLeave(Sender: TObject);
begin
  sImage3.ImageIndex := 4;
end;

procedure TfrmPlayer.sImage7MouseEnter(Sender: TObject);
begin
  sImage7.ImageIndex := 5;
end;

procedure TfrmPlayer.sImage7MouseLeave(Sender: TObject);
begin
  sImage7.ImageIndex := 0;
end;

procedure TfrmPlayer.sImage8MouseEnter(Sender: TObject);
begin
  sImage8.ImageIndex := 6;
end;

procedure TfrmPlayer.sImage8MouseLeave(Sender: TObject);
begin
  sImage8.ImageIndex := 1;
end;

procedure TfrmPlayer.sImage9MouseEnter(Sender: TObject);
begin
  sImage9.ImageIndex := 7;
end;

procedure TfrmPlayer.sImage9MouseLeave(Sender: TObject);
begin
  sImage9.ImageIndex := 2;
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
        sLabel2.Caption := format('%d:%d',[minutes,seconds]);
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
