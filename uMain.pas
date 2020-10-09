unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types, Vcl.GraphUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, utags, Vcl.StdCtrls, sPanel, Vcl.ExtCtrls, sSkinManager, sSkinProvider, sButton, Vcl.ComCtrls,
  sTreeView, acShellCtrls, sListView, sComboBoxes, sSplitter, Vcl.Buttons, sSpeedButton, System.ImageList, Vcl.ImgList, acAlphaImageList,
  acProgressBar, JvComponentBase, JvThread, sMemo, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, acImage, JPEG, PNGImage, GIFImg, TagsLibrary,
  acNoteBook, sTrackBar, acArcControls, sGauge, BASS, BassFlac, xSuperObject, SynEditHighlighter, SynHighlighterJSON, SynEdit, SynMemo, sListBox,
  JvExControls, clipbrd, Spectrum3DLibraryDefs, bass_aac,
  JvaScrollText, acSlider, uSearchImage, sBitBtn, Vcl.OleCtrls, SHDocVw, activeX, acWebBrowser, Vcl.Grids, JvExGrids, JvStringGrid, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding, Vcl.WinXCtrls, AdvUtil, AdvObj, BaseGrid,
  ovctable, AdvGrid, dateutils, uCoverSearch, sDialogs, sLabel, sBevel, uSelectDirectory, AdvReflectionLabel, AdvMemo, acPNG,
  JvExComCtrls, JvProgressBar, KryptoGlowLabel, uni_RegCommon, Vcl.onguard, uRegister;

type
  TfMain = class(TForm)
    pnBack: TsPanel;
    sSkinProvider1: TsSkinProvider;
    sSkinManager1: TsSkinManager;
    pnToolbar: TsPanel;
    sROPMedia: TsRollOutPanel;
    sSplitter1: TsSplitter;
    sTVMedias: TsTreeView;
    pnToolbarTreeView: TsPanel;
    pnStatus: TsPanel;
    pnStatusTreeView: TsPanel;
    sILIcons: TsAlphaImageList;
    pb1: TsProgressBar;
    thListMP3: TJvThread;
    sDEFolder: TsDirectoryEdit;
    sILTV: TsAlphaImageList;
    sImage1: TsImage;
    sROPPlaylist: TsRollOutPanel;
    TrackBar1: TsTrackBar;
    Timer1: TTimer;
    sButton1: TsButton;
    sButton2: TsButton;
    SynJSONSyn1: TSynJSONSyn;
    slbPlaylist: TsListBox;
    pnMain: TsPanel;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sShellTreeView1: TsShellTreeView;
    sgList: TAdvStringGrid;
    sButton3: TsButton;
    sButton4: TsButton;
    sButton5: TsButton;
    sSaveDialog1: TsSaveDialog;
    sOpenDialog1: TsOpenDialog;
    sButton6: TsButton;
    sILButtons: TsAlphaImageList;
    sButton7: TsButton;
    sButton8: TsButton;
    sPanel3: TsPanel;
    thDisplay: TJvThread;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    sPanel6: TsPanel;
    sBevel1: TsBevel;
    sPanel7: TsPanel;
    sPanel8: TsPanel;
    sPanel9: TsPanel;
    tbVolume: TsTrackBar;
    kglArtist: TKryptoGlowLabel;
    kglTitle: TKryptoGlowLabel;
    Image2: TImage;
    sImage2: TsImage;
    image1: TsImage;
    sGauge1: TsGauge;
    sGauge2: TsGauge;
    sPanel10: TsPanel;
    VuR: TsImage;
    vuL: TsImage;
    thAddToPlayList: TJvThread;
    bsRegister: TsButton;
    procedure Button1Click(Sender: TObject);
    procedure thListMP3Execute(Sender: TObject; Params: Pointer);
    procedure sTVMediasChange(Sender: TObject; Node: TTreeNode);
    procedure sTVMediasExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure sDEFolderAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
    procedure sTVMediasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbVolumeChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure slbPlaylistItemIndexChanged(Sender: TObject);
    procedure slbPlaylistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sShellTreeView1KeyPress(Sender: TObject; var Key: Char);
    procedure sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: Boolean);
    procedure sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sgListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sButton3Click(Sender: TObject);
    procedure sgListRowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sShellTreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure thDisplayExecute(Sender: TObject; Params: Pointer);
    procedure sButton9Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tbVolumeSkinPaint(Sender: TObject; Canvas: TCanvas);
    procedure sShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure sShellTreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure thAddToPlayListExecute(Sender: TObject; Params: Pointer);
    procedure bsRegisterClick(Sender: TObject);
  private
    { Déclarations privées }
    jConfig: ISuperObject;
    function findNode(sLabel: String): TTreeNode;
    procedure ListCoverArts(aImage: TsImage; Tags: TTags); overload;
    Procedure ListCoverArts(aImage: TsImage; sFileName: String); overload;
    procedure OpenConfig;
    procedure downloadImage(sUrl: string);
  public
    { Déclarations publiques }
    Channel: HStream;
    ChannelPreview: HStream;
    CurrentPlayingFileName: String;
    AdjustingPlaybackPosition: Boolean;
    delais: Integer;
    momentdown: tDateTime;
    GlobalMediaFile: tMediaFile;
    procedure PlayStream(FileName: String);
    procedure addfileName;
    procedure setPBMax;
    procedure SetPBPosition;
    procedure ResetPB;
    procedure ExpandNode;
    procedure updateTV;
    procedure initGrid;
    procedure removeKeyFromStack;
    function AddToPlayList(ARow: Integer): Integer; overload;
    function AddToPlayList(aNode: TTreeNode; bRecurse: Boolean): Integer; overload;
    Procedure AddFolderToGrid(sFolder: String);
    Procedure AddFileToGrid(sFile: String);
    Procedure AddFileToGridTH;
    Procedure AddToPlayListTH;
    procedure GetImgLink;
    Procedure PlayNextTrack(Sender: TObject);
    Procedure PlayPrevTrack;
    Procedure showPlayList;
    Procedure showExplorer;
    procedure savePlaylist;
    procedure loadPlaylist;
    procedure playlistRemoveItem(index: Integer);
    procedure updatePlayingInfos(sFileName: String); overload;
    procedure updatePlayingInfos(aTags: TTags); overload;
    function FormatTextWithEllipse(aText: string): string;
    procedure DrawTransparentRectangle(Canvas: TCanvas; Rect: TRect; Color: TColor; Transparency: Integer);
    procedure UpdateVuMetre(LeftLevel, RightLevel: Integer);
  end;

