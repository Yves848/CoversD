unit uTypes;

interface
uses
   TagsLibrary;

type
  tMediaFile = class
      mediaName : string;
      mediaPath : string;
      mediaType : integer;
      tags : TTags;
  public
      constructor create (aFileName : string);
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

end.