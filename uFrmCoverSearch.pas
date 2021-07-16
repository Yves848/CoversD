unit uFrmCoverSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  IdComponent, uSearchImage, xSuperObject, SHDocVw, MSHTML,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSL, IdSSLOpenSSL, IdURI, NetEncoding,
  JPEG, PNGImage, GIFImg, TagsLibrary, utypes, acImage, uFrameCover,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, AdvObj, BaseGrid, AdvGrid, sScrollBox, Vcl.StdCtrls, sEdit, Vcl.ExtCtrls, sPanel,
  IdBaseComponent, sButton, Vcl.OleCtrls, System.RegularExpressions;

type

  tREfreshCell0 = procedure(aCol, aRow: Integer) of object;
  tAddLog = procedure(sFunc, sLog: String) of object;
  tSearchTerminated = procedure(pFrame: tFrame; iResult: Integer) of object;

  TfrmCoverSearch = class(tFrame)
    sPanel1: TsPanel;
    seArtist: TsEdit;
    seTitle: TsEdit;
    sSBCovers: TsScrollBox;
    sPNRow0: TsPanel;
    sPnRow1: TsPanel;
    sPnRow2: TsPanel;
    IdHTTP1: TIdHTTP;
    Image1: TsImage;
    sButton1: TsButton;
    WebBrowser1: TWebBrowser;
    Edit1: TEdit;
    sButton2: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure sButton2Click(Sender: TObject);
  private
    { Déclarations privées }
    sListUrls: tStrings;
  public
    { Déclarations publiques }
    gCol, gRow: Integer;
    artist, title: string;
    sFile: String;
    pHandle: tHandle;
    iStart: Integer;
    fAddLog: tAddLog;
    procedure removeframes;
    procedure GetImage(sNum: String);
    procedure ImageClick(Sender: TObject);
    procedure StartSearch(const start: Integer = 1);
    procedure StartSearch2(const start: Integer = 1);
    procedure SearchTerminated(pFrame: tFrame; iResult: Integer);
    procedure GlobalAddGrid(sUrls: tStrings);
    function getLinks: tStrings;
    function parseResult(aList: tStrings): ISuperObject;
  end;

implementation

{$R *.dfm}

procedure TfrmCoverSearch.GetImage(sNum: String);
var
  aComponent: tComponent;
  aFrame: tFrameCover;
begin
  aComponent := sSBCovers.FindComponent('aFrameCover' + sNum);
  if aComponent <> Nil then
  begin
    aFrame := tFrameCover(aComponent);
    ImageClick(aFrame.sImage1);
  end;

end;

procedure TfrmCoverSearch.GlobalAddGrid(sUrls: tStrings);

const
  sPanelName = 'sPnRow%d';
var
  thDownload: tDownloadThread;
  aFrameCover: tFrameCover;
  aParentPanel: TsPanel;
  iPanelNumber: Integer;
  i: Integer;
begin
  i := 0;
  if sListUrls = nil then
    sListUrls := tStringList.Create
  else
    sListUrls.Clear;
  sListUrls.Assign(sUrls);
  removeframes;
  while (sListUrls.count > 0) and (i < 9) do
  begin
    sSBCovers.SkinData.BeginUpdate;

    iPanelNumber := round(i div 3);
    aParentPanel := TsPanel(self.FindComponent(format(sPanelName, [iPanelNumber])));
    aFrameCover := tFrameCover.Create(sSBCovers);
    aFrameCover.addLog := fAddLog;
    aFrameCover.Name := 'aFrameCover' + inttostr(i + 1);
    aFrameCover.sUrl := sListUrls[0];
    aFrameCover.sLabel1.Caption := inttostr(i + 1);
    aFrameCover.sImage1.OnClick := ImageClick;
    aFrameCover.Left := 1000;
    aFrameCover.parent := aParentPanel;
    // TODO: Implémenter un callback pour le retour de résultat.
    aFrameCover.SearchTerminated := SearchTerminated;
    aFrameCover.StartDownload;
    Inc(i);
    sListUrls.Delete(0);
    sSBCovers.SkinData.EndUpdate(true);
  end;

end;

procedure TfrmCoverSearch.ImageClick(Sender: TObject);
var
  aFrame: tFrame;
begin
  if TsImage(Sender).Owner.ClassName = 'tFrameCover' then
  begin
    aFrame := tFrameCover(TsImage(Sender).Owner);
    Image1.Picture.Assign(TsImage(Sender).Picture);
  end;

end;

