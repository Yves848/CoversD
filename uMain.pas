unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types,
  Vcl.GraphUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, Vcl.StdCtrls, sPanel, Vcl.ExtCtrls, sSkinManager, sSkinProvider, sButton,
  Vcl.ComCtrls,
  sTreeView, acShellCtrls, sListView, sComboBoxes, sSplitter, Vcl.Buttons, sSpeedButton, System.ImageList, Vcl.ImgList,
  acAlphaImageList,
  acProgressBar, JvComponentBase, JvThread, sMemo, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, acImage, JPEG, PNGImage,
  GIFImg, TagsLibrary,
  acNoteBook, sTrackBar, acArcControls, sGauge, BASS, BassFlac, xSuperObject, sListBox, JvExControls, clipbrd,
  Spectrum3DLibraryDefs, bass_aac,
  MMSystem, uDeleteCover, JvaScrollText, acSlider, uSearchImage, sBitBtn, Vcl.OleCtrls, SHDocVw, activeX, acWebBrowser, Vcl.Grids,
  JvExGrids,
  JvStringGrid, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, Generics.collections,
  NetEncoding, Vcl.WinXCtrls, AdvUtil, AdvObj, BaseGrid, AdvGrid, dateutils, uCoverSearch, sDialogs, sLabel, sBevel, AdvMemo, acPNG,
  JvExComCtrls, JvProgressBar, KryptoGlowLabel, uni_RegCommon, Vcl.onguard, uRegister, Vcl.Menus, System.RegularExpressions, sEdit,
  sComboBox,
  sCheckBox, sPageControl, SynEditHighlighter, SynHighlighterJSON, System.StrUtils, sComboEdit, acPopupCtrls, uDM1, acAlphaHints,
  BtnListB,
  sScrollBox, uFrmPlayer, JvExStdCtrls, JvWinampLabel, uFormPlayer, acFontStore, uLog, ufrmLog;

