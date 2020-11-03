unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types, Vcl.GraphUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, Vcl.StdCtrls, sPanel, Vcl.ExtCtrls, sSkinManager, sSkinProvider, sButton, Vcl.ComCtrls,
  sTreeView, acShellCtrls, sListView, sComboBoxes, sSplitter, Vcl.Buttons, sSpeedButton, System.ImageList, Vcl.ImgList, acAlphaImageList,
  acProgressBar, JvComponentBase, JvThread, sMemo, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, acImage, JPEG, PNGImage, GIFImg, TagsLibrary,
  acNoteBook, sTrackBar, acArcControls, sGauge, BASS, BassFlac, xSuperObject, sListBox, JvExControls, clipbrd, Spectrum3DLibraryDefs, bass_aac,
  MMSystem, uDeleteCover, JvaScrollText, acSlider, uSearchImage, sBitBtn, Vcl.OleCtrls, SHDocVw, activeX, acWebBrowser, Vcl.Grids, JvExGrids,
  JvStringGrid, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, Generics.collections,
  NetEncoding, Vcl.WinXCtrls, AdvUtil, AdvObj, BaseGrid, AdvGrid, dateutils, uCoverSearch, sDialogs, sLabel, sBevel, AdvMemo, acPNG,
  JvExComCtrls, JvProgressBar, KryptoGlowLabel, uni_RegCommon, Vcl.onguard, uRegister, Vcl.Menus, System.RegularExpressions, sEdit, sComboBox,
  sCheckBox, sPageControl, SynEditHighlighter, SynHighlighterJSON, System.StrUtils, sComboEdit, acPopupCtrls, uDM1, acAlphaHints, BtnListB,
  sScrollBox, uFrmPlayer, JvExStdCtrls, JvWinampLabel, uFormPlayer, acFontStore;

type

  TfMain = class(TForm)
    pnBack: TsPanel;
    sSkinProvider1: TsSkinProvider;
    sSkinManager1: TsSkinManager;
    pnToolbar: TsPanel;
    pnToolbarTreeView: TsPanel;
    pnStatus: TsPanel;
    sILIcons: TsAlphaImageList;
    pb1: TsProgressBar;
    thListMP3: TJvThread;
    sImage1: TsImage;
    sROPPlaylist: TsRollOutPanel;
    TrackBar1: TsTrackBar;
    Timer1: TTimer;
    sButton1: TsButton;
    sButton2: TsButton;
    slbPlaylist: TsListBox;
    pnMain: TsPanel;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sgList: TAdvStringGrid;
    btnUtils: TsButton;
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
    sImage2: TsImage;
    image1: TsImage;
    sGauge1: TsGauge;
    sGauge2: TsGauge;
    sPanel10: TsPanel;
    VuR: TsImage;
    vuL: TsImage;
    thAddToPlayList: TJvThread;
    bsRegister: TsButton;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    Add1: TMenuItem;
    PopupMenu2: TPopupMenu;
    PopupMenu21: TMenuItem;
    sAlphaImageList1: TsAlphaImageList;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sLabelFX2: TsLabelFX;
    sCB1: TsComboBox;
    sCB2: TsComboBox;
    sCB3: TsComboBox;
    ckRegEx01: TsCheckBox;
    ckRegEx02: TsCheckBox;
    ckRegEx03: TsCheckBox;
    btnRegex: TsButton;
    ckClearCovers: TsCheckBox;
    sEP03: TsComboBox;
    sEP01: TsComboBox;
    sEP02: TsComboBox;
    ropVisual: TsRollOutPanel;
    seRegEx: TsPopupBox;
    sBB1: TsBadgeBtn;
    sPageControl2: TsPageControl;
    tsVisual: TsTabSheet;
    tsEdit: TsTabSheet;
    sILTV: TsAlphaImageList;
    sBB2: TsBadgeBtn;
    sBB3: TsBadgeBtn;
    sEFROM02: tsEdit;
    sCKReplace02: TsCheckBox;
    sLabel1: TsLabel;
    sETO02: tsEdit;
    sComboBox1: TsComboBox;
    sPnReplace02: TsPanel;
    sCKReplace01: TsCheckBox;
    sCKReplace03: TsCheckBox;
    sLabel3: TsLabel;
    sPNReplace01: TsPanel;
    sLabel2: TsLabel;
    sETO01: tsEdit;
    sEFROM01: tsEdit;
    sComboBox2: TsComboBox;
    sPNReplace03: TsPanel;
    sLabel4: TsLabel;
    sETO03: tsEdit;
    sEFROM03: tsEdit;
    sComboBox4: TsComboBox;
    sSplitView1: TsSplitView;
    sBitBtn1: TsBitBtn;
    sILBtns: TsAlphaImageList;
    sAlphaHints1: TsAlphaHints;
    sILNoCover: TsAlphaImageList;
    sButton3: TsButton;
    sPnPlayer: TsPanel;
    sShellTreeView1: TsShellTreeView;
    procedure thListMP3Execute(Sender: TObject; Params: Pointer);
    procedure sTVMediasChange(Sender: TObject; Node: TTreeNode);
    procedure sTVMediasExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
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
    procedure sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: Boolean);
    procedure sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgListRowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sShellTreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure thDisplayExecute(Sender: TObject; Params: Pointer);
    procedure FormResize(Sender: TObject);
    procedure tbVolumeSkinPaint(Sender: TObject; Canvas: TCanvas);
    procedure sShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure sShellTreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure thAddToPlayListExecute(Sender: TObject; Params: Pointer);
    procedure bsRegisterClick(Sender: TObject);
    procedure slCoversSliderChange(Sender: TObject);
    procedure PopupMenu21Click(Sender: TObject);
    procedure sgListRightClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure sgListSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure btnRegexClick(Sender: TObject);
    procedure sgListKeyPress(Sender: TObject; var Key: Char);
    procedure sgListGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure ckRegEx01Click(Sender: TObject);
    procedure ckRegEx02Click(Sender: TObject);
    procedure ckRegEx03Click(Sender: TObject);
    procedure sCB3Change(Sender: TObject);
    procedure sCB1Change(Sender: TObject);
    procedure sCB2Change(Sender: TObject);
    procedure seRegExChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sROPPlaylistAfterCollapse(Sender: TObject);
    procedure sROPPlaylistAfterExpand(Sender: TObject);
    procedure sROPMediaAfterCollapse(Sender: TObject);
    procedure sROPMediaAfterExpand(Sender: TObject);
    procedure sCKReplace02Click(Sender: TObject);
    procedure sCKReplace01Click(Sender: TObject);
    procedure sCKReplace03Click(Sender: TObject);
    procedure sSplitView1Opened(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sAlphaHints1ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo; var Frame: TFrame);
    procedure btnUtilsClick(Sender: TObject);
    procedure seRegExBeforePopup(Sender: TObject);
    procedure seRegExKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sButton3Click(Sender: TObject);
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
    dMultiChoices: tDictionary<String, TStrings>;
    procedure PlayStream(FileName: String);
    procedure setPBMax;
    procedure SetPBPosition;
    procedure ResetPB;
    procedure updateTV;
    procedure initGrid;
    procedure removeKeyFromStack;
    function AddToPlayList(aMediaFile : tMediaFile) : Integer; overload;
    function AddToPlayList(ARow: Integer): Integer; overload;
    function AddToPlayList(aNode: TTreeNode; bRecurse: Boolean): Integer; overload;
    Procedure AddFolderToGrid(sFolder: String);
    function AddFileToGrid(sFile: String): Integer;
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
    function ImageCount(aFile: String): Integer;
    Procedure RefreshCover(ARow: Integer);
    function GetwindowsVolume: Integer;
    procedure setGridRow;
    Procedure ExtractTags(iRow: Integer; bPreview: Boolean = false);
    Procedure SaveTags(iRow: Integer);
    procedure SaveCover(var m: Tmsg); Message WM_REFRESH_COVER;
    Procedure fillTagCombos;
    procedure RemoveCovers(aTags: TTags);
    procedure InitDictionaries;
    procedure AddToDictionary(cKey: string; sValue: string);
    procedure AssignMultiChoice(sCBTAg: TsComboBox; sCBChoice: TsComboBox);
    Procedure RefreshTagsCombos;
    Procedure FillTagLists;
    Procedure UpdateTagLists(iCol: Integer; sValue: String);
    procedure OpenRollOuts(var m: Tmsg); Message WM_OPEN_ROLLOUTS;
    procedure RefreshVisuals;
    function RxReplace(const Match: tMatch): String;
    Procedure GetNoCoverImage(aPicture: tPicture);
    function getExpression: String;
    Procedure OpenPlayer;
    procedure PreviewTrack(aNode : tTreeNode); overload;
    procedure PreviewTrack(aMediaFile : tMediafile); overload;
    procedure PreviewTrack(sFileName : String); overload;
    procedure AddDirectlyToPlayList;
    Procedure AddToGrid(bReset: Boolean);
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
  fCoverSearch: tfCoverSearch;
  fFrmPlayer: tFrmPlayer;

