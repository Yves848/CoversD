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
  ovctable, AdvGrid, dateutils, uCoverSearch, sDialogs, sLabel, sBevel, uSelectDirectory, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DBAdvGrid, Vcl.DBGrids, sEdit, AdvCGrid;

const
  WM_FILLGRID = WM_USER + 2000;

type
  tInsertIntoGrid = procedure(aId: Integer; aMediaName, aArtist, aTitle, aAlbum: string) of object;

  ThInsert = class(tThread)
  private
    insertRow: tInsertIntoGrid;
    MQ: TFDQuery;
  protected
    procedure Execute; override;
  public
    constructor create(MediaQuery: TFDQuery; callback: tInsertIntoGrid); reintroduce;
  end;

  TfMain = class(TForm)
    pnBack: TsPanel;
    sSkinProvider1: TsSkinProvider;
    sSkinManager1: TsSkinManager;
    pnToolbar: TsPanel;
    sSplitter1: TsSplitter;
    pnStatus: TsPanel;
    sILIcons: TsAlphaImageList;
    pb1: TsProgressBar;
    thListMP3: TJvThread;
    sILTV: TsAlphaImageList;
    sImage1: TsImage;
    sROPPlaylist: TsRollOutPanel;
    sSplitter2: TsSplitter;
    TrackBar1: TsTrackBar;
    sGauge1: TsGauge;
    Timer1: TTimer;
    sGauge2: TsGauge;
    TrackBar2: TsTrackBar;
    sButton1: TsButton;
    sButton2: TsButton;
    SynJSONSyn1: TSynJSONSyn;
    slbPlaylist: TsListBox;
    pnMain: TsPanel;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sButton3: TsButton;
    Image1: TsImage;
    sButton4: TsButton;
    sButton5: TsButton;
    sSaveDialog1: TsSaveDialog;
    sOpenDialog1: TsOpenDialog;
    sButton6: TsButton;
    sILButtons: TsAlphaImageList;
    sButton7: TsButton;
    sButton8: TsButton;
    sBevel1: TsBevel;
    slblArtist: TsLabel;
    slblTitle: TsLabel;
    sPanel3: TsPanel;
    thDisplay: TJvThread;
    sButton9: TsButton;
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    DataSource1: TDataSource;
    qMedias: TFDQuery;
    DataSource2: TDataSource;
    sgList: TAdvStringGrid;
    thFillGrid: TJvThread;
    sEdit1: TsEdit;
    sEdit2: TsEdit;
    qTags: TFDQuery;
    sPanel4: TsPanel;
    qSearchTag: TFDQuery;
    sImage2: TsImage;
    procedure Button1Click(Sender: TObject);
    procedure thListMP3Execute(Sender: TObject; Params: Pointer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
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
    procedure sgListClick(Sender: TObject);
    procedure thFillGridExecute(Sender: TObject; Params: Pointer);
    procedure DBAdvGrid1RowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
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
    Procedure AddFolderToGrid(sFolder: String);
    Procedure AddFileToGrid(sFile: String);
    Procedure AddFileToGridTH;
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
    Procedure FillGrid(var m: tMsg); Message WM_FILLGRID;
    procedure InsertInGrid(aId: Integer; aMediaName, aArtist, aTitle, aAlbum: string);
    procedure InsertInGrid2;
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
  thId: Integer;
  thMediaName: String;
  thArtist: String;
  thTitle: String;
  thAlbum: String;

implementation

{$R *.dfm}

uses
  JvDynControlEngineVcl;

procedure StreamEndCallback(handle: HSYNC; Channel, Data: DWORD; user: Pointer); stdcall;
begin
  fMain.PlayNextTrack(nil);
end;

procedure TfMain.PlayNextTrack(Sender: TObject);
var
  index: Integer;
begin
  if (BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING) or (Sender = nil) then
  begin
    index := slbPlaylist.ItemIndex;
    inc(index);
    if index > slbPlaylist.Items.Count - 1 then
      index := 0;

    slbPlaylist.ItemIndex := index;

    BASS_ChannelStop(Channel);
    PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
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

procedure TfMain.AddFileToGrid(sFile: String);
var
  ARow: Integer;
  pMediaFile: tMediaFile;
begin
  //
  // ARow := sgList.RowCount - 1;
  // if sgList.Cells[0, ARow] <> '' then
  // begin
  // sgList.RowCount := sgList.RowCount + 1;
  // ARow := sgList.RowCount - 1;
  // end;
  //
  // pMediaFile := tMediaFile.Create(sFile);
  // try
  // sgList.Cells[0, ARow] := sFile;
  // sgList.Cells[1, ARow] := pMediaFile.Tags.GetTag('ARTIST');
  // sgList.Cells[2, ARow] := pMediaFile.Tags.GetTag('TITLE');
  // sgList.Cells[3, ARow] := pMediaFile.Tags.GetTag('ALBUM');
  // if pMediaFile.Tags.CoverArts.Count > 0 then
  // sgList.Cells[4, ARow] := 'O'
  // else
  // sgList.Cells[4, ARow] := '';
  // finally
  // pMediaFile.Destroy;
  // end;
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
  while i <= length(aFiles) - 1 do
  begin
    sExt := tpath.GetExtension(aFiles[i]);
    bAdd := (tMediaUtils.isValidExtension(sExt) > -1);
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
  // result := -1;
  // aMediaFile := tMediaFile.Create(sgList.Cells[0, ARow]);
  // sPath := tpath.GetDirectoryName(aMediaFile.Tags.FileName);
  // sFile := tpath.GetFileNameWithoutExtension(aMediaFile.Tags.FileName);
  // index := slbPlaylist.Items.IndexOf(sFile);
  // if index = -1 then
  // begin
  // result := slbPlaylist.Items.AddObject(sFile, aMediaFile);
  // end
  // else
  // result := index;
end;

procedure TfMain.sgListClick(Sender: TObject);
begin

end;

// function TfMain.AddToPlayList(aNode: TTreeNode; bRecurse: Boolean): Integer;
// var
// index: Integer;
// Tags: TTags;
// currentNode: TTreeNode;
// begin
// if aNode.HasChildren then
// currentNode := aNode.getFirstChild;
// while currentNode <> nil do
// begin
//
// if tMediaFile(currentNode.data) <> nil then
// begin
// Tags := tMediaFile(currentNode.data).Tags;
// AddToPlayList(Tags);
// end;
// currentNode := currentNode.getNextSibling;
// end;
// end;

procedure TfMain.Button1Click(Sender: TObject);
var
  form2: tForm2;
begin
  form2 := tForm2.create(Self);
  form2.ShowModal;
  form2.Free;
end;

procedure TfMain.DBAdvGrid1RowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
var
  pMediaFile: tMediaFile;
  buff: tStream;
begin
  qSearchTag.Close;
  qSearchTag.ParamByName('id').AsInteger := FDTable1.FieldByName('Id').AsInteger;
  qSearchTag.Open;
  buff := qSearchTag.CreateBlobStream(qSearchTag.FieldByName('cover'), TBlobStreamMode.bmRead);
  if buff.Size > 0 then
    sImage2.Picture.BitMap.LoadFromStream(buff)
  else
    sImage2.Picture.BitMap.FreeImage;

  buff.Free;

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
    Image1.Picture.Assign(jpgImg)
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
      mediaFile := tMediaFile.create(sFileName);
      // aNode := sTVMedias.Items.AddObject(nil, sFile, mediaFile);
      aNode.ImageIndex := 0;
    end
    else
    begin
      // aParentNode := sTVMedias.Items.Add(nil, sFile);
      if TDirectory.Exists(sFileName) then
      begin
        aParentNode.HasChildren := True;
        aParentNode.ImageIndex := 2;
      end;
    end;
  end
  else
  begin
    mediaFile := tMediaFile.create(sFileName);
    // aNode := sTVMedias.Items.AddChildObject(aParentNode, sFile, mediaFile);
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
  // sDEFolder.Enabled := True;
end;

procedure TfMain.FillGrid(var m: tMsg);
var
  pTh: ThInsert;
begin
  initGrid;
  pb1.Position := 0;
  sEdit1.Text := timetostr(time);
  // pTH := THInsert.create(qMedias,InsertInGrid);
  // pTH.Resume;
  // while not pTH.terminated do
  // Application.ProcessMessages;
  //
  // pTH.Free;
  // thFillGrid.Execute(Self);

  qMedias.Open;
  qMedias.Last;
  iMax := qMedias.RecordCount;
  qMedias.First;
  while not qMedias.eof do
  begin
    InsertInGrid(qMedias.FieldByName('id').AsInteger, qMedias.FieldByName('FileName').asString, qMedias.FieldByName('artist').asString,
      qMedias.FieldByName('title').asString, qMedias.FieldByName('album').asString);

    qMedias.Next;
  end;
  qMedias.Close;


  sEdit2.Text := timetostr(time);
  pb1.Position := 0;
end;

function TfMain.findNode(sLabel: String): TTreeNode;
var
  i: Integer;
  sParent: String;
begin
  result := Nil;
  i := 0;

  // while i <= sTVMedias.Items.Count - 1 do
  // begin
  // if sTVMedias.Items[i].Text = sLabel then
  // begin
  // result := sTVMedias.Items[i];
  // i := sTVMedias.Items.Count;
  // end;
  // inc(i);
  // end;
  if result = nil then
  begin
    sParent := TDirectory.GetParent(sLabel);
    if sParent <> '' then
      result := findNode(sParent);
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
begin
  // * Never forget to init BASS

  BASS_Init(-1, 44100, 0, Self.handle, 0);

  ZeroMemory(@Params, SizeOf(TSpectrum3D_CreateParams));
  // * Set parent control
  Params.ParentHandle := sPanel3.handle;
  // * Use antialiasing
  Params.AntiAliasing := 4;
  // * Create our spectrum display
  Sprectrum3D := Spectrum3D_Create(@Params);
  // * Get all settings
  Spectrum3D_GetParams(Sprectrum3D, @Settings);
  // * Set params here eg.:
  Settings.ShowText := True;
  // * Apply new settings
  Spectrum3D_SetParams(Sprectrum3D, @Settings);
  // * Create a BASS channel (Below Delphi 2009 - ansi)
  // Channel := BASS_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_STREAM_AUTOFREE);
  // * Create a BASS channel (Delphi 2009 and above - unicode)
  // Channel := BASS_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_STREAM_AUTOFREE OR BASS_UNICODE);

  // * Set VU max. values
  sGauge1.MaxValue := High(Word) div 2 + 1;
  sGauge2.MaxValue := High(Word) div 2 + 1;
  // * Get current volume
  Volume := BASS_GetVolume;
  TrackBar2.Position := 100 - Round(Volume * 100);
  OpenConfig;
  initGrid;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Spectrum3D_Free(Sprectrum3D);
  BASS_Stop;
  BASS_Free;
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
      // VK_F1:
      // sShellTreeView1.SetFocus;
      // VK_F2:
      // sgList.SetFocus;
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
  Application.ProcessMessages;
  postMessage(Self.handle, WM_FILLGRID, 0, 0);

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

  sgList.Clear;
  sgList.AddCheckBoxColumn(6,false,false);
  sgList.RowCount := 2;
  sgList.ColWidths[0] := 36;
  sgList.ColWidths[1] := 486;
  sgList.ColWidths[2] := 200;
  sgList.ColWidths[3] := 200;
  sgList.ColWidths[4] := 160;
  sgList.ColWidths[5] := 160;
  sgList.ColWidths[6] := 60;

  sgList.Cells[1, 0] := 'Fichier';
  sgList.Cells[2, 0] := 'Artiste';
  sgList.Cells[3, 0] := 'Titre';
  sgList.Cells[4, 0] := 'Album';
  sgList.Cells[5, 0] := 'Genre';
  sgList.Cells[6, 0] := 'Cover';

end;

procedure TfMain.InsertInGrid(aId: Integer; aMediaName, aArtist, aTitle, aAlbum: string);
var
  ARow: Integer;
  pGridObject: tGridObject;
  buff: tStream;
begin
  ARow := sgList.RowCount - 1;
  if sgList.Cells[1, ARow] <> '' then
  begin
    sgList.RowCount := sgList.RowCount + 1;
    ARow := sgList.RowCount - 1;
  end;

  pGridObject := tGridObject.create(aId, aMediaName, aArtist, aTitle, aAlbum);
  sgList.Objects[0, ARow] := pGridObject;
  sgList.Cells[1, ARow] := aMediaName;
  sgList.Cells[2, ARow] := aArtist;
  sgList.Cells[3, ARow] := aTitle;
  sgList.Cells[4, ARow] := aAlbum;
  // qSearchTag.Close;
  // qSearchTag.ParamByName('id').AsInteger := aId;
  // qSearchTag.Active := true;
  // buff := qMedias.CreateBlobStream(qMedias.FieldByName('cover'), TBlobStreamMode.bmRead);
  // if buff.Size > 0 then
  // sgList.Cells[5, ARow] := 'O'
  // else
  // sgList.Cells[5, ARow] := 'N';
  // buff.Free;
  // qSearchTag.Close;
  sgList.Cells[5, ARow] := qMedias.FieldByName('genre').AsString;
  //sgList.Cells[6, ARow] := qMedias.FieldByName('cover').AsString;
  sgList.AddCheckBox(6,aRow,(qMedias.FieldByName('cover').asInteger = 1),true);



  if (ARow mod 1000) = 0 then
  begin
    pb1.Position := Round(ARow / iMax * 100);
    pb1.Refresh;
    Application.ProcessMessages;
  end;

end;

procedure TfMain.InsertInGrid2;
begin
  //
  InsertInGrid(thId, thMediaName, thArtist, thTitle, thAlbum);
end;

procedure TfMain.sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  index: Integer;
  i: Integer;
begin

  // if sgList.EditMode then
  // begin
  // if (Key = VK_NUMPAD1) and (ssCtrl in Shift) then
  // begin
  // removeKeyFromStack;
  // sgList.Cells[1, sgList.Row] := sgList.NormalEdit.SelText;
  //
  // end;
  // if (Key = VK_NUMPAD2) and (ssCtrl in Shift) then
  // begin
  // removeKeyFromStack;
  // sgList.Cells[2, sgList.Row] := sgList.NormalEdit.SelText;
  //
  // end;
  // if Key = VK_ESCAPE then
  // begin
  // sgList.Options := [goRowSelect, goRangeSelect];
  // end;
  // end
  // else
  // begin
  // if Key = VK_ADD then
  // begin
  // i := 0;
  // while i <= sgList.RowSelectCount - 1 do
  // begin
  // AddToPlayList(sgList.SelectedRow[i]);
  // inc(i);
  // end;
  // end;
  //
  // if Key = VK_RETURN then
  // begin
  // if Shift = [] then
  // begin
  // if not(goEditing in sgList.Options) then
  // begin
  // sgList.Options := [goEditing, goTabs];
  // sgList.Col := 1;
  // sgList.EditCell(1, sgList.Row);
  // end
  // else
  // begin
  // sgList.EditCell(sgList.Col, sgList.Row);
  // end;
  // // sgList.EditMode := True;
  // end
  // else
  // begin
  // if Shift = [ssCtrl] then
  // begin
  // BASS_ChannelStop(Channel);
  // PlayStream(sgList.Cells[0, sgList.Row]);
  // end
  // else
  // begin
  //
  // index := -1;
  // i := 0;
  // while i <= sgList.RowSelectCount - 1 do
  // begin
  // if i = 0 then
  // begin
  // if not(ssCtrl in Shift) then
  // begin
  // if (ssShift in Shift) then
  // index := AddToPlayList(sgList.SelectedRow[i]);
  // BASS_ChannelStop(Channel);
  // if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_STOPPED then
  // begin
  // slbPlaylist.ItemIndex := index;
  // PlayStream(tMediaFile(slbPlaylist.Items.Objects[index]).Tags.FileName);
  // end;
  //
  // end;
  // end;
  // inc(i);
  // end;
  // end;
  // end;
  //
  // removeKeyFromStack;
  // end;
  //
  // if Key = VK_DELETE then
  // begin
  // if ssShift in Shift then
  // if not sgList.EditMode then
  // initGrid;
  // removeKeyFromStack;
  // end;
  // end;

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
  // if delais >= 100 then
  // begin
  // sgList.Options := [goEditing];
  // sgList.EditMode := True;
  //
  // end;

end;

procedure TfMain.sgListRowChanging(Sender: TObject; OldRow, NewRow: Integer; var Allow: Boolean);
var
  pMediaFile: tMediaFile;
  buff: tStream;
begin
  // Afficher la pochette si elle existe
  // if sgList.Cells[0, NewRow] <> '' then
  // begin
  // pMediaFile := tMediaFile.Create(sgList.Cells[0, NewRow]);
  // ListCoverArts(Image1, pMediaFile.Tags);
  // pMediaFile.Destroy;
  // end;
  if not qMedias.Active then
  begin
    qSearchTag.Close;
    qSearchTag.ParamByName('id').AsInteger := tGridObject(sgList.Objects[0, NewRow]).id;
    qSearchTag.Open;
    buff := qSearchTag.CreateBlobStream(qSearchTag.FieldByName('cover'), TBlobStreamMode.bmRead);
    if buff.Size > 0 then
      sImage2.Picture.BitMap.LoadFromStream(buff)
    else
      sImage2.Picture.assign(nil);

    buff.Free;
  end;
end;

procedure TfMain.showExplorer;
begin
  // if sROPMedia.Collapsed then
  // begin
  // sROPMedia.ChangeState(False, True);
  // //sShellTreeView1.SetFocus;
  // end
  // else
  // sROPMedia.ChangeState(True, True);
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
end;

procedure TfMain.sButton2Click(Sender: TObject);
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

procedure TfMain.sButton3Click(Sender: TObject);
var
  fCoverSearch: tfCoverSearch;
begin
  fCoverSearch := tfCoverSearch.create(Self);
  // fCoverSearch.Artist := sgList.Cells[1, sgList.Row];
  // fCoverSearch.Title := sgList.Cells[2, sgList.Row];
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
  pfSelectDirectory := TfSelectDirectory.create(Self);
  pfSelectDirectory.ShowModal;
  pfSelectDirectory.Free;
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
  // CanAdd := True;
  // if not AFolder.IsFileFolder then
  // begin
  // sExtension := tpath.GetExtension(AFolder.PathName);
  // CanAdd := (pos(uppercase(sExtension), sValidExtensions) > 0);
  // end;
end;

procedure TfMain.sShellTreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  aNode: TTreeNode;
begin
  // if Shift = [ssCtrl] then
  // begin
  // aNode := sShellTreeView1.Selected;
  // if not TacShellFolder(aNode.data).IsFileFolder then
  // begin
  // // ListCoverArts(sImage1,TacShellFolder(aNode.data).PathName);
  // BASS_ChannelStop(Channel);
  // PlayStream(TacShellFolder(aNode.data).PathName);
  // end;
  // removeKeyFromStack;
  // end;
end;

procedure TfMain.sShellTreeView1KeyPress(Sender: TObject; var Key: Char);
var
  aNode: TTreeNode;
begin
  // if Key = #13 then
  // begin
  // if sShellTreeView1.Selected <> nil then
  // begin
  // aNode := sShellTreeView1.Selected;
  // if not TacShellFolder(aNode.data).IsFileFolder then
  // begin
  // AddFileToGrid(TacShellFolder(aNode.data).PathName);
  // end
  // else
  // begin
  // aPath := TacShellFolder(aNode.data).PathName;
  // thListMP3.Execute(Self);
  // end;
  // end;
  // Key := #0;
  // end;
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
                ImageJPEG.LoadFromStream(Stream);
                BitMap.Assign(ImageJPEG);
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
              BitMap.LoadFromStream(Stream);
            end;
        end;
        aImage.Picture.BitMap.Assign(BitMap);
      end;
    finally
      FreeAndNil(BitMap);
    end;
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
    while i <= Json.A['tracks'].length - 1 do
    begin
      pMediaFile := tMediaFile.create(Json.A['tracks'].O[i].S['filename']);
      slbPlaylist.Items.AddObject(tpath.GetFileNameWithoutExtension(pMediaFile.Tags.FileName), pMediaFile);
      inc(i);
    end;
  end;
end;

procedure TfMain.ListCoverArts(aImage: TsImage; sFileName: String);
var
  pMediaFile: tMediaFile;
begin
  pMediaFile := tMediaFile.create(sFileName);
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

procedure TfMain.thFillGridExecute(Sender: TObject; Params: Pointer);
var
  ARow: Integer;
  sg1 : taDvStringGrid;
begin
    sg1 := tfMain(params).sgList;

    aRow := 1;
    while aRow <= sg1.RowCount -1 do
    begin

      inc(aRow);
    end;
end;

procedure TfMain.thListMP3Execute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
  // sExt: String;
begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);

  i := 0;
  while i <= length(aFiles) - 1 do
  begin
    // sExt := tpath.GetExtension(aFiles[i]);
    bAdd := (tMediaUtils.isValidExtension(aFiles[i]) > 0);
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
  // Application.ProcessMessages;