type
  tAddToPlayListCallback = function(aFile: String): integer of object;
  tSearchCallback = procedure(aResult: String) of object;
  tSetBadgeColorCallBack = procedure(bactive: boolean) of object;

  thaddToPlayList = class(TThread)
  private
    AddToPlayList: tAddToPlayListCallback;
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    constructor create(addToPlaylistCallback: tAddToPlayListCallback); reintroduce;
  end;

  thSearchDisk = class(TThread)
  private
    returnResult: tSearchCallback;
    setBadgeColor: tSetBadgeColorCallBack;
    fRx: String;
    bOptions: tOptionsSearch;
    fStartFolder: String;
    fFirstMatch: string;
    fMAtches: tStrings;
    maxcount: integer;
    tag: integer;
  protected
    procedure Execute; override;
    procedure GetFiles(s: String);
    procedure GetFilesFast(s: string);
    Procedure DoTerminate; override;
    function matchesMask(sString: String; isDirectory: boolean): boolean;
    function _matches(sString: String; isDirectory: boolean; regexpr: tRegEx): boolean;
  public
    constructor create(StartFolder, sRx: String; aMatches: tStrings; poptions: tOptionsSearch; searchCallBack: tSearchCallback;
      setBadgeCallBAck: tSetBadgeColorCallBack); reintroduce;
  end;

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
    sbDetach: TsButton;
    sPnPlayer: TsPanel;
    sShellTreeView1: TsShellTreeView;
    seSearch: tsEdit;
    sPanel11: TsPanel;
    btnSearch: TsButton;
    sSearchBadge: TsBadgeBtn;
    sPanel12: TsPanel;
    sDESearch: TsDirectoryEdit;
    slWholeWord: TsSlider;
    slIncDir: TsSlider;
    procedure thListMP3Execute(Sender: TObject; Params: Pointer);
    procedure sTVMediasExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: boolean);
    procedure FormCreate(Sender: TObject);
    procedure tbVolumeChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure slbPlaylistItemIndexChanged(Sender: TObject);
    procedure slbPlaylistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: boolean);
    procedure sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgListRowChanging(Sender: TObject; OldRow, NewRow: integer; var Allow: boolean);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sShellTreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure thDisplayExecute(Sender: TObject; Params: Pointer);
    procedure FormResize(Sender: TObject);
    procedure tbVolumeSkinPaint(Sender: TObject; Canvas: TCanvas);
    procedure sShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure sShellTreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure bsRegisterClick(Sender: TObject);
    procedure slCoversSliderChange(Sender: TObject);
    procedure PopupMenu21Click(Sender: TObject);
    procedure sgListRightClickCell(Sender: TObject; ARow, ACol: integer);
    procedure sgListSetEditText(Sender: TObject; ACol, ARow: integer; const Value: string);
    procedure btnRegexClick(Sender: TObject);
    procedure sgListKeyPress(Sender: TObject; var Key: Char);
    procedure sgListGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
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
    procedure sAlphaHints1ShowHint(var HintStr: string; var CanShow: boolean; var HintInfo: THintInfo; var Frame: TFrame);
    procedure btnUtilsClick(Sender: TObject);
    procedure seRegExBeforePopup(Sender: TObject);
    procedure seRegExKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbDetachClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure seSearchChange(Sender: TObject);
    procedure sShellTreeView1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure slWholeWordChanging(Sender: TObject; var CanChange: boolean);
    procedure slIncDirChanging(Sender: TObject; var CanChange: boolean);
  private
    { Déclarations privées }
    jConfig: ISuperObject;
    function findNode(sLabel: String): TTreeNode;
    procedure ListCoverArts(aImage: TsImage; Tags: TTags); overload;
    Procedure ListCoverArts(aImage: TsImage; sFileName: String); overload;
    procedure OpenConfig;
    procedure OpenLogWindow;
    procedure downloadImage(sUrl: string);
    procedure SelfMove(var msg: TWMMove); message WM_MOVE;
    procedure terminatePreviousSearch;

  public
    { Déclarations publiques }
    Channel: HStream;
    ChannelPreview: HStream;
    CurrentPlayingFileName: String;
    AdjustingPlaybackPosition: boolean;
    delais: integer;
    momentdown: tDateTime;
    dMultiChoices: tDictionary<String, tStrings>;
    procedure PlayStream(FileName: String);
    procedure setPBMax;
    procedure SetPBPosition;
    procedure ResetPB;
    procedure initGrid;
    procedure initAddToPlayListThread;
    procedure removeKeyFromStack;
    function AddToPlayList(aFile: String): integer; overload;
    function AddToPlayList(aMediaFile: tMediaFile): integer; overload;
    function AddToPlayList(ARow: integer): integer; overload;
    function AddToPlayList(aNode: TTreeNode; bRecurse: boolean): integer; overload;
    Procedure AddFolderToGrid(sFolder: String);
    function AddFileToGrid(sFile: String): integer;
    Procedure AddFileToGridTH;
    Procedure AddToPlayListTH;
    procedure GetImgLink;
    Procedure PlayNextTrack(Sender: TObject);
    Procedure PlayPrevTrack;
    Procedure showPlayList;
    Procedure showExplorer;
    procedure savePlaylist;
    procedure loadPlaylist;
    procedure playlistRemoveItem(index: integer);
    procedure updatePlayingInfos(sFileName: String); overload;
    procedure updatePlayingInfos(aTags: TTags); overload;
    function FormatTextWithEllipse(aText: string): string;
    procedure DrawTransparentRectangle(Canvas: TCanvas; Rect: TRect; Color: TColor; Transparency: integer);
    procedure UpdateVuMetre(LeftLevel, RightLevel: integer);
    function ImageCount(aFile: String): integer;
    Procedure RefreshCover(ARow: integer);
    procedure setGridRow;
    Procedure ExtractTags(iRow: integer; bPreview: boolean = false);
    Procedure SaveTags(iRow: integer);
    procedure SaveCover(var m: Tmsg); Message WM_REFRESH_COVER;
    Procedure fillTagCombos;
    procedure RemoveCovers(aTags: TTags);
    procedure InitDictionaries;
    procedure AddToDictionary(cKey: string; sValue: string);
    procedure AssignMultiChoice(sCBTAg: TsComboBox; sCBChoice: TsComboBox);
    Procedure RefreshTagsCombos;
    Procedure FillTagLists;
    Procedure UpdateTagLists(iCol: integer; sValue: String);
    procedure OpenRollOuts(var m: Tmsg); Message WM_OPEN_ROLLOUTS;
    procedure RefreshVisuals;
    function RxReplace(const Match: tMatch): String;
    Procedure GetNoCoverImage(aPicture: tPicture);
    function getExpression: String;
    Procedure OpenPlayer;
    procedure PreviewTrack(aNode: TTreeNode); overload;
    procedure PreviewTrack(aMediaFile: tMediaFile); overload;
    procedure PreviewTrack(sFileName: String); overload;
    procedure AddDirectlyToPlayList;
    Procedure AddToGrid(bReset: boolean);
    procedure FillGlobalList(sPAth: String);
    procedure AddLog(sLog: String); overload;
    procedure AddLog(sFunc: String; sLog: String); overload;
    procedure attach(var msg: Tmsg); Message WM_ATTACH;
    procedure SetSearchResult(s: String);
    procedure setBadgeColor(bactive: boolean);
    procedure MPlayNext(var msg: TMessage); Message WM_PLAY_NEXT;
  end;

var
  fMain: TfMain;
  fLog: tfLog;
  Sprectrum3D: Pointer;
  iProgress: integer;
  iMax: integer;
  sFileName: String;
  g_sPath: String;
  g_sFile: String;
  g_tsFiles: tStrings;
  aNode: TTreeNode;
  iImg: integer;
  sLink: String;
  Params: TSpectrum3D_CreateParams;
  Settings: TSpectrum3D_Settings;
  fCoverSearch: tfCoverSearch;
  fFrmPlayer: tFrmPlayer;
  fFrmLog: tFrmLog;
  pThAddToPlayList: thaddToPlayList;
  pTHSearch: thSearchDisk;
  Form1: tForm1;
  sMatches: tStrings;
  gSearchFolder: String;
  gOldControl: tWinControl;

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
  index: integer;
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
  index: integer;
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
  fFrmPlayer.PlayStream(sFileName);
end;

procedure TfMain.PreviewTrack(aMediaFile: tMediaFile);
begin
  PreviewTrack(aMediaFile.Tags.FileName);
end;

procedure TfMain.PreviewTrack(aNode: TTreeNode);
begin
  if not TacShellFolder(aNode.data).IsFileFolder then
  begin
    BASS_ChannelStop(Channel);
    PreviewTrack(TacShellFolder(aNode.data).PathName);
  end;
end;

procedure TfMain.RefreshCover(ARow: integer);
var
  aFile: String;
  i: integer;
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
  i: integer;
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
    ss := TStringStream.create(HTMLCode);
    try
      // et un adaptateur IStream
      sa := TStreamAdapter.create(ss); // Ne pas libérer
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
    // g_sPath := TacShellFolder(aNode.data).PathName;
    FillGlobalList(TacShellFolder(aNode.data).PathName);
    if pThAddToPlayList.Suspended then
      pThAddToPlayList.Resume
    else
      pThAddToPlayList.Start;
  end;
