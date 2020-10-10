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
  tMediaFile = class(tPersistent)
  public
    tags: TTags;
    constructor create; overload;
    constructor create(aFileName: string); overload;
    destructor Destroy; overload;
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

implementation

{ tMediaFile }

constructor tMediaFile.create(aFileName: string);
begin
  //
  // inherited create;
  self.create;
  tags := TTags.create;
  tags.ParseCoverArts := true;
  tags.LoadFromFile(aFileName);
end;

constructor tMediaFile.create;
begin
  inherited create;
  tags := TTags.create;
end;

destructor tMediaFile.Destroy;
begin
  tags.Free;
  // inherited Free;
  inherited Destroy;
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


end.