var
  fMain: TfMain;
  Sprectrum3D: Pointer;
  iProgress: Integer;
  iMax: Integer;
  sFileName: String;
  aPath: String;
  sFile: String;
  aNode: TTreeNode;
  iImg: Integer;
  sLink: String;
  Params: TSpectrum3D_CreateParams;
  Settings: TSpectrum3D_Settings;

implementation

{$R *.dfm}

uses
  JvDynControlEngineVcl, acntUtils, acgpUtils, sVCLUtils;

function TfMain.FormatTextWithEllipse(aText: string): string;
const
  csEllipses = '...';
var
  ldTextWidth: Double;
  lsText: String;
begin

  Result := aText;
  lsText := aText;

  ldTextWidth := kglTitle.Canvas.TextWidth(lsText);
  if (ldTextWidth > kglTitle.Width) then
    repeat
      lsText := Copy(lsText, 1, Length(lsText) - 1);
      Result := lsText + csEllipses;
      ldTextWidth := kglTitle.Canvas.TextWidth(Result);
    until (ldTextWidth < kglTitle.Width);

end;

procedure StreamEndCallback(handle: HSYNC; Channel, data: DWORD; user: Pointer); stdcall;
begin
  fMain.PlayNextTrack(nil);
end;

procedure TfMain.PlayNextTrack(Sender: TObject);
var
  index: Integer;
begin
  if (BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING) or (Sender = nil) then
  begin
    if slbPlaylist.Items.Count > 0 then
    begin

      index := slbPlaylist.ItemIndex;

      inc(index);
      if index > slbPlaylist.Items.Count - 1 then
        index := 0;

      slbPlaylist.ItemIndex := index;

      BASS_ChannelStop(Channel);
      updatePlayingInfos(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
      PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
    end;
  end;

end;

procedure TfMain.PlayPrevTrack;
var
  index: Integer;
begin
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
    index := slbPlaylist.ItemIndex;
    dec(index);
    if index < 0 then
      index := slbPlaylist.Items.Count - 1;

    slbPlaylist.ItemIndex := index;

    BASS_ChannelStop(Channel);
    PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
  end;

end;

procedure TfMain.PlayStream(FileName: String);

begin
  BASS_StreamFree(Channel);

  if uppercase(tpath.GetExtension(FileName)) = '.MP3' then
    Channel := BASS_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else if uppercase(tpath.GetExtension(FileName)) = '.M4A' then
    Channel := BASS_AAC_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else
    Channel := BASS_FLAC_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);

  // * Set an end sync which will be called when playback reaches end to play the next song
  BASS_ChannelSetSync(Channel, BASS_SYNC_END, 0, @StreamEndCallback, 0);
  CurrentPlayingFileName := FileName;
  TrackBar1.Max := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);
  // * Start playback
  updatePlayingInfos(FileName);

  Spectrum3D_SetChannel(Sprectrum3D, Channel);
  // * Start playing and visualising
  BASS_ChannelPlay(Spectrum3D_GetChannel(Sprectrum3D), True);

end;

procedure TfMain.removeKeyFromStack;
var
  Mgs: tMsg;
begin
  PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure LoadHTML(AWebBrowser: TWebBrowser; const HTMLCode: string);
var
  ss: TStringStream;
  sa: TStreamAdapter;
begin
  // Il est nécessaire de réinitialiser la page avec un appel à Navigate
  AWebBrowser.Navigate('about:blank');

  // Il faut attendre que le navigateur soit prêt
  while AWebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  if Assigned(AWebBrowser.Document) then
  begin
    // On crée un flux
    ss := TStringStream.Create(HTMLCode);
    try
      // et un adaptateur IStream
      sa := TStreamAdapter.Create(ss); // Ne pas libérer

      // On appelle la méthode de chargement du WebBrowser
      (AWebBrowser.Document as IPersistStreamInit).Load(sa);
    finally
      // On libère le flux
      ss.Free;
    end;
  end;
end;

procedure TfMain.AddFileToGrid(sFile: String);
var
  ARow: Integer;
  pMediaFile: tMediaFile;