end;

function TfMain.AddFileToGrid(sFile: String): integer;
var
  ARow: integer;
  pMediaFile: tMediaFile;
begin
  //
  ARow := sgList.RowCount - 1;
  if sgList.Cells[1, ARow] <> '' then
  begin
    sgList.RowCount := sgList.RowCount + 1;
    ARow := sgList.RowCount - 1;
  end;

  pMediaFile := tMediaFile.create(sFile);
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
  AddFileToGrid(g_sFile);
end;

procedure TfMain.AddFolderToGrid(sFolder: String);
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
end;

procedure TfMain.AddLog(sFunc, sLog: String);
var
  sLine: String;
begin
{$IFDEF DEBUG}
  sLine := format('[%s] %s', [sFunc, sLog]);
  AddLog(sLine);
{$ENDIF}
end;

procedure TfMain.AddLog(sLog: String);
begin
{$IFDEF DEBUG}
  fFrmLog.add(sLog);
{$ENDIF}
end;

function TfMain.AddToPlayList(aNode: TTreeNode; bRecurse: boolean): integer;
var
  aMediaFile: tMediaFile;
begin
  Result := -1;
  if not TacShellFolder(aNode.data).IsFileFolder then
  begin
    aMediaFile := tMediaFile.create(TacShellFolder(aNode.data).PathName);
    if aMediaFile <> Nil then
      Result := AddToPlayList(aMediaFile);
  end
end;

function TfMain.AddToPlayList(aMediaFile: tMediaFile): integer;
var
  sPAth, aFile: String;
  index: integer;
begin
  Result := -1;
  AddLog('AddToPlayList', aMediaFile.Tags.FileName);
  if fileExists(aMediaFile.Tags.FileName) then
  begin
    sPAth := tpath.GetDirectoryName(aMediaFile.Tags.FileName);
    aFile := tpath.GetFileNameWithoutExtension(aMediaFile.Tags.FileName);
    index := fFrmPlayer.slbPlaylist.Items.IndexOf(aFile);
    if index = -1 then
    begin
      Result := fFrmPlayer.slbPlaylist.Items.AddObject(aFile, aMediaFile);
      if fFrmPlayer.slbPlaylist.ItemIndex = -1 then
        fFrmPlayer.slbPlaylist.ItemIndex := Result;

    end
    else
      Result := index;
  end;
end;

function TfMain.AddToPlayList(ARow: integer): integer;
var
  aMediaFile: tMediaFile;
begin
  Result := -1;
  aMediaFile := tMediaFile(sgList.Objects[1, ARow]);
  if aMediaFile <> nil then
    Result := AddToPlayList(aMediaFile);
end;

procedure TfMain.AddToDictionary(cKey, sValue: string);
var
  aList: tStrings;
begin
  if dMultiChoices.TryGetValue(cKey, aList) then
  begin
    //
    if aList.IndexOf(sValue) = -1 then
      aList.add(sValue);
  end;
end;

procedure TfMain.AddToGrid(bReset: boolean);
var
  NewRow: integer;
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
        GlobalMediaFile := tMediaFile.create(TacShellFolder(aNode.data).PathName);
        ListCoverArts(image1, GlobalMediaFile.Tags);
        GlobalMediaFile.Destroy;
      end;
    end
    else
    begin
      g_sPath := TacShellFolder(aNode.data).PathName;
      thListMP3.Execute(self);
    end;
  end;
end;

function TfMain.AddToPlayList(aFile: String): integer;
var
  aMediaFile: tMediaFile;
begin
  aMediaFile := tMediaFile.create(aFile);
  Result := AddToPlayList(aMediaFile);
end;

procedure TfMain.AddToPlayListTH;
var
  aMediaFile: tMediaFile;
  sPAth: String;
  index: integer;
begin
  AddLog('AddToPlayListTH', g_sFile);
  aMediaFile := tMediaFile.create(g_sFile);
  index := slbPlaylist.Items.IndexOf(g_sFile);
  if index = -1 then
  begin
    // AddToPlayList(aMediaFile);
  end

end;

procedure TfMain.AssignMultiChoice(sCBTAg, sCBChoice: TsComboBox);
const
  arTags: tArray<String> = ['ALBUM', 'ARTIST'];
var
  sTag: String;
  sList: tStrings;
  iColumn: integer;
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

procedure TfMain.attach(var msg: Tmsg);
begin
  //
  fFrmPlayer.deInit;
  fFrmPlayer.Parent := sPnPlayer;
  fFrmPlayer.init;
  sbDetach.Caption := 'Detach';
end;

procedure TfMain.bsRegisterClick(Sender: TObject);
var
  fRegister: tfRegister;
begin
  fRegister := tfRegister.create(self);
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
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.create(nil);
  IdHTTP1 := TIdHTTP.create;
  IdHTTP1.ReadTimeout := 5000;
  IdHTTP1.IOHandler := IdSSL;
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  try
    MS := TMemoryStream.create;
    jpgImg := TJPEGImage.create;
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

procedure TfMain.ExtractTags(iRow: integer; bPreview: boolean = false);
var
  i: integer;
  iGroup: integer;
  iMatch: integer;
  aFile: String;
  Match: tMatch;
  regexpr: tRegEx;
  RegExReplace: tRegEx;
  RO: TRegExOptions;
  ARow: integer;
  iColumn: integer;