implementation

{$R *.dfm}

uses
  JvDynControlEngineVcl, acntUtils, acgpUtils, sVCLUtils, uRegEx, uFileFrame;

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
    Channel := BASS_StreamCreateFile(false, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else if (uppercase(tpath.GetExtension(FileName)) = '.M4A') or (uppercase(tpath.GetExtension(FileName)) = '.MP4') then
    Channel := BASS_AAC_StreamCreateFile(false, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE)
  else
    Channel := BASS_FLAC_StreamCreateFile(false, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);

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

procedure TfMain.PopupMenu21Click(Sender: TObject);
var
  GlobalMediaFile: tMediaFile;
begin
  // test if multiple lines selected.....

  if sgList.Objects[1, sgList.Row] <> Nil then
    GlobalMediaFile := tMediaFile(sgList.Objects[1, sgList.Row]);

  if sgList.RowSelectCount > 1 then
  begin
    fCoverSearch.seTitle.BoundLabel.Caption := 'Album';
    if trim(sgList.Cells[2, sgList.Row]) + trim(sgList.Cells[4, sgList.Row]) = '' then
      fCoverSearch.Title := GlobalMediaFile.Tags.FileName
    else

    begin
      fCoverSearch.sFile := GlobalMediaFile.Tags.FileName;
      fCoverSearch.Artist := sgList.Cells[2, sgList.Row];
      fCoverSearch.Title := sgList.Cells[4, sgList.Row];
    end;
  end
  else
  begin
    fCoverSearch.seTitle.BoundLabel.Caption := 'Title';
    if trim(sgList.Cells[2, sgList.Row]) + trim(sgList.Cells[3, sgList.Row]) = '' then
      fCoverSearch.Title := GlobalMediaFile.Tags.FileName
    else

    begin
      fCoverSearch.sFile := GlobalMediaFile.Tags.FileName;
      fCoverSearch.Artist := sgList.Cells[2, sgList.Row];
      fCoverSearch.Title := sgList.Cells[3, sgList.Row];
    end;
  end;

  fCoverSearch.image1.Picture.Assign(Nil);
  fCoverSearch.ShowModal;
end;

procedure TfMain.PreviewTrack(sFileName: String);
begin
  //PlayStream(sFileName);
  fFrmPlayer.PlayStream(sFilename);
end;

procedure TfMain.PreviewTrack(aMediaFile: tMediafile);
begin
   PreviewTrack(aMediaFile.tags.FileName);
end;

procedure TfMain.PreviewTrack(aNode : tTreeNode);
begin
  if not TacShellFolder(aNode.data).IsFileFolder then
  begin
    // ListCoverArts(sImage1,TacShellFolder(aNode.data).PathName);
    BASS_ChannelStop(Channel);
    PreviewTrack(TacShellFolder(aNode.data).PathName);
  end;
end;

procedure TfMain.RefreshCover(ARow: Integer);
var
  aFile: String;
  i: Integer;
  GlobalMediaFile: tMediaFile;
begin
  // SaveCover;
  i := 0;
  if sgList.Objects[1, ARow] <> Nil then
  begin
    GlobalMediaFile := tMediaFile(sgList.Objects[1, ARow]);
    aFile := GlobalMediaFile.Tags.FileName;
    GlobalMediaFile.Tags.clear;
    GlobalMediaFile.LoadTags(aFile);
    ListCoverArts(image1, GlobalMediaFile.Tags);
    sgList.AddImageIdx(5, ARow, 0, haCenter, vaCenter);
  end;
  Application.ProcessMessages;

end;

procedure TfMain.RefreshTagsCombos;
begin
  sCB1Change(Nil);
  sCB2Change(Nil);
  sCB3Change(Nil);
  sEP01.Text := '';
  sEP02.Text := '';
  sEP03.Text := '';
end;

procedure TfMain.RefreshVisuals;
begin
  Spectrum3D_ReInitialize(Sprectrum3D);
  Spectrum3D_ReAlign(Sprectrum3D, sPanel3.handle);
  image1.Repaint;
  Application.ProcessMessages;
end;

procedure TfMain.RemoveCovers(aTags: TTags);
var
  i: Integer;
begin
  while aTags.CoverArtCount > 0 do
  begin
    aTags.DeleteCoverArt(0);
  end;

end;

procedure TfMain.removeKeyFromStack;
var
  Mgs: Tmsg;
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

procedure TfMain.AddDirectlyToPlayList;
begin
  aNode := sShellTreeView1.Selected;
  if not TacShellFolder(aNode.data).IsFileFolder then
  begin
    AddToPlayList(aNode, false);
  end
  else
  begin
    aPath := TacShellFolder(aNode.data).PathName;
    thAddToPlayList.Execute(self);
  end;
end;

function TfMain.AddFileToGrid(sFile: String): Integer;
var
  ARow: Integer;
  pMediaFile: tMediaFile;
begin
  //
  ARow := sgList.RowCount - 1;
  if sgList.Cells[1, ARow] <> '' then
  begin
    sgList.RowCount := sgList.RowCount + 1;
    ARow := sgList.RowCount - 1;
  end;

  pMediaFile := tMediaFile.Create(sFile);
  try
    sgList.Objects[1, ARow] := pMediaFile;
    sgList.Cells[1, ARow] := tpath.GetFileName(sFile);
    sgList.Cells[2, ARow] := pMediaFile.Tags.GetTag('ARTIST');
    sgList.Cells[3, ARow] := pMediaFile.Tags.GetTag('TITLE');
    sgList.Cells[4, ARow] := pMediaFile.Tags.GetTag('ALBUM');

    AddToDictionary('ARTIST', pMediaFile.Tags.GetTag('ARTIST'));
    AddToDictionary('ALBUM', pMediaFile.Tags.GetTag('ALBUM'));

    Result := ARow;
    if pMediaFile.Tags.CoverArts.Count > 0 then
      sgList.AddImageIdx(5, ARow, 0, haCenter, vaCenter)
    else
      sgList.AddImageIdx(5, ARow, 1, haCenter, vaCenter);
  finally
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
    if aMediaFile <> Nil then
      result := AddToPlayList(aMediaFile);
  end
end;

function TfMain.AddToPlayList(aMediaFile: tMediaFile): Integer;
var
  sPath, sFile: String;
  index: Integer;
begin
  Result := -1;
  sPath := tpath.GetDirectoryName(aMediaFile.Tags.FileName);
  sFile := tpath.GetFileNameWithoutExtension(aMediaFile.Tags.FileName);

  index := fFrmPlayer.slbPlaylist.Items.IndexOf(sFile);
  if index = -1 then
  begin
    Result := fFrmPlayer.slbPlaylist.Items.AddObject(sFile, aMediaFile);
  end
  else
    Result := index;

end;

function TfMain.AddToPlayList(ARow: Integer): Integer;
var
  aMediaFile: tMediaFile;
  sPath, sFile: String;
  index: Integer;
begin
  Result := -1;
  aMediaFile := tMediaFile(sgList.Objects[1, ARow]);
  if aMediaFile <> nil then
     result := AddToPlayList(aMediaFile);
end;

procedure TfMain.AddToDictionary(cKey, sValue: string);
var
  aList: TStrings;
begin
  if dMultiChoices.TryGetValue(cKey, aList) then
  begin
    //
    if aList.IndexOf(sValue) = -1 then
      aList.Add(sValue);
  end;
end;

procedure TfMain.AddToGrid(bReset: Boolean);
var
  NewRow: Integer;
  GlobalMediaFile: tMediaFile;
begin
  if sShellTreeView1.Selected <> nil then
  begin
    aNode := sShellTreeView1.Selected;
    if bReset then
    begin
      // Clear grid before
      initGrid;
    end;
    if not TacShellFolder(aNode.data).IsFileFolder then
    begin
      NewRow := AddFileToGrid(TacShellFolder(aNode.data).PathName);
      if sgList.Objects[1, NewRow] <> Nil then
      begin
        GlobalMediaFile := tMediaFile.Create(TacShellFolder(aNode.data).PathName);
        ListCoverArts(image1, GlobalMediaFile.Tags);
        GlobalMediaFile.Destroy;
      end;
    end
    else
    begin
      aPath := TacShellFolder(aNode.data).PathName;
      thListMP3.Execute(self);
    end;
  end;
end;



procedure TfMain.AddToPlayListTH;
var
  aMediaFile: tMediaFile;
  sPath: String;
  index: Integer;
begin
  aMediaFile := tMediaFile.Create(sFile);
  index := slbPlaylist.Items.IndexOf(sFile);
  if index = -1 then
  begin
    slbPlaylist.Items.AddObject(tpath.GetFileNameWithoutExtension(sFile), aMediaFile);
  end

end;

procedure TfMain.AssignMultiChoice(sCBTAg, sCBChoice: TsComboBox);
const
  arTags: tArray<String> = ['ALBUM', 'ARTIST'];
var
  sTag: String;
  sList: TStrings;
  iColumn: Integer;
begin
  //
  sTag := tTagKey(sCBTAg.Items.Objects[sCBTAg.ItemIndex]).sTag;
  if MAtchStr(sTag, arTags) then
  begin
    iColumn := tTagKey(sCBTAg.Items.Objects[sCBTAg.ItemIndex]).sCol;
    if iColumn > -1 then
    begin
      if dMultiChoices.TryGetValue(sTag, sList) then
        sCBChoice.Items.Assign(sList);
    end
    else
    begin
      sCBChoice.Items.clear;
    end;

  end
  else
    sCBChoice.Items.clear;

end;

procedure TfMain.bsRegisterClick(Sender: TObject);
var
  fRegister: tfRegister;
begin
  fRegister := tfRegister.Create(self);
  fRegister.ShowModal;
  fRegister.Free;
end;

procedure TfMain.ckRegEx01Click(Sender: TObject);
begin
  sEP01.ReadOnly := ckRegEx01.Checked;
  ExtractTags(sgList.Row, True);
end;

procedure TfMain.ckRegEx02Click(Sender: TObject);
begin
  sEP02.ReadOnly := ckRegEx02.Checked;
  ExtractTags(sgList.Row, True);
end;

procedure TfMain.ckRegEx03Click(Sender: TObject);
begin
  sEP03.ReadOnly := ckRegEx03.Checked;
  ExtractTags(sgList.Row, True);
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

procedure TfMain.ExtractTags(iRow: Integer; bPreview: Boolean = false);
var
  i: Integer;
  iGroup: Integer;
  iMatch: Integer;
  aFile: String;
  Match: tMatch;
  regexpr: tREgEx;
  RegExReplace: tREgEx;
  RO: TRegExOptions;
  ARow: Integer;
  iColumn: Integer;

begin

  RO := [roIgnoreCase];

  i := 0;
  try
    // regexpr := tREgEx.Create(seRegEx.Text, [roIgnoreCase]);
    sBB1.Visible := false;
    sBB2.Visible := false;
    sBB3.Visible := false;
    regexpr := tREgEx.Create(getExpression, [roIgnoreCase]);
{$REGION 'Tags Preview'}
    if bPreview then
    begin
      if sgList.Objects[1, iRow] <> Nil then
      begin
        aFile := tpath.GetFileNameWithoutExtension(tMediaFile(sgList.Objects[1, iRow]).Tags.FileName);
      end;
      Match := regexpr.Match(aFile);

      while Match.Success do
      begin
        if Match.Groups.Count > 1 then
        begin
          for iGroup := 1 to Match.Groups.Count - 1 do
            case iGroup of
              1:
                begin
                  sBB1.Visible := True;
                  if ckRegEx01.Checked then
                    sEP01.Text := Match.Groups.Item[iGroup].Value;
                  if sCKReplace01.Checked then
                  begin
                    RegExReplace.Create(sEFROM01.Text);
                    sEP01.Text := RegExReplace.Replace(sEP01.Text, sETO01.Text);
                  end;
                end;
              2:
                begin
                  sBB2.Visible := True;
                  if ckRegEx02.Checked then
                    sEP02.Text := Match.Groups.Item[iGroup].Value;
                  if sCKReplace02.Checked then
                  begin
                    RegExReplace.Create(sEFROM02.Text);
                    sEP02.Text := RegExReplace.Replace(sEP02.Text, sETO02.Text);
                  end;
                end;
              3:
                begin
                  sBB3.Visible := True;
                  if ckRegEx03.Checked then
                    sEP03.Text := Match.Groups.Item[iGroup].Value;
                  if sCKReplace03.Checked then
                  begin
                    RegExReplace.Create(sEFROM03.Text);
                    sEP03.Text := RegExReplace.Replace(sEP03.Text, sETO03.Text);
                  end;
                end;
            end;
        end;
        Match := Match.NextMatch;
      end;
    end
{$ENDREGION}
{$REGION 'Replace Tags'}
    else
    begin
      pb1.Position := 0;
      pb1.Max := sgList.SelectedRowCount;
      while i <= sgList.SelectedRowCount - 1 do
      begin
        ARow := sgList.SelectedRow[i];
        if sgList.Objects[1, ARow] <> Nil then
        begin
          aFile := tpath.GetFileNameWithoutExtension(tMediaFile(sgList.Objects[1, ARow]).Tags.FileName);
        end;

        Match := regexpr.Match(aFile);
        iMatch := 0;
        while Match.Success do
        begin
          if Match.Groups.Count > 1 then
          begin
            for iGroup := 1 to Match.Groups.Count - 1 do
              case iGroup of
                1:
                  begin
                    iColumn := tTagKey(sCB1.Items.Objects[sCB1.ItemIndex]).sCol;
                    if (iColumn > -1) and (ckRegEx01.Checked) then
                    begin
                      sgList.Cells[iColumn, ARow] := Match.Groups.Item[iGroup].Value;
                      if sCKReplace01.Checked then
                      begin
                        RegExReplace.Create(sEFROM01.Text);
                        sgList.Cells[iColumn, ARow] := RegExReplace.Replace(sgList.Cells[iColumn, ARow], sETO01.Text);
                      end;
                      tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB1.Items.Objects[sCB1.ItemIndex]).sTag, sgList.Cells[iColumn, ARow]);
                      tMediaFile(sgList.Objects[1, ARow]).bModified := True;
                    end;
                  end;
                2:
                  begin
                    iColumn := tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sCol;
                    if (iColumn > -1) and (ckRegEx02.Checked) then
                    begin
                      sgList.Cells[iColumn, ARow] := Match.Groups.Item[iGroup].Value;
                      if sCKReplace02.Checked then
                      begin
                        RegExReplace.Create(sEFROM02.Text);
                        sgList.Cells[iColumn, ARow] := RegExReplace.Replace(sgList.Cells[iColumn, ARow], sETO02.Text);
                      end;
                      tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sTag, sgList.Cells[iColumn, ARow]);
                      tMediaFile(sgList.Objects[1, ARow]).bModified := True;
                    end;
                  end;
                3:
                  begin
                    iColumn := tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sCol;
                    if (iColumn > -1) and (ckRegEx03.Checked) then
                    begin
                      sgList.Cells[iColumn, ARow] := Match.Groups.Item[iGroup].Value;
                      if sCKReplace03.Checked then
                      begin
                        RegExReplace.Create(sEFROM03.Text);
                        sgList.Cells[iColumn, ARow] := RegExReplace.Replace(sgList.Cells[iColumn, ARow], sETO03.Text);
                      end;
                      tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sTag, sgList.Cells[iColumn, ARow]);
                      tMediaFile(sgList.Objects[1, ARow]).bModified := True;
                    end;
                  end;
              end;
          end;
          Match := Match.NextMatch;
        end;

        if (not ckRegEx01.Checked) then
        begin
          iColumn := tTagKey(sCB1.Items.Objects[sCB1.ItemIndex]).sCol;
          if iColumn > -1 then
          begin
            sgList.Cells[iColumn, ARow] := sEP01.Text;
            tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB1.Items.Objects[sCB1.ItemIndex]).sTag, sgList.Cells[iColumn, ARow]);
            tMediaFile(sgList.Objects[1, ARow]).bModified := True;
          end;
        end;

        if (not ckRegEx02.Checked) then
        begin
          iColumn := tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sCol;
          if iColumn > -1 then
          begin
            sgList.Cells[iColumn, ARow] := sEP02.Text;
            tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sTag, sgList.Cells[iColumn, ARow]);
            tMediaFile(sgList.Objects[1, ARow]).bModified := True;
          end;
        end;

        if (not ckRegEx03.Checked) then
        begin
          iColumn := tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sCol;
          if iColumn > -1 then
          begin
            sgList.Cells[iColumn, ARow] := sEP03.Text;
            tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sTag, sgList.Cells[iColumn, ARow]);
            tMediaFile(sgList.Objects[1, ARow]).bModified := True;
          end;
        end;

        if ckClearCovers.Checked then
        begin
          RemoveCovers(tMediaFile(sgList.Objects[1, ARow]).Tags);
          sgList.SetImageIdx(5, ARow, 1);
        end;
        pb1.Position := i;
        SaveTags(ARow);

        inc(i);
      end;
      sgList.SetFocus;
    end;
{$ENDREGION}
    pb1.Position := 0;
    FillTagLists;
    // RefreshTagsCombos;
  except

  end;
