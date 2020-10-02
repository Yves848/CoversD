unit uSelectDirectory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, JPEG,
  PNGImage, GIFImg,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, sTreeView, acShellCtrls, Vcl.ExtCtrls, sPanel, AdvMemo, Vcl.StdCtrls, sButton,
  uTypes, TagsLibrary, acProgressBar, acImage;

type
  TfSelectDirectory = class(TForm)
    FDConnection1: TFDConnection;
    tMedias: TFDTable;
    tv1: TsShellTreeView;
    sPanel1: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    qMedias: TFDQuery;
    qTags: TFDQuery;
    pb1: TsProgressBar;
    sImage1: TsImage;
    sButton3: TsButton;
    qSearchTag: TFDQuery;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure BrowsePath(sPath: String);
    Procedure AddToDB(aFiles: TStringDynArray);
    function loadTags(sFile: String; aTags: tTags): boolean;
    procedure ListCoverArts(aImage: TImage; Tags: tTags);
  public
    { Déclarations publiques }
  end;

var
  fSelectDirectory: TfSelectDirectory;

implementation

{$R *.dfm}

procedure TfSelectDirectory.AddToDB(aFiles: TStringDynArray);
var
  sMediaPath, sMediaName: String;
  iMediaType: Integer;
  pMediaFile: tMediaFile;
  i: Integer;
  iCount: Integer;
  pImage: TImage;
  mstream: tMEmoryStream;
  sFile: String;

begin
  pMediaFile := tMediaFile.Create;
  tMedias.Open;
  i := 0;
  while i <= length(aFiles) - 1 do
  begin
    if tMediaUtils.isValidExtension(aFiles[i]) > -1 then
    begin
      sFile := aFiles[i];
      sMediaPath := tPath.GetFullPath(sFile);
      sMediaName := tPath.GetFileName(sFile);
      iMediaType := tMediaUtils.isValidExtension(sFile);
      tMedias.Append;
      tMedias.FieldByName('FilePath').AsString := sMediaPath;
      tMedias.FieldByName('FileName').AsString := sMediaName;
      // tMedias.FieldByName('mediaType').AsInteger := iMediaType;

      // Get the Tags
      if loadTags(sFile, pMediaFile.Tags) then
      begin
        // Memo1.Lines.Add(pMediaFile.tags.GetTag('ARTIST') + pMediaFile.tags.GetTag('TITLE'));
        tMedias.FieldByName('Artist').AsString := pMediaFile.Tags.GetTag('ARTIST');
        tMedias.FieldByName('Title').AsString := pMediaFile.Tags.GetTag('TITLE');
        tMedias.FieldByName('Album').AsString := pMediaFile.Tags.GetTag('ALBUM');
        tMedias.FieldByName('Genre').AsString := pMediaFile.Tags.GetTag('GENRE');
        if pMediaFile.Tags.CoverArtCount > 0 then
          tMedias.FieldByName('Cover').AsInteger := 1
        else
          tMedias.FieldByName('Cover').AsInteger := 0;
      end;
      tMedias.Post;

    end;
    inc(i);
  end;
  tMedias.Close;

  pMediaFile.Destroy;

end;

procedure TfSelectDirectory.BrowsePath(sPath: String);
var
  i: Integer;
  aFiles: TStringDynArray;
  aFileAttributes: tFileAttributes;
  aSearchOption: tSearchOption;

begin
  aSearchOption := tSearchOption.soAllDirectories;
  aFiles := TDirectory.GetFileSystemEntries(sPath, aSearchOption, nil);
  AddToDB(aFiles);
end;

procedure TfSelectDirectory.ListCoverArts(aImage: TImage; Tags: tTags);
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

function TfSelectDirectory.loadTags(sFile: String; aTags: tTags): boolean;
begin
  aTags.Clear;
  result := false;
  try
    aTags.ParseCoverArts := true;
    aTags.LoadFromFile(sFile);
    result := true;
  except

  end;
end;

procedure TfSelectDirectory.sButton1Click(Sender: TObject);
var
  aNode: TTreeNode;
begin
  // Memo1.Lines.Clear;
  if tv1.Selected <> Nil then
  begin
    aNode := tv1.Selected;
    BrowsePath(TacShellFolder(aNode.Data).PathName);

  end;

end;

procedure TfSelectDirectory.sButton2Click(Sender: TObject);
var
  pMediaFile: tMediaFile;
  i: Integer;
  iCount: Integer;
  pImage: TImage;
  mstream: tMEmoryStream;
begin

  pMediaFile := tMediaFile.Create;

  with qMedias do
  begin
    Open;
    last;
    iCount := RecordCount;
    i := 0;
    pb1.Position := 0;
    first;
    pImage := TImage.Create(self);
    while not eof do
    begin
      if loadTags(FieldByName('FilePAth').AsString, pMediaFile.Tags) then
      begin
        // Memo1.Lines.Add(pMediaFile.tags.GetTag('ARTIST') + pMediaFile.tags.GetTag('TITLE'));
        qTags.ParamByName('MediaId').AsInteger := qMedias.FieldByName('id').AsInteger;
        pImage.Picture.BitMap := nil;
        ListCoverArts(pImage, pMediaFile.Tags);
        mstream := tMEmoryStream.Create;
        try
          mstream.Position := 0;
          pImage.Picture.BitMap.SaveToStream(mstream);
          mstream.Position := 0;
          qTags.ParamByName('cover').LoadFromStream(mstream, ftBlob);
        finally
          mstream.Free;
        end;

        qTags.ExecSQL;
      end;
      inc(i);
      if (i div 100 = 0) then
      begin
        pb1.Position := round(i / iCount * 100);
        application.ProcessMessages;
      end;
      Next;
    end;
    Close;
  end;
end;

procedure TfSelectDirectory.sButton3Click(Sender: TObject);
var
  buff: tStream;
begin

  qSearchTag.Close;
  qSearchTag.ParamByName('id').AsInteger := 68;
  qSearchTag.Open;
  buff := qSearchTag.CreateBlobStream(qSearchTag.FieldByName('cover'), TBlobStreamMode.bmRead);
  if buff.Size > 0 then
    sImage1.Picture.BitMap.LoadFromStream(buff);
  buff.Free;
end;

end.