begin

  RO := [roIgnoreCase];

  i := 0;
  try
    // regexpr := tREgEx.Create(seRegEx.Text, [roIgnoreCase]);
    sBB1.Visible := false;
    sBB2.Visible := false;
    sBB3.Visible := false;
    regexpr := tRegEx.create(getExpression, [roIgnoreCase]);
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
                    RegExReplace.create(sEFROM01.Text);
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
                    RegExReplace.create(sEFROM02.Text);
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
                    RegExReplace.create(sEFROM03.Text);
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
                        RegExReplace.create(sEFROM01.Text);
                        sgList.Cells[iColumn, ARow] := RegExReplace.Replace(sgList.Cells[iColumn, ARow], sETO01.Text);
                      end;
                      tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB1.Items.Objects[sCB1.ItemIndex]).sTag,
                        sgList.Cells[iColumn, ARow]);
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
                        RegExReplace.create(sEFROM02.Text);
                        sgList.Cells[iColumn, ARow] := RegExReplace.Replace(sgList.Cells[iColumn, ARow], sETO02.Text);
                      end;
                      tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sTag,
                        sgList.Cells[iColumn, ARow]);
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
                        RegExReplace.create(sEFROM03.Text);
                        sgList.Cells[iColumn, ARow] := RegExReplace.Replace(sgList.Cells[iColumn, ARow], sETO03.Text);
                      end;
                      tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sTag,
                        sgList.Cells[iColumn, ARow]);
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
            tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB1.Items.Objects[sCB1.ItemIndex]).sTag,
              sgList.Cells[iColumn, ARow]);
            tMediaFile(sgList.Objects[1, ARow]).bModified := True;
          end;
        end;

        if (not ckRegEx02.Checked) then
        begin
          iColumn := tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sCol;
          if iColumn > -1 then
          begin
            sgList.Cells[iColumn, ARow] := sEP02.Text;
            tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB2.Items.Objects[sCB2.ItemIndex]).sTag,
              sgList.Cells[iColumn, ARow]);
            tMediaFile(sgList.Objects[1, ARow]).bModified := True;
          end;
        end;

        if (not ckRegEx03.Checked) then
        begin
          iColumn := tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sCol;
          if iColumn > -1 then
          begin
            sgList.Cells[iColumn, ARow] := sEP03.Text;
            tMediaFile(sgList.Objects[1, ARow]).Tags.SetTag(tTagKey(sCB3.Items.Objects[sCB3.ItemIndex]).sTag,
              sgList.Cells[iColumn, ARow]);
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

procedure TfMain.FillGlobalList(sPAth: String);
var
  i: integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: boolean;
  sExt: String;

begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(sPAth, aSearchOption, nil);
  if g_tsFiles = Nil then
    g_tsFiles := tStringList.create;

  i := 0;
  while i <= Length(aFiles) - 1 do
  begin
    sExt := tpath.GetExtension(aFiles[i]);
    bAdd := (pos(uppercase(sExt), sValidExtensions) > 0);
    if bAdd then
    begin
      g_tsFiles.add(aFiles[i]);
    end;
    inc(i);
  end;
end;

procedure TfMain.fillTagCombos;
var
  i: integer;
  dTagKey: tTagKey;
  Key: String;

  function SetIndex(aList: tStrings; aKey: String): integer;
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
  ARow: integer;
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

  Action := caFree;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  terminatePreviousSearch;

  if thListMP3 <> Nil then
  begin
    if not thListMP3.Terminated then
      thListMP3.Terminate;
    while not thListMP3.Terminated do
      Application.ProcessMessages;
  end;

  if pThAddToPlayList <> nil then
  begin
    if not pThAddToPlayList.Terminated then
      pThAddToPlayList.Terminate;
    while not pThAddToPlayList.Terminated do
      Application.ProcessMessages;
  end;

  fFrmPlayer.Stop;
  fFrmPlayer.deInit;

  jConfig.s['startFolder'] := sShellTreeView1.SelectedFolder.PathName;

  jConfig.SaveTo(TDirectory.GetCurrentDirectory + '\config.json');

  CanClose := True;

end;

procedure TfMain.FormCreate(Sender: TObject);
var
  Volume: Single;
  ReleaseCodeString: string;
  SerialNumber: Longint;
begin
  // * Never forget to init BASS
  // GlobalMediaFile := tMediaFile.Create;
  Form1 := tForm1.create(Nil);
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
  sSearchBadge.Visible := false;
  sSplitView1.Opened := false;
  sMatches := tStringList.create;
  initAddToPlayListThread;
  OpenConfig;
  initGrid;
  InitDictionaries;
  fillTagCombos;
  OpenPlayer;
  isRegistered := True;
{$IFDEF DEBUG}
  btnUtils.Visible := True;
  sbDetach.Visible := True;
  OpenLogWindow;
{$ELSE}
  // GetRegistrationInformation(ReleaseCodeString, SerialNumber);
  // if not IsReleaseCodeValid(ReleaseCodeString, SerialNumber) then
  // begin
  // Caption := Caption + ' Unregistered Demo!';
  // bsRegister.Visible := True;
  // isRegistered := false;
  // end
  // else
  // begin
  // Caption := Caption + ' Registered';
  // isRegistered := True;
  // end;
{$ENDIF}
  fCoverSearch := tfCoverSearch.create(self);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Spectrum3D_Free(Sprectrum3D);
  BASS_Stop;
  BASS_Free;
  sMatches.Free;
  if fCoverSearch <> Nil then
    fCoverSearch.Free;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sFocused: String;
  aControl: tWinControl;