procedure TfrmCoverSearch.removeframes;
var
  aFrame: tFrameCover;
  procedure remove;
  begin
    while sSBCovers.ComponentCount > 0 do
    begin
      if sSBCovers.Components[0].ClassNameIs('tFrameCover') then
      begin
        aFrame := tFrameCover(sSBCovers.Components[0]);
        aFrame.Free;
      end;
    end;
  end;

begin
  sSBCovers.SkinData.BeginUpdate;
  remove;
  sSBCovers.SkinData.EndUpdate(true);
end;

procedure TfrmCoverSearch.sButton1Click(Sender: TObject);
begin
  StartSearch2;
end;

procedure TfrmCoverSearch.sButton2Click(Sender: TObject);
begin
  StartSearch;
end;

procedure TfrmCoverSearch.SearchTerminated(pFrame: tFrame; iResult: Integer);
var
  aFrameCover: tFrameCover;
begin
  aFrameCover := tFrameCover(pFrame);
  if iResult = -1 then
  begin
    fAddLog(aFrameCover.Name, inttostr(iResult));
    if sListUrls.count > 0 then
    begin
      aFrameCover.sUrl := sListUrls[0];
      sListUrls.Delete(0);
      aFrameCover.StartDownload;
    end;
  end
  else
  begin
    fAddLog(aFrameCover.Name, inttostr(iResult));
  end;
end;

procedure TfrmCoverSearch.StartSearch(const start: Integer);
var
  aGoogleSearch: tGoogleSearch;
  aGoogleSearchFree: tGoogleSearchFree;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  webResult: String;
  pMediaImg: tMediaImg;
  Col, Row: Integer;
  nbPass: Integer;
  Key2: String;
  sKey2: String;
  aFrameCover: tFrameCover;
  aParentPanel: TsPanel;
  iPanelNumber: Integer;
  lResults: tStrings;

  procedure addToGrid;
  const
    sPanelName = 'sPnRow%d';
  var
    thDownload: tDownloadThread;
  begin
    i := 0;

    while (sListUrls.count > 0) and (i < 9) do
    begin
      sSBCovers.SkinData.BeginUpdate;

      iPanelNumber := round(i div 3);
      aParentPanel := TsPanel(self.FindComponent(format(sPanelName, [iPanelNumber])));
      aFrameCover := tFrameCover.Create(sSBCovers);
      aFrameCover.addLog := fAddLog;
      aFrameCover.Name := 'aFrameCover' + inttostr(i + 1);
      aFrameCover.sUrl := sListUrls[0];
      aFrameCover.sLabel1.Caption := inttostr(i + 1);
      aFrameCover.sImage1.OnClick := ImageClick;
      aFrameCover.Left := 1000;
      aFrameCover.parent := aParentPanel;
      // TODO: Implémenter un callback pour le retour de résultat.
      aFrameCover.SearchTerminated := SearchTerminated;
      aFrameCover.StartDownload;
      Inc(i);
      sListUrls.Delete(0);
      sSBCovers.SkinData.EndUpdate(true);
    end;

  end;

begin

  removeframes;
  // sBtnPrev.Enabled := (start > 1);
  Col := 0;
  Row := 0;

  nbPass := 0;

  Key2 := seTitle.Text;
  if seTitle.BoundLabel.Caption = 'Title' then
    Key2 := Key2 + ' cover';

  // aGoogleSearch := tGoogleSearch.create(seArtist.Text + ' ' + Key2, start);

   aGoogleSearchFree := tGoogleSearchFree.create;
   jsResult := aGoogleSearchFree.getImages(seArtist.Text + ' ' + Key2, 10);

  // jsResult := aGoogleSearch.getImages;

  jsArray := jsResult.A[GS_ITEMS];

  sListUrls := tStringList.Create;
  i := 0;
  while (i <= jsArray.length - 1) do
  begin
    sListUrls.Add(jsArray.O[i].S[GS_LINK]);
    Inc(i);
  end;

  addToGrid;

end;

procedure TfrmCoverSearch.StartSearch2(const start: Integer);
const
  sUrl = 'https://www.google.com/search?q=%s&source=lnms&tbm=isch&tbs=isz:l';
var
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  webResult: String;
  pMediaImg: tMediaImg;
  Col, Row: Integer;
  nbPass: Integer;
  Key2: String;
  sKey2: String;
  aFrameCover: tFrameCover;
  aParentPanel: TsPanel;
  iPanelNumber: Integer;
  lResults: tStrings;

