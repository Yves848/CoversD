unit uTypes;

interface

uses
  winApi.windows, winApi.Messages, System.Classes, System.SysUtils, System.IOUtils, System.Types, TagsLibrary, Vcl.Graphics,Vcl.Forms, strUtils,
  Generics.Defaults, Generics.collections, XSuperObject;

const
  WM_REFRESH_COVER = WM_USER + 2000;
  WM_OPEN_ROLLOUTS = WM_USER + 2001;
  WM_ATTACH = WM_USER + 2002;

  WM_PLAY_PREVIOUS = WM_USER + 3000;
  WM_PLAY_NEXT = WM_USER + 3010;
  WM_STOP = WM_USER + 3020;
  WM_PLAY = WM_USER + 3030;
  WM_PAUSE = WM_USER + 3040;

  sValidExtensions = '.MP3.MP4.FLAC.OGG.WAV.M4A';
  aValidExtensions: TArray<string> = ['.MP3', '.MP4', '.FLAC', '.OGG', '.WAV', '.M4A'];
  cArtist = 'Artist';
  cTitle = 'Title';
  cAlbum = 'Album';
  cFileName = 'Filename';

  col_on = clRed;
  col_off = clNavy;

type
  TacFrame = class of TFrame;

  TCmpData = record
    Caption,
    Hint: string;
    ImgIndex,
    GroupIndex,
    ImgListIndex: integer;
    FrameType: TacFrame;
  end;
  PCmpData = ^TCmpData;


  TCmpsArray = array [0..1] of TCmpData;
  PCmpsArray = ^TCmpsArray;

  tTagKey = class
    sTAG: String;
    sCol: Integer;
  end;

  tOptionsSearch = class
  Public
    class var
      bWord: Boolean;
      bDir : Boolean;
  end;

  tExpr = class
    sExpr: String;
  end;

  tMediaFile = class(tPersistent)
  private
    fFileName: String;
    fTempFileName: String;
  public
    bModified: Boolean;
    tags: TTags;
    property fileName: String read fFileName write fFileName;
    property tempFileName: String read fTempFileName write fTempFileName;
    constructor create; overload;
    constructor create(aFileName: string); overload;
    destructor Destroy; overload;
    procedure SaveTags;
    Procedure LoadTags(pFile: String);
  end;

  tMediaImg = class(tPersistent)
  public
    tnLink: String;
    Link: String;
    BitMap: tPicture;
    constructor create; overload;
    destructor Destroy; override;
  end;

  tMediaUtils = class
  public
    class function isValidExtension(sFile: String): Boolean; static;
    class function isValidExtension2(sFile: String): Integer; static;
    class function getExtension(sFile: String): string; static;
  end;

function FindTag(iCol: Integer): String;

var
  isRegistered: Boolean;
  dTags: TDictionary<String, tTagKey>;
  dExpressions: TDictionary<String, tExpr>;

implementation


function FindTag(iCol: Integer): String;
var
  value: tTagKey;
begin
  result := '';
  for value in dTags.Values do
  begin
    if value.sCol = iCol then
    begin
      result := value.sTAG;
      break;
    end;
  end;

end;
{ tMediaFile }

constructor tMediaFile.create(aFileName: string);
begin
  //
  // inherited create;
  self.create;
  bModified := false;
  filename := aFileName;
  tags := TTags.create;
  tags.ParseCoverArts := true;
  tags.LoadFromFile(aFileName);
end;

constructor tMediaFile.create;
begin
  inherited create;
  bModified := false;
  tags := TTags.create;
end;

destructor tMediaFile.Destroy;
begin
  tags.Free;
  // inherited Free;
  inherited Destroy;
end;

procedure tMediaFile.LoadTags(pFile: String);
begin
  tags.Clear;
  bModified := false;
  tags.LoadFromFile(pFile);
end;

procedure tMediaFile.SaveTags;
begin
  tags.SaveToFile(tags.fileName);
  bModified := false;
end;

{ tMediaImg }

constructor tMediaImg.create;
begin
  inherited create;
  BitMap := Nil;
end;

destructor tMediaImg.Destroy;
begin
  if BitMap <> nil then
    FreeAndNil(BitMap);
  inherited Destroy;
end;

{ tMediaUtils }

class function tMediaUtils.getExtension(sFile: String): string;
var
  i: Integer;
begin
  result := 'unknown';
  i := isValidExtension2(sFile);
  if i > -1 then
    result := aValidExtensions[i];

end;

class function tMediaUtils.isValidExtension(sFile: String): Boolean;
var
  sExt: String;
begin
  sExt := tpath.getExtension(sFile);
  result := (pos(uppercase(sExt), sValidExtensions) > 0);
end;

class function tMediaUtils.isValidExtension2(sFile: String): Integer;
var
  sExt: String;
  i: Integer;
begin
  sExt := uppercase(tpath.getExtension(sFile));
  i := 0;
  result := -1;
  for i := low(aValidExtensions) to High(aValidExtensions) do
  begin
    if SameText(aValidExtensions[i], sExt) then
    begin
      result := i;
      break;
    end;
  end;
end;

Initialization

var
  dTagKey: tTagKey;
begin
  dExpressions := TDictionary<String, tExpr>.create;
  dTags := TDictionary<String, tTagKey>.create;
  dTagKey := tTagKey.create;
  dTagKey.sTAG := 'ARTIST';
  dTagKey.sCol := 2;
  dTags.Add(cArtist, dTagKey);
  dTagKey := tTagKey.create;
  dTagKey.sTAG := 'TITLE';
  dTagKey.sCol := 3;
  dTags.Add(cTitle, dTagKey);
  dTagKey := tTagKey.create;
  dTagKey.sTAG := 'ALBUM';
  dTagKey.sCol := 4;
  dTags.Add(cAlbum, dTagKey);
  dTagKey := tTagKey.create;
  dTagKey.sTAG := 'NONE';
  dTagKey.sCol := -1;
  dTags.Add('N/A', dTagKey);
end;

Finalization

begin
  dTags.Clear;
  dTags.Free;
  dExpressions.Clear;
  dExpressions.Free;
end;

end.