begin
  try
    aControl := TForm(self).ActiveControl;
    AddLog('TfMain.FormKeyDown', aControl.Name);
  except
    AddLog('TfMain.FormKeyDown', 'exception');
  end;

  // Determine which control is concerned by the key.....

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
          // sButton2Click(Sender);
          postMessage(fFrmPlayer.handle, WM_PLAY, 0, 0);
        end;
      VK_MEDIA_STOP:
        begin
          // sButton1Click(Sender);
          postMessage(fFrmPlayer.handle, WM_STOP, 0, 0);
        end;
      VK_MEDIA_PREV_TRACK:
        begin
          PlayPrevTrack;
        end;
      VK_MEDIA_NEXT_TRACK:
        begin
          // PlayNextTrack(Sender);
          postMessage(fFrmPlayer.handle, WM_PLAY_NEXT, 0, 0);
        end;
    end;
  end;
end;

procedure TfMain.FormPaint(Sender: TObject);
begin
  if fFrmLog <> Nil then
  begin
    AddLog('TfMain.FormPaint');
    fLog.Top := self.Top;
    fLog.Left := self.Left - fLog.Width;
  end;
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  if fFrmLog <> Nil then
    AddLog('TfMain.FormResize');
  Spectrum3D_ReInitialize(Sprectrum3D);
  Spectrum3D_ReAlign(Sprectrum3D, sPanel3.handle);
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  postMessage(self.handle, WM_OPEN_ROLLOUTS, 0, 0);
end;

function TfMain.getExpression: String;
var
  regexpr, RegExReplace: tRegEx;
  iMatch: integer;
  Match: tMatch;
  iGroup: integer;
  sKey: String;
  sExpr: String;
  pExpr: tExpr;
begin
  sExpr := seRegEx.Text;
  if dExpressions <> Nil then
  begin
    if dExpressions.Count > 0 then
    begin
      regexpr := tRegEx.create('\[(.*?)\]');

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
            RegExReplace.create('\[' + Match.Groups.Item[iGroup].Value + '\]');
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

function TfMain.ImageCount(aFile: String): integer;
var
  GlobalMediaFile: tMediaFile;
begin
  GlobalMediaFile := tMediaFile.create(aFile);
  Result := GlobalMediaFile.Tags.CoverArtCount;
  GlobalMediaFile.Destroy;
end;

procedure TfMain.initAddToPlayListThread;
begin
  pThAddToPlayList := thaddToPlayList.create(AddToPlayList);
  pThAddToPlayList.Priority := TThreadPriority.tpLowest;
end;

procedure TfMain.InitDictionaries;
var
  pList: tStrings;
begin
  if dMultiChoices <> Nil then
  begin
    dMultiChoices.clear;
    dMultiChoices.Free;
  end;
  dMultiChoices := tDictionary<String, tStrings>.create;
  pList := tStringList.create;
  dMultiChoices.add('ARTIST', pList);
  pList := tStringList.create;
  dMultiChoices.add('ALBUM', pList);
end;

procedure TfMain.initGrid;

  procedure cleanObjects;
  var
    i: integer;
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

procedure TfMain.sgListGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
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
  index: integer;
  i: integer;
  pMediaFile: tMediaFile;
  ARow: integer;
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
            // fFrmPlayer.PlayStream(tMediaFile(sgList.Objects[1, sgList.Row]).Tags.FileName);
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
                // PlayStream(tMediaFile(slbPlaylist.Items.Objects[index]).Tags.FileName);
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

procedure TfMain.sgListRightClickCell(Sender: TObject; ARow, ACol: integer);
begin
  if sgList.SelectedRowCount <= 1 then
  begin
    sgList.Row := ARow;
    sgList.EditMode := false;
    sgList.Options := [goRowSelect, goRangeSelect];
  end;
end;

procedure TfMain.sgListRowChanging(Sender: TObject; OldRow, NewRow: integer; var Allow: boolean);
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

procedure TfMain.sgListSetEditText(Sender: TObject; ACol, ARow: integer; const Value: string);
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
  if not sSplitView1.Opened then
    gOldControl := TForm(self).ActiveControl;
  sSplitView1.Opened := not sSplitView1.Opened;
  if sSplitView1.Opened then
    TForm(self).SetFocusedControl(sShellTreeView1)
  else
    gOldControl.SetFocus;

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

procedure TfMain.sAlphaHints1ShowHint(var HintStr: string; var CanShow: boolean; var HintInfo: THintInfo; var Frame: TFrame);
begin
  if HintInfo.HintControl = sBitBtn1 then
  begin
    HintStr := 'Open Explorer Alt-E';
  end;

end;

procedure TfMain.savePlaylist;
var
  Json: ISuperObject;
  i: integer;
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
          s['fileName'] := pMediaFile.Tags.FileName;
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
  Width, Height: integer;
  NoOfColors: integer;
  ColorDepth: integer;
  PictureMagic: Word;
  CoverArtPictureFormat: TTagPictureFormat;
  CoverArt: TCoverArt;
  pMediaFile: tMediaFile;
  i, ARow: integer;
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
          JPEGPicture := TJPEGImage.create;
          try
            JPEGPicture.Assign(fCoverSearch.image1.Picture.BitMap);
            Width := JPEGPicture.Width;
            Height := JPEGPicture.Height;
            NoOfColors := 0;
            ColorDepth := 24;
          finally
            FreeAndNil(JPEGPicture);
          end;
          PictureStream := TMemoryStream.create;
          fCoverSearch.image1.Picture.BitMap.SaveToStream(PictureStream);
          PictureStream.Position := 0;
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

procedure TfMain.SaveTags(iRow: integer);
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

procedure TfMain.btnSearchClick(Sender: TObject);
var
  index: integer;
  bOptions: tOptionsSearch;