begin
  //
  ARow := sgList.RowCount - 1;
  if sgList.Cells[0, ARow] <> '' then
  begin
    sgList.RowCount := sgList.RowCount + 1;
    ARow := sgList.RowCount - 1;
  end;

  pMediaFile := tMediaFile.Create(sFile);
  try
    sgList.Cells[0, ARow] := sFile;
    sgList.Cells[1, ARow] := pMediaFile.Tags.GetTag('ARTIST');
    sgList.Cells[2, ARow] := pMediaFile.Tags.GetTag('TITLE');
    sgList.Cells[3, ARow] := pMediaFile.Tags.GetTag('ALBUM');
    if pMediaFile.Tags.CoverArts.Count > 0 then
      sgList.Cells[4, ARow] := 'O'
    else
      sgList.Cells[4, ARow] := '';
  finally
    pMediaFile.Destroy;
  end;
  Application.ProcessMessages;
end;

procedure TfMain.AddFileToGridTH;
begin
  AddFileToGrid(sFile);
end;

procedure TfMain.AddFolderToGrid(sFolder: String);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
  sExt: String;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(sFolder, aSearchOption, nil);

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
  //
end;

function TfMain.AddToPlayList(ARow: Integer): Integer;
var
  aMediaFile: tMediaFile;
  sPath, sFile: String;
  index: Integer;
begin
  Result := -1;
  aMediaFile := tMediaFile.Create(sgList.Cells[0, ARow]);
  sPath := tpath.GetDirectoryName(aMediaFile.Tags.FileName);
  sFile := tpath.GetFileNameWithoutExtension(aMediaFile.Tags.FileName);
  index := slbPlaylist.Items.IndexOf(sFile);
  if index = -1 then
  begin
    Result := slbPlaylist.Items.AddObject(sFile, aMediaFile);
  end
  else
    Result := index;
end;

function TfMain.AddToPlayList(aNode: TTreeNode; bRecurse: Boolean): Integer;
var
  aMediaFile: tMediaFile;
  sPath, sFile: String;
  index: Integer;
begin
  Result := -1;
  if not TacShellFolder(aNode.data).IsFileFolder then
  begin

    aMediaFile := tMediaFile.Create(TacShellFolder(aNode.data).PathName);
    sPath := tpath.GetDirectoryName(aMediaFile.Tags.FileName);
    sFile := tpath.GetFileNameWithoutExtension(aMediaFile.Tags.FileName);
    index := slbPlaylist.Items.IndexOf(sFile);
    if index = -1 then
    begin
      Result := slbPlaylist.Items.AddObject(sFile, aMediaFile);
    end
    else
      Result := index;
  end
end;

procedure TfMain.AddToPlayListTH;
var
  aMediaFile: tMediaFile;
  sPath : String;
  index: Integer;
begin
    aMediaFile := tMediaFile.Create(sFile);
    index := slbPlaylist.Items.IndexOf(sFile);
   if index = -1 then
    begin
      slbPlaylist.Items.AddObject(sFile, aMediaFile);
    end

end;

procedure TfMain.bsRegisterClick(Sender: TObject);
var
  fRegister : tfRegister;
begin
  fREgister := tfRegister.Create(self);
  fRegister.ShowModal;
  fREgister.Free;
end;

procedure TfMain.Button1Click(Sender: TObject);
var
  form2: tForm2;
begin
  form2 := tForm2.Create(Self);
  form2.ShowModal;
  form2.Free;
end;

procedure TfMain.downloadImage(sUrl: string);
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
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  try
    MS := TMemoryStream.Create;
    jpgImg := TJPEGImage.Create;
    IdHTTP1.Get(sUrl, MS);
    Application.ProcessMessages;
    MS.Seek(0, soFromBeginning);
    jpgImg.LoadFromStream(MS);
    image1.Picture.Assign(jpgImg)
  finally
    FreeAndNil(MS);
    FreeAndNil(jpgImg);
    IdHTTP1.Free;
    IdSSL.Free;
  end;
end;

procedure TfMain.addfileName;
var
  mediaFile: tMediaFile;
  aParentNode: TTreeNode;
  aNode: TTreeNode;
  sPath, sFile: String;
  isDirectory: Boolean;
begin
  //
  isDirectory := TDirectory.Exists(sFileName);
  if not isDirectory then
  begin
    // File to Add .....
    sPath := tpath.GetDirectoryName(sFileName);
    sFile := tpath.GetFileNameWithoutExtension(sFileName);
  end
  else
  begin
    sPath := sFileName;
    sFile := sFileName;
  end;

  aParentNode := findNode(sPath);
  if aParentNode = nil then
  begin
    if fileexists(sFileName) then
    begin
      mediaFile := tMediaFile.Create(sFileName);
      aNode := sTVMedias.Items.AddObject(nil, sFile, mediaFile);
      aNode.ImageIndex := 0;
    end
    else
    begin
      aParentNode := sTVMedias.Items.Add(nil, sFile);
      if TDirectory.Exists(sFileName) then
      begin
        aParentNode.HasChildren := True;
        aParentNode.ImageIndex := 2;
      end;
    end;
  end
  else
  begin
    mediaFile := tMediaFile.Create(sFileName);
    aNode := sTVMedias.Items.AddChildObject(aParentNode, sFile, mediaFile);
    aNode.ImageIndex := 0;
    if mediaFile.Tags.CoverArts.Count > 0 then
      aNode.ImageIndex := 1;
    if TDirectory.Exists(sFileName) then
    begin
      aNode.HasChildren := True;
      aNode.ImageIndex := 2;
    end;
  end;
  SetPBPosition;
  Application.ProcessMessages;

end;

procedure TfMain.ExpandNode;
begin
  if aNode <> nil then
  begin
    aNode.Expand(False);
    aNode := Nil;
  end;
  sDEFolder.Enabled := True;
end;

function TfMain.findNode(sLabel: String): TTreeNode;
var
  i: Integer;
  sParent: String;
