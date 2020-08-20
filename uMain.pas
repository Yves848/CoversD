unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types, Vcl.GraphUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, utags, Vcl.StdCtrls, sPanel, Vcl.ExtCtrls, sSkinManager, sSkinProvider, sButton, Vcl.ComCtrls,
  sTreeView, acShellCtrls, sListView, sComboBoxes, sSplitter, Vcl.Buttons, sSpeedButton, System.ImageList, Vcl.ImgList, acAlphaImageList,
  acProgressBar, JvComponentBase, JvThread, sMemo, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, acImage, JPEG, PNGImage, GIFImg, TagsLibrary,
  acNoteBook, sTrackBar, acArcControls, sGauge, BASS, xSuperObject, SynEditHighlighter, SynHighlighterJSON, SynEdit, SynMemo, sListBox, JvExControls,
  JvaScrollText, acSlider, uSearchImage, sBitBtn, Vcl.OleCtrls, SHDocVw, activeX, acWebBrowser, Vcl.Grids, JvExGrids, JvStringGrid, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding, Vcl.WinXCtrls, AdvUtil, AdvObj, BaseGrid,
  ovctable, AdvGrid;

const
  sValidExtensions = '.MP3.MP4.FLAC.OGG.WAV';

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
    sSlider1: TsSlider;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sBitBtn1: TsBitBtn;
    sg1: TJvStringGrid;
    thGetImages: TJvThread;
    Image1: TImage;
    sShellTreeView1: TsShellTreeView;
    sgList: TAdvStringGrid;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure thListMP3Execute(Sender: TObject; Params: Pointer);
    procedure sTVMediasChange(Sender: TObject; Node: TTreeNode);
    procedure sTVMediasExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure sDEFolderAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
    procedure sTVMediasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure sTVMediasCollapsed(Sender: TObject; Node: TTreeNode);
    procedure sBitBtn1Click(Sender: TObject);
    procedure thGetImagesExecute(Sender: TObject; Params: Pointer);
    procedure sg1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
    procedure sShellTreeView1KeyPress(Sender: TObject; var Key: Char);
    procedure sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: Boolean);
    procedure sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Déclarations privées }
    jConfig: ISuperObject;
    function findNode(sLabel: String): TTreeNode;
    procedure ListCoverArts(aImage: TsImage; Tags: TTags);
    procedure OpenConfig;
    procedure downloadImage(sUrl: string);
  public
    { Déclarations publiques }
    Channel: HStream;
    CurrentPlayingFileName: String;
    AdjustingPlaybackPosition: Boolean;
    procedure PlayNext;
    procedure PlayStream(FileName: String);
    procedure addfileName;
    procedure setPBMax;
    procedure SetPBPosition;
    procedure ResetPB;
    procedure ExpandNode;
    procedure updateTV;
    procedure initGrid;
    // function AddToPlayList(aNode: TTreeNode; bRecurse: Boolean): Integer; overload;
    function AddToPlayList(ARow: Integer): Integer; overload;
    Procedure AddFolderToGrid(sFolder: String);
    Procedure AddFileToGrid(sFile: String);
    Procedure AddFileToGridTH;
    procedure GetImgLink;
    Procedure PlayNextTrack;
    Procedure PlayPrevTrack;
  end;

var
  fMain: TfMain;
  iProgress: Integer;
  iMax: Integer;
  sFileName: String;
  aPath: String;
  sFile: String;
  aNode: TTreeNode;
  iImg: Integer;
  sLink: String;

implementation

{$R *.dfm}

uses
  JvDynControlEngineVcl;

procedure StreamEndCallback(handle: HSYNC; Channel, data: DWORD; user: Pointer); stdcall;
begin

end;

procedure TfMain.PlayNext;
var
  CurrentIndex: Integer;
  i: Integer;
begin
  // * Decide current playing index
end;

procedure TfMain.PlayNextTrack;
var
  index: Integer;
begin
  if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then
  begin
    index := slbPlaylist.ItemIndex;
    inc(index);
    if index > slbPlaylist.Items.Count - 1 then
      index := 0;

    slbPlaylist.ItemIndex := index;

    BASS_ChannelStop(Channel);
    ListCoverArts(sImage1, tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
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
    ListCoverArts(sImage1, tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
    PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
  end;


end;

procedure TfMain.PlayStream(FileName: String);
begin
  Channel := BASS_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);
  // * Set an end sync which will be called when playback reaches end to play the next song
  BASS_ChannelSetSync(Channel, BASS_SYNC_END, 0, @StreamEndCallback, 0);
  CurrentPlayingFileName := FileName;
  TrackBar1.Max := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);
  // * Start playback
  BASS_ChannelPlay(Channel, True);
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
    FreeAndNil(pMediaFile);
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
  while i <= length(aFiles) - 1 do
  begin
    sExt := tPath.GetExtension(aFiles[i]);
    bAdd := (pos(uppercase(sExt), sValidExtensions) > 0);
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
  result := -1;
  aMediaFile := tMediaFile.Create(sgList.Cells[0, ARow]);
  sPath := tPath.GetDirectoryName(aMediaFile.Tags.FileName);
  sFile := tPath.GetFileNameWithoutExtension(aMediaFile.Tags.FileName);
  index := slbPlaylist.Items.IndexOf(sFile);
  if index = -1 then
  begin
    result := slbPlaylist.Items.AddObject(sFile, aMediaFile);
  end
  else
    result := index;
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
    sPath := tPath.GetDirectoryName(sFileName);
    sFile := tPath.GetFileNameWithoutExtension(sFileName);
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
  result := Nil;
  i := 0;

  while i <= sTVMedias.Items.Count - 1 do
  begin
    if sTVMedias.Items[i].Text = sLabel then
    begin
      result := sTVMedias.Items[i];
      i := sTVMedias.Items.Count;
    end;
    inc(i);
  end;
  if result = nil then
  begin
    sParent := TDirectory.GetParent(sLabel);
    if sParent <> '' then
      result := findNode(sParent);
  end;