begin
  //
  if sMatches.Count = 0 then
  begin
    sSearchBadge.Visible := false;
    gSearchFolder := IncludeTrailingBackslash(sDESearch.Text);
    bOptions.bWord := slWholeWord.SliderOn;
    bOptions.bDir := slIncDir.SliderOn;
    pTHSearch := thSearchDisk.create(gSearchFolder, seSearch.Text, sMatches, bOptions, SetSearchResult, setBadgeColor);
    pTHSearch.Start;
  end
  else
  begin
    Index := sMatches.IndexOf(sShellTreeView1.Path);
    if Index < sMatches.Count - 1 then
    begin
      inc(Index);
    end
    else
    begin
      Index := 0;
    end;
    sShellTreeView1.Path := sMatches[index];
    sShellTreeView1.SetFocus;
  end;

end;

procedure TfMain.sbDetachClick(Sender: TObject);
begin
  fFrmPlayer.deInit;
  fFrmPlayer.Parent := Form1.sPanel1;
  fFrmPlayer.init;
  Form1.Show;
  sbDetach.Caption := 'Attach';
end;

procedure TfMain.btnRegexClick(Sender: TObject);
begin
  ExtractTags(sgList.Row, false);
end;

procedure TfMain.btnUtilsClick(Sender: TObject);
var
  fRegExFrame: tFrame2;
begin
  fRegExFrame := tFrame2.create(self);
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

procedure TfMain.SelfMove(var msg: TWMMove);
begin
  if msg.Result = 0 then
  begin
    if fFrmLog <> Nil then
    begin
      AddLog('TfMain.SelfMove');
      fLog.Top := self.Top;
      fLog.Left := self.Left - fLog.Width;
    end;
  end;
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
  iCaret: integer;
  sString: String;
  iBracketStart, iBracketEnd: integer;
  iLenght: integer;

  function rpos(Substr: String; s: String; iStart: integer): integer;
  var
    i: integer;
  begin
    for i := iStart downto 1 do
      if (Copy(s, i, Length(Substr)) = Substr) then
      begin
        Result := i;
        Exit;
      end;
  end;

  function lpos(Substr: String; s: String; iStart: integer): integer;
  var
    i: integer;
  begin
    for i := iStart to Length(s) do
      if (Copy(s, i, Length(Substr)) = Substr) then
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

procedure TfMain.terminatePreviousSearch;
begin
  if pTHSearch <> nil then
  begin
    if not pTHSearch.Terminated then
    begin
      pTHSearch.Terminate;
      while not pTHSearch.Terminated do
        if Application <> Nil then
          Application.ProcessMessages;

      FreeAndNil(pTHSearch);
    end;
  end;
end;

procedure TfMain.seSearchChange(Sender: TObject);
begin
  btnSearch.Enabled := false;
  terminatePreviousSearch;
  sSearchBadge.Visible := false;
  btnSearch.Caption := 'Search';
  btnSearch.Enabled := True;
  sMatches.clear;
end;

procedure TfMain.setBadgeColor(bactive: boolean);
var
  aColor: TColor;
begin
  if bactive then
  begin
    aColor := col_on;
    sSearchBadge.Caption := '0';
    sSearchBadge.Visible := True;
  end
  else
    aColor := col_off;

  with sSearchBadge.PaintOptions do
  begin
    DataActive.Color1 := aColor;
    DataActive.Color2 := aColor;
    DataNormal.Color1 := aColor;
    DataNormal.Color2 := aColor;
    DataPressed.Color1 := aColor;
    DataPressed.Color2 := aColor;
  end;

  if not bactive then
    terminatePreviousSearch;
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

procedure TfMain.SetSearchResult(s: String);
var
  PathName: String;
begin
  PathName := tpath.GetDirectoryName(s);
  if sMatches.IndexOf(PathName) = -1 then
  begin
    sMatches.add(s);
    if sMatches.Count = 1 then
    begin
      sShellTreeView1.Path := s;
      sShellTreeView1.SetFocus;
    end;
  end;
  sSearchBadge.Visible := sMatches.Count > 0;
  sSearchBadge.Caption := inttostr(sMatches.Count);
  btnSearch.Caption := '&Next';

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

procedure TfMain.slIncDirChanging(Sender: TObject; var CanChange: boolean);
begin
  seSearchChange(nil);
end;

procedure TfMain.slWholeWordChanging(Sender: TObject; var CanChange: boolean);
begin
  seSearchChange(nil);
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

procedure TfMain.sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: boolean);
var
  sExtension: string;
  aFile: String;
  iCount: integer;
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
    pMediaFile := tMediaFile.create(TacShellFolder(aNode.data).PathName);
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

procedure TfMain.sShellTreeView1Click(Sender: TObject);
begin
  //
  if sMatches.Count = 0 then
    sDESearch.Text := sShellTreeView1.Path;
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
      GlobalMediaFile := tMediaFile.create(TacShellFolder(Node.data).PathName);
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
      removeKeyFromStack;
      PreviewTrack(sShellTreeView1.Selected);
    end;

    if Key = VK_ADD then
    begin
      removeKeyFromStack;
      AddDirectlyToPlayList;
    end;
  end;

  if (Key = VK_ADD) and not(ssCtrl in Shift) then
  begin
    removeKeyFromStack;
    AddToGrid((Shift = [ssShift]));
  end;

end;

procedure TfMain.sSplitView1Opened(Sender: TObject);
begin
  sShellTreeView1.SetFocus;
end;