begin
  Result := Nil;
  i := 0;

  while i <= sTVMedias.Items.Count - 1 do
  begin
    if sTVMedias.Items[i].Text = sLabel then
    begin
      Result := sTVMedias.Items[i];
      i := sTVMedias.Items.Count;
    end;
    inc(i);
  end;
  if Result = nil then
  begin
    sParent := TDirectory.GetParent(sLabel);
    if sParent <> '' then
      Result := findNode(sParent);
  end;

end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if thListMP3 <> Nil then
  begin
    if not thListMP3.Terminated then
      thListMP3.Terminate;
    while not thListMP3.Terminated do
      Application.ProcessMessages;
  end;

  jConfig.SaveTo(TDirectory.GetCurrentDirectory + '\config.json');
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  Volume: Double;
  ReleaseCodeString: string;
  SerialNumber : longint;
begin
  // * Never forget to init BASS
  GlobalMediaFile := tMediaFile.Create;
  BASS_Init(-1, 44100, 0, Self.handle, 0);

  ZeroMemory(@Params, SizeOf(TSpectrum3D_CreateParams));
  Params.ParentHandle := sPanel3.handle;
  Params.AntiAliasing := 4;
  Sprectrum3D := Spectrum3D_Create(@Params);
  Spectrum3D_GetParams(Sprectrum3D, @Settings);
  Settings.ShowText := True;
  Spectrum3D_SetParams(Sprectrum3D, @Settings);

  sGauge1.MaxValue := High(Word) div 2 + 1;
  sGauge2.MaxValue := High(Word) div 2 + 1;
  UpdateVuMetre(0, 0);

  Volume := BASS_GetVolume;
  tbVolume.Position := 100 - Round(Volume * 100);
  OpenConfig;
  initGrid;

  GetRegistrationInformation (ReleaseCodeString, SerialNumber);
  if not IsReleaseCodeValid (ReleaseCodeString, SerialNumber) then
  begin
    Caption := Caption + ' Unregistered Demo!';
    bsRegister.Visible := true;
    isRegistered := false;
  end
  else
  begin
    Caption := caption + ' Registered';
    isRegistered := true;
  end;

end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Spectrum3D_Free(Sprectrum3D);
  BASS_Stop;
  BASS_Free;
  if GlobalMediaFile <> nil then
    GlobalMediaFile.Destroy;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssAlt in Shift then
  begin
    case Key of
      69:
        showExplorer;
      80:
        showPlayList;
      VK_F1:
        sShellTreeView1.SetFocus;
      VK_F2:
        sgList.SetFocus;
      VK_F3:
        slbPlaylist.SetFocus;
    end;

  end
  else
  begin
    case Key of
      VK_MEDIA_PLAY_PAUSE:
        begin
          sButton2Click(Sender);
        end;
      VK_MEDIA_STOP:
        begin
          sButton1Click(Sender);
        end;
      VK_MEDIA_PREV_TRACK:
        begin
          PlayPrevTrack;
        end;
      VK_MEDIA_NEXT_TRACK:
        begin
          PlayNextTrack(Sender);
        end;
    end;
  end;
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  Spectrum3D_ReInitialize(Sprectrum3D);
  Spectrum3D_ReAlign(Sprectrum3D, sPanel3.handle);
end;

procedure TfMain.FormShow(Sender: TObject);
var
  cols: Integer;
begin
end;

procedure TfMain.GetImgLink;
begin

end;

procedure TfMain.initGrid;
  procedure cleanObjects;
  var
    i: Integer;
  begin
    i := 1;
    while i <= sgList.RowCount - 1 do
    begin

      inc(i);
    end;
  end;

begin
  //
  sgList.Clear;
  sgList.RowCount := 2;
  sgList.ColWidths[0] := 486;
  sgList.ColWidths[1] := 225;
  sgList.ColWidths[2] := 225;
  sgList.ColWidths[3] := 192;
  sgList.ColWidths[4] := 65;

  sgList.Cells[0, 0] := 'Fichier';
  sgList.Cells[1, 0] := 'Artiste';
  sgList.Cells[2, 0] := 'Titre';
  sgList.Cells[3, 0] := 'Album';
  sgList.Cells[4, 0] := 'Cover';

end;

procedure TfMain.sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  index: Integer;
  i: Integer;
begin

  if sgList.EditMode then
  begin
    if (Key = VK_NUMPAD1) and (ssCtrl in Shift) then
    begin
      removeKeyFromStack;
      sgList.Cells[1, sgList.Row] := sgList.NormalEdit.SelText;

    end;
    if (Key = VK_NUMPAD2) and (ssCtrl in Shift) then
    begin
      removeKeyFromStack;
      sgList.Cells[2, sgList.Row] := sgList.NormalEdit.SelText;

    end;
    if Key = VK_ESCAPE then
    begin
      sgList.Options := [goRowSelect, goRangeSelect];
    end;
  end
  else
  begin
    if Key = VK_ADD then
    begin
      i := 0;
      while i <= sgList.RowSelectCount - 1 do
      begin
        AddToPlayList(sgList.SelectedRow[i]);
        inc(i);
      end;
    end;

    if Key = VK_RETURN then
    begin
      if Shift = [] then
      begin
        if not(goEditing in sgList.Options) then
        begin
          sgList.Options := [goEditing, goTabs];
          sgList.Col := 1;
          sgList.EditCell(1, sgList.Row);
        end
        else
        begin
          sgList.EditCell(sgList.Col, sgList.Row);
        end;
        // sgList.EditMode := True;
      end
      else
      begin
        if Shift = [ssCtrl] then
        begin
          BASS_ChannelStop(Channel);
          PlayStream(sgList.Cells[0, sgList.Row]);
        end
        else
        begin

          index := -1;
          i := 0;
          while i <= sgList.RowSelectCount - 1 do
          begin
            if i = 0 then
            begin
              if not(ssCtrl in Shift) then
              begin
                if (ssShift in Shift) then
                  index := AddToPlayList(sgList.SelectedRow[i]);
                BASS_ChannelStop(Channel);
                if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_STOPPED then
                begin
                  slbPlaylist.ItemIndex := index;
                  PlayStream(tMediaFile(slbPlaylist.Items.Objects[index]).Tags.FileName);
                end;

              end;
            end;
            inc(i);
          end;
        end;
      end;

      removeKeyFromStack;
    end;

    if Key = VK_DELETE then
    begin
      if ssShift in Shift then
        if not sgList.EditMode then
          initGrid;
      removeKeyFromStack;
    end;
  end;

