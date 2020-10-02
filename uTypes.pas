unit uTypes;

interface

uses
  VCL.ExtCtrls, winApi.windows, System.Classes, System.SysUtils, System.IOUtils, System.Types, TagsLibrary, Vcl.Graphics, strUtils,
  Generics.Defaults, Generics.collections, XSuperObject;

const
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
    class function isValidExtension(sFile: String): integer; static;
    class function getExtension(sFile: String): string; static;
  end;

  tGridObject = class(tPersistent)
  public
    id : Integer;
    MediaName : String;
    Artist : String;
    Title : String;
    Album : String;
    Cover : timage;
    constructor create; overload;
    constructor create(aId : Integer; aMediaName, aArtist, aTitle, aAlbum : string); overload;
    destructor destroy; overload;
  end;

implementation

{ tMediaFile }

constructor tMediaFile.create(aFileName: string);
begin
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
  i: integer;
begin
  result := 'unknown';
  i := isValidExtension(sFile);
  if i > -1 then
    result := aValidExtensions[i];

end;

class function tMediaUtils.isValidExtension(sFile: String): integer;
var
  sExt: String;
  i: integer;
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

{ tGridObject }

constructor tGridObject.create;
begin
    inherited create;
    id := -1;
    Artist := '';
    Title := '';
    Album := '';
    MediaName := '';
    Cover := nil;
end;

constructor tGridObject.create(aId: Integer; aMediaName, aArtist, aTitle, aAlbum: string);
begin
    self.create;
    Id := aId;
    MediaName := aMediaName;
    Artist := aArtist;
    Title := aTitle;
    Album := aAlbum;
end;

destructor tGridObject.destroy;
begin
  if cover <> nil then
     freeAndNil(cover);
  inherited Destroy;
end;

end.