end;

procedure TfMain.fillTagCombos;
var
  i: Integer;
  dTagKey: tTagKey;
  Key: String;

  function SetIndex(aList: TStrings; aKey: String): Integer;
  begin
    Result := aList.IndexOf(aKey);
  end;

begin
  //
  i := 0;
  sCB1.Items.clear;
  sCB2.Items.clear;
  sCB3.Items.clear;

  for Key in dTags.Keys do
  begin
    dTags.TryGetValue(Key, dTagKey);
    sCB1.Items.AddObject(Key, dTagKey);
    sCB2.Items.AddObject(Key, dTagKey);
    sCB3.Items.AddObject(Key, dTagKey);
  end;

  sCB1.ItemIndex := SetIndex(sCB1.Items, 'Artist');
  sCB2.ItemIndex := SetIndex(sCB2.Items, 'Title');
  sCB3.ItemIndex := SetIndex(sCB3.Items, 'N/A');

  sEP01.Text := '';
  sEP02.Text := '';
  sEP03.Text := '';

end;

procedure TfMain.FillTagLists;
var
  ARow: Integer;
begin
  InitDictionaries;
  ARow := 1;
  while ARow <= sgList.RowCount - 1 do
  begin
    AddToDictionary('ARTIST', sgList.Cells[2, ARow]);
    AddToDictionary('ALBUM', sgList.Cells[4, ARow]);
    inc(ARow);
  end;