end;

procedure TfMain.sgListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  delais := 0;
  momentdown := time;
end;

procedure TfMain.sgListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  momentup: ttime;
begin
  momentup := time;
  delais := MilliSecondsBetween(momentup, momentdown);
  if delais >= 100 then
  begin
    sgList.Options := [goEditing];
    sgList.EditMode := True;

  end;

end;

procedure TfMain.sgListRowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
var
  pMediaFile: tMediaFile;
begin
  // Afficher la pochette si elle existe
  if sgList.Cells[0, NewRow] <> '' then
  begin
    pMediaFile := tMediaFile.Create(sgList.Cells[0, NewRow]);
    ListCoverArts(image1, pMediaFile.Tags);
    pMediaFile.Destroy;
  end;
end;

procedure TfMain.showExplorer;
begin
  if sROPMedia.Collapsed then
  begin
    sROPMedia.ChangeState(False, True);
    sShellTreeView1.SetFocus;
  end
  else
    sROPMedia.ChangeState(True, True);
end;

procedure TfMain.showPlayList;
begin
  if sROPPlaylist.Collapsed then
  begin
    sROPPlaylist.ChangeState(False, True);
    slbPlaylist.SetFocus;
  end
  else
    sROPPlaylist.ChangeState(True, True);

end;

procedure TfMain.ResetPB;
begin
  pb1.Position := 0;
end;

procedure TfMain.savePlaylist;
var
  Json: ISuperObject;
  i: Integer;
  pMediaFile: tMediaFile;
begin
  if sSaveDialog1.Execute then
  begin
    i := 0;
    Json := SO;
    while i <= slbPlaylist.Items.Count - 1 do
    begin
      if slbPlaylist.Items.Objects[i] <> Nil then
      begin
        pMediaFile := tMediaFile(slbPlaylist.Items.Objects[i]);
        with Json.A['tracks'].O[i] do
        begin
          S['fileName'] := pMediaFile.Tags.FileName;
        end;
      end;
      inc(i);
    end;
    Json.SaveTo(sSaveDialog1.FileName);
  end;

end;

procedure TfMain.sButton1Click(Sender: TObject);
begin
  BASS_ChannelStop(Channel);
  sButton2.ImageIndex := 2;
end;

procedure TfMain.sButton2Click(Sender: TObject);
begin
  if Channel = 0 then
  begin
    // start playing
    if slbPlaylist.ItemIndex > -1 then
    begin
      BASS_ChannelStop(Channel);
      PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
      sButton2.ImageIndex := 3;
    end;
  end
  else
  begin
    if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
    begin
      BASS_ChannelPause(Channel);
      sButton2.ImageIndex := 0;
    end
    else
    begin
      BASS_ChannelPlay(Channel, False);
      sButton2.ImageIndex := 3;
    end;
  end;
end;

procedure TfMain.sButton3Click(Sender: TObject);
var
  fCoverSearch: tfCoverSearch;
begin
  fCoverSearch := tfCoverSearch.Create(Self);
  if trim(sgList.Cells[1, sgList.Row]) + trim(sgList.Cells[2, sgList.Row]) = '' then
    fCoverSearch.Title := trim(sgList.Cells[0, sgList.Row])
  else

  begin
    fCoverSearch.Artist := sgList.Cells[1, sgList.Row];
    fCoverSearch.Title := sgList.Cells[2, sgList.Row];
  end;
  fCoverSearch.Show;
  fCoverSearch.StartSearch;
  // fCoverSearch.free;
end;

procedure TfMain.sButton4Click(Sender: TObject);
begin
  savePlaylist;
end;

procedure TfMain.sButton5Click(Sender: TObject);
begin
  loadPlaylist;
end;

procedure TfMain.sButton9Click(Sender: TObject);
var
  pfSelectDirectory: TfSelectDirectory;
begin
  pfSelectDirectory := TfSelectDirectory.Create(Self);
  pfSelectDirectory.ShowModal;
  pfSelectDirectory.Free;
end;

procedure TfMain.sDEFolderAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
begin
  if name <> '' then
    if name <> aPath then
    begin
      aPath := Name;
      jConfig.S['startFolder'] := aPath;
      sDEFolder.Enabled := False;
      sTVMedias.Items.Clear;
      thListMP3.Execute(Self);
    end;
end;

procedure TfMain.setPBMax;
begin
  pb1.Max := iMax;
end;

procedure TfMain.SetPBPosition;
begin
  pb1.Position := pb1.Position + 1;
end;