procedure TfMain.ListCoverArts(aImage: TsImage; Tags: TTags);
var
  i: integer;
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
      BitMap := TBitmap.create;
      try
        with Tags.CoverArts[i] do
        begin
          Stream.Seek(0, soBeginning);
          case PictureFormat of
            tpfJPEG:
              begin
                ImageJPEG := TJPEGImage.create;
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
                ImagePNG := TPNGImage.create;
                try
                  ImagePNG.LoadFromStream(Stream);
                  BitMap.Assign(ImagePNG);
                finally
                  FreeAndNil(ImagePNG);
                end;
              end;
            tpfGIF:
              begin
                ImageGIF := TGIFImage.create;
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
    GetNoCoverImage(aImage.Picture);
  end;
end;

procedure TfMain.loadPlaylist;
var
  i: integer;
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
      pMediaFile := tMediaFile.create(Json.a['tracks'].O[i].s['filename']);
      slbPlaylist.Items.AddObject(tpath.GetFileNameWithoutExtension(pMediaFile.Tags.FileName), pMediaFile);
      inc(i);
    end;
  end;
end;

procedure TfMain.MPlayNext(var msg: TMessage);
begin
  postMessage(fFrmPlayer.handle, WM_PLAY_NEXT, 1, 0);
end;

procedure TfMain.ListCoverArts(aImage: TsImage; sFileName: String);
begin
end;

procedure TfMain.OpenConfig;
begin
  //
  g_sPath := TDirectory.GetCurrentDirectory;
  if fileExists(g_sPath + '\config.json') then
  begin
    jConfig := TSuperObject.ParseFile(g_sPath + '\config.json');
    g_sPath := jConfig.s['startFolder'];
    if g_sPath <> '' then
    begin
      if DirectoryExists(g_sPath) then
      begin
        sShellTreeView1.Path := g_sPath;
        if sShellTreeView1.Selected <> Nil then
          sShellTreeView1.Selected.Expand(false);
      end
      else
        g_sPath := 'c:\';
    end;
  end
  else
  begin
    jConfig := SO;
    g_sPath := 'c:\';
  end;
end;

procedure TfMain.OpenLogWindow;
begin
  fLog := tfLog.create(self);
  fFrmLog := tFrmLog.create(self);
  fFrmLog.Parent := fLog.sPnMain;

  fLog.Top := self.Top;
  fLog.Show;

end;

procedure TfMain.OpenPlayer;
begin
  // * Never forget to init BASS
  fFrmPlayer := tFrmPlayer.create(self);
  fFrmPlayer.Parent := sPnPlayer;
  fFrmPlayer.init;

end;

procedure TfMain.OpenRollOuts(var m: Tmsg);
begin
  image1.Picture.Assign(Nil);
  image1.Refresh;
  Application.ProcessMessages;
  GetNoCoverImage(image1.Picture);
  Application.ProcessMessages;
end;

procedure TfMain.playlistRemoveItem(index: integer);
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

procedure TfMain.sTVMediasExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: boolean);
begin
  if Node.Count = 0 then
  begin
    g_sPath := Node.Text;
    aNode := Node;
    thListMP3.Execute(self);
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
  i: integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: boolean;
  sExt: String;
  bConfirm: boolean;
  bFirst: boolean;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(g_sPath, aSearchOption, nil);
  bConfirm := True;
  bFirst := True;
  if Length(aFiles) > 1000 then
  begin
    bConfirm := (MessageDlg(format('Do you confirm adding %d files ?', [Length(aFiles)]), mtConfirmation, [mbYes, mbNo], 0,
      mbNo) = mrYes);
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
        g_sFile := aFiles[i];
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
    bm2 := TBitmap.create;
    bm2.SetSize(cliprect.Width, (cliprect.Height div 4));
    bm2.Canvas.Brush.Color := clTeal;
    bm2.Canvas.Brush.Style := bsSolid;
    R := TRect.create(0, 0, bm2.Width, bm2.Height);
    bm2.Canvas.Fillrect(R);
    Draw(0, cliprect.Height - (cliprect.Height div 4), bm2, 200);
    bm2.Free;
  end;
end;

procedure TfMain.UpdateTagLists(iCol: integer; sValue: String);
var
  sTag: String;
begin
  sTag := FindTag(iCol);
  if sTag <> '' then
    AddToDictionary(sTag, sValue);
end;

procedure TfMain.DrawTransparentRectangle(Canvas: TCanvas; Rect: TRect; Color: TColor; Transparency: integer);
var
  X: integer;
  Y: integer;
  C: TColor;
  R, G, B: integer;
  RR, RG, RB: integer;
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
  pMediaFile := tMediaFile.create(sFileName);
  updatePlayingInfos(pMediaFile.Tags);
  pMediaFile.Destroy;
end;

procedure TfMain.UpdateVuMetre(LeftLevel, RightLevel: integer);

  procedure updateMeter(aImage: TsImage; iLevel: integer; iMax: integer);
  var
    R: TRect;
    w: integer;
    l: integer;
    barwidth: integer;
    p, p2: integer;
    bm2: TBitmap;

  begin
    aImage.Picture.BitMap.Assign(sImage2.Picture.BitMap);
    with aImage.Canvas do
    begin
      bm2 := TBitmap.create;
      w := iMax;
      p := Round(iLevel / w * 100);
      p2 := 100 - p;
      barwidth := cliprect.Width;
      l := Round(barwidth / 100 * p);
      bm2.SetSize(Round(cliprect.Width / 100 * p2), cliprect.Height);
      bm2.Canvas.Brush.Color := clGray;
      bm2.Canvas.Brush.Style := bsSolid;
      R := TRect.create(0, 0, bm2.Width, bm2.Height);
      bm2.Canvas.Fillrect(R);
      Draw(l, 0, bm2, 220);
      bm2.Free;
    end;
  end;