end;

function TfMain.findNode(sLabel: String): TTreeNode;
begin
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

  fFrmPlayer.Stop;
  fFrmPlayer.deInit;

  jConfig.S['startFolder'] := sShellTreeView1.SelectedFolder.PathName;

  jConfig.SaveTo(TDirectory.GetCurrentDirectory + '\config.json');
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  Volume: Single;
  ReleaseCodeString: string;
  SerialNumber: Longint;
begin
  // * Never forget to init BASS
  // GlobalMediaFile := tMediaFile.Create;
  BASS_Init(-1, 44100, 0, self.handle, 0);

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
  InitDictionaries;
  fillTagCombos;
  OpenPlayer;

{$IFDEF DEBUG}
  isRegistered := True;
  btnUtils.Visible := True;
  sButton3.Visible := True;
{$ELSE}
  GetRegistrationInformation(ReleaseCodeString, SerialNumber);
  if not IsReleaseCodeValid(ReleaseCodeString, SerialNumber) then
  begin
    Caption := Caption + ' Unregistered Demo!';
    bsRegister.Visible := True;
    isRegistered := false;
  end
  else
  begin
    Caption := Caption + ' Registered';
    isRegistered := True;
  end;
{$ENDIF}
  fCoverSearch := tfCoverSearch.Create(self);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Spectrum3D_Free(Sprectrum3D);
  BASS_Stop;
  BASS_Free;

  if fCoverSearch <> Nil then
    fCoverSearch.Free;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssAlt in Shift then
  begin
    case Key of
      // 69:
      // showExplorer;
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
begin
  PostMessage(self.handle, WM_OPEN_ROLLOUTS, 0, 0);
