unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTypes, utags, Vcl.StdCtrls, sPanel, Vcl.ExtCtrls, sSkinManager, sSkinProvider, sButton, Vcl.ComCtrls,
  sTreeView, acShellCtrls, sListView, sComboBoxes, sSplitter, Vcl.Buttons, sSpeedButton, System.ImageList, Vcl.ImgList, acAlphaImageList,
  acProgressBar, JvComponentBase, JvThread, sMemo, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, acImage, JPEG, PNGImage, GIFImg, TagsLibrary,
  acNoteBook, sTrackBar, acArcControls, sGauge, BASS;

type
  TfMain = class(TForm)
    pnMain: TsPanel;
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
  private
    { Déclarations privées }
    function findNode(sLabel: String): TTreeNode;
    procedure ListCoverArts(Tags: TTags);
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
  end;

var
  fMain: TfMain;
  iProgress: Integer;
  iMax: Integer;
  sFileName: String;
  aPath: String;
  aNode: TTreeNode;

implementation

{$R *.dfm}

uses
  JvDynControlEngineVcl;

procedure StreamEndCallback(handle: HSYNC; channel, data: DWORD; user: Pointer); stdcall;
begin

end;

procedure TFMain.PlayNext;
var
    CurrentIndex: Integer;
    i: Integer;
begin
    //* Decide current playing index
end;


procedure TFMain.PlayStream(FileName: String);
begin
    Channel := BASS_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_UNICODE OR BASS_STREAM_AUTOFREE);
    //* Set an end sync which will be called when playback reaches end to play the next song
    BASS_ChannelSetSync(Channel, BASS_SYNC_END, 0, @StreamEndCallback, 0);
    CurrentPlayingFileName := FileName;
    TrackBar1.Max := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);
    //* Start playback
    BASS_ChannelPlay(Channel, True);
end;

procedure TfMain.Button1Click(Sender: TObject);
var
  form2: tForm2;
begin
  form2 := tForm2.Create(Self);
  form2.ShowModal;
  form2.Free;
end;

procedure TfMain.addfileName;
var
  mediaFile: tMediaFile;
  aParentNode: TTreeNode;
  aNode: TTreeNode;
  sPAth, sFile: String;
  isDirectory: Boolean;
begin
  //
  isDirectory := TDirectory.Exists(sFileName);
  if not isDirectory then
  begin
    // File to Add .....
    sPAth := tPath.GetDirectoryName(sFileName);
    sFile := tPath.GetFileNameWithoutExtension(sFileName);
  end
  else
  begin
    sPAth := sFileName;
    sFile := sFileName;
  end;

  aParentNode := findNode(sPAth);
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
        aParentNode.HasChildren := true;
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
      aNode.HasChildren := true;
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
    aNode.Expand(false);
    aNode := Nil;
  end;
  sDEFolder.Enabled := true;
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

procedure TfMain.FormCreate(Sender: TObject);
var
    Volume: Double;
begin
    //* Never forget to init BASS
    BASS_Init(-1, 44100, 0, Self.Handle, 0);
    //* Set VU max. values
    sGauge1.MaxValue := High(Word) div 2 + 1;
    sGauge2.MaxValue := High(Word) div 2 + 1;
    //* Get current volume
    Volume := BASS_GetVolume;
    TrackBar2.Position := 100 - Round(Volume * 100);

end;

procedure TfMain.ResetPB;
begin
  pb1.Position := 0;
end;

procedure TfMain.sDEFolderAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
begin
  if name <> aPath then
  begin
    aPath := Name;
    sDEFolder.Enabled := false;
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

procedure TfMain.sTVMediasChange(Sender: TObject; Node: TTreeNode);
begin
  // sMemo1.Clear;
  if assigned(Node.Data) then
  begin
    // sMemo1.lines.Add(tMediaFile(Node.Data).tags.filename);
    // sMemo1.lines.Add(tMediaFile(Node.Data).tags.GetTag('ARTIST'));
    // sMemo1.lines.Add(tMediaFile(Node.Data).tags.GetTag('TITLE'));
    // sMemo1.lines.Add(tMediaFile(Node.Data).tags.GetTag('ALBUM'));
    ListCoverArts(tMediaFile(Node.Data).Tags);
  end;

end;

procedure TfMain.ListCoverArts(Tags: TTags);
var
  i: Integer;
  ImageJPEG: TJPEGImage;
  ImagePNG: TPNGImage;
  ImageGIF: TGIFImage;
  Bitmap: TBitmap;