begin

  updateMeter(vuL, LeftLevel, sGauge1.MaxValue);
  updateMeter(VuR, RightLevel, sGauge2.MaxValue);
end;

{ thaddToPlayList }

constructor thaddToPlayList.create(addToPlaylistCallback: tAddToPlayListCallback);
begin
  inherited create(True);
  self.Priority := TThreadPriority.tpLower;
  AddToPlayList := addToPlaylistCallback;
end;

procedure thaddToPlayList.DoTerminate;
begin
  inherited;
  fMain.AddLog('DoTerminate', 'Terminate');
end;

procedure thaddToPlayList.Execute;
var
  index: integer;
  sFile: String;
begin

  inherited;
  while not Terminated do
  begin
    if g_tsFiles <> nil then
    begin
      if g_tsFiles.Count > 0 then
      begin
        index := 0;
        sFile := g_tsFiles[index];
        g_tsFiles.delete(index);
        AddToPlayList(sFile);
      end
      else
        Suspend;
    end;
    Application.ProcessMessages;
  end;
end;

{ thSearchDisk }

constructor thSearchDisk.create(StartFolder, sRx: String; aMatches: tStrings; poptions: tOptionsSearch;
  searchCallBack: tSearchCallback; setBadgeCallBAck: tSetBadgeColorCallBack);
begin
  inherited create(True);
  FreeOnTerminate := false;
  returnResult := searchCallBack;
  setBadgeColor := setBadgeCallBAck;
  fRx := sRx;
  bOptions := poptions;
  fStartFolder := StartFolder;
  fMAtches := tStringList.create;
  fMAtches.Assign(aMatches);
end;

procedure thSearchDisk.DoTerminate;
begin
  setBadgeColor(false);
  tag := 1;
  inherited;
end;

procedure thSearchDisk.Execute;
begin
  inherited;
  setBadgeColor(True);
  tag := 0;
  GetFilesFast(fStartFolder);
end;

procedure thSearchDisk.GetFiles(s: String);
{ recursively read all file names from directory S and add them to FileList }
var
  F: TSearchrec;
  R: integer;
begin
  R := FindFirst(s + '*.*', FaAnyFile, F);
  while (not Terminated) and (R = 0) and (tag = 0) do
  begin
    If (Length(F.Name) > 0) and (uppercase(F.Name) <> 'RECYCLED') and (F.Name[1] <> '.') and (F.Name <> '..') and
      (F.Attr and FAVolumeId = 0) then
    begin
      if ((F.Attr and FADirectory) > 0) then
      begin
        if bOptions.bDir then
        begin
          if matchesMask(s + F.Name, True) then
          begin
            returnResult(s + F.Name);
            Application.ProcessMessages;
          end;
        end;
        GetFiles(s + F.Name + '\')
      end
      else if matchesMask(s + F.Name, false) then
      begin
        if not bOptions.bDir then
          returnResult(s + F.Name);
        Application.ProcessMessages;
        // tag := 1;
      end;
    end;
    R := Findnext(F);
  end;
  FindClose(F);
end;

procedure thSearchDisk.GetFilesFast(s: string);
var
  Predicate: TDirectory.TFilterPredicate;
  tFiles: TStringDynArray;
  iFile: String;
  regexpr: tRegEx;
  RO: TRegExOptions;

begin
  RO := [roIgnoreCase];
  if bOptions.bWord then
    fRx := '\b' + fRx + '\b';
  regexpr := tRegEx.create(fRx, [roIgnoreCase]);
  Predicate := function(const Path: string; const SearchRec: TSearchrec): boolean
    begin
      if _matches(IncludeTrailingBackslash(Path) + SearchRec.Name, (SearchRec.Attr and FADirectory = SearchRec.Attr), regexpr) then
      begin
         returnResult(IncludeTrailingBackslash(path)+Searchrec.Name);
         application.ProcessMessages;
        Exit(True);
      end;
      Exit(false);
    end;
  // TDirectory.GetFileSystemEntries('c:\mp3\', Predicate);
  tFiles := TDirectory.GetFileSystemEntries(s, tSearchOption.soAllDirectories, Predicate);
//  for iFile in tFiles do
//  begin
//    returnResult(iFile);
//    Application.ProcessMessages;
//  end;
end;

function thSearchDisk._matches(sString: String; isDirectory: boolean; regexpr: tRegEx): boolean;
var
  sExtension: string;
  CanAdd: boolean;
begin
  Result := false;
  CanAdd := True;
  if not isDirectory then
  begin
    sExtension := tpath.GetExtension(sString);
    CanAdd := (pos(uppercase(sExtension), sValidExtensions) > 0);
  end;
  // if CanAdd and (fMAtches.IndexOf(sString) = -1) then
  if CanAdd then
  begin
    Result := regexpr.isMatch(sString);
  end;
end;

function thSearchDisk.matchesMask(sString: String; isDirectory: boolean): boolean;
var
  Match: tMatch;
  regexpr: tRegEx;
  RO: TRegExOptions;
  sExtension: string;
  CanAdd: boolean;
begin
  Result := false;
  CanAdd := True;
  // if not isDirectory then
  // begin
  // sExtension := tpath.GetExtension(sString);
  // CanAdd := (pos(uppercase(sExtension), sValidExtensions) > 0);
  // end;
  // if CanAdd and (fMAtches.IndexOf(sString) = -1) then
  if CanAdd then
  begin
    RO := [roIgnoreCase];
    if bOptions.bWord then
      fRx := '\b' + fRx + '\b';
    regexpr := tRegEx.create(fRx, [roIgnoreCase]);
    Match := regexpr.Match(sString);
    Result := Match.Success;
  end;
end;

end.