end;

function TfMain.getExpression: String;
var
  regexpr, RegExReplace: tREgEx;
  iMatch: Integer;
  Match: tMatch;
  iGroup: Integer;
  sKey: String;
  sExpr: String;
  pExpr: tExpr;
begin
  sExpr := seRegEx.Text;
  if dExpressions <> Nil then
  begin
    if dExpressions.Count > 0 then
    begin
      regexpr := tREgEx.Create('\[(.*?)\]');

      Match := regexpr.Match(seRegEx.Text);
      iMatch := 0;
      while Match.Success do
      begin
        if Match.Groups.Count > 1 then
        begin
          for iGroup := 1 to Match.Groups.Count - 1 do
          begin
            sKey := '[' + Match.Groups.Item[iGroup].Value + ']';
            dExpressions.TryGetValue(sKey, pExpr);
            RegExReplace.Create('\[' + Match.Groups.Item[iGroup].Value + '\]');
            sExpr := RegExReplace.Replace(sExpr, pExpr.sExpr);
            // sExpr := sExpr + pExpr.sExpr;
          end;
        end;
        Match := Match.NextMatch;
      end;
    end;
  end;
  Result := sExpr;
end;

procedure TfMain.GetImgLink;
begin

end;

function TfMain.GetwindowsVolume: Integer;
var
  iErr: Integer;
  i: Integer;
  a: TAuxCaps;
  vol: Word;
begin
  for i := 0 to auxGetNumDevs do
  begin
    auxGetDevCaps(i, Addr(a), SizeOf(a));
    If a.wTechnology = AUXCAPS_CDAUDIO Then
      break;
  end;
  iErr := auxGetVolume(i, Addr(vol));
  Result := vol;
end;

function TfMain.ImageCount(aFile: String): Integer;
var
  GlobalMediaFile: tMediaFile;
begin
  GlobalMediaFile := tMediaFile.Create(sFile);
  Result := GlobalMediaFile.Tags.CoverArtCount;
  GlobalMediaFile.Destroy;
end;

procedure TfMain.InitDictionaries;
var
  pList: TStrings;
begin
  if dMultiChoices <> Nil then
  begin
    dMultiChoices.clear;
    dMultiChoices.Free;
  end;
  dMultiChoices := tDictionary<String, TStrings>.Create;
  pList := tStringList.Create;
  dMultiChoices.Add('ARTIST', pList);
  pList := tStringList.Create;
  dMultiChoices.Add('ALBUM', pList);
end;

procedure TfMain.initGrid;

  procedure cleanObjects;
  var
    i: Integer;
  begin
    i := 1;
    while i <= sgList.RowCount - 1 do
    begin
      if sgList.Objects[1, i] <> nil then
        tMediaFile(sgList.Objects[1, i]).Destroy;
      inc(i);
    end;
  end;

begin
  cleanObjects;
  sgList.clear;
  sgList.RowCount := 2;
  sgList.ColWidths[0] := 486;
  sgList.ColWidths[1] := 225;
  sgList.ColWidths[2] := 225;
  sgList.ColWidths[3] := 192;
  sgList.ColWidths[4] := 65;

  sgList.Cells[0, 0] := 'File';
  sgList.Cells[1, 0] := 'Artist';
  sgList.Cells[2, 0] := 'Title';
  sgList.Cells[3, 0] := 'Album';
  sgList.Cells[4, 0] := 'Cover';

  sgList.InsertCols(0, 1);
  sgList.ColWidths[0] := 20;
  InitDictionaries;
  ExtractTags(1, True);
end;

procedure TfMain.sgListGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  pMediaFile: tMediaFile;
begin
  //
  if sgList.Objects[1, ARow] <> Nil then
  begin
    pMediaFile := tMediaFile(sgList.Objects[1, ARow]);
    if pMediaFile.bModified then
    begin
      ABrush.Color := clTeal;
    end
    else
    begin
      ABrush.Color := clWhite;
    end;

  end
  else
  begin
    ABrush.Color := clWhite;
  end;

end;

procedure TfMain.sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  index: Integer;
  i: Integer;
  pMediaFile: tMediaFile;
  ARow: Integer;
