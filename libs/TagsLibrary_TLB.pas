unit TagsLibrary_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 2020.04.08. 8:47:12 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\Documents and Settings\_3delite\My Documents\Delphi - C Projects\Tags Library\TagsLib\Tags Library COM\TagsLibrary (1)
// LIBID: {E1433DE5-549A-4B51-8F0C-51F278E03322}
// LCID: 0
// Helpfile:
// HelpString: Universal tag manager library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v4.0 StdVCL, (stdvcl40.dll)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer{, Winapi.ActiveX};


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  TagsLibraryMajorVersion = 1;
  TagsLibraryMinorVersion = 0;

  LIBID_TagsLibrary: TGUID = '{E1433DE5-549A-4B51-8F0C-51F278E03322}';

  IID_ITagManager: TGUID = '{FF8DC467-B48B-46BB-8E35-63B04A51C7AE}';
  CLASS_TagManager: TGUID = '{931F6FD8-2260-4E3C-98AB-3F2D2ED52955}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ITagManager = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  TagManager = ITagManager;


// *********************************************************************//
// Interface: ITagManager
// Flags:     (4352) OleAutomation Dispatchable
// GUID:      {FF8DC467-B48B-46BB-8E35-63B04A51C7AE}
// *********************************************************************//
  ITagManager = interface(IDispatch)
    ['{FF8DC467-B48B-46BB-8E35-63B04A51C7AE}']
    function LoadFromFile(const FileName: WideString; TagType: Integer): HResult; stdcall;
    function SaveToFile(const FileName: WideString; TagType: Integer): HResult; stdcall;
    function GetTagByIndex(Index: Integer; TagType: Integer; out Name: OleVariant;
                           out Tag: OleVariant; out Language: OleVariant;
                           out Description: OleVariant; out ExtTagType: OleVariant;
                           out NameValue: OleVariant; out MeanValue: OleVariant;
                           out DataType: OleVariant): HResult; stdcall;
    function GetTagByName(const Name: WideString; out Tag: OleVariant; TagType: Integer): HResult; stdcall;
    function SetTag(const Name: WideString; const Value: WideString; TagType: Integer): HResult; stdcall;
    function DeleteTagByName(const Name: WideString; TagType: Integer): HResult; stdcall;
    function DeleteTagByIndex(Index: Integer; TagType: Integer): HResult; stdcall;
    function GetCoverArtToFile(Index: Integer; const FileName: WideString; TagType: Integer): HResult; stdcall;
    function AddCoverArtFromFile(const FileName: WideString; const Name: WideString;
                                 const Description: WideString; CoverType: Integer; TagType: Integer): HResult; stdcall;
    function DeleteCoverArtByIndex(Index: Integer; TagType: Integer): HResult; stdcall;
    function RemoveTagsFromFile(const FileName: WideString; TagType: Integer): HResult; stdcall;
    function AddTag(const Name: WideString; const Value: WideString; TagType: Integer): HResult; stdcall;
    function TagCount(out Value: OleVariant; TagType: Integer): HResult; stdcall;
    function CoverArtCount(out Value: OleVariant; TagType: Integer): HResult; stdcall;
    function GetAudioAttribute(Attribute: Integer; out Value: OleVariant): HResult; stdcall;
    function GetAudioFormat(const FileName: WideString; out Value: OleVariant): HResult; stdcall;
    function SaveToFileEx(const FileName: WideString; TagType: Integer): HResult; stdcall;
    function SetTagEx(const Name: WideString; const Value: WideString; TagType: Integer;
                      const Language: WideString; const Description: WideString;
                      ExtTagType: Integer; const NameValue: WideString;
                      const MeanValue: WideString; DataType: Integer): HResult; stdcall;
    function GetWAVEVNT(Index: Integer; out EventID: OleVariant; out ParamType: OleVariant;
                        out StreamNumber: OleVariant; out AudioStreamOffset: OleVariant;
                        out wParam: OleVariant; out lParam: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoTagManager provides a Create and CreateRemote method to
// create instances of the default interface ITagManager exposed by
// the CoClass TagManager. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoTagManager = class
    class function Create: ITagManager;
    class function CreateRemote(const MachineName: string): ITagManager;
  end;

implementation

uses System.Win.ComObj;

class function CoTagManager.Create: ITagManager;
begin
  Result := CreateComObject(CLASS_TagManager) as ITagManager;
end;

class function CoTagManager.CreateRemote(const MachineName: string): ITagManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TagManager) as ITagManager;
end;

end.