end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not thListMP3.Terminated then
    thListMP3.Terminate;
  while not thListMP3.Terminated do
    Application.ProcessMessages;

  jConfig.SaveTo(TDirectory.GetCurrentDirectory + '\config.json');
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  Volume: Double;
begin
  // * Never forget to init BASS

  BASS_Init(-1, 44100, 0, Self.handle, 0);
  // * Set VU max. values
  sGauge1.MaxValue := High(Word) div 2 + 1;
  sGauge2.MaxValue := High(Word) div 2 + 1;
  // * Get current volume
  Volume := BASS_GetVolume;
  TrackBar2.Position := 100 - Round(Volume * 100);
  OpenConfig;
  initGrid;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssAlt in Shift then
  begin
    case Key of
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
          PlayNextTrack;
        end;
    end;
  end;
end;

procedure TfMain.FormShow(Sender: TObject);
var
  cols: Integer;
begin
  cols := sg1.width div sg1.DefaultColWidth;
  sg1.ColCount := cols;
end;

procedure TfMain.GetImgLink;
begin

end;

procedure TfMain.initGrid;
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

procedure TfMain.sg1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
      sg1.Canvas.StretchDraw(Rect, tMediaImg(sg1.Objects[ACol, ARow]).BitMap.Graphic)
    end;
  end;
end;

procedure TfMain.sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
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

procedure TfMain.sgListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Mgs: TMsg;
  index: Integer;
  i: Integer;
begin
  if Key = VK_RETURN then
  begin
    index := -1;
    i := 0;
    while i <= sgList.RowSelectCount - 1 do
    begin
      index := AddToPlayList(sgList.SelectedRow[i]);
      if i = 0 then
      begin
        if not(ssCtrl in Shift) then
        begin
          if (ssShift in Shift) then
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

    PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;

  if Key = VK_DELETE then
  begin
    initGrid;
    PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;

end;

procedure TfMain.ResetPB;
begin
  pb1.Position := 0;
end;

procedure TfMain.sBitBtn1Click(Sender: TObject);
var
  aNode: TTreeNode;
  Artist, Title: String;
  aGoogleSearch: tGoogleSearch;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  webResult: String;
  pMediaImg: tMediaImg;
  col, row: Integer;
  nbPass: Integer;

  procedure addToGrid;
  begin
    i := 0;
    while i <= jsArray.length - 1 do
    begin
      if sg1.Objects[col, row] <> nil then
      begin
        inc(col);
        if col > sg1.ColCount - 1 then
        begin
          sg1.RowCount := sg1.RowCount + 1;
          row := sg1.RowCount - 1;
          col := 0;
        end;
      end;
      pMediaImg := tMediaImg.Create;
      pMediaImg.TNLink := jsArray.O[i].S[GS_THUMBNAILLINK];
      pMediaImg.Link := jsArray.O[i].S[GS_LINK];
      sg1.Objects[col, row] := pMediaImg;
      inc(i);
    end;
  end;