begin

  ARow := sgList.Row;
  if Key = VK_ESCAPE then
  begin
    sgList.EditMode := false;
    sgList.Options := [goRowSelect, goRangeSelect];
  end;

  if sgList.EditMode then
  begin
    if (Key = VK_NUMPAD1) and (ssCtrl in Shift) then
    begin
      removeKeyFromStack;
      sgList.Cells[2, sgList.Row] := sgList.NormalEdit.SelText;

    end;
    if (Key = VK_NUMPAD2) and (ssCtrl in Shift) then
    begin
      removeKeyFromStack;
      sgList.Cells[3, sgList.Row] := sgList.NormalEdit.SelText;

    end;
    if Key = VK_RETURN then
    begin
      if Shift = [] then
      begin
        if sgList.Objects[1, sgList.Row] <> Nil then
        begin
          if tMediaFile(sgList.Objects[1, sgList.Row]).bModified then
          begin
            tMediaFile(sgList.Objects[1, sgList.Row]).SaveTags;
          end;
        end;
        sgList.EditMode := false;
        sgList.Options := [goRowSelect, goRangeSelect];

      end;
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
        if sgList.EditMode then
        begin
          sgList.EditMode := false;
          sgList.Options := [goRowSelect, goRangeSelect];
        end
        else if not(goEditing in sgList.Options) then
        begin
          sgList.Options := [goEditing, goTabs];

          if trim(sgList.Cells[2, ARow]) <> '' then
            sgList.EditCell(2, sgList.Row)
          else if trim(sgList.Cells[3, ARow]) <> '' then
            sgList.EditCell(3, sgList.Row)
          else
            sgList.EditCell(1, sgList.Row);

        end
        else
        begin
          sgList.EditCell(sgList.Col, sgList.Row);
        end;
      end
      else
      begin
        if Shift = [ssCtrl] then
        begin
          if sgList.Objects[1, sgList.Row] <> Nil then
          begin
            BASS_ChannelStop(Channel);
            // PlayStream(tMediaFile(sgList.Objects[1, sgList.Row]).Tags.FileName);
            //fFrmPlayer.PlayStream(tMediaFile(sgList.Objects[1, sgList.Row]).Tags.FileName);
            PreviewTrack(tMediaFile(sgList.Objects[1, sgList.Row]));
          end;
        end
        else
        begin
          index := -1;
          i := 0;
          while i <= sgList.RowSelectCount - 1 do
          begin
            if i = 0 then
            begin
              if (ssShift in Shift) then
                index := AddToPlayList(sgList.SelectedRow[i]);
              BASS_ChannelStop(Channel);
              if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_STOPPED then
              begin
                slbPlaylist.ItemIndex := index;
                //PlayStream(tMediaFile(slbPlaylist.Items.Objects[index]).Tags.FileName);
                PreviewTrack(tMediaFile(slbPlaylist.Items.Objects[index]));
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

procedure TfMain.sgListKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '?' then
  begin
    if not sgList.EditMode then
    begin
      ExtractTags(sgList.Row);
    end;
  end;
  if Key = '/' then
  begin
    PopupMenu21Click(Sender);
  end;
end;

procedure TfMain.sgListRightClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  if sgList.SelectedRowCount <= 1 then
  begin
    sgList.Row := ARow;
    sgList.EditMode := false;
    sgList.Options := [goRowSelect, goRangeSelect];
  end;
end;

procedure TfMain.sgListRowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
var
  pMediaFile: tMediaFile;
begin
  // Afficher la pochette si elle existe

  if sgList.EditMode then
    Allow := false;
  if sgList.Objects[1, NewRow] <> Nil then
  begin
    pMediaFile := tMediaFile(sgList.Objects[1, NewRow]);

    ExtractTags(NewRow, True);

    try
      ListCoverArts(image1, pMediaFile.Tags);

    except

    end;
  end;
end;

procedure TfMain.sgListSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  pMediaFile: tMediaFile;
begin
  // Caption := format('Col : %d Row : %d  Value : %s',[aCol,aRow,value]);
  if sgList.Objects[1, ARow] <> Nil then
  begin
    pMediaFile := tMediaFile(sgList.Objects[1, ARow]);
    pMediaFile.Tags.SetTag('ARTIST', sgList.Cells[2, ARow]);
    pMediaFile.Tags.SetTag('TITLE', sgList.Cells[3, ARow]);
    pMediaFile.Tags.SetTag('ALBUM', sgList.Cells[4, ARow]);
    pMediaFile.bModified := True;
    pMediaFile.SaveTags;
    UpdateTagLists(ACol, Value);
  end;

end;

procedure TfMain.showExplorer;
begin
  sSplitView1.Opened := not sSplitView1.Opened;
  if sSplitView1.Opened then
    sShellTreeView1.SetFocus
  else
    sgList.SetFocus;

end;

procedure TfMain.showPlayList;
begin
  if sROPPlaylist.Collapsed then
  begin
    sROPPlaylist.ChangeState(false, True);
    slbPlaylist.SetFocus;
  end
  else
    sROPPlaylist.ChangeState(True, True);
end;

procedure TfMain.ResetPB;
begin
  pb1.Position := 0;
end;

function TfMain.RxReplace(const Match: tMatch): String;
begin
  Result := '';
end;

procedure TfMain.sAlphaHints1ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo; var Frame: TFrame);
begin
  if HintInfo.HintControl = sBitBtn1 then
  begin
    HintStr := 'Open Explorer Alt-E';
  end;

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

procedure TfMain.SaveCover(var m: Tmsg);
var
  PictureStream: TMemoryStream;
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
  i, ARow: Integer;
begin
  // * Clear the cover art data
  i := 0;
  pb1.Position := 0;
  pb1.Max := sgList.RowSelectCount;
  while i <= sgList.RowSelectCount - 1 do
  begin
    ARow := sgList.SelectedRow[i];
    if sgList.Objects[1, ARow] <> Nil then
    begin
      pMediaFile := tMediaFile(sgList.Objects[1, ARow]);

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
          JPEGPicture := TJPEGImage.Create;
          try
            JPEGPicture.Assign(fCoverSearch.image1.Picture.BitMap);
            Width := JPEGPicture.Width;
            Height := JPEGPicture.Height;
            NoOfColors := 0;
            ColorDepth := 24;
          finally
            FreeAndNil(JPEGPicture);
          end;
          PictureStream := TMemoryStream.Create;
          fCoverSearch.image1.Picture.BitMap.SaveToStream(PictureStream);
          PictureStream.Position := 0;
          // pMediaFile := tMediaFile.Create(sFile);
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
          // pMediaFile.SaveTags;
          pMediaFile.bModified := True;
        finally
          FreeAndNil(PictureStream);
        end;
      except

      end;
    end;
    if pMediaFile.bModified then
      pMediaFile.SaveTags;
    pb1.Position := i;
    RefreshCover(ARow);
    inc(i);
  end;
  pb1.Position := 0;
  // if fCoverSearch <> nil then
  // fCoverSearch.Close;

end;

procedure TfMain.SaveTags(iRow: Integer);
begin
  if sgList.Objects[1, iRow] <> Nil then
  begin
    if tMediaFile(sgList.Objects[1, iRow]).bModified then
      tMediaFile(sgList.Objects[1, iRow]).SaveTags;
  end;
  Application.ProcessMessages;