begin
  WebBrowser1.Navigate('about:blank');
  removeframes;
  // sBtnPrev.Enabled := (start > 1);
  Col := 0;
  Row := 0;

  nbPass := 0;

  Key2 := seTitle.Text;
//  if seTitle.BoundLabel.Caption = 'Title' then
//    Key2 := Key2 + ' cover';

  // aGoogleSearch := tGoogleSearch.create(seArtist.Text + ' ' + Key2, start);

  // aGoogleSearchFree := tGoogleSearchFree.create;
  // jsResult := aGoogleSearchFree.getImages(seArtist.Text + ' ' + Key2, 10);

  // jsResult := aGoogleSearch.getImages;
  sKey2 := format(sUrl, [TNetEncoding.URL.Encode(seArtist.Text + ' ' + Key2)]);
  skey2 := StringReplace(sKey2,'+','%2B',[rfReplaceAll]);
  edit1.Text := sKey2;
  WebBrowser1.Navigate('about:blank');
  WebBrowser1.Navigate(sKey2);

end;

procedure TfrmCoverSearch.WebBrowser1DocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
var
  currentBrowser: IWebBrowser;
  topBrowser: IWebBrowser;
  document: OleVariant;
  windowName: string;
  jsResult: ISuperObject;
  jsArray: IsuperArray;
  i: Integer;
  webResult: String;
  pMediaImg: tMediaImg;
  Col, Row: Integer;
  nbPass: Integer;
  Key2: String;
  sKey2: String;
  aFrameCover: tFrameCover;
  aParentPanel: TsPanel;
  iPanelNumber: Integer;
  lResults: tStrings;

  procedure addToGrid;
  const
    sPanelName = 'sPnRow%d';
  var
    thDownload: tDownloadThread;
  begin
    i := 0;

    while (sListUrls.count > 0) and (i < 9) do
    begin
      sSBCovers.SkinData.BeginUpdate;

      iPanelNumber := round(i div 3);
      aParentPanel := TsPanel(self.FindComponent(format(sPanelName, [iPanelNumber])));
      aFrameCover := tFrameCover.Create(sSBCovers);
      aFrameCover.addLog := fAddLog;
      aFrameCover.Name := 'aFrameCover' + inttostr(i + 1);
      aFrameCover.sUrl := sListUrls[0];
      aFrameCover.sLabel1.Caption := inttostr(i + 1);
      aFrameCover.sImage1.OnClick := ImageClick;
      aFrameCover.Left := 1000;
      aFrameCover.parent := aParentPanel;
      // TODO: Implémenter un callback pour le retour de résultat.
      aFrameCover.SearchTerminated := SearchTerminated;
      aFrameCover.StartDownload;
      Inc(i);
      sListUrls.Delete(0);
      sSBCovers.SkinData.EndUpdate(true);
    end;

  end;

begin
  currentBrowser := pDisp as IWebBrowser;
  topBrowser := (ASender as TWebBrowser).DefaultInterface;
  if currentBrowser = topBrowser then
  begin
    // ShowMessage('Complete document was loaded')
    lResults := getLinks;
    jsResult := parseResult(lResults);

    jsArray := jsResult.A[GS_ITEMS];

    sListUrls := tStringList.Create;
    i := 0;
    while (i <= jsArray.length - 1) do
    begin
      sListUrls.Add(jsArray.O[i].S[GS_LINK]);
      Inc(i);
    end;
    AddToGrid;
  end;
end;

function TfrmCoverSearch.parseResult(aList: tStrings): ISuperObject;
var
  json: tSuperObject;
  jsArray: IsuperArray;
  jsobject: ISuperObject;
  anObject: ISuperObject;
  i: Integer;
begin

  result := SO;
  i := 0;

  while i <= aList.count - 1 do
  begin
    anObject := SO;
    anObject.S[GS_LINK] := aList[i];
    result.A[GS_ITEMS].Add(anObject);
    Inc(i);
  end;
end;

function TfrmCoverSearch.getLinks: tStrings;
var
  regexpr, RegExReplace: tRegEx;
  iMatch: Integer;
  Match: tMatch;
  iGroup: Integer;
  sKey: String;
  sExpr: String;

  document: IHTMLDocument2;
begin

  result := tStringList.Create;
  document := WebBrowser1.document as IHTMLDocument2;

  regexpr := tRegEx.Create('(http(s?):)([\/|.|\w|\s|-])*\.(?:jpg|gif|png)');

  Match := regexpr.Match(document.body.innerHTML);
  iMatch := 0;
  while Match.Success do
  begin
    result.Add(Match.Value);
    Match := Match.NextMatch;
  end;

end;

end.