procedure TfMain.slbPlaylistItemIndexChanged(Sender: TObject);
begin
  //
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_STOPPED then
    updatePlayingInfos(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
end;

procedure TfMain.slbPlaylistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if slbPlaylist.ItemIndex > -1 then
    begin
      BASS_ChannelStop(Channel);
      PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
      sButton2.ImageIndex := 3;
    end;
    removeKeyFromStack;
  end;

  if Key = VK_DELETE then
  begin
    if slbPlaylist.ItemIndex > -1 then
    begin
      playlistRemoveItem(slbPlaylist.ItemIndex);
    end;
    removeKeyFromStack;
  end;
end;

procedure TfMain.sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: Boolean);
var
  sExtension: string;
begin
  CanAdd := True;
  if not AFolder.IsFileFolder then
  begin
    sExtension := tpath.GetExtension(AFolder.PathName);
    CanAdd := (pos(uppercase(sExtension), sValidExtensions) > 0);
  end;
end;

procedure TfMain.sShellTreeView1Change(Sender: TObject; Node: TTreeNode);
var
  aNode: TTreeNode;
  pMediaFile: tMediaFile;
begin
  //
  aNode := sShellTreeView1.Selected;
  if not TacShellFolder(aNode.data).IsFileFolder then
  begin
    pMediaFile := tMediaFile.Create(TacShellFolder(aNode.data).PathName);
    if pMediaFile.Tags.CoverArtCount > 0 then
    begin
      ListCoverArts(image1, pMediaFile.Tags);
    end;
    pMediaFile.Free;
  end;
end;

procedure TfMain.sShellTreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  //
  if (Node <> Nil) then
  begin

    if tMediaUtils.isValidExtension2(TacShellFolder(Node.data).PathName) > -1 then
    begin
      // sMemo1.Lines.add(TacShellFolder(Node.data).PathName);
      GlobalMediaFile.Tags.Clear;
      GlobalMediaFile.Tags.ParseCoverArts := True;
      GlobalMediaFile.Tags.LoadFromFile(TacShellFolder(Node.data).PathName);
      if GlobalMediaFile.Tags.CoverArtCount > 0 then
        Node.ImageIndex := 1
      else
        Node.ImageIndex := 0;
    end
    else
    begin
      if TDirectory.Exists(TacShellFolder(Node.data).PathName) then
        Node.ImageIndex := 2;
    end;

  end;
end;

procedure TfMain.sShellTreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  aNode: TTreeNode;
begin
  if Shift = [ssCtrl] then
  begin
    aNode := sShellTreeView1.Selected;
    if not TacShellFolder(aNode.data).IsFileFolder then
    begin
      // ListCoverArts(sImage1,TacShellFolder(aNode.data).PathName);
      BASS_ChannelStop(Channel);
      PlayStream(TacShellFolder(aNode.data).PathName);
    end;
    removeKeyFromStack;
  end;
  if Key = VK_ADD then
    begin
      aNode := sShellTreeView1.Selected;
      if not TacShellFolder(aNode.data).IsFileFolder then
      begin
         AddToPlayList(aNode,false);
      end
      else
      begin
        aPath := TacShellFolder(aNode.data).PathName;
        thAddToPlayList.execute(self);
      end;
      removeKeyFromStack;
    end;
end;

procedure TfMain.sShellTreeView1KeyPress(Sender: TObject; var Key: Char);
var
  aNode: TTreeNode;
begin
  if Key = #13 then
  begin
    if sShellTreeView1.Selected <> nil then
    begin
      aNode := sShellTreeView1.Selected;
      if not TacShellFolder(aNode.data).IsFileFolder then
      begin
        AddFileToGrid(TacShellFolder(aNode.data).PathName);
      end
      else
      begin
        aPath := TacShellFolder(aNode.data).PathName;
        thListMP3.Execute(Self);
      end;
    end;
    Key := #0;
  end;
end;

procedure TfMain.sTVMediasChange(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node.data) then
  begin
    // ListCoverArts(sImage2, tMediaFile(Node.data).Tags);
  end;

end;

procedure TfMain.ListCoverArts(aImage: TsImage; Tags: TTags);
var
  i: Integer;
  ImageJPEG: TJPEGImage;
  ImagePNG: TPNGImage;
  ImageGIF: TGIFImage;
  BitMap: TBitmap;
begin
  // * List cover arts
  if Tags.CoverArtCount > 0 then
  begin
    for i := 0 to Tags.CoverArtCount - 1 do
    begin
      BitMap := TBitmap.Create;
      try
        with Tags.CoverArts[i] do
        begin
          Stream.Seek(0, soBeginning);
          case PictureFormat of
            tpfJPEG:
              begin
                ImageJPEG := TJPEGImage.Create;
                try
                  ImageJPEG.LoadFromStream(Stream);
                  BitMap.Assign(ImageJPEG);
                finally
                  FreeAndNil(ImageJPEG);
                end;
              end;
            tpfPNG:
              begin
                ImagePNG := TPNGImage.Create;
                try
                  ImagePNG.LoadFromStream(Stream);
                  BitMap.Assign(ImagePNG);
                finally
                  FreeAndNil(ImagePNG);
                end;
              end;
            tpfGIF:
              begin
                ImageGIF := TGIFImage.Create;
                try
                  ImageGIF.LoadFromStream(Stream);
                  BitMap.Assign(ImageGIF);
                finally
                  FreeAndNil(ImageGIF);
                end;
              end;
            tpfBMP:
              begin
                BitMap.LoadFromStream(Stream);
              end;
          end;
          if Assigned(BitMap) then
            aImage.Picture.BitMap.Assign(BitMap)
          else
            aImage.Picture.Assign(Nil);
        end;
      finally
        FreeAndNil(BitMap);
      end;
    end;
  end
  else
  begin
    aImage.Picture.Assign(Nil);
    aImage.refresh;
    Application.ProcessMessages;
    aImage.Picture.BitMap.Assign(Image2.Picture.BitMap);
  end;