end;

procedure TfMain.TrackBar1Change(Sender: TObject);
begin
  if NOT AdjustingPlaybackPosition then
  begin
    BASS_ChannelSetPosition(Channel, TrackBar1.Position, BASS_POS_BYTE);
  end;
end;

procedure TfMain.TrackBar2Change(Sender: TObject);
var
  Volume: Double;
begin
  Volume := (100 - TrackBar2.Position) / TrackBar2.Max;
  BASS_SetVolume(Volume);

end;

procedure TfMain.updatePlayingInfos(aTags: TTags);
begin
  slblArtist.Caption := aTags.GetTag('ARTIST');
  slblTitle.Caption := aTags.GetTag('TITLE');
  ListCoverArts(sImage1, aTags);
end;

procedure TfMain.updatePlayingInfos(sFileName: String);
var
  pMediaFile: tMediaFile;
begin
  pMediaFile := tMediaFile.create(sFileName);
  updatePlayingInfos(pMediaFile.Tags);
  pMediaFile.Destroy;
end;

procedure TfMain.updateTV;
begin
  // sTVMedias.Refresh;
end;

{ ThInsert }

constructor ThInsert.create(MediaQuery: TFDQuery; callback: tInsertIntoGrid);
begin
  inherited create(True);
  insertRow := callback;
  MQ := MediaQuery;
end;

procedure ThInsert.Execute;
begin
  inherited;
  MQ.Open;
  MQ.First;
  while not Terminated and not MQ.eof do
  begin
    insertRow(MQ.FieldByName('id').AsInteger, MQ.FieldByName('mediaName').asString, MQ.FieldByName('artist').asString,
      MQ.FieldByName('title').asString, MQ.FieldByName('album').asString);
    MQ.Next;
  end;
  MQ.Close;
  if not Terminated then
  begin
    Terminate;
  end;
end;

end.