begin
  row := 0;
  while row <= sg1.RowCount - 1 do
  begin
    col := 0;
    while col <= sg1.ColCount - 1 do
    begin
      if sg1.Objects[col, row] <> nil then
      begin
        tMediaImg(sg1.Objects[col, row]).destroy;
      end;
      inc(col)
    end;
    inc(row);
  end;

  sg1.Clear;
  sg1.RowCount := 1;
  aNode := sTVMedias.Selected;
  Artist := tMediaFile(aNode.data).Tags.GetTag('ARTIST');
  Title := tMediaFile(aNode.data).Tags.GetTag('TITLE');

  col := 0;
  row := 0;

  nbPass := 0;
  while nbPass < 2 do
  begin
    aGoogleSearch := tGoogleSearch.Create(Artist + ' ' + Title, (nbPass * 10) + 1);
    jsResult := aGoogleSearch.getImages;
    jsArray := jsResult.A[GS_ITEMS];
    addToGrid;
    inc(nbPass);
  end;
  thGetImages.Execute(Self);
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
  end
  else
  begin
    BASS_ChannelPlay(Channel, False);
  end;
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
    ListCoverArts(sImage1, tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
end;

procedure TfMain.slbPlaylistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Mgs: TMsg;
begin
  if Key = VK_RETURN then
  begin
    if slbPlaylist.ItemIndex > -1 then
    begin
      BASS_ChannelStop(Channel);
      ListCoverArts(sImage1, tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags);
      PlayStream(tMediaFile(slbPlaylist.Items.Objects[slbPlaylist.ItemIndex]).Tags.FileName);
    end;
    PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
end;

procedure TfMain.sShellTreeView1AddFolder(Sender: TObject; AFolder: TacShellFolder; var CanAdd: Boolean);
var
  sExtension: string;
begin
  CanAdd := True;
  if not AFolder.IsFileFolder then
  begin
    sExtension := tPath.GetExtension(AFolder.PathName);
    CanAdd := (pos(uppercase(sExtension), sValidExtensions) > 0);
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
        // AddFolderToGrid(TacShellFolder(aNode.data).PathName);
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

procedure TfMain.sTVMediasCollapsed(Sender: TObject; Node: TTreeNode);
var
  i: Integer;
  aNode: TTreeNode;
  aMediaFile: tMediaFile;
begin
  if sSlider1.SliderOn then
  begin
    i := 0;
    while Node.HasChildren do
    begin
      aNode := Node.getFirstChild;
      if Assigned(aNode.data) then
      begin
        aMediaFile := tMediaFile(aNode.data);
        aMediaFile.destroy;
      end;
      aNode.Free;
    end;
    Node.HasChildren := True;
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
        aImage.Picture.BitMap.Assign(BitMap);
      end;
    finally
      FreeAndNil(BitMap);
    end;
  end;
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
  Mgs: TMsg;
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
    PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;

end;

procedure TfMain.thGetImagesExecute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP1: TIdHTTP;
  MS: TMemoryStream;
  jpgImg: TJPEGImage;
  BitMap: TBitmap;
  sg1: TJvStringGrid;
  col, row: Integer;
begin
  //
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP1 := TIdHTTP.Create;
  IdHTTP1.ReadTimeout := 250;
  IdHTTP1.IOHandler := IdSSL;
  IdSSL.SSLOptions.Method := sslvTLSv1_2;
  IdSSL.SSLOptions.Mode := sslmUnassigned;
  sg1 := TfMain(Params).sg1;
  row := 0;
  while row <= sg1.RowCount - 1 do
  begin
    try
      try
        col := 0;
        while col <= sg1.ColCount - 1 do
        begin
          if sg1.Objects[col, row] <> nil then
          begin
            if tMediaImg(sg1.Objects[col, row]).BitMap = nil then
            begin
              MS := TMemoryStream.Create;
              jpgImg := TJPEGImage.Create;
              IdHTTP1.Get(tMediaImg(sg1.Objects[col, row]).TNLink, MS);
              Application.ProcessMessages;
              MS.Seek(0, soFromBeginning);
              jpgImg.LoadFromStream(MS);
              tMediaImg(sg1.Objects[col, row]).BitMap := tPicture.Create;
              tMediaImg(sg1.Objects[col, row]).BitMap.Assign(jpgImg);
              // resize img
              sg1.Refresh;
            end;
          end;
          inc(col);
        end;
      except
        on E: Exception do
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

procedure TfMain.thListMP3Execute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
  sExt: String;
begin
  // aSearchOption := tSearchOption.soTopDirectoryOnly;
  // aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);
  //
  // i := 0;
  // iMax := Length(aFiles) - 1;
  // thListMP3.Synchronize(TfMain(Params).ResetPB);
  // thListMP3.Synchronize(TfMain(Params).setPBMax);
  // while (i <= iMax) do
  // begin
  // if thListMP3.Terminated then
  // exit;
  // iProgress := i;
  // sFileName := aFiles[i];
  // bAdd := False;
  // if TDirectory.Exists(sFileName) then
  // begin
  // bAdd := True;
  // end
  // else
  // begin
  // aFileAttributes := tFile.GetAttributes(sFileName);
  // if not(tFileAttribute.faReadOnly in aFileAttributes) and not(tFileAttribute.faHidden in aFileAttributes) and
  // not(tFileAttribute.faSystem in aFileAttributes) then
  // begin
  // bAdd := True;
  // end;
  // end;
  //
  // if bAdd then
  // thListMP3.Synchronize(TfMain(Params).addfileName);
  //
  // inc(i);
  // end;
  // thListMP3.Synchronize(TfMain(Params).ExpandNode);
  // thListMP3.Synchronize(TfMain(Params).ResetPB);
  // thListMP3.Synchronize(TfMain(Params).updateTV);
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);

  i := 0;
  while i <= length(aFiles) - 1 do
  begin
    sExt := tPath.GetExtension(aFiles[i]);
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

procedure TfMain.updateTV;
begin
  sTVMedias.Refresh;
end;

end.