end;

procedure TfMain.loadPlaylist;
var
  i: Integer;
  pMediaFile: tMediaFile;
  Json: ISuperObject;
begin
  if sOpenDialog1.Execute then
  begin
    slbPlaylist.Clear;
    i := 0;
    Json := TSuperObject.ParseFile(sOpenDialog1.FileName);
    while i <= Json.A['tracks'].Length - 1 do
    begin
      pMediaFile := tMediaFile.Create(Json.A['tracks'].O[i].S['filename']);
      slbPlaylist.Items.AddObject(tpath.GetFileNameWithoutExtension(pMediaFile.Tags.FileName), pMediaFile);
      inc(i);
    end;
  end;
end;

procedure TfMain.ListCoverArts(aImage: TsImage; sFileName: String);
var
  pMediaFile: tMediaFile;
begin
  pMediaFile := tMediaFile.Create(sFileName);
  ListCoverArts(aImage, pMediaFile.Tags);
  pMediaFile.Destroy;
end;

procedure TfMain.OpenConfig;
var
  sPath: String;
begin
  //
  sPath := TDirectory.GetCurrentDirectory;
  if fileexists(sPath + '\config.json') then
  begin
    jConfig := TSuperObject.ParseFile(sPath + '\config.json');
    // SynMemo1.Lines.Text := jConfig.AsJSON(True);
    aPath := jConfig.S['startFolder'];
  end
  else
  begin
    jConfig := SO;
    aPath := 'c:\';
  end;
  // thListMP3.Execute(Self);
end;

procedure TfMain.playlistRemoveItem(index: Integer);
begin
  if index <= slbPlaylist.Items.Count - 1 then
  begin
    if slbPlaylist.Items.Objects[index] <> nil then
    begin
      tMediaFile(slbPlaylist.Items.Objects[index]).Destroy;
      slbPlaylist.Items.Delete(index);
      if index <= slbPlaylist.Items.Count - 1 then
        slbPlaylist.ItemIndex := index;
    end;
  end;
end;

procedure TfMain.sTVMediasExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  if Node.Count = 0 then
  begin
    aPath := Node.Text;
    aNode := Node;
    thListMP3.Execute(Self);
  end;
end;

procedure TfMain.sTVMediasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  aNode: TTreeNode;
  index: Integer;
  aMediaFile: tMediaFile;
begin
  if Key = VK_RETURN then
  begin
    aNode := sTVMedias.Selected;
    if aNode.HasChildren then // The node is a folder
    begin
      // AddToPlayList(aNode, False);
    end
    else
    begin
      if Assigned(aNode.data) then
      begin
        // index := AddToPlayList(tMediaFile(aNode.data).Tags);
        if not(ssCtrl in Shift) then
        begin
          if (ssShift in Shift) then
            BASS_ChannelStop(Channel);
          if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_STOPPED then
          begin
            slbPlaylist.ItemIndex := index;
            PlayStream(tMediaFile(slbPlaylist.Items.Objects[index]).Tags.FileName);
          end;

        end

      end;
    end;
    removeKeyFromStack;
  end;

end;

procedure TfMain.thAddToPlayListExecute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
  sExt: String;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);

  i := 0;
  while i <= Length(aFiles) - 1 do
  begin
    sExt := tpath.GetExtension(aFiles[i]);
    bAdd := (pos(uppercase(sExt), sValidExtensions) > 0);
    if bAdd then
    begin
      sFile := aFiles[i];
      thAddToPlayList.Synchronize(TfMain(Params).AddToPlayListTH);
    end;
    inc(i);
  end;

end;

procedure TfMain.thDisplayExecute(Sender: TObject; Params: Pointer);
var
  Level: Cardinal;
  LeftLevel: Word;
  RightLevel: Word;

begin
  Level := BASS_ChannelGetLevel(Channel);
  // * Separate L & R channel
  LeftLevel := LoWord(Level);
  RightLevel := HiWord(Level);
  // * Set the VUs
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
    // * Logarithmic

    sGauge1.Progress := LeftLevel;
    sGauge2.Progress := RightLevel;

  end
  else
  begin
    sGauge1.Progress := sGauge1.Progress - 1000;
    sGauge2.Progress := sGauge2.Progress - 1000;
  end;
  // * Playing position
  AdjustingPlaybackPosition := True;
  TrackBar1.Position := BASS_ChannelGetPosition(Channel, BASS_POS_BYTE);
  AdjustingPlaybackPosition := False;

end;

procedure TfMain.thListMP3Execute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
  sExt: String;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);

  i := 0;
  while i <= Length(aFiles) - 1 do
  begin
    sExt := tpath.GetExtension(aFiles[i]);
    bAdd := (pos(uppercase(sExt), sValidExtensions) > 0);
    if bAdd then
    begin
      sFile := aFiles[i];
      thListMP3.Synchronize(TfMain(Params).AddFileToGridTH);
    end;
    inc(i);
  end;

end;

procedure TfMain.Timer1Timer(Sender: TObject);
var
  Level: Cardinal;
  LeftLevel: Word;
  RightLevel: Word;

