unit uTypes;

interface
uses
   winApi.windows, System.Classes, System.SysUtils, TagsLibrary, Vcl.Graphics;

type
  tMediaFile = class(tPersistent)

  public
      mediaName : string;
      mediaPath : string;
      mediaType : integer;
      tags : TTags;
      constructor create; overload;
      constructor create (aFileName : string); overload;
      destructor Destroy; overload;
  end;

  tMediaImg = class(tPersistent)
    public
      tnLink : String;
      Link   : String;
      BitMap : tPicture;
      constructor create; overload;
      destructor destroy; override;
  end;

implementation

{ tMediaFile }

constructor tMediaFile.create(aFileName: string);
begin
    //
    inherited create;
    tags := ttags.Create;
    tags.ParseCoverArts := true;
    tags.LoadFromFile(aFileNAme);
end;

constructor tMediaFile.create;
begin
    inherited create;
    tags := ttags.Create;
end;

destructor tMediaFile.Destroy;
begin
    tags.Free;
    //inherited Free;
    inherited Destroy;
end;

{ tMediaImg }

constructor tMediaImg.create;
begin
     inherited create;
     Bitmap := Nil;
end;

destructor tMediaImg.destroy;
begin
    if Bitmap <> nil then
      FreeAndNil(BitMap);
    inherited destroy;
end;

end.
