unit uTypes;

interface

uses
  winApi.windows, Winapi.Messages,System.Classes, System.SysUtils, System.IOUtils, System.Types, TagsLibrary, Vcl.Graphics, strUtils,
  Generics.Defaults, Generics.collections, XSuperObject;

const
  WM_REFRESH_COVER = WM_USER + 2000;
  sValidExtensions = '.MP3.MP4.FLAC.OGG.WAV.M4A';
  aValidExtensions: TArray<string> = ['.MP3', '.MP4', '.FLAC', '.OGG', '.WAV', '.M4A'];

type
   tTagKey = class
     sTAG : String;
     sCol : Integer;
   end;

  tMediaFile = class(tPersistent)
  public
    bModified : boolean;
    tags: TTags;
    constructor create; overload;
    constructor create(aFileName: string); overload;
    destructor Destroy; overload;
    procedure SaveTags;
    Procedure LoadTags(pFile : String);
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
    class function isValidExtension(sFile: String): boolean; static;
    class function isValidExtension2(sFile: String): integer; static;
    class function getExtension(sFile : String) : string; static;
  end;


var
  isRegistered : boolean;
  dTags:TDictionary<String,tTagKey>;

implementation

{ tMediaFile }

constructor tMediaFile.create(aFileName: string);
begin
  //
  // inherited create;
  self.create;
  bModified := false;
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
  bModified := False;
  Tags.LoadFromFile(pFile);
end;

procedure tMediaFile.SaveTags;
begin
  Tags.SaveToFile(tags.FileName);
  bModified := False;
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
  i : Integer;
begin
    result := 'unknown';
    i := isValidExtension2(sFile);
    if i > -1 then
      result := aValidExtensions[i];

end;

class function tMediaUtils.isValidExtension(sFile: String): boolean;
var
  sExt: String;
begin
  sExt := tpath.GetExtension(sFile);
  result := (pos(uppercase(sExt), sValidExtensions) > 0);
end;

class function tMediaUtils.isValidExtension2(sFile: String): integer;
var
  sExt: String;
  i: integer;
begin
  sExt := uppercase(tpath.GetExtension(sFile));
  i := 0;
  result := -1;
  for i := low(aValidExtensions) to High(aValidExtensions) do
  begin
    if SameText(aValidExtensions[i],sExt) then
    begin
      result := i;
      break;
    end;
  end;
end;

Initialization
var
  dTagKey : tTagKey;
begin
  dTags := TDictionary<String,tTagKey>.create;
  dTagKey := tTagKey.create;
  dTagKey.sTAG := 'ARTIST';
  dTagKey.sCol := 2;
  dTags.Add('Artist',dTagKey);
  dTagKey := tTagKey.create;
  dTagKey.sTAG := 'TITLE';
  dTagKey.sCol := 3;
  dTags.Add('Title',dTagKey);
end;

Finalization
begin
  dTags.Clear;
  dTags.Free;
end;


end.