begin
  // * List cover arts
  for i := 0 to Tags.CoverArtCount - 1 do
  begin
    Bitmap := TBitmap.Create;
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
                Bitmap.Assign(ImageJPEG);
              finally
                FreeAndNil(ImageJPEG);
              end;
            end;
          tpfPNG:
            begin
              ImagePNG := TPNGImage.Create;
              try
                ImagePNG.LoadFromStream(Stream);
                Bitmap.Assign(ImagePNG);
              finally
                FreeAndNil(ImagePNG);
              end;
            end;
          tpfGIF:
            begin
              ImageGIF := TGIFImage.Create;
              try
                ImageGIF.LoadFromStream(Stream);
                Bitmap.Assign(ImageGIF);
              finally
                FreeAndNil(ImageGIF);
              end;
            end;
          tpfBMP:
            begin
              Bitmap.LoadFromStream(Stream);
            end;
        end;
        sImage1.Picture.Bitmap.Assign(Bitmap);
        // * This function resizes with nearest-neighbour mode (which is not recommended as it gives the worst quality possible),
        // * if you need a top-quality lanczos resizer which uses Graphics32, please contact me.
        // ResizeBitmap(Bitmap, 160, 120, clWhite);
        // with ListView2.Items.Add do begin
        // Caption := Tags.CoverArts[i].Name;
        // ImageIndex := ImageListThumbs.Add(Bitmap, nil);
        // end;
      end;
    finally
      FreeAndNil(Bitmap);
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
  aNode : tTreeNode;
  Mgs   : TMsg;
begin
  if Key = VK_RETURN then
  begin
     aNode := sTVMedias.Selected;
     if assigned(aNode.Data) then
     begin
       BASS_ChannelStop(Channel);
       PlayStream(tMediaFile(aNode.data).tags.FileName);
     end;
     PeekMessage(Mgs,0,WM_CHAR,WM_CHAR,PM_REMOVE);
  end;
end;

procedure TfMain.thListMP3Execute(Sender: TObject; Params: Pointer);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;
  bAdd: Boolean;
begin
  aSearchOption := tSearchOption.soTopDirectoryOnly;
  aFiles := TDirectory.GetFileSystemEntries(aPath, aSearchOption, nil);

  i := 0;
  iMax := Length(aFiles) - 1;
  thListMP3.Synchronize(TfMain(Params).ResetPB);
  thListMP3.Synchronize(TfMain(Params).setPBMax);
  while (i <= iMax) do
  begin
    if thListMP3.Terminated then
      exit;
    iProgress := i;
    sFileName := aFiles[i];
    // Determine file attributes
    bAdd := false;
    if TDirectory.Exists(sFileName) then
    begin
      bAdd := true;
    end
    else
    begin
      aFileAttributes := tFile.GetAttributes(sFileName);
      if not(tFileAttribute.faReadOnly in aFileAttributes) and not(tFileAttribute.faHidden in aFileAttributes) and
        not(tFileAttribute.faSystem in aFileAttributes) then
      begin
        bAdd := true;
      end;
    end;

    if bAdd then
      thListMP3.Synchronize(TfMain(Params).addfileName);

    inc(i);
    // thListMP3.Synchronize(TfMain(Params).SetPBPosition);
  end;
  thListMP3.Synchronize(TfMain(Params).ExpandNode);
  thListMP3.Synchronize(TfMain(Params).ResetPB);
  thListMP3.Synchronize(TfMain(Params).updateTV);

end;

procedure TfMain.Timer1Timer(Sender: TObject);
var
    Level: Cardinal;
    LeftLevel: Word;
    RightLevel: Word;

begin
    Level := BASS_ChannelGetLevel(Channel);
    //* Separate L & R channel
    LeftLevel := LoWord(Level);
    RightLevel := HiWord(Level);
    //* Set the VUs
    if BASS_ChannelIsActive(Channel) = BASS_ACTIVE_PLAYING then begin
        //* Logarithmic

            sGauge1.Progress := LeftLevel;
            sGauge2.Progress := RightLevel;

    end else begin
        sGauge1.Progress := sGauge1.Progress - 1000;
        sGauge2.Progress := sGauge2.Progress - 1000;
    end;
    //* Playing position
    AdjustingPlaybackPosition := True;
    TrackBar1.Position := BASS_ChannelGetPosition(Channel, BASS_POS_BYTE);
    AdjustingPlaybackPosition := False;

end;

procedure TfMain.TrackBar1Change(Sender: TObject);
begin
  if NOT AdjustingPlaybackPosition then begin
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