end;

procedure TfMain.sBitBtn1Click(Sender: TObject);
begin
  showExplorer;
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
      BASS_ChannelPlay(Channel, false);
      sButton2.ImageIndex := 3;
    end;
  end;
end;

procedure TfMain.sButton3Click(Sender: TObject);
begin
  fFrmPlayer.deInit;
  fFrmPlayer.Parent := Form1.sPanel1;
  fFrmPlayer.init;
  Form1.Show;
end;

procedure TfMain.btnRegexClick(Sender: TObject);
begin
  ExtractTags(sgList.Row, false);
end;

procedure TfMain.btnUtilsClick(Sender: TObject);
var
  fRegExFrame: tFrame2;
begin
  fRegExFrame := tFrame2.Create(self);
  fRegExFrame.Name := 'FrameFile01';
  fRegExFrame.Top := 64000;
  fRegExFrame.align := alright;
  fRegExFrame.Parent := sPanel1;
end;

procedure TfMain.sButton4Click(Sender: TObject);
begin
  savePlaylist;
end;

procedure TfMain.sButton5Click(Sender: TObject);
begin
  loadPlaylist;
end;

procedure TfMain.sCB1Change(Sender: TObject);
begin
  AssignMultiChoice(sCB1, sEP01);
end;

procedure TfMain.sCB2Change(Sender: TObject);
begin
  AssignMultiChoice(sCB2, sEP02);
end;

procedure TfMain.sCB3Change(Sender: TObject);
begin
  AssignMultiChoice(sCB3, sEP03);
end;

procedure TfMain.sCKReplace03Click(Sender: TObject);
begin
  sPNReplace03.Visible := sCKReplace03.Checked;
end;

procedure TfMain.sCKReplace01Click(Sender: TObject);
begin
  sPNReplace01.Visible := sCKReplace01.Checked;
end;

procedure TfMain.sCKReplace02Click(Sender: TObject);
begin
  sPnReplace02.Visible := sCKReplace02.Checked;
end;

procedure TfMain.seRegExBeforePopup(Sender: TObject);
begin
  //
  fRegEx.sEdit := seRegEx;
end;

procedure TfMain.seRegExChange(Sender: TObject);
begin
  ExtractTags(sgList.Row, True);
end;

procedure TfMain.seRegExKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  iCaret: Integer;
  sString: String;
  iBracketStart, iBracketEnd: Integer;
  iLenght: Integer;

  function rpos(Substr: String; S: String; iStart: Integer): Integer;
  var
    i: Integer;
  begin
    for i := iStart downto 1 do
      if (Copy(S, i, Length(Substr)) = Substr) then
      begin
        Result := i;
        Exit;
      end;
  end;

  function lpos(Substr: String; S: String; iStart: Integer): Integer;
  var
    i: Integer;
  begin
    for i := iStart to Length(S) do
      if (Copy(S, i, Length(Substr)) = Substr) then
      begin
        Result := i;
        Exit;
      end;
  end;

begin
  // sString := seRegEx.Text;
  // iCaret := TsPopupBox(Sender).SelStart;
  // iBracketStart := rpos('[', sString, iCaret);
  // iBracketEnd := lpos(']', sString, iBracketStart);
  // iLenght := (iBracketEnd - iBracketStart) + 1;
  // sMemo1.lines.Add(format('Caret : %d - BracketStart : %d - BracketEnd : %d', [iCaret, iBracketStart, iBracketEnd]));
  // if ssCtrl in Shift then
  // begin
  // if (Key = VK_LEFT) or (Key = VK_RIGHT) then
  // begin
  // TsPopupBox(Sender).SelStart := iBracketStart - 1;
  // TsPopupBox(Sender).SelLength := iLenght;
  // removeKeyFromStack;
  // end;
  // end;
  // if Key = VK_DELETE then
  // begin
  // if (iCaret in [iBracketStart .. iBracketEnd]) then
  // begin
  // removeKeyFromStack;
  // delete(sString, iBracketStart, iLenght);
  // TsPopupBox(Sender).Text := sString;
  // TsPopupBox(Sender).SelStart := iCaret;
  // TsPopupBox(Sender).SelLength := 0;
  //
  // end;
  // end;
end;

procedure TfMain.setGridRow;
begin
  sgList.Row := 1;
  if sgList.Objects[1, 1] <> Nil then
  begin
    ListCoverArts(image1, tMediaFile(sgList.Objects[1, 1]).Tags);
    ExtractTags(1, True);
  end;
end;

procedure TfMain.setPBMax;
begin
  pb1.Max := 100;
end;

procedure TfMain.SetPBPosition;
begin
  pb1.Position := Round(iProgress / iMax * 100);
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

procedure TfMain.slCoversSliderChange(Sender: TObject);
var
  aNode: TTreeNode;
begin
  //
  if sShellTreeView1.Selected <> nil then
    aNode := sShellTreeView1.Selected
  else
    aNode := sShellTreeView1.Items[0];

  sShellTreeView1.Refresh(aNode);
end;

procedure TfMain.sROPMediaAfterCollapse(Sender: TObject);
begin
  RefreshVisuals;
end;

procedure TfMain.sROPMediaAfterExpand(Sender: TObject);
begin
  RefreshVisuals;
end;

procedure TfMain.sROPPlaylistAfterCollapse(Sender: TObject);
begin
  RefreshVisuals;
end;

procedure TfMain.sROPPlaylistAfterExpand(Sender: TObject);
begin
  RefreshVisuals;
end;

procedure TfMain.sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: Boolean);
var
  sExtension: string;
  aFile: String;
  iCount: Integer;
begin
  CanAdd := True;
  if not AFolder.IsFileFolder then
  begin
    aFile := AFolder.PathName;
    sExtension := tpath.GetExtension(aFile);
    CanAdd := (pos(uppercase(sExtension), sValidExtensions) > 0);
  end;
end;

Procedure TfMain.GetNoCoverImage(aPicture: tPicture);
begin
  // sILNoCover.GetBitmap(0,);
  aPicture.BitMap.Assign(sILNoCover.CreateBitmap32(0, 256, 256));
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
    end
    else
    begin
      // Use DM1
      image1.Picture.Assign(Nil);
      Application.ProcessMessages;
      // image1.Picture.BitMap.Assign(GetNoCoverImage);
      GetNoCoverImage(image1.Picture);
    end;
    pMediaFile.Free;
  end;
end;

procedure TfMain.sShellTreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
var
  GlobalMediaFile: tMediaFile;
begin
  //
  if (Node <> Nil) then
  begin

    if tMediaUtils.isValidExtension2(TacShellFolder(Node.data).PathName) > -1 then
    begin
      GlobalMediaFile := tMediaFile.Create(TacShellFolder(Node.data).PathName);
      if GlobalMediaFile.Tags.CoverArtCount > 0 then
        Node.ImageIndex := 1
      else
        Node.ImageIndex := 0;
      GlobalMediaFile.Destroy;
    end
    else
    begin
      if TDirectory.Exists(TacShellFolder(Node.data).PathName) then
        Node.ImageIndex := 2;
    end;

  end;
