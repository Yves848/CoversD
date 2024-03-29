unit uSearchImage;

interface
uses
  System.SysUtils,IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,IdSSL, IdSSLOpenSSL,  NetEncoding, xSuperObject;

  const
    CSE_API_KEY = '007439388879951561867:3ragl0fkhpm';
    CSE_ID = 'AIzaSyB_bfo21im9wVOPM93Rcx9Vbbh7NFiKHnw';
    GS_STARTINDEX = 'startIndex';
    GS_COUNT = 'count';
    GS_ITEMS = 'items';
    GS_LINK = 'link';
    GS_THUMBNAILLINK = 'thumbnailLink';

  type tGoogleSearch = class
    private
       parameters : string;
       path : String;
       IdHTTP1: TIdHTTP;
       function  parseResult(sJson : String) : ISuperObject;
    public
    constructor create(key : string; start : integer);
    function getImages : iSuperObject;
  end;

  type tGoogleSearchFree = class
     private
        idSSL : TIdSSLIOHandlerSocketOpenSSL;
        IdHTTP1: TIdHTTP;
        function  parseResult(sJson : String) : ISuperObject;
     public
        constructor create;
        destructor destroy;
     published
        function getImages(skey : String; const nbImages : Integer = 10) : iSuperObject;
        function getImages2(skey: String; const nbImages: Integer): string;
  end;
implementation

{ googleSearch }

constructor tGoogleSearch.create(key: string; start : integer);
begin
  inherited create;
  parameters := '?q=' + TNetEncoding.URL.Encode(key);
  parameters := parameters + '&cx=' + CSE_API_KEY;
  parameters := parameters + '&imgSize=large';
  parameters := parameters + '&searchType=image';
  parameters := parameters + '&key=' + CSE_ID;
  parameters := parameters + '&filetype=jpeg';
  parameters := parameters + '&imgSize=xxlarge';
  parameters := parameters + format('&start=%d',[Start]);
  path := 'https://www.googleapis.com/customsearch/v1' + parameters;
end;

function tGoogleSearch.getImages: ISuperObject;
var
  idSSL : TIdSSLIOHandlerSocketOpenSSL;
  sJson : String;
begin
   IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

   IdHttp1 := TIdHTTP.Create;
   idHTTP1.ReadTimeout := 10000;
   IdHTTP1.IOHandler := idSSL;
   IdHttp1.request.AcceptEncoding:= 'gzip,deflate';
   idSSL.SSLOptions.Method:= sslvTLSv1;
   idSSL.SSLOptions.Mode := sslmUnassigned;
   sJson := IdHTTP1.Get(path);
   result := parseResult(sJson);
   idSSL.Free;
   IdHTTP1.Free;
end;

function tGoogleSearch.parseResult(sJson: String): ISuperObject;
var
  json : tSuperObject;
  jsArray : ISuperArray;
  jsobject : iSuperObject;
  anObject : iSuperObject;
  i : Integer;
begin
    Json := TSuperObject.Create(sJson);
    {$IFDEF DEBUG}
    //json.SaveTo('result.json',true);
    {$ENDIF}
    result := SO;
   // result.I[GS_STARTINDEX] := strtoint(json.S[GS_STARTINDEX]);
   // result.I[GS_COUNT] := strtoint(json.S[GS_COUNT]);

    i := 0;
    jsArray := json.A[GS_ITEMS];
    while i <= jsArray.Length -1 do
    begin
      jsObject := jsArray.O[i];
      anObject := SO;
      anObject.S[GS_LINK] := jsObject.S[GS_LINK];
      anObject.S[GS_THUMBNAILLINK] := jsObject.O['image'].S[GS_THUMBNAILLINK];
      result.A[GS_ITEMS].Add(anObject);
//      with result.A[GS_ITEMS].O[0] do
//      begin
//         s[GS_LINK] := jsObject.S[GS_LINK];
//      end;
      inc(i);
    end;
end;

{ tGoogleSearchFree }

constructor tGoogleSearchFree.create;
begin
   inherited create;
   IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
   IdHttp1 := TIdHTTP.Create;
   idHTTP1.ReadTimeout := 60000;
   IdHTTP1.IOHandler := idSSL;
   //IdHttp1.request.AcceptEncoding:= 'gzip,deflate';
   idSSL.SSLOptions.Method:= sslvTLSv1;
   idSSL.SSLOptions.Mode := sslmUnassigned;
end;

destructor tGoogleSearchFree.destroy;
begin
   IdHTTP1.Free;
   idSSL.Free;
   inherited destroy;
end;

function tGoogleSearchFree.getImages(skey: String; const nbImages: Integer): iSuperObject;
const
  baseUrl = 'http://localhost:8080/search/%s';
var
   sUrl : String;
   sKey2 : string;
begin
   skey2 := TNetEncoding.URL.Encode(skey);
   sUrl := format(baseUrl,[sKey2]);
   result := ParseResult('{"items":'+IdHTTP1.Get(sUrl)+'}');
end;


function tGoogleSearchFree.getImages2(skey: String; const nbImages: Integer): string;
const
  baseUrl = 'http://localhost:8080/search/%s';
var
   sUrl : String;
   sKey2 : string;
begin
   skey2 := TNetEncoding.URL.Encode(skey);
   sUrl := format(baseUrl,[sKey2]);
   result :=IdHTTP1.Get(sUrl);
end;

function tGoogleSearchFree.parseResult(sJson: String): ISuperObject;
var
  json : tSuperObject;
  jsArray : ISuperArray;
  jsobject : iSuperObject;
  anObject : iSuperObject;
  i : Integer;
begin
    Json := TSuperObject.Create(sJson);
    {$IFDEF DEBUG}
    //json.SaveTo('result.json',true);
    {$ENDIF}
    result := SO;
    i := 0;
    jsArray := json.A[GS_ITEMS];
    while i <= jsArray.Length -1 do
    begin
      jsObject := jsArray.O[i];
      anObject := SO;
      anObject.S[GS_LINK] := jsObject.S['url'];
      result.A[GS_ITEMS].Add(anObject);
      inc(i);
    end;
end;

end.