begin
  Level := BASS_ChannelGetLevel(Channel);
  // * Separate L & R channel
  LeftLevel := LoWord(Level);
  RightLevel := HiWord(Level);
  // * Set the VUs
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
    // * Logarithmic

    // sGauge1.Progress := LeftLevel;
    // sGauge2.Progress := RightLevel;
    UpdateVuMetre(LeftLevel, RightLevel);
  end
  else
  begin
    sGauge1.Progress := sGauge1.Progress - 1000;
    sGauge2.Progress := sGauge2.Progress - 1000;
    UpdateVuMetre(0, 0);
  end;
  // * Playing position
  AdjustingPlaybackPosition := True;
  TrackBar1.Position := BASS_ChannelGetPosition(Channel, BASS_POS_BYTE);
  AdjustingPlaybackPosition := False;
end;

procedure TfMain.TrackBar1Change(Sender: TObject);
begin
  if NOT AdjustingPlaybackPosition then
  begin
    BASS_ChannelSetPosition(Channel, TrackBar1.Position, BASS_POS_BYTE);
  end;
end;

procedure TfMain.tbVolumeChange(Sender: TObject);
var
  Volume: Double;
begin
  Volume := (100 - tbVolume.Position) / tbVolume.Max;
  BASS_SetVolume(Volume);

end;

procedure TfMain.tbVolumeSkinPaint(Sender: TObject; Canvas: TCanvas);
var
  Points: array [0 .. 2] of TPoint;
  C: TColor;
  R: TRect;
begin

  R := tbVolume.ChannelRect;
  OffsetRect(R, WidthOf(R), 0);
  InflateRect(R, 0, -HeightOf(tbVolume.ThumbRect) div 2);
  Points[1] := R.TopLeft;
  Points[0] := Point(R.Left, R.Bottom);
  if not tbVolume.Reversed then
    Points[2] := Point(R.Right, R.Top)
  else
    Points[2] := Point(R.Right, R.Bottom);
  C := acColorToRGB(clBtnText);

  acgpFillPolygon(Canvas.handle, TColor($44000000 or Cardinal(C)), PPoint(@Points[0]), 3);

end;

procedure TfMain.updatePlayingInfos(aTags: TTags);
var
  R: TRect;
  bm2: TBitmap;
begin
  kglArtist.Caption := aTags.GetTag('ARTIST');
  kglTitle.Caption := FormatTextWithEllipse(aTags.GetTag('TITLE'));

  ListCoverArts(sImage1, aTags);
  with sImage1.Canvas do
  begin
    bm2 := TBitmap.Create;
    bm2.SetSize(cliprect.Width, (cliprect.height div 4));
    bm2.Canvas.Brush.Color := clTeal;
    bm2.Canvas.Brush.Style := bsSolid;
    R := TRect.Create(0, 0, bm2.Width, bm2.height);
    bm2.Canvas.Fillrect(R);
    Draw(0, cliprect.height - (cliprect.height div 4), bm2, 200);
    bm2.Free;
  end;
end;

procedure TfMain.DrawTransparentRectangle(Canvas: TCanvas; Rect: TRect; Color: TColor; Transparency: Integer);
var
  X: Integer;
  Y: Integer;
  C: TColor;
  R, G, B: Integer;
  RR, RG, RB: Integer;
begin
  RR := GetRValue(Color);
  RG := GetGValue(Color);
  RB := GetBValue(Color);

  for Y := Rect.Top to Rect.Bottom - 1 do
    for X := Rect.Left to Rect.Right - 1 do
    begin
      C := Canvas.Pixels[X, Y];
      R := Round(0.01 * (Transparency * GetRValue(C) + (100 - Transparency) * RR));

      G := Round(0.01 * (Transparency * GetGValue(C) + (100 - Transparency) * RG));

      B := Round(0.01 * (Transparency * GetBValue(C) + (100 - Transparency) * RB));

      Canvas.Pixels[X, Y] := RGB(R, G, B);
    end;
end;

procedure TfMain.updatePlayingInfos(sFileName: String);
var
  pMediaFile: tMediaFile;
begin
  pMediaFile := tMediaFile.Create(sFileName);
  updatePlayingInfos(pMediaFile.Tags);
  pMediaFile.Destroy;
end;

procedure TfMain.updateTV;
begin
  sTVMedias.refresh;
end;

procedure TfMain.UpdateVuMetre(LeftLevel, RightLevel: Integer);

  procedure updateMeter(aImage: TsImage; iLevel: Integer; iMax: Integer);
  var
    R: TRect;
    w: Integer;
    l: Integer;
    barwidth: Integer;
    p, p2: Integer;
    bm2: TBitmap;

  begin
    aImage.Picture.BitMap.Assign(sImage2.Picture.BitMap);
    with aImage.Canvas do
    begin
      bm2 := TBitmap.Create;
      w := iMax;
      p := Round(iLevel / w * 100);
      p2 := 100 - p;
      barwidth := cliprect.Width;
      l := Round(barwidth / 100 * p);
      bm2.SetSize(Round(cliprect.Width / 100 * p2), cliprect.height);
      bm2.Canvas.Brush.Color := clGray;
      bm2.Canvas.Brush.Style := bsSolid;
      R := TRect.Create(0, 0, bm2.Width, bm2.height);
      bm2.Canvas.Fillrect(R);
      Draw(l, 0, bm2, 220);
      bm2.Free;
    end;
  end;

begin
  //
  updateMeter(vuL, LeftLevel, sGauge1.MaxValue);
  updateMeter(VuR, RightLevel, sGauge2.MaxValue);
end;

end.