end;

procedure TfMain.sShellTreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Shift = [ssCtrl] then
  begin

    if Key = ord('P') then
    begin
      // Preview track
      removeKeyFromStack;
      PreviewTrack(sShellTreeView1.Selected);
    end;

    if Key = VK_ADD then
    begin
      // Add directly to playlist
      removeKeyFromStack;
      AddDirectlyToPlayList;
    end;
  end;

  if (Key = VK_ADD) and not (ssCtrl in []) then
  begin
    // Add to Grid
    removeKeyFromStack;
    AddToGrid((Shift = [ssShift]));
  end;

end;

procedure TfMain.sSplitView1Opened(Sender: TObject);
begin
  sShellTreeView1.SetFocus;
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

                  try
                    ImageJPEG.LoadFromStream(Stream);
                    BitMap.Assign(ImageJPEG);
                  except
                    FreeAndNil(BitMap);
                  end;
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
                try
                  BitMap.LoadFromStream(Stream);
                except
                  FreeAndNil(BitMap);
                end;
              end;
          end;
          if Assigned(BitMap) then
            try
              aImage.Picture.BitMap.Assign(BitMap)
            except
              Caption := 'erreur';
            end
          else
            aImage.Picture.Assign(Nil);
        end;
      finally
        if Assigned(BitMap) then
          FreeAndNil(BitMap);
      end;
    end;
  end
  else
  begin
    aImage.Picture.Assign(Nil);
    aImage.Refresh;
    Application.ProcessMessages;
    // aImage.Picture.BitMap.Assign(GetNoCoverImage);
    GetNoCoverImage(aImage.Picture);
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
    slbPlaylist.clear;
    i := 0;
    Json := TSuperObject.ParseFile(sOpenDialog1.FileName);
    while i <= Json.a['tracks'].Length - 1 do
    begin
      pMediaFile := tMediaFile.Create(Json.a['tracks'].O[i].S['filename']);
      slbPlaylist.Items.AddObject(tpath.GetFileNameWithoutExtension(pMediaFile.Tags.FileName), pMediaFile);
      inc(i);
    end;
  end;
end;

procedure TfMain.ListCoverArts(aImage: TsImage; sFileName: String);
begin
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
    aPath := jConfig.S['startFolder'];
    if aPath <> '' then
    begin
      if DirectoryExists(aPath) then
      begin
        sShellTreeView1.Path := aPath;
        if sShellTreeView1.Selected <> Nil then
          sShellTreeView1.Selected.Expand(false);
      end
      else
        aPath := 'c:\';
    end;
  end
  else
  begin
    jConfig := SO;
    aPath := 'c:\';
  end;
end;

procedure TfMain.OpenPlayer;
begin
  // * Never forget to init BASS
  // GlobalMediaFile := tMediaFile.Create;
  fFrmPlayer := tFrmPlayer.Create(self);
  fFrmPlayer.Parent := sPnPlayer;
  fFrmPlayer.init;

end;

procedure TfMain.OpenRollOuts(var m: Tmsg);
begin
  // sROPPlaylist.ChangeState(false, True);
  // sROPMedia.ChangeState(false, True);
  image1.Picture.Assign(Nil);
  image1.Refresh;
  Application.ProcessMessages;
  // image1.Picture.BitMap.Assign(GetNoCoverImage);
  GetNoCoverImage(image1.Picture);
  Application.ProcessMessages;
end;

procedure TfMain.playlistRemoveItem(index: Integer);
begin
  if index <= slbPlaylist.Items.Count - 1 then
  begin
    if slbPlaylist.Items.Objects[index] <> nil then
    begin
      tMediaFile(slbPlaylist.Items.Objects[index]).Destroy;
      slbPlaylist.Items.delete(index);
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
    thListMP3.Execute(self);
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
  AdjustingPlaybackPosition := false;

end;

procedure TfMain.thListMP3Execute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
  sExt: String;
  bConfirm: Boolean;
  bFirst: Boolean;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);
  bConfirm := True;
  bFirst := True;
  if Length(aFiles) > 1000 then
  begin
    bConfirm := (MessageDlg(format('Do you confirm adding %d files ?', [Length(aFiles)]), mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes);
  end;
  if bConfirm then
  begin
    sgList.BeginUpdate;
    iMax := Length(aFiles);
    i := 0;
    while i <= Length(aFiles) - 1 do
    begin
      iProgress := i;
      thListMP3.Synchronize(TfMain(Params).SetPBPosition);
      sExt := tpath.GetExtension(aFiles[i]);
      bAdd := (pos(uppercase(sExt), sValidExtensions) > 0);
      if bAdd then
      begin
        sFile := aFiles[i];
        thListMP3.Synchronize(TfMain(Params).AddFileToGridTH);
        if bFirst then
        begin
          thListMP3.Synchronize(TfMain(Params).setGridRow);
          bFirst := false;
        end;
      end;
      inc(i);
    end;
    iProgress := iMax;
    thListMP3.Synchronize(TfMain(Params).SetPBPosition);
    iProgress := 0;
    thListMP3.Synchronize(TfMain(Params).SetPBPosition);
    thListMP3.Synchronize(TfMain(Params).RefreshTagsCombos);
    sgList.EndUpdate;
  end;

end;

procedure TfMain.Timer1Timer(Sender: TObject);
var
  Level: Cardinal;
  LeftLevel: Word;
  RightLevel: Word;
  Volume: Single;
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
  Volume := BASS_GetVolume;
  tbVolume.Position := 100 - Round(Volume * 100);
  AdjustingPlaybackPosition := false;
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
    bm2.SetSize(cliprect.Width, (cliprect.Height div 4));
    bm2.Canvas.Brush.Color := clTeal;
    bm2.Canvas.Brush.Style := bsSolid;
    R := TRect.Create(0, 0, bm2.Width, bm2.Height);
    bm2.Canvas.Fillrect(R);
    Draw(0, cliprect.Height - (cliprect.Height div 4), bm2, 200);
    bm2.Free;
  end;
end;

procedure TfMain.UpdateTagLists(iCol: Integer; sValue: String);
var
  sTag: String;
begin
  sTag := FindTag(iCol);
  if sTag <> '' then
    AddToDictionary(sTag, sValue);
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
  // sTVMedias.Refresh;
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
      bm2.SetSize(Round(cliprect.Width / 100 * p2), cliprect.Height);
      bm2.Canvas.Brush.Color := clGray;
      bm2.Canvas.Brush.Style := bsSolid;
      R := TRect.Create(0, 0, bm2.Width, bm2.Height);
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
