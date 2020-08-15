unit uTypes;

interface
uses
   System.SysUtils, TagsLibrary;

type
  tMediaFile = class
      mediaName : string;
      mediaPath : string;
      mediaType : integer;
      tags : TTags;
  public
      constructor create (aFileName : string);
      destructor Destroy; overload;
  end;

implementation

{ tMediaFile }

constructor tMediaFile.create(aFileName: string);
begin
    //
    tags := ttags.Create;
    tags.ParseCoverArts := true;
    tags.LoadFromFile(aFileNAme);
end;

destructor tMediaFile.Destroy;
begin
    tags.Free;
    //inherited Free;
    inherited Destroy;
end;

end.
