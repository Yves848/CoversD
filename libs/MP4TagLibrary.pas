//********************************************************************************************************************************
//*                                                                                                                              *
//*     MP4 Tag Library 1.0.48.104 © 3delite 2012-2019                                                                           *
//*     See MP4 Tag Library ReadMe.txt for details.                                                                              *
//*                                                                                                                              *
//* Licenses available for this component:                                                                                       *
//* Freeware License: €25                                                                                                        *
//* 	http://www.shareit.com/product.html?productid=300953212                                                                  *
//* Shareware License: €50                                                                                                       *
//*     http://www.shareit.com/product.html?productid=300548330                                                                  *
//* Commercial License: €250                                                                                                     *
//*     http://www.shareit.com/product.html?productid=300548328                                                                  *
//*                                                                                                                              *
//* Home page:                                                                                                                   *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                        *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                          *
//*                                                                                                                              *
//* There is also an ID3v2 Library available at:                                                                                 *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                         *
//*                                                                                                                              *
//* and also an APEv2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                         *
//*                                                                                                                              *
//* and also an Ogg Vorbis and Opus Tag Library available at:                                                                    *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                       *
//*                                                                                                                              *
//* a Flac Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                       *
//*                                                                                                                              *
//* an WMA Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                        *
//*                                                                                                                              *
//* a WAV Tag Library available at:                                                                                              *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                        *
//*                                                                                                                              *
//* an MKV Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MKVTagLibrary.html                                        *
//*                                                                                                                              *
//* For other Delphi components see the home page:                                                                               *
//*                                                                                                                              *
//*     https://www.3delite.hu/                                                                                                  *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

{.$DEFINE IVAN_LLANAS}

// Changes by Ivan Llanas:
//
// - Added MP4TAGLIBRARY_VERSION_FRIENDLY constant for Trilobite components list.
// - Fixed the Audio information gathering when the audio is not the first trak.
//   GetAudioAttributes assumes that the first trak atom in the header
//   always contains the audio info in an internal mp4a atom. Error. Often the
//   first trak atom is the video one.
// - Added prefix 'Audio' to ChannelCount, Resolution and SampleRate variables.
// - Added VideoWidth and VideoHeight.

// Wanted: FrameRate, VideoColorDepth, VideoBitRate, AudioBitRate.

unit MP4TagLibrary;

{$IFDEF IOS}
    {$DEFINE MP4TL_MOBILE}
{$ENDIF}

{$IFDEF ANDROID}
    {$DEFINE MP4TL_MOBILE}
{$ENDIF}

{$MINENUMSIZE 4}

{$IFDEF FPC}
    {$MODE DELPHI}{$H+}
{$ENDIF}

interface

Uses
    SysUtils,
    {$IFNDEF FPC}
        {$IFDEF MSWINDOWS}
        Windows,
        {$ENDIF}
    {$ENDIF}
    Classes,
    Generics.Collections;

Const
    MP4TAGLIBRARY_VERSION = $010048104;
    MP4TAGLIBRARY_VERSION_FRIENDLY = '1.0.48.104 (Ivan Llanas branch)';

Const
    MP4TAGLIBRARY_SUCCESS                       = 0;
    MP4TAGLIBRARY_ERROR                         = $FFFF;
    MP4TAGLIBRARY_ERROR_NO_TAG_FOUND            = 1;
    MP4TAGLIBRARY_ERROR_EMPTY_TAG               = 2;
    MP4TAGLIBRARY_ERROR_EMPTY_FRAMES            = 3;
    MP4TAGLIBRARY_ERROR_OPENING_FILE            = 4;
    MP4TAGLIBRARY_ERROR_READING_FILE            = 5;
    MP4TAGLIBRARY_ERROR_WRITING_FILE            = 6;
    MP4TAGLIBRARY_ERROR_DOESNT_FIT              = 7;
    MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION   = 8;
    MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT    = 9;
    MP4TAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS   = 10;
    MP4TAGLIBRARY_ERROR_UPDATE_stco             = 11;
    MP4TAGLIBRARY_ERROR_UPDATE_co64             = 12;

Const
    MP4TAGLIBRARY_DEFAULT_PADDING_SIZE          = 4096;
    MP4TAGLIBRARY_FAIL_ON_CURRUPT_FILE          = False;
    MP4TAGLIBRARY_PARSE_Xtra                    = True;

const
    ID3Genres: Array[0..192] of String = (
        { The following genres are defined in ID3v1 }
        '',
        'Blues',
        'Classic Rock',
        'Country',
        'Dance',
        'Disco',
        'Funk',
        'Grunge',
        'Hip-Hop',
        'Jazz',
        'Metal',
        'New Age',
        'Oldies',
        'Other',     { <= 12 Default }
        'Pop',
        'R&B',
        'Rap',
        'Reggae',
        'Rock',
        'Techno',
        'Industrial',
        'Alternative',
        'Ska',
        'Death Metal',
        'Pranks',
        'Soundtrack',
        'Euro-Techno',
        'Ambient',
        'Trip-Hop',
        'Vocal',
        'Jazz+Funk',
        'Fusion',
        'Trance',
        'Classical',
        'Instrumental',
        'Acid',
        'House',
        'Game',
        'Sound Clip',
        'Gospel',
        'Noise',
        'AlternRock',
        'Bass',
        'Soul',
        'Punk',
        'Space',
        'Meditative',
        'Instrumental Pop',
        'Instrumental Rock',
        'Ethnic',
        'Gothic',
        'Darkwave',
        'Techno-Industrial',
        'Electronic',
        'Pop-Folk',
        'Eurodance',
        'Dream',
        'Southern Rock',
        'Comedy',
        'Cult',
        'Gangsta',
        'Top 40',
        'Christian Rap',
        'Pop/Funk',
        'Jungle',
        'Native American',
        'Cabaret',
        'New Wave',
        'Psychedelic', // = 'Psychadelic' in ID3 docs, 'Psychedelic' in winamp.
        'Rave',
        'Showtunes',
        'Trailer',
        'Lo-Fi',
        'Tribal',
        'Acid Punk',
        'Acid Jazz',
        'Polka',
        'Retro',
        'Musical',
        'Rock & Roll',
        'Hard Rock',
        { The following genres are Winamp extensions }
        'Folk',
        'Folk-Rock',
        'National Folk',
        'Swing',
        'Fast Fusion',
        'Bebob',
        'Latin',
        'Revival',
        'Celtic',
        'Bluegrass',
        'Avantgarde',
        'Gothic Rock',
        'Progressive Rock',
        'Psychedelic Rock',
        'Symphonic Rock',
        'Slow Rock',
        'Big Band',
        'Chorus',
        'Easy Listening',
        'Acoustic',
        'Humour',
        'Speech',
        'Chanson',
        'Opera',
        'Chamber Music',
        'Sonata',
        'Symphony',
        'Booty Bass',
        'Primus',
        'Porn Groove',
        'Satire',
        'Slow Jam',
        'Club',
        'Tango',
        'Samba',
        'Folklore',
        'Ballad',
        'Power Ballad',
        'Rhythmic Soul',
        'Freestyle',
        'Duet',
        'Punk Rock',
        'Drum Solo',
        'A capella', // A Capella
        'Euro-House',
        'Dance Hall',
        { winamp ?? genres }
        'Goa',
        'Drum & Bass',
        'Club-House',
        'Hardcore',
        'Terror',
        'Indie',
        'BritPop',
        'Negerpunk',
        'Polsk Punk',
        'Beat',
        'Christian Gangsta Rap',
        'Heavy Metal',
        'Black Metal',
        'Crossover',
        'Contemporary Christian',
        'Christian Rock',
        { winamp 1.91 genres }
        'Merengue',
        'Salsa',
        'Trash Metal',
        { winamp 1.92 genres }
        'Anime',
        'JPop',
        'SynthPop',
        {Winamp 5.6}
        'Abstract',
        'Art Rock',
        'Baroque',
        'Bhangra',
        'Big Beat',
        'Breakbeat',
        'Chillout',
        'Downtempo',
        'Dub',
        'EBM',
        'Eclectic',
        'Electro',
        'Electroclash',
        'Emo',
        'Experimental',
        'Garage',
        'Global',
        'IDM',
        'Illbient',
        'Industro-Goth',
        'Jam Band',
        'Krautrock',
        'Leftfield',
        'Lounge',
        'Math Rock',
        'New Romantic',
        'Nu-Breakz',
        'Post-Punk',
        'Post-Rock',
        'Psytrance',
        'Shoegaze',
        'Space Rock',
        'Trop Rock',
        'World Music',
        'Neoclassical',
        'Audiobook',
        'Audio Theatre',
        'Neue Deutsche Welle',
        'Podcast',
        'Indie Rock',
        'G-Funk',
        'Dubstep',
        'Garage Rock',
        'Psybient'
    );

Const
    MAGIC_PNG = $5089;  //* Little endian form
    MAGIC_JPG = $d8ff;  //* Little endian form
    MAGIC_GIF = $4947;  //* Little endian form
    MAGIC_BMP = $4d42;  //* Little endian form

type
    DWord = Cardinal;
    {
type
    MP4XtraWMT_ATTR_DATATYPE = Word of
        (MP4XtraWMT_TYPE_DWORD,
        MP4XtraWMT_TYPE_STRING,
        MP4XtraWMT_TYPE_BINARY,
        MP4XtraWMT_TYPE_BOOL,
        MP4XtraWMT_TYPE_QWORD,
        MP4XtraWMT_TYPE_WORD,
        MP4XtraWMT_TYPE_GUID,
        MP4XtraWMT_TYPE_UNKNOWN);
    TMP4XtraWMTAttrDataType = MP4XtraWMT_ATTR_DATATYPE;
    }

Const // MP4XtraBasicType
    MP4_XTRA_BT_UNICODE   =  8;
    MP4_XTRA_BT_INT64     = 19;
    MP4_XTRA_BT_FILETIME  = 21;
    MP4_XTRA_BT_GUID      = 72;

type
    TAtomName = Array [0..3] of Byte;

type
    TMP4AudioFormat = (mp4afUnknown, mp4afAAC, mp4afALAC, mpfafAC3);

type
    TMP4XtraUsageConversion = (mp4eucNone, mp4eucParse, mp4eucWrite, mp4eucParseAndWrite, mp4eucWriteJustXtra);
    TMP4XtraPriority = (mp4epXtraHasPriority, mp4epCommonHasPriority);

type
    TMP4Atom = class;

    TMP4Atommean = class
        Data: TMemoryStream;
        Parent: TMP4Atom;
        AlreadyParsed: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        procedure Clear;
        function Write(MP4Stream: TStream): Boolean;
        function Assign(MP4Atommean: TMP4Atommean): Boolean;
        function GetAsText: String;
        function SetAsText(const Text: String): Boolean;
    end;

    TMP4Atomname = class
        Data: TMemoryStream;
        Parent: TMP4Atom;
        AlreadyParsed: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        procedure Clear;
        function Write(MP4Stream: TStream): Boolean;
        function Assign(MP4Atomname: TMP4Atomname): Boolean;
        function GetAsText: String;
        function SetAsText(const Text: String): Boolean;
    end;

    TMP4AtomData = class
        Data: TMemoryStream;
        DataType: DWord;
        Reserved: DWord;
        Parent: TMP4Atom;
        Index: Integer;
        AlreadyParsed: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function GetAsBytes: TBytes;
        function GetAsText: String;
        function GetAsInteger(out Value: UInt64): Boolean;
        function GetAsInteger8: Byte;
        function GetAsInteger16: Word;
        function GetAsInteger32: DWord;
        function GetAsInteger48(var LowDWord: DWord; var HighWord: Word; out Value: UInt64): Boolean;
        function GetAsInteger64(var LowDWord, HighDWord: DWord; out Value: UInt64): Boolean;
        function GetAsBool: Boolean;
        function GetAsList(List: TStrings): Boolean;
        function SetAsText(const Text: String): Boolean;
        function SetAsInteger8(Value: Byte): Boolean;
        function SetAsInteger16(Value: Word): Boolean;
        function SetAsInteger32(Value: DWord): Boolean;
        function SetAsInteger48(Value: UInt64): Boolean; overload;
        function SetAsInteger48(LowDWord: DWord; HighWord: Word): Boolean; overload;
        function SetAsInteger64(Value: UInt64): Boolean; overload;
        function SetAsInteger64(LowDWord, HighDWord: DWord): Boolean; overload;
        function SetAsBool(Value: Boolean): Boolean;
        function SetAsList(List: TStrings): Boolean;
        procedure Clear;
        function Write(MP4Stream: TStream): Boolean;
        function Delete: Boolean;
        function Assign(MP4AtomData: TMP4AtomData): Boolean;
    end;

    TMP4Tag = class;

    TMP4Atom = class
    private
        function GetIndex: Integer;
    public
        ID: TAtomName;
        Size: DWord;
        mean: TMP4Atommean;
        name: TMP4Atomname;
        Datas: Array of TMP4AtomData;
        Flags: DWord;
        Parent: TMP4Tag;
        //Index: Integer;
        AlreadyParsed: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function AddData: TMP4AtomData;
        function GetAsText: String;
        function GetAsInteger(out Value: UInt64): Boolean;
        function GetAsInteger8: Byte;
        function GetAsInteger16: Word;
        function GetAsInteger32: DWord;
        function GetAsInteger48(var LowDWord: DWord; HiWord: Word; out Value: UInt64): Boolean;
        function GetAsInteger64(var LowDWord, HiDWord: DWord; out Value: UInt64): Boolean;
        function GetAsBool: Boolean;
        function GetAsList(List: TStrings): Boolean;
        function GetAsCommonText(var _name: String; var _mean: String): String;
        function SetAsText(const Text: String): Boolean;
        function SetAsInteger8(Value: Byte): Boolean;
        function SetAsInteger16(Value: Word): Boolean;
        function SetAsInteger32(Value: DWord): Boolean;
        function SetAsInteger48(Value: UInt64): Boolean; overload;
        function SetAsInteger48(LowDWord: DWord; HiWord: Word): Boolean; overload;
        function SetAsInteger64(Value: UInt64): Boolean; overload;
        function SetAsInteger64(LowDWord, HiDWord: DWord): Boolean; overload;
        function SetAsBool(Value: Boolean): Boolean;
        function SetAsList(List: TStrings): Boolean;
        function SetAsCommonText(const _name: String; const _mean: String; const Value: String): Boolean;
        function Count: Integer;
        procedure Clear;
        function CalculateAtomSize: Cardinal;
        function Write(MP4Stream: TStream): Boolean;
        procedure Delete;
        function DeleteData(AtomIndex: Integer): Boolean;
        function Deletemean: Boolean;
        function Deletename: Boolean;
        procedure CompactAtomDataList;
        function Assign(MP4Atom: TMP4Atom): Boolean;
        procedure ReSetAlreadyParsedState;
        property Index: Integer read GetIndex;
    end;

    TMP4Xtra = class
    private
        function GetIndex: Integer;
    public
        Name: String;
        PropType: Word;
        Data: TMemoryStream;
        Parent: TMP4Tag;
        AlreadyParsed: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function GetAsText: String;
        function GetAsInteger(out Value: Int64): Boolean;
        function GetAsGUID(out Value: TGUID): Boolean;
        function GetAsDateTime(out Value: TDateTime): Boolean;
        function SetAsText(const Value: String): Boolean;
        function SetAsInteger(Value: Int64): Boolean;
        function SetAsGUID(Value: TGUID): Boolean;
        function SetAsDateTime(Value: TDateTime): Boolean;
        function Assign(Xtra: TMP4Xtra): Boolean;
        procedure Clear;
        property Index: Integer read GetIndex;
    end;

    TMP4Tag = class
    private
        FLoaded: Boolean;
        FFileSize: Int64;
        FAtommdatPosition: Int64;
        FAtommdatSize: Int64;
        FPlaytime: Double;
        FAudioChannelCount: Word;
        FAudioResolution: Integer;
        FAudioSampleRate: Cardinal;
        FBitRate: Integer;
        FVideoWidth: Integer;
        FVideoHeight: Integer;
        FAudioFormat: TMP4AudioFormat;
        FAtommoovPosition: Int64;
        FAtommoovSize: Int64;
        FAtomudtaPosition: Int64;
        FAtomudtaSize: Int64;
        FAtommetaPosition: Int64;
        FAtommetaSize: Int64;
        FAtomilstPosition: Int64;
        FAtomilstSize: Int64;
        procedure _GetIvanParameters (MP4Stream : TStream);
    public
        FileName: String;
        Atoms: TList<TMP4Atom>;
        Xtras: TList<TMP4Xtra>;
        Version: Byte;
        Flags: DWord;
        PaddingToWrite: Cardinal;
        ParseXtra: Boolean;
        XtraUsageConversion: TMP4XtraUsageConversion;
        XtraPriority: TMP4XtraPriority;
        ParseCoverArts: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function LoadFromFile(MP4FileName: String): Integer;
        function LoadFromStream(MP4Stream: TStream; Buffered: Boolean = True): Integer;
        function SaveToFile(MP4FileName: String; KeepPadding: Boolean = True; UseMemoryForTempDataMaxFileSize: Int64 = 250 * 1024 * 1024 {250 MB}): Integer;
        function SaveToStream(MP4Stream: TStream; Buffered: Boolean = True; KeepPadding: Boolean = True; MP4FileName: String = ''): Integer;
        function AddAtom(AtomName: TAtomName): TMP4Atom; overload;
        function AddAtom(AtomName: String): TMP4Atom; overload;
        function ReadAtom(MP4Stream: TStream; var MP4Atom: TMP4Atom): Boolean;
        function ReadAtomData(MP4Stream: TStream; var MP4AtomData: TMP4AtomData; SkipLoadingOfDatas: Boolean): Boolean;
        function LoadXtra(MP4Stream: TStream; XtraAtomSize: UInt64): Boolean;
        function AddXtra(const FieldName: String): TMP4Xtra;
        function CreateXtraAtomStream(XtraStream: TMemoryStream): Boolean;
        function Count: Integer;
        function CoverArtCount: Integer;
        procedure Clear;
        procedure ClearXtras;
        function DeleteAtom(Index: Integer): Boolean; overload;
        function DeleteAtom(AtomName: TAtomName): Boolean; overload;
        function DeleteAtom(const AtomName: String): Boolean; overload;
        function DeleteXtra(const FieldName: String): Boolean; overload;
        function DeleteXtra(Index: Integer): Boolean; overload;
        function DeleteAllAtoms(AtomName: TAtomName): Boolean; overload;
        function DeleteAllAtoms(const AtomName: String): Boolean; overload;
        function DeleteAtomCommon(const AtomName: String; const _name: String; const _mean: String): Boolean;
        function CalculateSize: Int64;
        function FindAtom(AtomName: TAtomName): TMP4Atom; overload;
        function FindAtom(const AtomName: String): TMP4Atom; overload;
        function FindAtomCommon(AtomName: TAtomName; const _name: String; const _mean: String): TMP4Atom; overload;
        function FindAtomCommon(const AtomName: String; const _name: String; const _mean: String): TMP4Atom; overload;
        function FindAtomXtra(const FieldName: String): TMP4Xtra; overload;
        function FindAtomXtraIndex(const FieldName: String): Integer;
        function GetText(AtomName: TAtomName): String; overload;
        function GetText(const AtomName: String): String; overload;
        function GetInteger(AtomName: TAtomName; out Value: UInt64): Boolean; overload;
        function GetInteger(const AtomName: String; out Value: UInt64): Boolean; overload;
        function GetInteger8(AtomName: TAtomName): Byte; overload;
        function GetInteger8(const AtomName: String): Byte; overload;
        function GetInteger16(AtomName: TAtomName): Word; overload;
        function GetInteger16(const AtomName: String): Word; overload;
        function GetInteger32(AtomName: TAtomName): DWord; overload;
        function GetInteger32(const AtomName: String): DWord; overload;
        function GetInteger48(AtomName: TAtomName; var LowDWord: DWord; HiWord: Word; out Value: UInt64): Boolean; overload;
        function GetInteger48(const AtomName: String; var LowDWord: DWord; HiWord: Word; out Value: UInt64): Boolean; overload;
        function GetInteger64(AtomName: TAtomName; var LowDWord, HiDWord: DWord; out Value: UInt64): Boolean; overload;
        function GetInteger64(const AtomName: String; var LowDWord, HiDWord: DWord; out Value: UInt64): Boolean; overload;
        function GetBool(AtomName: TAtomName): Boolean; overload;
        function GetBool(const AtomName: String): Boolean; overload;
        function GetList(AtomName: TAtomName; List: TStrings): Boolean; overload;
        function GetList(const AtomName: String; List: TStrings): Boolean; overload;
        function SetText(AtomName: TAtomName; const Text: String): Boolean; overload;
        function SetText(const AtomName: String; const Text: String): Boolean; overload;
        function SetInteger8(AtomName: TAtomName; Value: Byte): Boolean; overload;
        function SetInteger8(const AtomName: String; Value: Byte): Boolean; overload;
        function SetInteger16(AtomName: TAtomName; Value: Word): Boolean; overload;
        function SetInteger16(const AtomName: String; Value: Word): Boolean; overload;
        function SetInteger32(AtomName: TAtomName; Value: DWord): Boolean; overload;
        function SetInteger32(const AtomName: String; Value: DWord): Boolean; overload;
        function SetInteger48(AtomName: TAtomName; Value: UInt64): Boolean; overload;
        function SetInteger48(const AtomName: String; Value: UInt64): Boolean; overload;
        function SetInteger48(AtomName: TAtomName; LowDWord: DWord; HighWord: Word): Boolean; overload;
        function SetInteger48(const AtomName: String; LowDWord: DWord; HighWord: Word): Boolean; overload;
        function SetInteger64(AtomName: TAtomName; Value: UInt64): Boolean; overload;
        function SetInteger64(AtomName: TAtomName; LowDWord, HighDWord: DWord): Boolean; overload;
        function SetInteger64(const AtomName: String; Value: UInt64): Boolean; overload;
        function SetInteger64(const AtomName: String; LowDWord, HighDWord: DWord): Boolean; overload;
        function SetBool(AtomName: TAtomName; Value: Boolean): Boolean; overload;
        function SetBool(const AtomName: String; Value: Boolean): Boolean; overload;
        function SetList(AtomName: TAtomName; List: TStrings): Boolean; overload;
        function SetList(const AtomName: String; List: TStrings): Boolean; overload;
        function GetCommon(const _name: String; const _mean: String): String;
        function SetCommon(const _name: String; const _mean: String; const Value: String): Boolean;
        function GetMediaType: String;
        function SetMediaType(Media: String): Boolean;
        function GetTrack: Word;
        function GetTotalTracks: Word;
        function GetDisc: Word;
        function GetTotalDiscs: Word;
        function SetTrack(Track: Word; TotalTracks: Word): Boolean;
        function SetDisc(Disc: Word; TotalDiscs: Word): Boolean;
        function GetGenre: String;
        function SetGenre(const Genre: String): Boolean;
        function GetPurchaseCountry: String;
        function SetPurchaseCountry(Country: String): Boolean;
        function Assign(MP4Tag: TMP4Tag): Boolean;
        procedure ReSetAlreadyParsedState;
        function GetMultipleValuesMultipleAtoms(AtomName: TAtomName; List: TStrings): Boolean; overload;
        function GetMultipleValuesMultipleAtoms(AtomName: String; List: TStrings): Boolean; overload;
        procedure SetMultipleValuesCommaSeparated(AtomName: TAtomName; List: TStrings); overload;
        procedure SetMultipleValuesCommaSeparated(AtomName: String; List: TStrings); overload;
        procedure SetMultipleValuesMultipleAtoms(AtomName: TAtomName; List: TStrings); overload;
        procedure SetMultipleValuesMultipleAtoms(AtomName: String; List: TStrings); overload;

        function GetTextXtra(const FieldName: String): String;
        function SetTextXtra(const FieldName: String; const Value: String): Boolean;
        function GetIntegerXtra(const FieldName: String; out Value: Int64): Boolean;
        function SetIntegerXtra(const FieldName: String; Value: Int64): Boolean;
        function GetGUIDXtra(const FieldName: String; out Value: TGUID): Boolean;
        function SetGUIDXtra(const FieldName: String; Value: TGUID): Boolean;
        function GetFileTimeXtra(const FieldName: String; out Value: TDateTime): Boolean;
        function SetFileTimeXtra(const FieldName: String; Value: TDateTime): Boolean;

        property Loaded: Boolean read FLoaded;
        property FileSize: Int64 read FFileSize;
        property mdatAtomPosition: Int64 read FAtommdatPosition;
        property mdatAtomSize: Int64 read FAtommdatSize;
        property Playtime: Double read FPlaytime;
        property AudioChannelCount: Word read FAudioChannelCount;
        property AudioResolution: Integer read FAudioResolution;
        property AudioSampleRate: Cardinal read FAudioSampleRate;
        property BitRate: Integer read FBitRate;
        property VideoWidth: Integer read FVideoWidth;
        property VideoHeight: Integer read FVideoHeight;
        property AudioFormat: TMP4AudioFormat read FAudioFormat;
        property AtommoovPosition: Int64 read FAtommoovPosition;
        property AtommoovSize: Int64 read FAtommoovSize;
        property AtomudtaPosition: Int64 read FAtomudtaPosition;
        property AtomudtaSize: Int64 read FAtomudtaSize;
        property AtommetaPosition: Int64 read FAtommetaPosition;
        property AtommetaSize: Int64 read FAtommetaSize;
        property AtomilstPosition: Int64 read FAtomilstPosition;
        property AtomilstSize: Int64 read FAtomilstSize;
    end;

    function ReadAtomHeader(MP4Stream: TStream; var AtomName: TAtomName; var AtomSize: Int64; var Is64BitSize: Boolean; FailOnCurrupt: Boolean = True): Boolean;
    function WriteAtomHeader(MP4Stream: TStream; AtomName: TAtomName; AtomSize: Int64): Boolean; overload;
    function WriteAtomHeader(MP4Stream: TStream; AtomName: String; AtomSize: Int64): Boolean; overload;
    function WritePadding(MP4Stream: TStream; PaddingSize: Integer): Integer;
    function MP4mdatAtomLocation(MP4Stream: TStream): Int64;
    function MP4UpdatestcoAtom(MP4Stream: TStream; Offset: Integer): Boolean;
    function MP4Updateco64Atom(MP4Stream: TStream; Offset: Int64): Boolean;
    procedure GetmdatAtom(MP4Stream: TStream; out Position, Size: Int64);
    function GetPlaytime(MP4Stream: TStream): Double;

    //function GetAudioAttributes(MP4Tag: TMP4Tag; MP4Stream: TStream): Boolean;

    function RemoveMP4TagFromFile(FileName: String; KeepPadding: Boolean; CreatePaddingSize: Integer = 0): Integer;
    function RemoveMP4TagFromStream(Stream: TStream; KeepPadding: Boolean; CreatePaddingSize: Integer = 0): Integer;

    function ReverseBytes16(AWord: Word): Word; inline;
    function ReverseBytes32(Value: Cardinal): Cardinal; overload; inline;
    function ReverseBytes32(Value: Integer): Integer; overload; inline;
    function ReverseBytes64(const aVal: Int64): Int64; overload; inline;
    function ReverseBytes64(const aVal: UInt64): UInt64; overload; inline;

    function MakeUInt64(LowDWord, HiDWord: DWord): UInt64; inline;
    function LowDWordOfUInt64(Value: UInt64): Cardinal; inline;
    function HighDWordOfUInt64(Value: UInt64): Cardinal; inline;

    function LoWord(L: DWord): Word; inline;
    function HiWord(L: DWord): Word; inline;

    //procedure AnsiStringToPAnsiChar(const Source: String; Dest: PChar; const MaxLength: Integer);

    function GenreToIndex(Genre: String): Integer;

    function MediaTypeToStr(Value: Integer): string;

    function IsSameAtomName(const ID: TAtomName; const Name: String): Boolean; overload; inline;
    function IsSameAtomName(const ID1: TAtomName; const ID2: TAtomName): Boolean; overload; inline;

    function StringToAtomName(const Name: String; var ID: TAtomName): Boolean; inline;
    function AtomNameToString(ID: TAtomName): String; inline;
    function ClearAtomName: TAtomName; inline;

    function MP4TagErrorCode2String(ErrorCode: Integer): String;

var
    MP4AtomDataID: TAtomName;
    MP4AtommeanID: TAtomName;
    MP4AtomnameID: TAtomName;
    MP4TagLibraryDefaultPaddingSize: Integer = MP4TAGLIBRARY_DEFAULT_PADDING_SIZE;
    MP4TagLibraryFailOnCorruptFile: Boolean = MP4TAGLIBRARY_FAIL_ON_CURRUPT_FILE;
    MP4TagLibraryParseXtra: Boolean = MP4TAGLIBRARY_PARSE_Xtra;
    MP4TagLibraryXtraUsageConversion: TMP4XtraUsageConversion = mp4eucParseAndWrite;
    MP4TagLibraryXtraPriority: TMP4XtraPriority = mp4epXtraHasPriority;

implementation

Uses
    {$IFDEF POSIX}
    Posix.UniStd,
    //Posix.StdIO;
    {$ENDIF}
    DateUtils,
    BufferedStream;

type
    TStreamHelper = class helper for TStream
    public
        function Read2(var Buffer; Count: Longint): Longint;
    end;

function TStreamHelper.Read2(var Buffer; Count: Longint): Longint;
begin
    FillChar(Buffer, Count, 0);
    Result := Read(Buffer, Count);
end;

function ReverseBytes32(Value: Cardinal): Cardinal;
begin
    Result := (Value SHR 24) OR (Value SHL 24) OR ((Value AND $00FF0000) SHR 8) OR ((Value AND $0000FF00) SHL 8);
end;

function ReverseBytes32(Value: Integer): Integer;
begin
    Result := Integer(ReverseBytes32(Cardinal(Value)));
end;

function ReverseBytes64(const aVal: Int64): Int64; inline;
begin
    Int64Rec(Result).Bytes[0] :=  Int64Rec(aVal).Bytes[7];
    Int64Rec(Result).Bytes[1] :=  Int64Rec(aVal).Bytes[6];
    Int64Rec(Result).Bytes[2] :=  Int64Rec(aVal).Bytes[5];
    Int64Rec(Result).Bytes[3] :=  Int64Rec(aVal).Bytes[4];
    Int64Rec(Result).Bytes[4] :=  Int64Rec(aVal).Bytes[3];
    Int64Rec(Result).Bytes[5] :=  Int64Rec(aVal).Bytes[2];
    Int64Rec(Result).Bytes[6] :=  Int64Rec(aVal).Bytes[1];
    Int64Rec(Result).Bytes[7] :=  Int64Rec(aVal).Bytes[0];
end;

function ReverseBytes64(const aVal: UInt64): UInt64;
begin
    Result := UInt64(ReverseBytes64(Int64(aVal)));
end;

function ReverseBytes16(AWord: Word): Word;
begin
    Result := Swap(AWord);
end;

function MakeUInt64(LowDWord, HiDWord: DWord): UInt64;
begin
    Result := LowDWord OR (UInt64(HiDWord) SHL 32);
end;

function LowDWordOfUInt64(Value: UInt64): Cardinal;
begin
    Result := (Value SHL 32) SHR 32;
end;

function HighDWordOfUInt64(Value: UInt64): Cardinal;
begin
    Result := Value SHR 32;
end;

function Min(const B1, B2: Integer): Integer;
begin
    if B1 < B2 then begin
        Result := B1
    end else begin
        Result := B2;
    end;
end;

function LoWord(L: DWord): Word;
begin
    Result := Word(L);
end;

function HiWord(L: DWORD): Word;
begin
    Result := L SHR 16;
end;

function IsSameAtomName(const ID: TAtomName; const Name: String): Boolean;
begin
    {$IFDEF MP4TL_MOBILE}
    if (ID[0] = Ord(Name[0]))
    AND (ID[1] = Ord(Name[1]))
    AND (ID[2] = Ord(Name[2]))
    AND (ID[3] = Ord(Name[3]))
    {$ELSE}
    if (ID[0] = Ord(Name[1]))
    AND (ID[1] = Ord(Name[2]))
    AND (ID[2] = Ord(Name[3]))
    AND (ID[3] = Ord(Name[4]))
    {$ENDIF}
    then begin
        Result := True;
    end else begin
        Result := False;
    end;
end;

function IsSameAtomName(const ID1: TAtomName; const ID2: TAtomName): Boolean;
begin
    if (ID1[0] = ID2[0])
    AND (ID1[1] = ID2[1])
    AND (ID1[2] = ID2[2])
    AND (ID1[3] = ID2[3])
    then begin
        Result := True;
    end else begin
        Result := False;
    end;
end;

function StringToAtomName(const Name: String; var ID: TAtomName): Boolean;
begin
    FillChar(ID, SizeOf(ID), 0);
    {$IFDEF MP4TL_MOBILE}
    if Length(Name) > 0 then begin
        ID[0] := Ord(Name[0]);
    end;
    if Length(Name) > 1 then begin
        ID[1] := Ord(Name[1]);
    end;
    if Length(Name) > 2 then begin
        ID[2] := Ord(Name[2]);
    end;
    if Length(Name) > 3 then begin
        ID[3] := Ord(Name[3]);
    end;
    {$ELSE}
    if Length(Name) > 0 then begin
        ID[0] := Ord(Name[1]);
    end;
    if Length(Name) > 1 then begin
        ID[1] := Ord(Name[2]);
    end;
    if Length(Name) > 2 then begin
        ID[2] := Ord(Name[3]);
    end;
    if Length(Name) > 3 then begin
        ID[3] := Ord(Name[4]);
    end;
    {$ENDIF}
    Result := True;
end;

function AtomNameToString(ID: TAtomName): String;
begin
    Result := Char(ID[0]) + Char(ID[1]) + Char(ID[2]) + Char(ID[3]);
end;

function ClearAtomName: TAtomName;
begin
    Result[0] := 0;
    Result[1] := 0;
    Result[2] := 0;
    Result[3] := 0;
end;

function GenreToIndex(Genre: String): Integer;
var
    i: Integer;
    GenreText: String;
begin
    Result := - 1;
    GenreText := UpperCase(Genre);
    for i := 1 to Length(ID3Genres) - 1 do begin
        if UpperCase(ID3Genres[i]) = GenreText then begin
            Result := i;
            Exit;
        end;
    end;
end;

function WritePadding(MP4Stream: TStream; PaddingSize: Integer): Integer;
var
    Data: TBytes;
begin
    try
        SetLength(Data, PaddingSize);
        MP4Stream.Write(Data[0], Length(Data));
        Result := MP4TAGLIBRARY_SUCCESS;
    except
        Result := MP4TAGLIBRARY_ERROR_WRITING_FILE;
    end;
end;

function RemoveMP4TagFromFile(FileName: String; KeepPadding: Boolean; CreatePaddingSize: Integer = 0): Integer;
var
    MP4Tag: TMP4Tag;
begin
    if NOT FileExists(FileName) then begin
        Result := MP4TAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end else begin
        MP4Tag := TMP4Tag.Create;
        try
            MP4Tag.PaddingToWrite := CreatePaddingSize;
            Result := MP4Tag.SaveToFile(FileName, KeepPadding);
        finally
            FreeAndNil(MP4Tag);
        end;
    end;
end;

function RemoveMP4TagFromStream(Stream: TStream; KeepPadding: Boolean; CreatePaddingSize: Integer = 0): Integer;
var
    MP4Tag: TMP4Tag;
begin
    if Stream.Size = 0 then begin
        Result := MP4TAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end else begin
        MP4Tag := TMP4Tag.Create;
        try
            MP4Tag.PaddingToWrite := CreatePaddingSize;
            Result := MP4Tag.SaveToStream(Stream, True, KeepPadding);
        finally
            FreeAndNil(MP4Tag);
        end;
    end;
end;

function MP4mdatAtomLocation(MP4Stream: TStream): Int64;
var
    Size: Int64;
begin
    GetmdatAtom(MP4Stream, Result, Size);
end;

function MP4UpdatestcoAtom(MP4Stream: TStream; Offset: Integer): Boolean;
var
    AtomName: TAtomName;
    //AtomSize: Int64;
    moovAtomSize: Int64;
    moovAtomPosition: Int64;
    trakAtomSize: Int64;
    trakAtomPosition: Int64;
    mdiaAtomSize: Int64;
    mdiaAtomPosition: Int64;
    minfAtomSize: Int64;
    minfAtomPosition: Int64;
    stblAtomSize: Int64;
    stblAtomPosition: Int64;
    stcoAtomSize: Int64;
    stcoAtomPosition: Int64;
    Version: Byte;
    Flags: DWord;
    NumberOfOffsets: Cardinal;
    OffsetValue: Integer;//DWord;
    i: Cardinal;
    moovIs64BitAtomSize: Boolean;
    trakIs64BitAtomSize: Boolean;
    mdiaIs64BitAtomSize: Boolean;
    minfIs64BitAtomSize: Boolean;
    stblIs64BitAtomSize: Boolean;
    stcoIs64BitAtomSize: Boolean;
begin
    Result := True;
    try
        Version := 0;
        Flags := 0;
        NumberOfOffsets := 0;
        moovAtomSize := 0;
        //moovAtomPosition := 0;
        trakAtomSize := 0;
        //trakAtomPosition := 0;
        mdiaAtomSize := 0;
        //mdiaAtomPosition := 0;
        minfAtomSize := 0;
        //minfAtomPosition := 0;
        stblAtomSize := 0;
        //stblAtomPosition := 0;
        stcoAtomSize := 0;
        //stcoAtomPosition := 0;
        OffsetValue := 0;
        moovIs64BitAtomSize := False;
        trakIs64BitAtomSize := False;
        mdiaIs64BitAtomSize := False;
        minfIs64BitAtomSize := False;
        stblIs64BitAtomSize := False;
        stcoIs64BitAtomSize := False;
        AtomName := ClearAtomName;
        repeat
            ReadAtomHeader(MP4Stream, AtomName, moovAtomSize, moovIs64BitAtomSize);
            if IsSameAtomName(AtomName, 'moov') then begin
                if moovIs64BitAtomSize then begin
                    moovAtomPosition := MP4Stream.Position - 16;
                end else begin
                    moovAtomPosition := MP4Stream.Position - 8;
                end;
                repeat
                    ReadAtomHeader(MP4Stream, AtomName, trakAtomSize, trakIs64BitAtomSize);
                    if IsSameAtomName(AtomName, 'trak') then begin
                        if trakIs64BitAtomSize then begin
                            trakAtomPosition := MP4Stream.Position - 16;
                        end else begin
                            trakAtomPosition := MP4Stream.Position - 8;
                        end;
                        repeat
                            ReadAtomHeader(MP4Stream, AtomName, mdiaAtomSize, mdiaIs64BitAtomSize);
                            if IsSameAtomName(AtomName, 'mdia') then begin
                                if mdiaIs64BitAtomSize then begin
                                    mdiaAtomPosition := MP4Stream.Position - 16;
                                end else begin
                                    mdiaAtomPosition := MP4Stream.Position - 8;
                                end;
                                repeat
                                    ReadAtomHeader(MP4Stream, AtomName, minfAtomSize, minfIs64BitAtomSize);
                                    if IsSameAtomName(AtomName, 'minf') then begin
                                        if minfIs64BitAtomSize then begin
                                            minfAtomPosition := MP4Stream.Position - 16;
                                        end else begin
                                            minfAtomPosition := MP4Stream.Position - 8;
                                        end;
                                        repeat
                                            ReadAtomHeader(MP4Stream, AtomName, stblAtomSize, stblIs64BitAtomSize);
                                            if IsSameAtomName(AtomName, 'stbl') then begin
                                                if stblIs64BitAtomSize then begin
                                                    stblAtomPosition := MP4Stream.Position - 16;
                                                end else begin
                                                    stblAtomPosition := MP4Stream.Position - 8;
                                                end;
                                                repeat
                                                    ReadAtomHeader(MP4Stream, AtomName, stcoAtomSize, stcoIs64BitAtomSize);
                                                    if IsSameAtomName(AtomName, 'stco') then begin
                                                        Result := False;
                                                        if stcoIs64BitAtomSize then begin
                                                            stcoAtomPosition := MP4Stream.Position - 16;
                                                        end else begin
                                                            stcoAtomPosition := MP4Stream.Position - 8;
                                                        end;
                                                        MP4Stream.Read2(Version, 1);
                                                        MP4Stream.Read2(Flags, 3);
                                                        MP4Stream.Read2(NumberOfOffsets, 4);
                                                        NumberOfOffsets := ReverseBytes32(NumberOfOffsets);
                                                        i := 0;
                                                        while MP4Stream.Position < stcoAtomPosition + stcoAtomSize do begin
                                                            MP4Stream.Read2(OffsetValue, 4);
                                                            OffsetValue := ReverseBytes32(OffsetValue);
                                                            OffsetValue := OffsetValue + Offset;
                                                            OffsetValue := ReverseBytes32(OffsetValue);
                                                            MP4Stream.Seek(- 4, soCurrent);
                                                            MP4Stream.Write(OffsetValue, 4);
                                                            Inc(i);
                                                        end;
                                                        if i = NumberOfOffsets then begin
                                                            Result := True;
                                                        end;
                                                    end else begin
                                                        if stcoIs64BitAtomSize then begin
                                                            MP4Stream.Seek(stcoAtomSize - 16, soCurrent);
                                                        end else begin
                                                            MP4Stream.Seek(stcoAtomSize - 8, soCurrent);
                                                        end;
                                                    end;
                                                 until (MP4Stream.Position >= MP4Stream.Size)
                                                OR (MP4Stream.Position >= stblAtomPosition + stblAtomSize);
                                            end else begin
                                                if stblIs64BitAtomSize then begin
                                                    MP4Stream.Seek(stblAtomSize - 16, soCurrent);
                                                end else begin
                                                    MP4Stream.Seek(stblAtomSize - 8, soCurrent);
                                                end;
                                            end;
                                        until (MP4Stream.Position >= MP4Stream.Size)
                                        OR (MP4Stream.Position >= minfAtomPosition + minfAtomSize);
                                    end else begin
                                        if minfIs64BitAtomSize then begin
                                            MP4Stream.Seek(minfAtomSize - 16, soCurrent);
                                        end else begin
                                            MP4Stream.Seek(minfAtomSize - 8, soCurrent);
                                        end;
                                    end;
                                until (MP4Stream.Position >= MP4Stream.Size)
                                OR (MP4Stream.Position >= mdiaAtomPosition + mdiaAtomSize);
                            end else begin
                                if mdiaIs64BitAtomSize then begin
                                    MP4Stream.Seek(mdiaAtomSize - 16, soCurrent);
                                end else begin
                                    MP4Stream.Seek(mdiaAtomSize - 8, soCurrent);
                                end;
                            end;
                        until (MP4Stream.Position >= MP4Stream.Size)
                        OR (MP4Stream.Position >= trakAtomPosition + trakAtomSize);
                    end else begin
                        if trakIs64BitAtomSize then begin
                            MP4Stream.Seek(trakAtomSize - 16, soCurrent);
                        end else begin
                            MP4Stream.Seek(trakAtomSize - 8, soCurrent);
                        end;
                    end;
                until (MP4Stream.Position >= MP4Stream.Size)
                OR (MP4Stream.Position >= moovAtomPosition + moovAtomSize);
            end else begin
                if moovIs64BitAtomSize then begin
                    MP4Stream.Seek(moovAtomSize - 16, soCurrent);
                end else begin
                    MP4Stream.Seek(moovAtomSize - 8, soCurrent);
                end;
            end;
        until (MP4Stream.Position >= MP4Stream.Size)
        OR (moovAtomSize = 0);
    except
        Result := False;
    end;
end;

function MP4Updateco64Atom(MP4Stream: TStream; Offset: Int64): Boolean;
var
    AtomName: TAtomName;
    //AtomSize: Int64;
    moovAtomSize: Int64;
    moovAtomPosition: Int64;
    trakAtomSize: Int64;
    trakAtomPosition: Int64;
    mdiaAtomSize: Int64;
    mdiaAtomPosition: Int64;
    minfAtomSize: Int64;
    minfAtomPosition: Int64;
    stblAtomSize: Int64;
    stblAtomPosition: Int64;
    co64AtomSize: Int64;
    co64AtomPosition: Int64;
    Version: Byte;
    Flags: DWord;
    NumberOfOffsets: Cardinal;
    OffsetValue: Int64;//DWord;
    i: Cardinal;
    moovIs64BitAtomSize: Boolean;
    trakIs64BitAtomSize: Boolean;
    mdiaIs64BitAtomSize: Boolean;
    minfIs64BitAtomSize: Boolean;
    stblIs64BitAtomSize: Boolean;
    co64Is64BitAtomSize: Boolean;
begin
    Result := True;
    try
        Version := 0;
        Flags := 0;
        NumberOfOffsets := 0;
        moovAtomSize := 0;
        //moovAtomPosition := 0;
        trakAtomSize := 0;
        //trakAtomPosition := 0;
        mdiaAtomSize := 0;
        //mdiaAtomPosition := 0;
        minfAtomSize := 0;
        //minfAtomPosition := 0;
        stblAtomSize := 0;
        //stblAtomPosition := 0;
        co64AtomSize := 0;
        //co64AtomPosition := 0;
        OffsetValue := 0;
        moovIs64BitAtomSize := False;
        trakIs64BitAtomSize := False;
        mdiaIs64BitAtomSize := False;
        minfIs64BitAtomSize := False;
        stblIs64BitAtomSize := False;
        co64Is64BitAtomSize := False;
        AtomName := ClearAtomName;
        repeat
            ReadAtomHeader(MP4Stream, AtomName, moovAtomSize, moovIs64BitAtomSize);
            if IsSameAtomName(AtomName, 'moov') then begin
                if moovIs64BitAtomSize then begin
                    moovAtomPosition := MP4Stream.Position - 16;
                end else begin
                    moovAtomPosition := MP4Stream.Position - 8;
                end;
                repeat
                    ReadAtomHeader(MP4Stream, AtomName, trakAtomSize, trakIs64BitAtomSize);
                    if IsSameAtomName(AtomName, 'trak') then begin
                        if trakIs64BitAtomSize then begin
                            trakAtomPosition := MP4Stream.Position - 16;
                        end else begin
                            trakAtomPosition := MP4Stream.Position - 8;
                        end;
                        repeat
                            ReadAtomHeader(MP4Stream, AtomName, mdiaAtomSize, mdiaIs64BitAtomSize);
                            if IsSameAtomName(AtomName, 'mdia') then begin
                                if mdiaIs64BitAtomSize then begin
                                    mdiaAtomPosition := MP4Stream.Position - 16;
                                end else begin
                                    mdiaAtomPosition := MP4Stream.Position - 8;
                                end;
                                repeat
                                    ReadAtomHeader(MP4Stream, AtomName, minfAtomSize, minfIs64BitAtomSize);
                                    if IsSameAtomName(AtomName, 'minf') then begin
                                        if minfIs64BitAtomSize then begin
                                            minfAtomPosition := MP4Stream.Position - 16;
                                        end else begin
                                            minfAtomPosition := MP4Stream.Position - 8;
                                        end;
                                        repeat
                                            ReadAtomHeader(MP4Stream, AtomName, stblAtomSize, stblIs64BitAtomSize);
                                            if IsSameAtomName(AtomName, 'stbl') then begin
                                                if stblIs64BitAtomSize then begin
                                                    stblAtomPosition := MP4Stream.Position - 16;
                                                end else begin
                                                    stblAtomPosition := MP4Stream.Position - 8;
                                                end;
                                                repeat
                                                    ReadAtomHeader(MP4Stream, AtomName, co64AtomSize, co64Is64BitAtomSize);
                                                    if IsSameAtomName(AtomName, 'co64') then begin
                                                        Result := False;
                                                        if co64Is64BitAtomSize then begin
                                                            co64AtomPosition := MP4Stream.Position - 16;
                                                        end else begin
                                                            co64AtomPosition := MP4Stream.Position - 8;
                                                        end;
                                                        MP4Stream.Read2(Version, 1);
                                                        MP4Stream.Read2(Flags, 3);
                                                        MP4Stream.Read2(NumberOfOffsets, 4);
                                                        NumberOfOffsets := ReverseBytes32(NumberOfOffsets);
                                                        i := 0;
                                                        while MP4Stream.Position < co64AtomPosition + co64AtomSize do begin
                                                            MP4Stream.Read2(OffsetValue, 8);
                                                            OffsetValue := ReverseBytes64(OffsetValue);
                                                            OffsetValue := OffsetValue + Offset;
                                                            OffsetValue := ReverseBytes64(OffsetValue);
                                                            MP4Stream.Seek(- 8, soCurrent);
                                                            MP4Stream.Write(OffsetValue, 8);
                                                            Inc(i);
                                                        end;
                                                        if i = NumberOfOffsets then begin
                                                            Result := True;
                                                        end;
                                                    end else begin
                                                        if co64Is64BitAtomSize then begin
                                                            MP4Stream.Seek(co64AtomSize - 16, soCurrent);
                                                        end else begin
                                                            MP4Stream.Seek(co64AtomSize - 8, soCurrent);
                                                        end;
                                                    end;
                                                 until (MP4Stream.Position >= MP4Stream.Size)
                                                OR (MP4Stream.Position >= stblAtomPosition + stblAtomSize);
                                            end else begin
                                                if stblIs64BitAtomSize then begin
                                                    MP4Stream.Seek(stblAtomSize - 16, soCurrent);
                                                end else begin
                                                    MP4Stream.Seek(stblAtomSize - 8, soCurrent);
                                                end;
                                            end;
                                        until (MP4Stream.Position >= MP4Stream.Size)
                                        OR (MP4Stream.Position >= minfAtomPosition + minfAtomSize);
                                    end else begin
                                        if minfIs64BitAtomSize then begin
                                            MP4Stream.Seek(minfAtomSize - 16, soCurrent);
                                        end else begin
                                            MP4Stream.Seek(minfAtomSize - 8, soCurrent);
                                        end;
                                    end;
                                until (MP4Stream.Position >= MP4Stream.Size)
                                OR (MP4Stream.Position >= mdiaAtomPosition + mdiaAtomSize);
                            end else begin
                                if mdiaIs64BitAtomSize then begin
                                    MP4Stream.Seek(mdiaAtomSize - 16, soCurrent);
                                end else begin
                                    MP4Stream.Seek(mdiaAtomSize - 8, soCurrent);
                                end;
                            end;
                        until (MP4Stream.Position >= MP4Stream.Size)
                        OR (MP4Stream.Position >= trakAtomPosition + trakAtomSize);
                    end else begin
                        if trakIs64BitAtomSize then begin
                            MP4Stream.Seek(trakAtomSize - 16, soCurrent);
                        end else begin
                            MP4Stream.Seek(trakAtomSize - 8, soCurrent);
                        end;
                    end;
                until (MP4Stream.Position >= MP4Stream.Size)
                OR (MP4Stream.Position >= moovAtomPosition + moovAtomSize);
            end else begin
                if moovIs64BitAtomSize then begin
                    MP4Stream.Seek(moovAtomSize - 16, soCurrent);
                end else begin
                    MP4Stream.Seek(moovAtomSize - 8, soCurrent);
                end;
            end;
        until (MP4Stream.Position >= MP4Stream.Size)
        OR (moovAtomSize = 0);
    except
        Result := False;
    end;
end;

procedure GetmdatAtom(MP4Stream: TStream; out Position, Size: Int64);
var
    PreviousPosition: Int64;
    AtomName: TAtomName;
    AtomSize: Int64;
    Is64BitAtomSize: Boolean;
begin
    Position := - 1;
    Size := 0;
    AtomName := ClearAtomName;
    AtomSize := 0;
    Is64BitAtomSize := False;
    try
        PreviousPosition := MP4Stream.Position;
        try
            MP4Stream.Seek(0, soBeginning);
            repeat
                ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize, False);
                if Is64BitAtomSize then begin
                    if IsSameAtomName(AtomName, 'mdat') then begin
                        Position := MP4Stream.Position - 16;
                        Size := AtomSize;
                        Exit;
                    end else begin
                        MP4Stream.Seek(AtomSize - 16, soCurrent);
                    end;
                end else begin
                    if IsSameAtomName(AtomName, 'mdat') then begin
                        Position := MP4Stream.Position - 8;
                        Size := AtomSize;
                        Exit;
                    end else begin
                        MP4Stream.Seek(AtomSize - 8, soCurrent);
                    end;
                end;
            until (MP4Stream.Position >= MP4Stream.Size)
            OR (AtomSize = 0)
            OR ((AtomName[0] = 0) AND (AtomName[1] = 0) AND (AtomName[2] = 0) AND (AtomName[3] = 0));
        finally
            MP4Stream.Seek(PreviousPosition, soBeginning);
        end;
    except
        Position := - 1;
        Size := 0;
    end;
end;

function GetPlayTime(MP4Stream: TStream): Double;
var
    AtomName: TAtomName;
    AtomSize: Int64;
    Version: Byte;
    TimeScale: Cardinal;
    Duration4: Cardinal;
    Duration8: UInt64;
    moovAtomSize: Int64;
    Is64BitAtomSize: Boolean;
    PreviousPosition: Int64;
begin
    Result := 0;
    PreviousPosition := MP4Stream.Position;
    AtomName := ClearAtomName;
    AtomSize := 0;
    Is64BitAtomSize := False;
    moovAtomSize := 0;
    Version := 0;
    TimeScale := 0;
    Duration4 := 0;
    Duration8 := 0;
    try
        try
            MP4Stream.Seek(0, soBeginning);
            try
                ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize, False);
            except
                //* Will except if not an MP4 file and MP4TagLibraryFailOnCorruptFile is True
            end;
            if NOT IsSameAtomName(AtomName, 'ftyp') then begin
                Exit;
            end;
            //* Continue loading
            MP4Stream.Seek(AtomSize - 8, soCurrent);
            repeat
                ReadAtomHeader(MP4Stream, AtomName, moovAtomSize, Is64BitAtomSize);
                if IsSameAtomName(AtomName, 'moov') then begin
                    repeat
                        ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                        if IsSameAtomName(AtomName, 'mvhd') then begin
                            MP4Stream.Read2(Version, 1);
                            MP4Stream.Seek(3, soCurrent);
                            if Version = 1 then begin
                                MP4Stream.Seek(8, soCurrent);
                                MP4Stream.Seek(8, soCurrent);
                                MP4Stream.Read2(TimeScale, 4);
                                TimeScale := ReverseBytes32(TimeScale);
                                MP4Stream.Read2(Duration8, 8);
                                Duration8 := ReverseBytes64(Duration8);
                                if (TimeScale <> 0)
                                AND (Duration8 <> 0)
                                then begin
                                    Result := (Duration8 / TimeScale);
                                end;
                            end else begin
                                MP4Stream.Seek(4, soCurrent);
                                MP4Stream.Seek(4, soCurrent);
                                MP4Stream.Read2(TimeScale, 4);
                                TimeScale := ReverseBytes32(TimeScale);
                                MP4Stream.Read2(Duration4, 4);
                                Duration4 := ReverseBytes32(Duration4);
                                if (TimeScale <> 0)
                                AND (Duration4 <> 0)
                                then begin
                                    Result := (Duration4 / TimeScale);
                                end;
                            end;
                            Exit;
                        end else begin
                            if Is64BitAtomSize then begin
                                MP4Stream.Seek(AtomSize - 16, soCurrent);
                            end else begin
                                MP4Stream.Seek(AtomSize - 8, soCurrent);
                            end;
                        end;
                    until MP4Stream.Position >= MP4Stream.Size;
                end else begin
                    if Is64BitAtomSize then begin
                        MP4Stream.Seek(moovAtomSize - 16, soCurrent);
                    end else begin
                        MP4Stream.Seek(moovAtomSize - 8, soCurrent);
                    end;
                end;
            until (MP4Stream.Position >= MP4Stream.Size)
            OR (moovAtomSize = 0);
        except
            Result := 0;
        end;
    finally
        MP4Stream.Seek(PreviousPosition, soBeginning);
    end;
end;

function MediaTypeToStr(Value: Integer): string;
begin
    Result := '';
    case Value of
        0: Result := 'Movie';
        1: Result := 'Music';
        2: Result := 'Audiobook';
        6: Result := 'Music Video';
        9: Result := 'Movie';
        10: Result := 'TV Show';
        11: Result := 'Booklet';
        14: Result := 'Ringtone';
    end;
end;

function ReadAtomHeader(MP4Stream: TStream; var AtomName: TAtomName; var AtomSize: Int64; var Is64BitSize: Boolean; FailOnCurrupt: Boolean = True): Boolean;
var
    AtomSize32LE: DWord;
    AtomSize64: UInt64;
    RemainingFileSpace: Int64;
begin
    Result := False;
    if MP4Stream.Position >= MP4Stream.Size then begin
        Exit;
    end;
    Is64BitSize := False;
    FillChar(AtomName, SizeOf(AtomName), 0);
    AtomSize32LE := 0;
    AtomSize := 0;
    MP4Stream.Read2(AtomSize32LE, 4);
    MP4Stream.Read2(AtomName, 4);
    AtomSize := ReverseBytes32(AtomSize32LE);
    //* 64 bit
    if AtomSize = 1 then begin
        MP4Stream.Read2(AtomSize64, 8);
        AtomSize := ReverseBytes64(AtomSize64);
        Is64BitSize := True;
    end;
    if FailOnCurrupt
    OR MP4TagLibraryFailOnCorruptFile
    then begin
        RemainingFileSpace := MP4Stream.Size - MP4Stream.Position + 8;
        if Is64BitSize then begin
            RemainingFileSpace := RemainingFileSpace + 8;
        end;
        if (AtomSize < 8)
        OR (AtomSize > RemainingFileSpace)
        then begin
            raise Exception.Create('Corrupted MP4 file. Atom name: ' + AtomNameToString(AtomName));
        end;
    end;
    Result := True;
end;

function WriteAtomHeader(MP4Stream: TStream; AtomName: TAtomName; AtomSize: Int64): Boolean;
var
    AtomSize32: DWord;
    AtomSize32LE: DWord;
    AtomSize64: UInt64;
begin
    Result := False;
    try
        //* 32 bit
        if AtomSize <= High(Cardinal) then begin
            AtomSize32 := Cardinal(AtomSize);
            AtomSize32LE := ReverseBytes32(AtomSize32);
            MP4Stream.Write(AtomSize32LE, 4);
            MP4Stream.Write(AtomName, 4);
        //* 64 bit
        end else begin
            AtomSize32LE := ReverseBytes32(1);
            MP4Stream.Write(AtomSize32LE, 4);
            MP4Stream.Write(AtomName, 4);
            AtomSize64 := ReverseBytes64(AtomSize);
            MP4Stream.Write(AtomSize64, 8);
        end;
        Result := True;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

function WriteAtomHeader(MP4Stream: TStream; AtomName: String; AtomSize: Int64): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := WriteAtomHeader(MP4Stream, AtomID, AtomSize);
end;

{TMP4Atommean}

Constructor TMP4Atommean.Create;
begin
    Inherited;
    Data := TMemoryStream.Create;
end;

Destructor TMP4Atommean.Destroy;
begin
    FreeAndNil(Data);
    Inherited;
end;

function TMP4Atommean.GetAsText: String;
var
    Bytes: TBytes;
begin
    Result := '';
    if Data.Size < 4 then begin
        Exit;
    end;
    Data.Seek(4, soBeginning);
    SetLength(Bytes, Data.Size - 4);
    Data.Read(Bytes[0], Data.Size - 4);
    Data.Seek(0, soBeginning);
    {$IFDEF FPC}
    SetLength(Result, Length(Bytes));
    Move(Bytes[0], Result[1], Length(Bytes));
    {$ELSE}
    Result := TEncoding.UTF8.GetString(Bytes);
    {$ENDIF}
    AlreadyParsed := True;
end;

function TMP4Atommean.SetAsText(const Text: String): Boolean;
var
    Zero: DWord;
    Bytes: TBytes;
begin
    Data.Clear;
    if Text = '' then begin
        Result := True;
        Exit;
    end;
    {$IFDEF FPC}
    SetLength(Bytes, Length(Text));
    Move(Text[1], Bytes[0], Length(Text));
    {$ELSE}
    Bytes := TEncoding.UTF8.GetBytes(Text);
    {$ENDIF}
    Zero := 0;
    Data.Write(Zero, 4);
    Data.Write(Bytes[0], Length(Bytes));
    Data.Seek(0, soBeginning);
    Result := True;
end;

procedure TMP4Atommean.Clear;
begin
    Data.Clear;
end;

function TMP4Atommean.Write(MP4Stream: TStream): Boolean;
var
    AtomSize: DWord;
    AtomSizeLE: DWord;
begin
    Result := False;
    try
        if Data.Size > 0 then begin
            AtomSize := Data.Size + 8;
            AtomSizeLE := ReverseBytes32(AtomSize);
            MP4Stream.Write(AtomSizeLE, 4);
            MP4Stream.Write(MP4AtommeanID, 4);
            Data.Seek(0, soBeginning);
            MP4Stream.CopyFrom(Data, Data.Size);
            Data.Seek(0, soBeginning);
            Result := True;
        end;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

function TMP4Atommean.Assign(MP4Atommean: TMP4Atommean): Boolean;
begin
    Clear;
    if MP4Atommean <> nil then begin
        MP4Atommean.Data.Seek(0, soBeginning);
        Data.CopyFrom(MP4Atommean.Data, MP4Atommean.Data.Size);
        MP4Atommean.Data.Seek(0, soBeginning);
    end;
    Result := True;
end;

{TMP4Atomname}

Constructor TMP4Atomname.Create;
begin
    Inherited;
    Data := TMemoryStream.Create;
end;

Destructor TMP4Atomname.Destroy;
begin
    FreeAndNil(Data);
    Inherited;
end;

function TMP4Atomname.GetAsText: String;
var
    Bytes: TBytes;
begin
    Result := '';
    if Data.Size < 4 then begin
        Exit;
    end;
    Data.Seek(4, soBeginning);
    SetLength(Bytes, Data.Size - 4);
    Data.Read(Bytes[0], Data.Size - 4);
    Data.Seek(0, soBeginning);
    {$IFDEF FPC}
    SetLength(Result, Length(Bytes));
    Move(Bytes[0], Result[1], Length(Bytes));
    {$ELSE}
    Result := TEncoding.UTF8.GetString(Bytes);
    {$ENDIF}
    AlreadyParsed := True;
end;

function TMP4Atomname.SetAsText(const Text: String): Boolean;
var
    Zero: DWord;
    Bytes: TBytes;
begin
    Data.Clear;
    if Text = '' then begin
        Result := True;
        Exit;
    end;
    {$IFDEF FPC}
    SetLength(Bytes, Length(Text));
    Move(Text[1], Bytes[0], Length(Text));
    {$ELSE}
    Bytes := TEncoding.UTF8.GetBytes(Text);
    {$ENDIF}
    Zero := 0;
    Data.Write(Zero, 4);
    Data.Write(Bytes[0], Length(Bytes));
    Data.Seek(0, soBeginning);
    Result := True;
end;

procedure TMP4Atomname.Clear;
begin
    Data.Clear;
end;

function TMP4Atomname.Write(MP4Stream: TStream): Boolean;
var
    AtomSize: DWord;
    AtomSizeLE: DWord;
begin
    Result := False;
    try
        if Data.Size > 0 then begin
            AtomSize := Data.Size + 8;
            AtomSizeLE := ReverseBytes32(AtomSize);
            MP4Stream.Write(AtomSizeLE, 4);
            MP4Stream.Write(MP4AtomnameID, 4);
            Data.Seek(0, soBeginning);
            MP4Stream.CopyFrom(Data, Data.Size);
            Data.Seek(0, soBeginning);
            Result := True;
        end;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

function TMP4Atomname.Assign(MP4Atomname: TMP4Atomname): Boolean;
begin
    Clear;
    if MP4Atomname <> nil then begin
        MP4Atomname.Data.Seek(0, soBeginning);
        Data.CopyFrom(MP4Atomname.Data, MP4Atomname.Data.Size);
        MP4Atomname.Data.Seek(0, soBeginning);
    end;
    Result := True;
end;

{TMP4AtomData}

Constructor TMP4AtomData.Create;
begin
    Inherited;
    Data := TMemoryStream.Create;
end;

Destructor TMP4AtomData.Destroy;
begin
    FreeAndNil(Data);
    Inherited;
end;

function TMP4AtomData.GetAsBytes: TBytes;
begin
    SetLength(Result, Data.Size);
    if Data.Size = 0 then
        Exit;
    Data.Seek(0, soBeginning);
    Data.Read(Result[0], Data.Size);
    Data.Seek(0, soBeginning);
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsText: String;
var
    Bytes: TBytes;
begin
    Result := '';
    if (DataType <> 1)
    OR (Data.Size = 0)
    then begin
        Exit;
    end;
    Data.Seek(0, soBeginning);
    SetLength(Bytes, Data.Size);
    Data.Read(Bytes[0], Data.Size);
    Data.Seek(0, soBeginning);
    {$IFDEF FPC}
    SetLength(Result, Length(Bytes));
    Move(Bytes[0], Result[1], Length(Bytes));
    {$ELSE}
    Result := TEncoding.UTF8.GetString(Bytes);
    {$ENDIF}
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsInteger(out Value: UInt64): Boolean;
var
    LowDWord: DWord;
    HighDWord: DWord;
    HighWord: Word;
begin
    Result := True;
    Value := 0;
    LowDWord := 0;
    HighDWord := 0;
    HighWord := 0;
    case Data.Size of
        1: Value := GetAsInteger8;
        2: Value := GetAsInteger16;
        4: Value := GetAsInteger32;
        6: Result := GetAsInteger48(LowDWord, HighWord, Value);
        8: Result := GetAsInteger64(LowDWord, HighDWord, Value);
        else Result := False;
    end;
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsInteger8: Byte;
begin
    Result := 0;
    if (DataType <> 0)
    AND (DataType <> 21)
    then begin
        Exit;
    end;
    Data.Seek(0, soBeginning);
    Data.Read2(Result, 1);
    Data.Seek(0, soBeginning);
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsList(List: TStrings): Boolean;
var
    DataByte: Byte;
    Bytes: TBytes;
    Name: String;
    Value: String;
    ByteCounter: Integer;
begin
    Result := False;
    List.Clear;
    if DataType <> 1 then begin
        Exit;
    end;
    DataByte := 0;
    Data.Seek(0, soBeginning);
    while Data.Position < Data.Size do begin
        SetLength(Bytes, 0);
        ByteCounter := 0;
        repeat
            Data.Read2(DataByte, 1);
            if DataByte = $0D then begin
                Data.Read2(DataByte, 1);
                if DataByte = $0A then begin
                    Break;
                end;
            end;
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := DataByte;
            Inc(ByteCounter);
        until Data.Position >= Data.Size;
        {$IFDEF FPC}
        SetLength(Name, Length(Bytes));
        Move(Bytes[0], Name[1], Length(Bytes));
        {$ELSE}
        Name := TEncoding.UTF8.GetString(Bytes);
        {$ENDIF}
        SetLength(Bytes, 0);
        ByteCounter := 0;
        repeat
            Data.Read2(DataByte, 1);
            if DataByte = $0D then begin
                Data.Read2(DataByte, 1);
                if DataByte = $0A then begin
                    Break;
                end;
            end;
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := DataByte;
            Inc(ByteCounter);
        until Data.Position >= Data.Size;

        {$IFDEF FPC}
        SetLength(Value, Length(Bytes));
        Move(Bytes[0], Value[1], Length(Bytes));
        {$ELSE}
        Value := TEncoding.UTF8.GetString(Bytes);
        {$ENDIF}
        List.Append(Name + '=' + Value);
        Result := True;
    end;
    Data.Seek(0, soBeginning);
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsInteger16: Word;
begin
    Result := 0;
    if (DataType <> 0)
    AND (DataType <> 21)
    then begin
        Exit;
    end;
    Data.Seek(0, soBeginning);
    Data.Read2(Result, 2);
    Data.Seek(0, soBeginning);
    Result := ReverseBytes16(Result);
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsInteger32: DWord;
begin
    Result := 0;
    if (DataType <> 0)
    AND (DataType <> 21)
    then begin
        Exit;
    end;
    Data.Seek(0, soBeginning);
    Data.Read2(Result, 4);
    Data.Seek(0, soBeginning);
    if Data.Size = 4 then begin
        Result := ReverseBytes32(Result);
    end;
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsInteger48(var LowDWord: DWord; var HighWord: Word; out Value: UInt64): Boolean;
begin
    Value := 0;
    LowDWord := 0;
    HighWord := 0;
    Result := (DataType = 0) OR (DataType = 21);
    if (DataType <> 0)
    AND (DataType <> 21)
    then begin
        Exit;
    end;
    Data.Seek(0, soBeginning);
    Data.Read2(HighWord, 2);
    Data.Read2(LowDWord, 4);
    Data.Seek(0, soBeginning);
    HighWord := ReverseBytes16(HighWord);
    LowDWord := ReverseBytes32(LowDWord);
    Value := MakeUInt64(LowDWord, HighWord);
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsInteger64(var LowDWord, HighDWord: DWord; out Value: UInt64): Boolean;
begin
    Value := 0;
    LowDWord := 0;
    HighDWord := 0;
    Result := (DataType = 0) OR (DataType = 21);
    if (DataType <> 0)
    AND (DataType <> 21)
    then begin
        Exit;
    end;
    Data.Seek(0, soBeginning);
    Data.Read2(Value, 8);
    Data.Seek(0, soBeginning);
    Value := ReverseBytes64(Value);
    HighDWord := HighDWordOfUInt64(Value);
    LowDWord := LowDWordOfUInt64(Value);
    AlreadyParsed := True;
end;

function TMP4AtomData.GetAsBool: Boolean;
var
    Value: Byte;
begin
    Value := GetAsInteger8;
    if Value = 0 then begin
        Result := False;
    end else begin
        Result := True;
    end;
    AlreadyParsed := True;
end;

function TMP4AtomData.SetAsText(const Text: String): Boolean;
var
    Bytes: TBytes;
begin
    {$IFDEF FPC}
    SetLength(Bytes, Length(Text));
    Move(Text[1], Bytes[0], Length(Text));
    {$ELSE}
    Bytes := TEncoding.UTF8.GetBytes(Text);
    {$ENDIF}
    Data.Clear;
    Data.Write(Bytes[0], Length(Bytes));
    Data.Seek(0, soBeginning);
    DataType := 1;
    Result := True;
end;

function TMP4AtomData.SetAsInteger8(Value: Byte): Boolean;
begin
    DataType := 0;
    Data.Clear;
    Data.Write(Value, 1);
    Data.Seek(0, soBeginning);
    Result := True;
end;

function TMP4AtomData.SetAsList(List: TStrings): Boolean;
var
    i: Integer;
    DataByte: Byte;
    BytesName: TBytes;
    BytesValue: TBytes;
begin
    Data.Clear;
    for i := 0 to List.Count - 1 do begin
        {$IFDEF FPC}
        SetLength(BytesName, Length(List.Names[i]));
        Move(List.Names[i][1], BytesName[0], Length(List.Names[i]));
        {$ELSE}
        BytesName := TEncoding.UTF8.GetBytes(List.Names[i]);
        {$ENDIF}
        {$IFDEF FPC}
        SetLength(BytesValue, Length(List.ValueFromIndex[i]));
        Move(List.ValueFromIndex[i][1], BytesValue[0], Length(List.ValueFromIndex[i]));
        {$ELSE}
        BytesValue := TEncoding.UTF8.GetBytes(List.ValueFromIndex[i]);
        {$ENDIF}
        Data.Write(BytesName[0], Length(BytesName));
        DataByte := $0D;
        Data.Write(DataByte, 1);
        DataByte := $0A;
        Data.Write(DataByte, 1);
        Data.Write(BytesValue[0], Length(BytesValue));
        DataByte := $0D;
        Data.Write(DataByte, 1);
        DataByte := $0A;
        Data.Write(DataByte, 1);
    end;
    Data.Seek(0, soBeginning);
    DataType := 1;
    Result := True;
end;

function TMP4AtomData.SetAsInteger16(Value: Word): Boolean;
begin
    DataType := 0;
    Data.Clear;
    Value := ReverseBytes16(Value);
    Data.Write(Value, 2);
    Data.Seek(0, soBeginning);
    Result := True;
end;

function TMP4AtomData.SetAsInteger32(Value: DWord): Boolean;
begin
    DataType := 0;
    Data.Clear;
    Value := ReverseBytes32(Value);
    Data.Write(Value, 4);
    Data.Seek(0, soBeginning);
    Result := True;
end;

function TMP4AtomData.SetAsInteger48(Value: UInt64): Boolean;
var
    LowDWord: DWord;
    HiWord: Word;
begin
    LowDWord := LowDWordOfUInt64(Value);
    HiWord := HighDWordOfUInt64(Value);
    Result := SetAsInteger48(LowDWord, HiWord);
end;

function TMP4AtomData.SetAsInteger48(LowDWord: DWord; HighWord: Word): Boolean;
begin
    DataType := 0;
    Data.Clear;
    LowDWord := ReverseBytes32(LowDWord);
    HighWord := ReverseBytes16(HighWord);
    Data.Write(HighWord, 2);
    Data.Write(LowDWord, 4);
    Data.Seek(0, soBeginning);
    Result := True;
end;

function TMP4AtomData.SetAsInteger64(Value: UInt64): Boolean;
var
    LowDWord: DWord;
    HighDWord: DWord;
begin
    LowDWord := LowDWordOfUInt64(Value);
    HighDWord := HighDWordOfUInt64(Value);
    Result := SetAsInteger64(LowDWord, HighDWord);
end;

function TMP4AtomData.SetAsInteger64(LowDWord, HighDWord: DWord): Boolean;
var
    DataLE: UInt64;
    Value: UInt64;
begin
    DataType := 0;
    Data.Clear;
    Value := HighDWord;
    Value := Value SHL 32;
    Value := Value OR LowDWord;
    DataLE := ReverseBytes64(Value);
    Data.Write(DataLE, 8);
    Data.Seek(0, soBeginning);
    Result := True;
end;

function TMP4AtomData.SetAsBool(Value: Boolean): Boolean;
var
    DataByte: Byte;
begin
    DataByte := Byte(Value);
    Result := SetAsInteger8(DataByte);
end;

procedure TMP4AtomData.Clear;
begin
    DataType := 0;
    Data.Clear;
end;

function TMP4AtomData.Delete: Boolean;
begin
    Result := Parent.DeleteData(Self.Index);
end;

function TMP4AtomData.Assign(MP4AtomData: TMP4AtomData): Boolean;
begin
    Clear;
    if MP4AtomData <> nil then begin
        DataType := MP4AtomData.DataType;
        Reserved := MP4AtomData.Reserved;
        MP4AtomData.Data.Seek(0, soBeginning);
        Data.CopyFrom(MP4AtomData.Data, MP4AtomData.Data.Size);
        MP4AtomData.Data.Seek(0, soBeginning);
    end;
    Result := True;
end;

function TMP4AtomData.Write(MP4Stream: TStream): Boolean;
var
    AtomSize: DWord;
    AtomSizeLE: DWord;
    DataTypeLE: DWord;
begin
    Result := False;
    try
        //if Data.Size > 0 then begin
            AtomSize := Data.Size + 16;
            AtomSizeLE := ReverseBytes32(AtomSize);
            MP4Stream.Write(AtomSizeLE, 4);
            MP4Stream.Write(MP4AtomDataID, 4);
            DataTypeLE := ReverseBytes32(DataType);
            MP4Stream.Write(DataTypeLE, 4);
            MP4Stream.Write(Reserved, 4);
            Data.Seek(0, soBeginning);
            MP4Stream.CopyFrom(Data, Data.Size);
            Data.Seek(0, soBeginning);
            Result := True;
        //end;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

{TMP4Atom}

Constructor TMP4Atom.Create;
begin
    Inherited;
    mean := TMP4Atommean.Create;
    name := TMP4Atomname.Create;
end;

Destructor TMP4Atom.Destroy;
begin
    Clear;
    FreeAndNil(mean);
    FreeAndNil(name);
    FillChar(ID, SizeOf(ID), 0);
    Inherited;
end;

function TMP4Atom.GetAsText: String;
var
    Value: UInt64;
begin
    Result := '';
    if Length(Datas) < 1 then begin
        Exit;
    end;
    if Datas[0].DataType = 1 then begin
        Result := Datas[0].GetAsText;
    end else begin
        if Datas[0].GetAsInteger(Value) then begin
            {$IFDEF FPC}
            Result := IntToStr(Value);
            {$ELSE}
            Result := UIntToStr(Value);
            {$ENDIF}
        end;
    end;
    AlreadyParsed := True;
end;

function TMP4Atom.GetIndex: Integer;
begin
    Result := Self.Parent.Atoms.IndexOf(Self);
end;

procedure TMP4Atom.ReSetAlreadyParsedState;
var
    i: Integer;
begin
    for i := Low(Datas) to High(Datas) do begin
        Datas[i].AlreadyParsed := False;
    end;
end;

function TMP4Atom.GetAsInteger(out Value: UInt64): Boolean;
begin
    Result := False;
    Value := 0;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsInteger(Value);
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsInteger8: Byte;
begin
    Result := 0;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsInteger8;
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsList(List: TStrings): Boolean;
begin
    Result := False;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsList(List);
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsInteger16: Word;
begin
    Result := 0;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsInteger16;
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsInteger32: DWord;
begin
    Result := 0;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsInteger32;
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsInteger48(var LowDWord: DWord; HiWord: Word; out Value: UInt64): Boolean;
begin
    Result := False;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsInteger48(LowDWord, HiWord, Value);
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsInteger64(var LowDWord, HiDWord: DWord; out Value: UInt64): Boolean;
begin
    Result := False;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsInteger64(LowDWord, HiDWord, Value);
    AlreadyParsed := True;
end;

function TMP4Atom.GetAsBool: Boolean;
begin
    Result := False;
    if Length(Datas) < 1 then begin
        Exit;
    end;
    Result := Datas[0].GetAsBool;
    AlreadyParsed := True;
end;

function TMP4Atom.SetAsText(const Text: String): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsText(Text);
end;

function TMP4Atom.SetAsInteger8(Value: Byte): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger8(Value);
end;

function TMP4Atom.SetAsList(List: TStrings): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsList(List);
end;

function TMP4Atom.SetAsInteger16(Value: Word): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger16(Value);
end;

function TMP4Atom.SetAsInteger32(Value: DWord): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger32(Value);
end;

function TMP4Atom.SetAsInteger48(Value: UInt64): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger48(Value);
end;

function TMP4Atom.SetAsInteger48(LowDWord: DWord; HiWord: Word): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger48(LowDWord, HiWord);
end;

function TMP4Atom.SetAsInteger64(Value: UInt64): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger64(Value);
end;

function TMP4Atom.SetAsInteger64(LowDWord, HiDWord: DWord): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsInteger64(LowDWord, HiDWord);
end;

function TMP4Atom.SetAsBool(Value: Boolean): Boolean;
begin
    if Count = 0 then begin
        AddData;
    end;
    Result := Datas[0].SetAsBool(Value);
end;

function TMP4Atom.GetAsCommonText(var _name: String; var _mean: String): String;
begin
    _name := Self.name.GetAsText;
    _mean := Self.mean.GetAsText;
    Result := Self.GetAsText;
    AlreadyParsed := True;
end;

function TMP4Atom.SetAsCommonText(const _name: String; const _mean: String; const Value: String): Boolean;
begin
    Result := Self.name.SetAsText(_name)
        AND Self.mean.SetAsText(_mean)
        AND Self.SetAsText(Value);
end;

function TMP4Atom.AddData: TMP4AtomData;
begin
    Result := nil;
    try
        SetLength(Datas, Length(Datas) + 1);
        Datas[Length(Datas) - 1] := TMP4AtomData.Create;
        Datas[Length(Datas) - 1].Parent := Self;
        Datas[Length(Datas) - 1].Index := Length(Datas) - 1;
        Result := Datas[Length(Datas) - 1];
    except
        On E: exception do begin
            //*
        end;
    end;
end;

function TMP4Atom.Count: Integer;
begin
    Result := Length(Datas);
end;

procedure TMP4Atom.Clear;
var
    i: Integer;
begin
    for i := 0 to Length(Datas) - 1 do begin
        Datas[i].Clear;
        FreeAndNil(Datas[i]);
    end;
    SetLength(Datas, 0);
    mean.Clear;
    name.Clear;
end;

function TMP4Atom.CalculateAtomSize: Cardinal;
var
    i: Integer;
begin
    Result := 0;
    if mean.Data.Size > 0 then begin
        Result := Result + mean.Data.Size + 8;
    end;
    if name.Data.Size > 0 then begin
        Result := Result + name.Data.Size + 8;
    end;
    for i := 0 to Length(Datas) - 1 do begin
        //if Datas[i].Data.Size > 0 then begin
            Result := Result + Datas[i].Data.Size + 16;
        //end;
    end;
    Result := Result + 8;
end;

function TMP4Atom.Write(MP4Stream: TStream): Boolean;
var
    AtomSizeLE: DWord;
    i: Integer;
begin
    Result := False;
    try
        AtomSizeLE := ReverseBytes32(CalculateAtomSize);
        //if AtomSizeLE > 0 then begin
            MP4Stream.Write(AtomSizeLE, 4);
            MP4Stream.Write(ID, 4);
            if mean.Data.Size > 0 then begin
                mean.Write(MP4Stream);
            end;
            if name.Data.Size > 0 then begin
                name.Write(MP4Stream);
            end;
            for i := 0 to Count - 1 do begin
                Datas[i].Write(MP4Stream);
            end;
            Result := True;
        //end;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

procedure TMP4Atom.Delete;
begin
    Parent.DeleteAtom(Self.Index);
end;

function TMP4Atom.DeleteData(AtomIndex: Integer): Boolean;
begin
    Result := False;
    if (AtomIndex >= Length(Datas))
    OR (AtomIndex < 0)
    then begin
        Exit;
    end;
    FreeAndNil(Datas[AtomIndex]);
    CompactAtomDataList;
    Result := True;
end;

function TMP4Atom.Deletemean: Boolean;
begin
    mean.Clear;
    Result := True;
end;

function TMP4Atom.Deletename: Boolean;
begin
    name.Clear;
    Result := True;
end;

procedure TMP4Atom.CompactAtomDataList;
var
    i: Integer;
    Compacted: Boolean;
begin
    Compacted := False;
    if Datas[Length(Datas) - 1]  = nil then begin
        Compacted := True;
    end else begin
        for i := 0 to Length(Datas) - 2 do begin
            if Datas[i] = nil then begin
                Datas[i] := Datas[i + 1];
                Datas[i].Index := i;
                Datas[i + 1] := nil;
                Compacted := True;
            end;
        end;
    end;
    if Compacted then begin
        SetLength(Datas, Length(Datas) - 1);
    end;
end;

function TMP4Atom.Assign(MP4Atom: TMP4Atom): Boolean;
var
    i: Integer;
begin
    Clear;
    if MP4Atom <> nil then begin
        ID := MP4Atom.ID;
        Flags := MP4Atom.Flags;
        for i := 0 to MP4Atom.Count - 1 do begin
            AddData.Assign(MP4Atom.Datas[i]);
        end;
        mean.Assign(MP4Atom.mean);
        name.Assign(MP4Atom.name);
    end;
    Result := True;
end;

{TMP4Tag}

Constructor TMP4Tag.Create;
begin
    Inherited;
    Atoms := TList<TMP4Atom>.Create;
    Atoms.Capacity := 256;
    Xtras := TList<TMP4Xtra>.Create;
    Xtras.Capacity := 256;
    Clear;
    PaddingToWrite := MP4TagLibraryDefaultPaddingSize;
    ParseXtra := MP4TagLibraryParseXtra;
    XtraUsageConversion := MP4TagLibraryXtraUsageConversion;
    XtraPriority := MP4TagLibraryXtraPriority;
    ParseCoverArts := True;
end;

Destructor TMP4Tag.Destroy;
begin
    Clear;
    FreeAndNil(Xtras);
    FreeAndNil(Atoms);
    Inherited;
end;

function TMP4Tag.LoadFromFile(MP4FileName: String): Integer;
var
    MP4Stream: TFileStream;
begin
    Clear;
    FLoaded := False;
    Self.FileName := MP4FileName;
    try
        MP4Stream := TFileStream.Create(MP4FileName, fmOpenRead OR fmShareDenyWrite);
    except
        Result := MP4TAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        Result := LoadFromStream(MP4Stream);
    finally
        FreeAndNil(MP4Stream);
    end;
end;

procedure TMP4Tag._GetIvanParameters (MP4Stream : TStream);
var aWidth, aHeight : Word;
    MP4Stream_Size  : Int64;
    AtomName        : TAtomName;
    AtomSize        : Int64;
    Is64BitAtomSize : boolean;

   procedure SkipAtom;
   begin
      if Is64BitAtomSize then MP4Stream.Seek (AtomSize - 16, soCurrent)
      else                    MP4Stream.Seek (AtomSize -  8, soCurrent);
   end;

   procedure ParseTrakForVideoParams;
   begin
      repeat
         ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
         if IsSameAtomName(AtomName, 'tkhd') then
         begin
            MP4Stream.Seek (76, soCurrent);
            MP4Stream.Read (aWidth,  2);
            aWidth := Swap (aWidth);
            MP4Stream.Read (aHeight, 2);
            MP4Stream.Read (aHeight, 2);
            aHeight := Swap (aHeight);
            if (FVideoWidth<=aWidth) and (FVideoHeight<=aHeight) then
            begin
               FVideoWidth  := aWidth;
               FVideoHeight := aHeight;
            end;
            Exit;
         end
         else SkipAtom;
      until MP4Stream.Position >= MP4Stream_Size;
   end;

   procedure ParseTrakForAudioParams;
   var _NumberOfDescriptions : Cardinal;
       _AudioChannels        : Word;
       _SampleSize           : Word;
       _SampleRate           : Cardinal;
       {
       Version: Byte;
       dateAndDurationValues: Byte;
       Lang: Byte;
       }
   begin
      _NumberOfDescriptions := 0;
      _AudioChannels := 0;
      _SampleSize := 0;
      _SampleRate := 0;
      repeat
         ReadAtomHeader (MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
         if IsSameAtomName (AtomName, 'mdia') then
         begin
            repeat
               ReadAtomHeader (MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
               (*
               if IsSameAtomName (AtomName, 'mdhd') then begin
                    MP4Stream.Read (Version, 1);
                    if Version = 1 then begin
                        dateAndDurationValues := 8;
                    end else begin
                        dateAndDurationValues := 4;
                    end;
                    MP4Stream.Seek (3, soCurrent);
                    MP4Stream.Seek (dateAndDurationValues * 2, soCurrent);
                    MP4Stream.Seek (4, soCurrent);
                    MP4Stream.Seek (dateAndDurationValues, soCurrent);
                    MP4Stream.Read (Lang, 1); //* code for english = 0x15C7   85
                    Lang:= ReverseBytes16(Lang);
               end else
               *)
               if IsSameAtomName (AtomName, 'minf') then
               begin
                  repeat
                     ReadAtomHeader (MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                     if IsSameAtomName (AtomName, 'stbl') then
                     begin
                        repeat
                           ReadAtomHeader (MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                           if IsSameAtomName (AtomName, 'stsd') then
                           begin
                              MP4Stream.Seek (4, soCurrent);
                              MP4Stream.Read (_NumberOfDescriptions, 4);
                              _NumberOfDescriptions := ReverseBytes32(_NumberOfDescriptions);
                              if _NumberOfDescriptions=1 then
                              begin
                                 repeat
                                    ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                                    if IsSameAtomName(AtomName, 'mp4a') then
                                    begin
                                       MP4Stream.Seek($10, soCurrent);
                                       MP4Stream.Read2(_AudioChannels, 2);
                                       FAudioChannelCount:= ReverseBytes16(_AudioChannels);
                                       MP4Stream.Read2(_SampleSize, 2);
                                       FAudioResolution := ReverseBytes16(_SampleSize);
                                       MP4Stream.Seek(2, soCurrent);
                                       MP4Stream.Read2(_SampleRate, 4);
                                       FAudioSampleRate := ReverseBytes32(_SampleRate);
                                       //* Quick hack
                                       if FAudioSampleRate = 30464 then begin
                                           FAudioSampleRate := 96000;
                                       end;
                                       FAudioFormat := mp4afAAC;
                                       Exit;
                                    end else
                                    if IsSameAtomName(AtomName, 'alac') then
                                    begin
                                       MP4Stream.Seek($10, soCurrent);
                                       MP4Stream.Read2(_AudioChannels, 2);
                                       FAudioChannelCount:= ReverseBytes16(_AudioChannels);
                                       MP4Stream.Read2(_SampleSize, 2);
                                       FAudioResolution := ReverseBytes16(_SampleSize);
                                       MP4Stream.Seek($28, soCurrent);
                                       MP4Stream.Read2(_SampleRate, 4);
                                       FAudioSampleRate := ReverseBytes32(_SampleRate);
                                       //* Quick hack
                                       if FAudioSampleRate = 30464 then begin
                                           FAudioSampleRate := 96000;
                                       end;
                                       FAudioFormat := mp4afALAC;
                                       Exit;
                                    end else
                                    if IsSameAtomName(AtomName, 'ac-3') then
                                    begin
                                       MP4Stream.Seek($10, soCurrent);
                                       MP4Stream.Read2(_AudioChannels, 2);
                                       FAudioChannelCount:= ReverseBytes16(_AudioChannels);
                                       MP4Stream.Read2(_SampleSize, 2);
                                       FAudioResolution := ReverseBytes16(_SampleSize);
                                       MP4Stream.Seek($2, soCurrent);
                                       MP4Stream.Read2(_SampleRate, 4);
                                       FAudioSampleRate := ReverseBytes32(_SampleRate);
                                       //* Quick hack
                                       if FAudioSampleRate = 30464 then begin
                                           FAudioSampleRate := 96000;
                                       end;
                                       FAudioFormat := mpfafAC3;
                                       Exit;
                                    end
                                    else SkipAtom;
                                 until (MP4Stream.Position >= MP4Stream_Size) OR (MP4Stream.Position + AtomSize >= MP4Stream_Size);
                              end;
                           end
                           else SkipAtom;
                        until (MP4Stream.Position >= MP4Stream_Size) OR (MP4Stream.Position + AtomSize >= MP4Stream_Size);
                     end
                     else SkipAtom;
                  until (MP4Stream.Position >= MP4Stream_Size) OR (MP4Stream.Position + AtomSize >= MP4Stream_Size);
               end
               else SkipAtom;
            until (MP4Stream.Position >= MP4Stream_Size) OR (MP4Stream.Position + AtomSize >= MP4Stream_Size);
         end
         else SkipAtom;
      until MP4Stream.Position >= MP4Stream_Size;
   end;

var SavedPos           : Int64;
    oldAtomSize        : Int64;
    oldIs64BitAtomSize : boolean;

   procedure SaveState;
   begin
      oldAtomSize        := AtomSize;
      oldIs64BitAtomSize := Is64BitAtomSize;
      SavedPos           := MP4Stream.Position;
   end;

   procedure RestoreState;
   begin
      MP4Stream.Position := SavedPos;
      AtomSize           := oldAtomSize;
      Is64BitAtomSize    := oldIs64BitAtomSize;
   end;

begin
   FVideoWidth     := 0;
   FVideoHeight    := 0;
   MP4Stream_Size := MP4Stream.Size;
   try
      repeat
         ReadAtomHeader (MP4Stream, AtomName, AtomSize, Is64BitAtomSize, False);
         if IsSameAtomName (AtomName, 'moov') then
         begin
            repeat
               ReadAtomHeader (MP4Stream, AtomName, AtomSize, Is64BitAtomSize, False);
               if IsSameAtomName(AtomName, 'trak') then
               begin
                  SaveState;
                  ParseTrakForVideoParams; // Parse the trak for video params.
                  RestoreState;            // Restore state to parse for audio params.
                  ParseTrakForAudioParams; // Parse the trak for video params.
                  RestoreState;            // Restore state to skip correctly this trak and check the next one if exists.
               end;
               SkipAtom;
            until (MP4Stream.Position >= MP4Stream_Size)
            OR (AtomSize = 0)
            OR ((AtomName[0] = 0) AND (AtomName[1] = 0) AND (AtomName[2] = 0) AND (AtomName[3] = 0));
         end
         else SkipAtom;
      until (MP4Stream.Position >= MP4Stream_Size) OR (AtomSize <= 0);
   except
   end;
end;

function TMP4Tag.LoadFromStream(MP4Stream: TStream; Buffered: Boolean = True): Integer;
var
    AtomName: TAtomName;
    AtomSize: Int64;
    ilstAtomSize: Int64;
    ilstAtomPosition: Int64;
    NewAtom: TMP4Atom;
    moovAtomSize: Int64;
    Is64BitAtomSize: Boolean;
    moovOffset: Int64;
    LStream: TStream;
    TagsLoaded: Boolean;
    XtraLoaded: Boolean;
begin
    Clear;
    FLoaded := False;
    Self.FileName := '';
    AtomName := ClearAtomName;
    AtomSize := 0;
    Is64BitAtomSize := False;
    moovAtomSize := 0;
    Is64BitAtomSize := False;
    ilstAtomSize := 0;
    TagsLoaded := False;
    XtraLoaded := False;
    try
        Result := MP4TAGLIBRARY_ERROR_NO_TAG_FOUND;
        if Buffered then
            LStream := TBufferedStream.Create(MP4Stream)
        else
            LStream := MP4Stream;
        try
            try
                ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize, False);
            except
                //* Will except if not an MP4 file and MP4TagLibraryFailOnCorruptFile is True
            end;
            if NOT IsSameAtomName(AtomName, 'ftyp') then begin
                Result := MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            FFileSize := LStream.Size;
            //* Get mdat atom size
            GetmdatAtom(LStream, FAtommdatPosition, FAtommdatSize);
            //* Get play time
            FPlaytime := GetPlayTime(LStream);
            {$IFNDEF IVAN_LLANAS}
            // No. This function assumes that the first trak atom in the header
            // always contains the audio info in an internal mp4a atom. Error.
            // Often the first trak atom is the video one.
            //* Get audio attributes
            //GetAudioAttributes(Self, LStream);
            {$ENDIF}
            if FPlayTime <> 0 then begin
                FBitRate := Trunc((FAtommdatSize / FPlayTime / 125) + 0.5);
            end;
            //* Continue loading
            LStream.Seek(AtomSize - 8, soCurrent);
            moovOffset := LStream.Position;
            _GetIvanParameters (LStream); // Get Video parameters. Get Audio parameters correctly.
            LStream.Position := moovOffset;
            // Continue gathering the atoms for the file metadata.
            repeat
                ReadAtomHeader(LStream, AtomName, moovAtomSize, Is64BitAtomSize);
                if IsSameAtomName(AtomName, 'moov') then begin
                    if Is64BitAtomSize then begin
                        FAtommoovPosition := LStream.Position - 16;
                    end else begin
                        FAtommoovPosition := LStream.Position - 8;
                    end;
                    FAtommoovSize := moovAtomSize;
                    repeat
                        ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                        if IsSameAtomName(AtomName, 'udta') then begin
                            if Is64BitAtomSize then begin
                                FAtomudtaPosition := LStream.Position - 16;
                            end else begin
                                FAtomudtaPosition := LStream.Position - 8;
                            end;
                            FAtomudtaSize := AtomSize;
                            repeat
                                ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                                if IsSameAtomName(AtomName, 'meta') then begin
                                    if Is64BitAtomSize then begin
                                        FAtommetaPosition := LStream.Position - 16;
                                    end else begin
                                        FAtommetaPosition := LStream.Position - 8;
                                    end;
                                    FAtommetaSize := AtomSize;
                                    LStream.Read2(Version, 1);
                                    LStream.Read2(Flags, 3);
                                    repeat
                                        ReadAtomHeader(LStream, AtomName, ilstAtomSize, Is64BitAtomSize);
                                        if IsSameAtomName(AtomName, 'ilst') then begin
                                            if Is64BitAtomSize then begin
                                                ilstAtomPosition := LStream.Position - 16;
                                                FAtomilstPosition := LStream.Position - 16;
                                            end else begin
                                                FAtomilstPosition := LStream.Position - 8;
                                                ilstAtomPosition := LStream.Position - 8;
                                            end;
                                            FAtomilstSize := ilstAtomSize;
                                            while LStream.Position < ilstAtomPosition + ilstAtomSize do begin
                                                NewAtom := AddAtom('');
                                                ReadAtom(LStream, NewAtom);
                                                Result := MP4TAGLIBRARY_SUCCESS;
                                                FLoaded := True;
                                                TagsLoaded := True;
                                            end;
                                            if ParseXtra then begin
                                                if XtraLoaded then begin
                                                    Exit;
                                                end else begin
                                                    Break; //* For Xtra, continue
                                                end;
                                            end else begin
                                                Exit;
                                            end;
                                        end else begin
                                            if Is64BitAtomSize then begin
                                                LStream.Seek(ilstAtomSize - 16, soCurrent);
                                            end else begin
                                                LStream.Seek(ilstAtomSize - 8, soCurrent);
                                            end;
                                        end;
                                    until (LStream.Position >= LStream.Size)
                                    OR (LStream.Position + ilstAtomSize >= LStream.Size);
                                end else if IsSameAtomName(AtomName, 'Xtra')
                                AND ParseXtra
                                then begin
                                    if Is64BitAtomSize then begin
                                        LoadXtra(LStream, AtomSize - 16);
                                    end else begin
                                        LoadXtra(LStream, AtomSize - 8);
                                    end;
                                    XtraLoaded := True;
                                    if TagsLoaded then begin
                                        Exit;
                                    end;
                                end else begin
                                    if Is64BitAtomSize then begin
                                        LStream.Seek(AtomSize - 16, soCurrent);
                                    end else begin
                                        LStream.Seek(AtomSize - 8, soCurrent);
                                    end;
                                end;
                            until (LStream.Position >= LStream.Size)
                            OR (LStream.Position >= FAtomudtaPosition + FAtomudtaSize);
                            //* udta atom found and processed no need to parse atoms further
                            Exit;
                        end else begin
                            if Is64BitAtomSize then begin
                                LStream.Seek(AtomSize - 16, soCurrent);
                            end else begin
                                LStream.Seek(AtomSize - 8, soCurrent);
                            end;
                        end;
                    until (LStream.Position >= LStream.Size)
                    OR (LStream.Position >= FAtommoovPosition + moovAtomSize);
                    //* moov atom found and processed no need to parse atoms further
                    Exit;
                end else begin
                    if Is64BitAtomSize then begin
                        LStream.Seek(moovAtomSize - 16, soCurrent);
                    end else begin
                        LStream.Seek(moovAtomSize - 8, soCurrent);
                    end;
                end;
            until (LStream.Position >= LStream.Size)
            OR (moovAtomSize = 0);
        finally
            if Buffered then
                FreeAndNil(LStream);
        end;
    except
        Result := MP4TAGLIBRARY_ERROR_READING_FILE
    end;
end;

function TMP4Tag.LoadXtra(MP4Stream: TStream; XtraAtomSize: UInt64): Boolean;
var
    StartPosition: UInt64;
    TagSize, FieldNameSize: DWord;
    FieldNameBytes: TBytes;
    FieldName: String;
    Xtra: TMP4Xtra;
    VersionFlags: DWord;
    PropSize: DWord;
    PropType: Word;
    PropValueSize: DWord;
begin
    Result := False;
    StartPosition := MP4Stream.Position;
    while MP4Stream.Position < StartPosition + XtraAtomSize do begin
        MP4Stream.Read2(TagSize, 4);
        TagSize := ReverseBytes32(TagSize);
        MP4Stream.Read2(FieldNameSize, 4);
        FieldNameSize := ReverseBytes32(FieldNameSize);
        SetLength(FieldNameBytes, FieldNameSize);
        MP4Stream.Read2(FieldNameBytes[0], Length(FieldNameBytes));
        FieldName := TEncoding.UTF8.GetString(FieldNameBytes);
        MP4Stream.Read2(VersionFlags, 4);
        VersionFlags := ReverseBytes32(VersionFlags); //* 0x00000001
	    MP4Stream.Read2(PropSize, 4);
        PropSize := ReverseBytes32(PropSize);
	    // if( propSize >= sizeof(uint32_t) + sizeof(uint16_t) )
	    MP4Stream.Read2(PropType, 2);
        PropType := ReverseBytes16(PropType);
	    PropValueSize := PropSize - SizeOf(DWord) - SizeOf(Word);
        //MP4Stream.Seek(6, soCurrent); //* TODO: What are these 6 bytes?
        Xtra := AddXtra(FieldName);
        Xtra.Data.CopyFrom(MP4Stream, PropValueSize {TagSize - FieldNameSize - 18});
        Xtra.PropType := PropType;//TMP4XtraWMTAttrDataType(DataType);
        Result := True;
    end;
end;

function TMP4Tag.CreateXtraAtomStream(XtraStream: TMemoryStream): Boolean;
var
    StartPosition: Int64;
    AtomName: TAtomName;
    AtomSize32: DWord;
    i: Integer;
    Xtra: TMP4Xtra;
    TagSize, FieldNameSize: DWord;
    FieldNameBytes: TBytes;
    VersionFlags: DWord;
    PropSize: DWord;
    PropType: Word;
begin
    Result := False;
    if Xtras.Count = 0 then begin
        Exit;
    end;
    StartPosition := XtraStream.Position;
    ///* Xtra atom size, will be updated
    AtomSize32 := 0;
    XtraStream.Write(AtomSize32, 4);
    //* Atom ID
    StringToAtomName('Xtra', AtomName);
    XtraStream.Write(AtomName, 4);
    //* Write all Xtra tags
    for i := 0 to Xtras.Count - 1 do begin
        Xtra := Xtras[i];
        //* Skip invalid tags
        if (Xtra.Name = '')
        OR (Xtra.PropType = 0)
        OR (Xtra.Data.Size = 0)
        then begin
            Continue;
        end;
        //* Tag name
        FieldNameBytes := TEncoding.UTF8.GetBytes(Xtra.Name);
        FieldNameSize := Length(FieldNameBytes);
        //* Tag size
        TagSize := 18 + FieldNameSize + Xtra.Data.Size;
        TagSize := ReverseBytes32(TagSize);
        XtraStream.Write(TagSize, 4);
        //* Tag name size
        FieldNameSize := ReverseBytes32(FieldNameSize);
        XtraStream.Write(FieldNameSize, 4);
        //* Tag name
        XtraStream.Write(FieldNameBytes[0], Length(FieldNameBytes));
        //* Tag version
        VersionFlags := 1; //* 0x00000001
        VersionFlags := ReverseBytes32(VersionFlags);
        XtraStream.Write(VersionFlags, 4);
        //* Tag content size
        PropSize := Xtra.Data.Size + 6;
        PropSize := ReverseBytes32(PropSize);
        XtraStream.Write(PropSize, 4);
        //* Tag data type
        PropType := Xtra.PropType;
        PropType := ReverseBytes16(PropType);
        XtraStream.Write(PropType, 2);
        //* The tag conent
        Xtra.Data.Seek(0, soBeginning);
        XtraStream.CopyFrom(Xtra.Data, Xtra.Data.Size);
        //* Wrote at least 1 tag
        Result := True;
    end;
    if Result then begin
        //* Seek back and update Xtra atom size value
        XtraStream.Seek(StartPosition, soBeginning);
        AtomSize32 := XtraStream.Size;
        AtomSize32 := ReverseBytes32(AtomSize32);
        XtraStream.Write(AtomSize32, 4);
    end else begin
        XtraStream.Size := StartPosition;
    end;
end;

function TMP4Tag.ReadAtom(MP4Stream: TStream; var MP4Atom: TMP4Atom): Boolean;
var
    AtomSize: DWord;
    AtomName: TAtomName;
    AtomData: TMP4AtomData;
    AtomPosition: Int64;
    SkipLoadingOfDatas: Boolean;
begin
    Result := False;
    AtomName := ClearAtomName;
    AtomSize := 0;
    SkipLoadingOfDatas := False;
    try
        MP4Stream.Read2(AtomSize, 4);
        MP4Stream.Read2(AtomName, 4);
        MP4Atom.Size := ReverseBytes32(AtomSize);
        MP4Atom.ID := AtomName;
        AtomPosition := MP4Stream.Position - 8;
        if NOT ParseCoverArts then begin
            if IsSameAtomName(AtomName, 'covr') then begin
                SkipLoadingOfDatas := True;
            end;
        end;
        while MP4Stream.Position < AtomPosition + MP4Atom.Size do begin
            MP4Stream.Read2(AtomSize, 4);
            MP4Stream.Read2(AtomName, 4);
            AtomSize := ReverseBytes32(AtomSize);
            if IsSameAtomName(AtomName, 'mean') then begin
                if AtomSize > 8 then begin
                    MP4Atom.mean.Data.CopyFrom(MP4Stream, AtomSize - 8);
                end;
            end else begin
                if IsSameAtomName(AtomName, 'name') then begin
                    if AtomSize > 8 then begin
                        MP4Atom.name.Data.CopyFrom(MP4Stream, AtomSize - 8);
                    end;
                end else begin
                    if IsSameAtomName(AtomName, 'data') then begin
                        MP4Stream.Seek(- 8, soCurrent);
                        AtomData := MP4Atom.AddData;
                        ReadAtomData(MP4Stream, AtomData, SkipLoadingOfDatas);
                    end else begin
                        MP4Stream.Seek(AtomSize - 8, soCurrent);
                    end;
                end;
            end;
            Result := True;
        end;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

function TMP4Tag.ReadAtomData(MP4Stream: TStream; var MP4AtomData: TMP4AtomData; SkipLoadingOfDatas: Boolean): Boolean;
var
    AtomSize: DWord;
    AtomName: TAtomName;
    DataType: DWord;
begin
    Result := False;
    AtomSize := 0;
    AtomName := ClearAtomName;
    DataType := 0;
    try
        MP4Stream.Read2(AtomSize, 4);
        MP4Stream.Read2(AtomName, 4);
        AtomSize := ReverseBytes32(AtomSize);
        if IsSameAtomName(AtomName, 'data') then begin
            MP4Stream.Read2(DataType, 4);
            MP4AtomData.DataType := ReverseBytes32(DataType);
            MP4Stream.Read2(MP4AtomData.Reserved, 4);
            if SkipLoadingOfDatas then begin
                MP4Stream.Seek(AtomSize - 16, soCurrent);
            end else begin
                if AtomSize > 16 then begin
                    MP4AtomData.Data.CopyFrom(MP4Stream, AtomSize - 16);
                    MP4AtomData.Data.Seek(0, soBeginning);
                end;
            end;
            Result := True;
        end else begin
            MP4Stream.Seek(AtomSize - 16, soCurrent);
        end;
    except
        On E: exception do begin
            //*
        end;
    end;
end;

procedure TMP4Tag.ReSetAlreadyParsedState;
var
    i: Integer;
begin
    for i := 0 to Atoms.Count - 1 do begin
        Atoms[i].AlreadyParsed := False;
        Atoms[i].ReSetAlreadyParsedState;
    end;
    for i := 0 to Xtras.Count - 1 do begin
        Xtras[i].AlreadyParsed := False;
    end;
end;

function TMP4Tag.AddAtom(AtomName: TAtomName): TMP4Atom;
begin
    Result := nil;
    try
        if Atoms.Count = Atoms.Capacity then begin
            Atoms.Capacity := Atoms.Capacity + 256;
        end;
        Result := TMP4Atom.Create;
        Result.ID := AtomName;
        Result.Parent := Self;
        Atoms.Add(Result);
    except
        On E: exception do begin
            //*
        end;
    end;
end;

function TMP4Tag.AddAtom(AtomName: String): TMP4Atom;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := AddAtom(AtomID);
end;

function TMP4Tag.AddXtra(const FieldName: String): TMP4Xtra;
var
    MP4Xtra: TMP4Xtra;
begin
    MP4Xtra := TMP4Xtra.Create;
    MP4Xtra.Parent := Self;
    MP4Xtra.Name := FieldName;
    Xtras.Add(MP4Xtra);
    Result := MP4Xtra;
end;

function TMP4Tag.Count: Integer;
begin
    Result := Atoms.Count;
end;

procedure TMP4Tag.Clear;
var
    i: Integer;
begin
    for i := Atoms.Count - 1 downto 0 do begin
        Atoms[i].Free;
        Atoms.Delete(i);
    end;
    Version := 0;
    Flags := 0;
    FLoaded := False;
    FFileSize := 0;
    FAtommdatPosition := 0;
    FAtommdatSize := 0;
    FAtommoovPosition := 0;
    FAtommoovSize := 0;
    FAtomudtaPosition := 0;
    FAtomudtaSize := 0;
    FAtommetaPosition := 0;
    FAtommetaSize := 0;
    FAtomilstPosition := 0;
    FAtomilstSize := 0;
    FAudioChannelCount := 0;
    FAudioResolution := 0;
    FAudioSampleRate := 0;
    FPlaytime := 0;
    FVideoWidth := 0;
    FVideoHeight := 0;
    FAudioFormat := mp4afUnknown;
    ClearXtras;
end;

procedure TMP4Tag.ClearXtras;
var
    i: Integer;
begin
    for i := Xtras.Count - 1 downto 0 do begin
        Xtras[i].Free;
    end;
    Xtras.Clear;
end;

function TMP4Tag.DeleteAtom(Index: Integer): Boolean;
begin
    Result := False;
    if (Index >= Atoms.Count)
    OR (Index < 0)
    then begin
        Exit;
    end;
    Atoms[Index].Free;
    Atoms.Delete(Index);
    Result := True;
end;

function TMP4Tag.DeleteAtom(AtomName: TAtomName): Boolean;
var
    Atom: TMP4Atom;
begin
    Result := False;
    Atom := FindAtom(AtomName);
    if Assigned(Atom) then begin
        Atom.Delete;
        Result := True;
    end;
end;

function TMP4Tag.DeleteAtom(const AtomName: String): Boolean;
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    Result := DeleteAtom(ID);
end;

function TMP4Tag.DeleteAtomCommon(const AtomName: String; const _name: String; const _mean: String): Boolean;
var
    Atom: TMP4Atom;
begin
    Result := False;
    Atom := FindAtomCommon(AtomName, _name, _mean);
    if Assigned(Atom) then begin
        Atom.Delete;
        Result := True;
    end;
end;

function TMP4Tag.DeleteXtra(Index: Integer): Boolean;
begin
    Result := False;
    if (Index > - 1)
    AND (Index < Xtras.Count)
    then begin
        Xtras[Index].Free;
        Xtras.Delete(Index);
        Result := True;
    end;
end;

function TMP4Tag.DeleteXtra(const FieldName: String): Boolean;
var
    Index: Integer;
begin
    Result := False;
    Index := FindAtomXtraIndex(FieldName);
    if Index > - 1 then begin
        Xtras[Index].Free;
        Xtras.Delete(Index);
        Result := True;
    end;
end;

function TMP4Tag.CalculateSize: Int64;
var
    i: Integer;
begin
    Result := 0;
    for i := 0 to Count - 1 do begin
        Result := Result + Atoms[i].CalculateAtomSize;
    end;
    if Result > 0  then begin
        Inc(Result, 8);
    end;
    if Result > High(Cardinal) then begin
        Inc(Result, 8);
    end;
end;

function TMP4Tag.SaveToFile(MP4FileName: String; KeepPadding: Boolean = True; UseMemoryForTempDataMaxFileSize: Int64 = 250 * 1024 * 1024 {250 MB}): Integer;
var
    MP4Stream: TFileStream;
begin
    try
        if NOT FileExists(MP4FileName) then begin
            MP4Stream := TFileStream.Create(MP4FileName, fmCreate OR fmShareDenyWrite);
        end else begin
            MP4Stream := TFileStream.Create(MP4FileName, fmOpenReadWrite OR fmShareDenyWrite);
        end;
        try
            if MP4Stream.Size < UseMemoryForTempDataMaxFileSize then begin
                //* Temporary data in memory
                Result := SaveToStream(MP4Stream, True, KeepPadding, '');
            end else begin
                //* Temporary data to temp files
                Result := SaveToStream(MP4Stream, True, KeepPadding, MP4FileName);
            end;
        finally
            FreeAndNil(MP4Stream);
        end;
    except
        Result := MP4TAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
end;

function TMP4Tag.SaveToStream(MP4Stream: TStream; Buffered: Boolean = True; KeepPadding: Boolean = True; MP4FileName: String = ''): Integer;
var
    //MP4Stream: TFileStream;
    AtomName: TAtomName;
    AtomSize: Int64;
    moovAtomSize: Int64;
    moovAtomPosition: Int64;
    udtaAtomSize: Int64;
    udtaAtomPosition: Int64;
    metaAtomSize: Int64;
    metaAtomPosition: Int64;
    freeAtomSize: Int64;
    XtraAtomSizePrevious: Int64;
    i: Integer;
    NewTagSize: Int64;
    StreamRest: TStream;
    moovAtomRest: TStream;
    udtaAtomRest: TStream;
    metaAtomRest: TStream;
    StreamRestFileName: String;
    moovAtomRestFileName: String;
    udtaAtomRestFileName: String;
    metaAtomRestFileName: String;
    mdatPreviousLocation: Int64;
    mdatNewLocation: Int64;
    AvailableSpace: Int64;
    NeededSpace: Int64;
    PaddingNeededToWrite: Integer;
    moovProcessingFinished: Boolean;
    Temp: DWord;
    Is64BitAtomSize: Boolean;
    moovIs64BitAtomSize: Boolean;
    LStream: TStream;
    XtraAtomStream: TMemoryStream;
    TagFits: Boolean;
    MP4StreamPreviousPosition: Int64;
begin
    //Result := MP4TAGLIBRARY_ERROR;
    NewTagSize := CalculateSize;
    if NewTagSize = 0 then begin
        NewTagSize := 8;
    end;
    FLoaded := False;
    Self.FileName := MP4FileName;
    Flags := 0;
    moovAtomSize := 0;
    moovAtomPosition := 0;
    AvailableSpace := 0;
    XtraAtomSizePrevious := 0;
    moovIs64BitAtomSize := False;
    Temp := 0;
    AtomName := ClearAtomName;
    Is64BitAtomSize := False;
    AtomSize := 0;
    StreamRest := nil;
    moovAtomRest := nil;
    udtaAtomRest := nil;
    metaAtomRest := nil;
    XtraAtomStream := nil;
    try
        if Buffered then
            LStream := TBufferedStream.Create(MP4Stream)
        else
            LStream := MP4Stream;
        try
            if LStream.Size > 0 then begin
                try
                    LStream.Seek(0, soBeginning);
                    ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize, False);
                except
                    //* Will except if not an MP4 file and MP4TagLibraryFailOnCorruptFile is True
                end;
                if NOT IsSameAtomName(AtomName, 'ftyp') then begin
                    Result := MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            //* When creating new file add a fake ftyp
            LStream.Seek(0, soBeginning);
            if LStream.Size = 0 then begin
                WriteAtomHeader(LStream, 'ftyp', 8);
            end;
            //* Working with file
            if FileName <> '' then begin
                StreamRestFileName := ChangeFileExt(FileName, '.rest.tmp');
                moovAtomRestFileName := ChangeFileExt(FileName, '.moovAtom.tmp');
                udtaAtomRestFileName := ChangeFileExt(FileName, '.udtaAtom.tmp');
                metaAtomRestFileName := ChangeFileExt(FileName, '.metaAtom.tmp');
                StreamRest := TFileStream.Create(StreamRestFileName, fmCreate);
                moovAtomRest := TFileStream.Create(moovAtomRestFileName, fmCreate);
                udtaAtomRest := TFileStream.Create(udtaAtomRestFileName, fmCreate);
                metaAtomRest := TFileStream.Create(metaAtomRestFileName, fmCreate);
            //* Working in memory
            end else begin
                StreamRest := TMemoryStream.Create;
                moovAtomRest := TMemoryStream.Create;
                udtaAtomRest := TMemoryStream.Create;
                metaAtomRest := TMemoryStream.Create;
            end;
            LStream.Seek(0, soBeginning);
            mdatPreviousLocation := MP4mdatAtomLocation(LStream);
            LStream.Seek(0, soBeginning);
            //* Locate moov atom and calc free atoms after it (moovAtomPosition is used for where to write the new tag, if free atom is before moov atom then use that)
            moovProcessingFinished := False;
            repeat
                ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                if IsSameAtomName(AtomName, 'moov') then begin
                    moovAtomSize := AtomSize;
                    moovIs64BitAtomSize := Is64BitAtomSize;
                    if Is64BitAtomSize then begin
                        Inc(AvailableSpace, AtomSize);
                        if moovAtomPosition = 0 then begin
                            moovAtomPosition := LStream.Position - 16;
                        end;
                    end else begin
                        Inc(AvailableSpace, AtomSize);
                        if moovAtomPosition = 0 then begin
                            moovAtomPosition := LStream.Position - 8;
                        end;
                    end;
                    if moovAtomSize > High(Cardinal) then begin
                        LStream.Seek(moovAtomSize - 16, soCurrent);
                    end else begin
                        LStream.Seek(moovAtomSize - 8, soCurrent);
                    end;
                    if ((AtomSize < 8 + 1) AND (NOT Is64BitAtomSize))
                    OR ((AtomSize < 16 + 1) AND (Is64BitAtomSize))
                    then begin
                        Continue;
                    end;
                    if LStream.Position >= LStream.Size then begin
                        Break;
                    end;
                    repeat
                        ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                        if IsSameAtomName(AtomName, 'free') then begin
                            if Is64BitAtomSize then begin
                                Inc(AvailableSpace, AtomSize);
                                if moovAtomPosition = 0 then begin
                                    moovAtomPosition := LStream.Position - 16;
                                end;
                            end else begin
                                Inc(AvailableSpace, AtomSize);
                                if moovAtomPosition = 0 then begin
                                    moovAtomPosition := LStream.Position - 8;
                                end;
                            end;
                            if Is64BitAtomSize then begin
                                LStream.Seek(AtomSize - 16, soCurrent);
                            end else begin
                                LStream.Seek(AtomSize - 8, soCurrent);
                            end;
                        end else begin
                            moovProcessingFinished := True;
                        end;
                    until NOT IsSameAtomName(AtomName, 'free')
                    OR (LStream.Position >= LStream.Size)
                    OR moovProcessingFinished;
                end else begin
                    if Is64BitAtomSize then begin
                        LStream.Seek(AtomSize - 16, soCurrent);
                    end else begin
                        LStream.Seek(AtomSize - 8, soCurrent);
                    end;
                end;
            until (LStream.Position >= LStream.Size)
            //OR ((moovAtomPosition > 0) AND (LStream.Position >= moovAtomPosition + moovAtomSize))
            OR moovProcessingFinished
            OR (AtomSize = 0);
            //* Load the content of the moov atom
            if (moovAtomPosition > 0)
            AND (((moovAtomSize > 8 + 1) AND (NOT moovIs64BitAtomSize)) OR ((moovAtomSize > 16 + 1) AND (moovIs64BitAtomSize)))
            then begin
                if moovIs64BitAtomSize then begin
                    LStream.Seek(moovAtomPosition + 16, soBeginning);
                end else begin
                    LStream.Seek(moovAtomPosition + 8, soBeginning);
                end;
                //* Process all moov sub-atoms
                repeat
                    ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                    if IsSameAtomName(AtomName, 'udta') then begin
                        udtaAtomSize := AtomSize;
                        if Is64BitAtomSize then begin
                            udtaAtomPosition := LStream.Position - 16;
                        end else begin
                            udtaAtomPosition := LStream.Position - 8;
                        end;
                        if ((AtomSize < 8 + 1) AND (NOT Is64BitAtomSize))
                        OR ((AtomSize < 16 + 1) AND (Is64BitAtomSize))
                        then begin
                            Continue;
                        end;
                        repeat
                            ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                            if IsSameAtomName(AtomName, 'meta') then begin
                                metaAtomSize := AtomSize;
                                if Is64BitAtomSize then begin
                                    metaAtomPosition := LStream.Position - 16;
                                end else begin
                                    metaAtomPosition := LStream.Position - 8;
                                end;
                                if ((AtomSize >= 8 + 4) AND (NOT Is64BitAtomSize))
                                OR ((AtomSize >= 16 + 4) AND (Is64BitAtomSize))
                                then begin
                                    LStream.Read2(Temp, 1);
                                    LStream.Read2(Temp, 3);
                                end;
                                if ((AtomSize <= 8 + 4) AND (NOT Is64BitAtomSize))
                                OR ((AtomSize <= 16 + 4) AND (Is64BitAtomSize))
                                then begin
                                    Continue;
                                end;
                                repeat
                                    ReadAtomHeader(LStream, AtomName, AtomSize, Is64BitAtomSize);
                                    if IsSameAtomName(AtomName, 'ilst') then begin
                                        //ilstAtomSize := AtomSize;
                                        if Is64BitAtomSize then begin
                                            LStream.Seek(AtomSize - 16, soCurrent);
                                        end else begin
                                            LStream.Seek(AtomSize - 8, soCurrent);
                                        end;
                                    end else if NOT IsSameAtomName(AtomName, 'free') then begin
                                        if Is64BitAtomSize then begin
                                            LStream.Seek(- 16, soCurrent);
                                        end else begin
                                            LStream.Seek(- 8, soCurrent);
                                        end;
                                        metaAtomRest.CopyFrom(LStream, AtomSize);
                                    end else begin
                                        if Is64BitAtomSize then begin
                                            LStream.Seek(AtomSize - 16, soCurrent);
                                        end else begin
                                            LStream.Seek(AtomSize - 8, soCurrent);
                                        end;
                                    end;
                                until (LStream.Position >= LStream.Size)
                                OR (LStream.Position >= metaAtomPosition + metaAtomSize);

                            end else if IsSameAtomName(AtomName, 'Xtra') then begin
                                XtraAtomSizePrevious := AtomSize;
                                if Is64BitAtomSize then begin
                                    LStream.Seek(AtomSize - 16, soCurrent);
                                end else begin
                                    XtraAtomSizePrevious :=
                                    LStream.Seek(AtomSize - 8, soCurrent);
                                end;

                            end else if NOT IsSameAtomName(AtomName, 'free') then begin
                                if Is64BitAtomSize then begin
                                    LStream.Seek(- 16, soCurrent);
                                end else begin
                                    LStream.Seek(- 8, soCurrent);
                                end;
                                udtaAtomRest.CopyFrom(LStream, AtomSize);
                            end else begin
                                if Is64BitAtomSize then begin
                                    LStream.Seek(AtomSize - 16, soCurrent);
                                end else begin
                                    LStream.Seek(AtomSize - 8, soCurrent);
                                end;
                            end;
                        until (LStream.Position >= LStream.Size)
                        OR (LStream.Position >= udtaAtomPosition + udtaAtomSize);
                    end else if NOT IsSameAtomName(AtomName, 'free') then begin
                        if Is64BitAtomSize then begin
                            LStream.Seek(- 16, soCurrent);
                        end else begin
                            LStream.Seek(- 8, soCurrent);
                        end;
                        moovAtomRest.CopyFrom(LStream, AtomSize);
                    end else begin
                        if Is64BitAtomSize then begin
                            LStream.Seek(AtomSize - 16, soCurrent);
                        end else begin
                            LStream.Seek(AtomSize - 8, soCurrent);
                        end;
                    end;
                until (LStream.Position >= LStream.Size)
                OR (LStream.Position >= moovAtomPosition + moovAtomSize);
            end;
            //* Calculate needed space
            NeededSpace := NewTagSize;

            //* Xtra
            XtraAtomStream := TMemoryStream.Create;
            CreateXtraAtomStream(XtraAtomStream);

            //* meta
            if NeededSpace + metaAtomRest.Size + 8 + 4 > High(Cardinal) then begin
                Inc(NeededSpace, metaAtomRest.Size + 16 + 4); //* + 4 bytes for version/flags
            end else begin
                Inc(NeededSpace, metaAtomRest.Size + 8 + 4); //* + 4 bytes for version/flags
            end;
            //* udta
            if NeededSpace + udtaAtomRest.Size + 8 - XtraAtomSizePrevious + XtraAtomStream.Size > High(Cardinal) then begin
                Inc(NeededSpace, udtaAtomRest.Size + 16);
            end else begin
                Inc(NeededSpace, udtaAtomRest.Size + 8);
            end;
            //* moov
            if NeededSpace + moovAtomRest.Size + 8 - XtraAtomSizePrevious + XtraAtomStream.Size > High(Cardinal) then begin
                Inc(NeededSpace, moovAtomRest.Size + 16);
            end else begin
                Inc(NeededSpace, moovAtomRest.Size + 8);
            end;
            //* Check if tags fit
            if (AvailableSpace = NeededSpace {- XtraAtomSizePrevious} + XtraAtomStream.Size)
            AND KeepPadding
            then begin
                PaddingNeededToWrite := 0;
                TagFits := True;
            //* Fits
            end else if (AvailableSpace > NeededSpace + 8 + 1 {- XtraAtomSizePrevious} + XtraAtomStream.Size)
            AND KeepPadding
            then begin
                PaddingNeededToWrite := AvailableSpace - NeededSpace {- XtraAtomSizePrevious} - XtraAtomStream.Size;
                TagFits := True;
            //* Doesn't fit
            end else begin
                PaddingNeededToWrite := Self.PaddingToWrite;
                //* Copy everything after moov atom except free atoms following moov atom
                LStream.Seek(moovAtomPosition + AvailableSpace {- XtraAtomSizePrevious + XtraAtomStream.Size}, soBeginning);
                if LStream.Size <> LStream.Position then begin

                    //* Do not use buffering when copying much data
                    MP4StreamPreviousPosition := MP4Stream.Position;
                    try
                        MP4Stream.Seek(LStream.Position, soBeginning);
                        StreamRest.CopyFrom(MP4Stream, MP4Stream.Size - MP4Stream.Position);
                    finally
                        MP4Stream.Seek(MP4StreamPreviousPosition, soBeginning);
                    end;

                    //StreamRest.CopyFrom(LStream, LStream.Size - LStream.Position);
                end;
                TagFits := False;
            end;
            //* Write the new atoms
            if moovAtomPosition <> 0 then begin
                LStream.Seek(moovAtomPosition, soBeginning);
            end else begin
                LStream.Seek(0, soEnd);
            end;
            //* Write moov (no difference between 32/64 bit)
            WriteAtomHeader(LStream, 'moov', NeededSpace + XtraAtomStream.Size + PaddingNeededToWrite);
            LStream.CopyFrom(moovAtomRest, 0);
            //* Write udta
            if NeededSpace - moovAtomRest.Size + PaddingNeededToWrite - 8 + XtraAtomStream.Size > High(Cardinal) then begin
                WriteAtomHeader(LStream, 'udta', NeededSpace - moovAtomRest.Size + PaddingNeededToWrite - 16 + XtraAtomStream.Size);
            end else begin
                WriteAtomHeader(LStream, 'udta', NeededSpace - moovAtomRest.Size + PaddingNeededToWrite - 8 + XtraAtomStream.Size);
            end;
            LStream.CopyFrom(udtaAtomRest, 0);
            //* Write meta
            if NeededSpace - moovAtomRest.Size - udtaAtomRest.Size + PaddingNeededToWrite - 8 - 8 > High(Cardinal) then begin
                WriteAtomHeader(LStream, 'meta', NeededSpace - moovAtomRest.Size - udtaAtomRest.Size + PaddingNeededToWrite - 16 - 16);
            end else begin
                WriteAtomHeader(LStream, 'meta', NeededSpace - moovAtomRest.Size - udtaAtomRest.Size + PaddingNeededToWrite - 8 - 8);
            end;
            //* TODO: Reverse bytes ?
            LStream.Write(Self.Version, 1);
            LStream.Write(Self.Flags, 3);
            LStream.CopyFrom(metaAtomRest, 0);
            //* ilst finally
            WriteAtomHeader(LStream, 'ilst', NewTagSize);
            //* Write the new tags
            for i := 0 to Count - 1 do begin
                Atoms[i].Write(LStream);
            end;
            //* Write the padding
            if PaddingNeededToWrite > 0 then begin
                freeAtomSize := PaddingNeededToWrite;
                WriteAtomHeader(LStream, 'free', freeAtomSize);
                if freeAtomSize > High(Cardinal) then begin
                    WritePadding(LStream, PaddingNeededToWrite - 16);
                end else begin
                    WritePadding(LStream, PaddingNeededToWrite - 8);
                end;
            end;

            //* Write Xtra atom
            if XtraAtomStream.Size > 0 then begin
                XtraAtomStream.Seek(0, soBeginning);
                LStream.CopyFrom(XtraAtomStream, XtraAtomStream.Size);
            end;

            //* Copy file rest
            if StreamRest.Size > 0 then begin
                //* Truncate file
                LStream.Size := LStream.Position;
                //* Copy rest
                //LStream.CopyFrom(StreamRest, 0);

                if Buffered then begin
                    FreeAndNil(LStream);
                    LStream := MP4Stream;
                end;

                LStream.Seek(0, soEnd);
                LStream.CopyFrom(StreamRest, 0);

                if Buffered then begin
                    LStream := TBufferedStream.Create(MP4Stream);
                    LStream.Seek(0, soEnd);
                end;

            end;

            //* Truncate file
            if NOT TagFits then begin
                LStream.Size := LStream.Position;
            end;

            //* Check and update stco/co64 atom
            LStream.Seek(0, soBeginning);
            mdatNewLocation := MP4mdatAtomLocation(LStream);
            LStream.Seek(0, soBeginning);
            if mdatNewLocation - mdatPreviousLocation <> 0 then begin
                LStream.Seek(0, soBeginning);
                if NOT MP4UpdatestcoAtom(LStream, mdatNewLocation - mdatPreviousLocation) then begin
                    Result := MP4TAGLIBRARY_ERROR_UPDATE_stco;
                    Exit;
                end;
                LStream.Seek(0, soBeginning);
                if NOT MP4Updateco64Atom(LStream, mdatNewLocation - mdatPreviousLocation) then begin
                    Result := MP4TAGLIBRARY_ERROR_UPDATE_co64;
                    Exit;
                end;
            end;
            Result := MP4TAGLIBRARY_SUCCESS;
        finally
            if Buffered then
                FreeAndNil(LStream);
        end;
    finally
        {$IFDEF NEXTGEN}
        if Assigned(StreamRest) then begin
            StreamRest.DisposeOf;
            StreamRest := nil;
        end;
        if Assigned(moovAtomRest) then begin
            moovAtomRest.DisposeOf;
            moovAtomRest := nil;
        end;
        if Assigned(udtaAtomRest) then begin
            udtaAtomRest.DisposeOf;
            udtaAtomRest := nil;
        end;
        if Assigned(metaAtomRest) then begin
            metaAtomRest.DisposeOf;
            metaAtomRest := nil;
        end;
        {$ELSE}
        if Assigned(StreamRest) then begin
            FreeAndNil(StreamRest);
        end;
        if Assigned(moovAtomRest) then begin
            FreeAndNil(moovAtomRest);
        end;
        if Assigned(udtaAtomRest) then begin
            FreeAndNil(udtaAtomRest);
        end;
        if Assigned(metaAtomRest) then begin
            FreeAndNil(metaAtomRest);
        end;
        {$ENDIF}
        if Assigned(XtraAtomStream) then begin
            FreeAndNil(XtraAtomStream);
        end;
        SysUtils.DeleteFile(StreamRestFileName);
        SysUtils.DeleteFile(moovAtomRestFileName);
        SysUtils.DeleteFile(udtaAtomRestFileName);
        SysUtils.DeleteFile(metaAtomRestFileName);
    end;
end;

function TMP4Tag.FindAtom(AtomName: TAtomName): TMP4Atom;
var
    i: Integer;
begin
    Result := nil;
    for i := 0 to Count - 1 do begin
        if IsSameAtomName(Atoms[i].ID, AtomName) then begin
            Result := Atoms[i];
            Exit;
        end;
    end;
end;

function TMP4Tag.FindAtom(const AtomName: String): TMP4Atom;
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    Result := FindAtom(ID);
end;

function TMP4Tag.FindAtomCommon(AtomName: TAtomName; const _name: String; const _mean: String): TMP4Atom;
var
    i: Integer;
    _nameValue: String;
    _meanValue: String;
begin
    Result := nil;
    for i := 0 to Count - 1 do begin
        if IsSameAtomName(Atoms[i].ID, AtomName) then begin
            Atoms[i].GetAsCommonText(_nameValue, _meanValue);
            if SameText(_nameValue, _name)
            AND SameText(_meanValue, _mean)
            then begin
                Result := Atoms[i];
                Exit;
            end;
        end;
    end;
end;

function TMP4Tag.FindAtomCommon(const AtomName: String; const _name: String; const _mean: String): TMP4Atom;
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    Result := FindAtomCommon(ID, _name, _mean);
end;

function TMP4Tag.FindAtomXtra(const FieldName: String): TMP4Xtra;
var
    i: Integer;
begin
    Result := nil;
    for i := 0 to Xtras.Count - 1 do begin
        if SameText(Xtras[i].Name, FieldName) then begin
            Result := Xtras[i];
            Break;
        end;
    end;
end;

function TMP4Tag.FindAtomXtraIndex(const FieldName: String): Integer;
var
    i: Integer;
begin
    Result := - 1;
    for i := 0 to Xtras.Count - 1 do begin
        if SameText(Xtras[i].Name, FieldName) then begin
            Result := i;
            Break;
        end;
    end;
end;

function TMP4Tag.CoverArtCount: Integer;
begin
    Result := 0;
    if Assigned(FindAtom('covr')) then begin
        Result := Length(FindAtom('covr').Datas);
    end;
end;

function TMP4Tag.GetText(AtomName: TAtomName): String;
var
    MP4Atom: TMP4Atom;
begin
    Result := '';
    MP4Atom := FindAtom(AtomName);
    if Assigned(MP4Atom) then begin
        Result := MP4Atom.GetAsText;
    end;
end;

function TMP4Tag.GetText(const AtomName: String): String;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetText(AtomID);
end;

function TMP4Tag.GetTextXtra(const FieldName: String): String;
var
    Xtra: TMP4Xtra;
begin
    Result := '';
    Xtra := FindAtomXtra(FieldName);
    if Assigned(Xtra) then begin
        Result := Xtra.GetAsText;
    end;
end;

function TMP4Tag.GetFileTimeXtra(const FieldName: String; out Value: TDateTime): Boolean;
var
    Xtra: TMP4Xtra;
begin
    Result := False;
    Xtra := FindAtomXtra(FieldName);
    if Assigned(Xtra) then begin
        Result := Xtra.GetAsDateTime(Value);
    end;
end;

function TMP4Tag.SetFileTimeXtra(const FieldName: String; Value: TDateTime): Boolean;
var
    Xtra: TMP4Xtra;
    Index: Integer;
begin
    Result := False;
    if FieldName = '' then begin
        Exit;
    end;
    if Value <> 0 then begin
        Xtra := FindAtomXtra(FieldName);
        if NOT Assigned(Xtra) then begin
            Xtra := AddXtra(FieldName);
        end;
        if Assigned(Xtra) then begin
            Result := Xtra.SetAsDateTime(Value);
        end;
    end else begin
        Index := FindAtomXtraIndex(FieldName);
        if Index > - 1 then begin
            Result := DeleteXtra(Index);
        end;
    end;
end;

function TMP4Tag.GetInteger(AtomName: TAtomName; out Value: UInt64): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    Result := Assigned(MP4Atom) and MP4Atom.GetAsInteger(Value);
end;

function TMP4Tag.GetInteger(const AtomName: String; out Value: UInt64): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetInteger(AtomID, Value);
end;

function TMP4Tag.GetInteger8(AtomName: TAtomName): Byte;
var
    MP4Atom: TMP4Atom;
begin
    Result := 0;
    MP4Atom := FindAtom(AtomName);
    if Assigned(MP4Atom) then begin
        Result := MP4Atom.GetAsInteger8;
    end;
end;

function TMP4Tag.GetInteger8(const AtomName: String): Byte;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetInteger8(AtomID);
end;

function TMP4Tag.GetIntegerXtra(const FieldName: String; out Value: Int64): Boolean;
var
    Xtra: TMP4Xtra;
begin
    Result := False;
    Xtra := FindAtomXtra(FieldName);
    if Assigned(Xtra) then begin
        Result := Xtra.GetAsInteger(Value);
    end;
end;

function TMP4Tag.GetList(AtomName: TAtomName; List: TStrings): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    Result := False;
    MP4Atom := FindAtom(AtomName);
    if Assigned(MP4Atom) then begin
        Result := MP4Atom.GetAsList(List);
    end;
end;

function TMP4Tag.GetList(const AtomName: String; List: TStrings): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetList(AtomID, List);
end;

function TMP4Tag.GetCommon(const _name: String; const _mean: String): String;
var
    Atom: TMP4Atom;
    XtraContent: String;
begin
    Result := '';
    Atom := FindAtomCommon('----', _name, _mean);
    if Assigned(Atom) then begin
        Result := Atom.GetAsText;
    end;

    if (XtraPriority = mp4epCommonHasPriority)
    AND (Result <> '')
    then begin
        Exit;
    end;

    case XtraUsageConversion of
        mp4eucParse, mp4eucParseAndWrite: begin
            if SameText(_name, 'RATING')
            OR SameText(_name, 'SharedUserRating')
            then begin
                XtraContent := GetTextXtra('WM/SharedUserRating');
                if XtraContent <> '' then begin
                    XtraContent := IntToStr(Trunc((StrToIntDef(XtraContent, 0) / 99) * High(Byte)));
                end;
            end;
            if SameText(_name, 'AuthorURL') then begin
                XtraContent := GetTextXtra('WM/AuthorURL');
            end;
            if SameText(_name, 'PromotionURL') then begin
                XtraContent := GetTextXtra('WM/PromotionURL');
            end;
            if SameText(_name, 'SubTitle') then begin
                XtraContent := GetTextXtra('WM/SubTitle');
            end;
            if SameText(_name, 'Category') then begin
                XtraContent := GetTextXtra('WM/Category');
            end;
            if SameText(_name, 'Producer') then begin
                XtraContent := GetTextXtra('WM/Producer');
            end;
            if SameText(_name, 'EncodedBy') then begin
                XtraContent := GetTextXtra('WM/EncodedBy');
            end;
            if SameText(_name, 'Conductor') then begin
                XtraContent := GetTextXtra('WM/Conductor');
            end;
            if SameText(_name, 'ParentalRating') then begin
                XtraContent := GetTextXtra('WM/ParentalRating');
            end;
            if SameText(_name, 'Writer')
            OR SameText(_name, 'WRITTEN_BY')
            then begin
                XtraContent := GetTextXtra('WM/Writer');
            end;
            if SameText(_name, 'Director')
            OR SameText(_name, 'DIRECTED_BY')
            then begin
                XtraContent := GetTextXtra('WM/Director');
            end;
            if SameText(_name, 'Publisher') then begin
                XtraContent := GetTextXtra('WM/Publisher');
            end;
            if SameText(_name, 'Mood') then begin
                XtraContent := GetTextXtra('WM/Mood');
            end;
            if SameText(_name, 'ContentDistributor')
            OR SameText(_name, 'DISTRIBUTED_BY')
            then begin
                XtraContent := GetTextXtra('WM/ContentDistributor');
            end;
            if SameText(_name, 'InitialKey')
            OR SameText(_name, 'KEY')
            then begin
                XtraContent := GetTextXtra('WM/InitialKey')
            end;
            if SameText(_name, 'Period') then begin
                XtraContent := GetTextXtra('WM/Period');
            end;
            if SameText(_name, 'PartOfSet') then begin
                XtraContent := GetTextXtra('WM/PartOfSet');
            end;
            //* ID GUIDs
            if SameText(_name, 'MediaClassPrimaryID') then begin
                XtraContent := GetTextXtra('WM/MediaClassPrimaryID');
            end;
            if SameText(_name, 'MediaClassSecondaryID') then begin
                XtraContent := GetTextXtra('WM/MediaClassSecondaryID');
            end;
            if SameText(_name, 'WMContentID') then begin
                XtraContent := GetTextXtra('WM/WMContentID');
            end;
            if SameText(_name, 'WMCollectionID') then begin
                XtraContent := GetTextXtra('WM/WMCollectionID');
            end;
            if SameText(_name, 'WMCollectionGroupID') then begin
                XtraContent := GetTextXtra('WM/WMCollectionGroupID');
            end;
        end;
    end;

    //* XtraPriority = mp4epXtraHasPriority
    if XtraContent <> '' then begin
        Result := XtraContent;
    end;

    {
WM/SubTitle
WM/Producer
WM/EncodedBy
WM/Conductor
WM/ParentalRating
WM/Writer
WM/Director
WM/Mood
WM/ContentDistributor
WM/InitialKey
WM/Period
WM/AuthorUR
WM/PromotionURL
WM/Provider
WM/Publisher
WM/Category
WM/UniqueFileIdentifier
WM/ProviderStyle
WM/SharedUserRating
WM/EncodingTime
WM/MediaClassSecondaryID
WM/MediaClassPrimaryID
WM/WMContentID
WM/WMCollectionID
WM/WMCollectionGroupID
AverageLevel
PeakValue
    }

end;

function TMP4Tag.GetInteger16(AtomName: TAtomName): Word;
var
    MP4Atom: TMP4Atom;
begin
    Result := 0;
    MP4Atom := FindAtom(AtomName);
    if Assigned(MP4Atom) then begin
        Result := MP4Atom.GetAsInteger16;
    end;
end;

function TMP4Tag.GetInteger16(const AtomName: String): Word;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetInteger16(AtomID);
end;

function TMP4Tag.GetInteger32(AtomName: TAtomName): DWord;
var
    MP4Atom: TMP4Atom;
begin
    Result := 0;
    MP4Atom := FindAtom(AtomName);
    if Assigned(MP4Atom) then begin
        Result := MP4Atom.GetAsInteger32;
    end;
end;

function TMP4Tag.GetInteger32(const AtomName: String): DWord;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetInteger32(AtomID);
end;

function TMP4Tag.GetInteger48(AtomName: TAtomName; var LowDWord: DWord; HiWord: Word; out Value: UInt64): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    Result := Assigned(MP4Atom) and MP4Atom.GetAsInteger48(LowDWord, HiWord, Value);
end;

function TMP4Tag.GetInteger48(const AtomName: String; var LowDWord: DWord; HiWord: Word; out Value: UInt64): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetInteger48(AtomID, LowDWord, HiWord, Value);
end;

function TMP4Tag.GetInteger64(AtomName: TAtomName; var LowDWord, HiDWord: DWord; out Value: UInt64): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    Result := Assigned(MP4Atom) and MP4Atom.GetAsInteger64(LowDWord, HiDWord, Value);
end;

function TMP4Tag.GetInteger64(const AtomName: String; var LowDWord, HiDWord: DWord; out Value: UInt64): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetInteger64(AtomID, LowDWord, HiDWord, Value);
end;

function TMP4Tag.GetBool(AtomName: TAtomName): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    Result := False;
    MP4Atom := FindAtom(AtomName);
    if Assigned(MP4Atom) then begin
        Result := MP4Atom.GetAsBool;
    end;
end;

function TMP4Tag.GetBool(const AtomName: String): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := GetBool(AtomID);
end;

function TMP4Tag.SetText(AtomName: TAtomName; const Text: String): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if Text <> '' then begin
        if NOT Assigned(MP4Atom) then begin
            MP4Atom := AddAtom(AtomName);
        end;
        Result := MP4Atom.SetAsText(Text);
    end else begin
        if Assigned(MP4Atom) then begin
            DeleteAtom(MP4Atom.Index);
        end;
        Result := True;
    end;
end;

function TMP4Tag.SetText(const AtomName: String; const Text: String): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetText(AtomID, Text);
end;

function TMP4Tag.SetTextXtra(const FieldName, Value: String): Boolean;
var
    Xtra: TMP4Xtra;
    Index: Integer;
begin
    Result := False;
    if FieldName = '' then begin
        Exit;
    end;
    if Value <> '' then begin
        Xtra := FindAtomXtra(FieldName);
        if NOT Assigned(Xtra) then begin
            Xtra := AddXtra(FieldName);
        end;
        if Assigned(Xtra) then begin
            Result := Xtra.SetAsText(Value);
        end;
    end else begin
        Index := FindAtomXtraIndex(FieldName);
        if Index > - 1 then begin
            Result := DeleteXtra(Index);
        end;
    end;
end;

function TMP4Tag.SetInteger8(AtomName: TAtomName; Value: Byte): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger8(Value);
end;

function TMP4Tag.SetInteger8(const AtomName: String; Value: Byte): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger8(AtomID, Value);
end;

function TMP4Tag.SetIntegerXtra(const FieldName: String; Value: Int64): Boolean;
var
    Xtra: TMP4Xtra;
begin
    Result := False;
    Xtra := FindAtomXtra(FieldName);
    if NOT Assigned(Xtra) then begin
        Xtra := AddXtra(FieldName);
    end;
    if Assigned(Xtra) then begin
        Result := Xtra.SetAsInteger(Value);
    end;
end;

function TMP4Tag.SetList(AtomName: TAtomName; List: TStrings): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsList(List);
end;

function TMP4Tag.SetList(const AtomName: String; List: TStrings): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetList(AtomID, List);
end;

function TMP4Tag.SetCommon(const _name: String; const _mean: String; const Value: String): Boolean;
var
    Atom: TMP4Atom;
    SetXtra: Boolean;
    IntValue: Integer;
begin
    Result := False;
    //Atom := nil;
    if Value = '' then begin
        Atom := FindAtomCommon('----', _name, _mean);
        if Assigned(Atom) then begin
            DeleteAtom(Atom.Index);
        end;
        Result := True;
    end;
    //* Xtra
    SetXtra := False;
    if (XtraUsageConversion = mp4eucWriteJustXtra)
    OR (XtraUsageConversion = mp4eucWrite)
    then begin
        //* Xtra stuff
        case XtraUsageConversion of
            mp4eucWrite, mp4eucParseAndWrite: begin
                if SameText(_name, 'RATING')
                OR SameText(_name, 'SharedUserRating')
                then begin
                    if Pos('=', Value) > 0 then begin
                        IntValue := StrToIntDef(Copy(Value, Pos('=', Value) + 1, Length(Value)), - 1);
                    end else begin
                        IntValue := StrToIntDef(Value, - 1);
                    end;
                    IntValue := Trunc((IntValue / High(Byte)) * 99);
                    if IntValue > - 1 then begin
                        SetXtra := Self.SetIntegerXtra('WM/SharedUserRating', IntValue);
                    end;
                end;
                if SameText(_name, 'AuthorURL') then begin
                    SetXtra := SetTextXtra('WM/AuthorURL', Value);
                end;
                if SameText(_name, 'PromotionURL') then begin
                    SetXtra := SetTextXtra('WM/PromotionURL', Value);
                end;
                if SameText(_name, 'SubTitle') then begin
                    SetXtra := SetTextXtra('WM/SubTitle', Value);
                end;
                if SameText(_name, 'Category') then begin
                    SetXtra := SetTextXtra('WM/Category', Value);
                end;
                if SameText(_name, 'Producer') then begin
                    SetXtra := SetTextXtra('WM/Producer', Value);
                end;
                if SameText(_name, 'EncodedBy') then begin
                    SetXtra := SetTextXtra('WM/EncodedBy', Value);
                end;
                if SameText(_name, 'Conductor') then begin
                    SetXtra := SetTextXtra('WM/Conductor', Value);
                end;
                if SameText(_name, 'ParentalRating') then begin
                    SetXtra := SetTextXtra('WM/ParentalRating', Value);
                end;
                if SameText(_name, 'Writer')
                OR SameText(_name, 'WRITTEN_BY')
                then begin
                    SetXtra := SetTextXtra('WM/Writer', Value);
                end;
                if SameText(_name, 'Director')
                OR SameText(_name, 'DIRECTED_BY')
                then begin
                    SetXtra := SetTextXtra('WM/Director', Value);
                end;
                if SameText(_name, 'Publisher') then begin
                    SetXtra := SetTextXtra('WM/Publisher', Value);
                end;
                if SameText(_name, 'Mood') then begin
                    SetXtra := SetTextXtra('WM/Mood', Value);
                end;
                if SameText(_name, 'ContentDistributor')
                OR SameText(_name, 'DISTRIBUTED_BY')
                then begin
                    SetXtra := SetTextXtra('WM/ContentDistributor', Value);
                end;
                if SameText(_name, 'InitialKey')
                OR SameText(_name, 'KEY')
                then begin
                    SetXtra := SetTextXtra('WM/InitialKey', Value);
                end;
                if SameText(_name, 'Period') then begin
                    SetXtra := SetTextXtra('WM/Period', Value);
                end;
                if SameText(_name, 'PartOfSet') then begin
                    SetXtra := SetTextXtra('WM/PartOfSet', Value);
                end;
                //* ID GUIDs
                if SameText(_name, 'MediaClassPrimaryID') then begin
                    SetXtra := SetGUIDXtra('WM/MediaClassPrimaryID', StringToGUID(Value));
                end;
                if SameText(_name, 'MediaClassSecondaryID') then begin
                    SetXtra := SetGUIDXtra('WM/MediaClassSecondaryID', StringToGUID(Value));
                end;
                if SameText(_name, 'WMContentID') then begin
                    SetXtra := SetGUIDXtra('WM/WMContentID', StringToGUID(Value));
                end;
                if SameText(_name, 'WMCollectionID') then begin
                    SetXtra := SetGUIDXtra('WM/WMCollectionID', StringToGUID(Value));
                end;
                if SameText(_name, 'WMCollectionGroupID') then begin
                    SetXtra := SetGUIDXtra('WM/WMCollectionGroupID', StringToGUID(Value));
                end;
            end;
        end;
    end;


    {
WM/SubTitle
WM/Producer
WM/EncodedBy
WM/Conductor
WM/ParentalRating
WM/Writer
WM/Director
WM/Mood
WM/ContentDistributor
WM/InitialKey
WM/Period
WM/AuthorUR
WM/PromotionURL
WM/Provider
WM/Publisher
WM/Category
WM/UniqueFileIdentifier
WM/ProviderStyle
WM/SharedUserRating
WM/EncodingTime
WM/MediaClassSecondaryID
WM/MediaClassPrimaryID
WM/WMContentID
WM/WMCollectionID
WM/WMCollectionGroupID
AverageLevel
PeakValue
    }

    //* Exit if we're done
    if (XtraUsageConversion = mp4eucWriteJustXtra)
    AND SetXtra
    then begin
        Result := True;
        Exit;
    end;
    //* Set the common atom
    if Value <> '' then begin
        Atom := FindAtomCommon('----', _name, _mean);
        if NOT Assigned(Atom) then begin
            Atom := AddAtom('----');
        end;
        Result := Atom.SetAsCommonText(_name, _mean, Value);
    end;
end;

function TMP4Tag.SetInteger16(AtomName: TAtomName; Value: Word): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger16(Value);
end;

function TMP4Tag.SetInteger16(const AtomName: String; Value: Word): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger16(AtomID, Value);
end;

function TMP4Tag.SetInteger32(AtomName: TAtomName; Value: DWord): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger32(Value);
end;

function TMP4Tag.SetInteger32(const AtomName: String; Value: DWord): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger32(AtomID, Value);
end;

function TMP4Tag.SetInteger48(AtomName: TAtomName; Value: UInt64): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger48(Value);
end;

function TMP4Tag.SetInteger48(const AtomName: String; Value: UInt64): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger48(AtomID, Value);
end;

function TMP4Tag.SetInteger48(AtomName: TAtomName; LowDWord: DWord; HighWord: Word): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger48(LowDWord, HighWord);
end;

function TMP4Tag.SetInteger48(const AtomName: String; LowDWord: DWord; HighWord: Word): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger48(AtomID, LowDWord, HighWord);
end;

function TMP4Tag.SetInteger64(AtomName: TAtomName; Value: UInt64): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger64(Value);
end;

function TMP4Tag.SetInteger64(const AtomName: String; Value: UInt64): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger64(AtomID, Value);
end;

function TMP4Tag.SetInteger64(AtomName: TAtomName; LowDWord, HighDWord: DWord): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsInteger64(LowDWord, HighDWord);
end;

function TMP4Tag.SetInteger64(const AtomName: String; LowDWord, HighDWord: DWord): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetInteger64(AtomID, LowDWord, HighDWord);
end;

function TMP4Tag.SetBool(AtomName: TAtomName; Value: Boolean): Boolean;
var
    MP4Atom: TMP4Atom;
begin
    MP4Atom := FindAtom(AtomName);
    if NOT Assigned(MP4Atom) then begin
        MP4Atom := AddAtom(AtomName);
    end;
    Result := MP4Atom.SetAsBool(Value);
end;

function TMP4Tag.SetBool(const AtomName: String; Value: Boolean): Boolean;
var
    AtomID: TAtomName;
begin
    AtomID := ClearAtomName;
    StringToAtomName(AtomName, AtomID);
    Result := SetBool(AtomID, Value);
end;

function TMP4Tag.GetMediaType: String;
begin
    if FindAtom('stik') <> nil then
        Result := MediaTypeToStr(GetInteger16('stik'))
    else
        Result := '';
end;

function TMP4Tag.SetMediaType(Media: String): Boolean;
begin
    Result := False;
    if Media = 'Movie' then begin
        Result := SetInteger16('stik', 9);
    end;
    if Media = 'Music' then begin
        Result := SetInteger16('stik', 1);
    end;
    if Media = 'Audiobook' then begin
        Result := SetInteger16('stik', 2);
    end;
    if Media = 'Music Video' then begin
        Result := SetInteger16('stik', 6);
    end;
    if Media = 'TV Show' then begin
        Result := SetInteger16('stik', 10);
    end;
    if Media = 'Booklet' then begin
        Result := SetInteger16('stik', 11);
    end;
    if Media = 'Ringtone' then begin
        Result := SetInteger16('stik', 14);
    end;
end;

function TMP4Tag.GetTrack: Word;
var
    LowDWord: DWord;
    HighWord: Word;
    Value: UInt64;
begin
    Result := 0;
    LowDWord := 0;
    HighWord := 0;
    if GetInteger48('trkn', LowDWord, HighWord, Value) then begin
        Result := HiWord(LowDWord);
    end;
end;

function TMP4Tag.GetTotalTracks: Word;
var
    LowDWord: DWord;
    HighWord: Word;
    Value: UInt64;
begin
    Result := 0;
    LowDWord := 0;
    HighWord := 0;
    if GetInteger48('trkn', LowDWord, HighWord, Value) then begin
        Result := LoWord(LowDWord);
    end;
end;

function TMP4Tag.GetDisc: Word;
var
    LowDWord: DWord;
    HighWord: Word;
    Value: UInt64;
begin
    Result := 0;
    LowDWord := 0;
    HighWord := 0;
    if GetInteger48('disk', LowDWord, HighWord, Value) then begin
        Result := HiWord(LowDWord);
    end;
end;

function TMP4Tag.GetTotalDiscs: Word;
var
    LowDWord: DWord;
    HighWord: Word;
    Value: UInt64;
begin
    Result := 0;
    LowDWord := 0;
    HighWord := 0;
    if GetInteger48('disk', LowDWord, HighWord, Value) then begin
        Result := LoWord(LowDWord);
    end;
end;

function TMP4Tag.SetTrack(Track: Word; TotalTracks: Word): Boolean;
var
    LowDWord: DWord;
    HighDWord: DWord;
    Atom: TMP4Atom;
begin
    if (Track = 0)
    AND (TotalTracks = 0)
    then begin
        Atom := FindAtom('trkn');
        if Assigned(Atom) then begin
            DeleteAtom(Atom.Index);
        end;
        Result := True;
    end else begin
        LowDWord := TotalTracks SHL 16;
        HighDWord := Track;
        Result := SetInteger64('trkn', LowDWord, HighDWord);
    end;
end;

function TMP4Tag.SetDisc(Disc: Word; TotalDiscs: Word): Boolean;
var
    Value: DWord;
    Atom: TMP4Atom;
begin
    if (Disc = 0)
    AND (TotalDiscs = 0)
    then begin
        Atom := FindAtom('disk');
        if Assigned(Atom) then begin
            DeleteAtom(Atom.Index);
        end;
        Result := True;
    end else begin
        Value := (Disc SHL 16) + TotalDiscs;
        Result := SetInteger48('disk', Value, 0);
    end;
end;

(*
function GetAudioAttributes(MP4Tag: TMP4Tag; MP4Stream: TStream): Boolean;
var
    AtomName: TAtomName;
    AtomSize: Int64;
    moovAtomSize: Int64;
    Is64BitAtomSize: Boolean;
    PreviousPosition: Int64;
    NumberOfDescriptions: Cardinal;
    AudioChannels: Word;
    SampleSize: Word;
    SampleRate: Cardinal;
begin
    Result := False;
    MP4Tag.Resolution := 0;
    MP4Tag.SampleRate := 0;
    PreviousPosition := MP4Stream.Position;
    try
        try
            MP4Stream.Seek(0, soBeginning);
            try
                ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize, False);
            except
                //* Will except if not an MP4 file and MP4TagLibraryFailOnCorruptFile is True
            end;
            if NOT IsSameAtomName(AtomName, 'ftyp') then begin
                Exit;
            end;
            //* Continue loading
            MP4Stream.Seek(AtomSize - 8, soCurrent);
            repeat
                ReadAtomHeader(MP4Stream, AtomName, moovAtomSize, Is64BitAtomSize);
                if IsSameAtomName(AtomName, 'moov') then begin
                    repeat
                        ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                        if IsSameAtomName(AtomName, 'trak') then begin
                            repeat
                                ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                                if IsSameAtomName(AtomName, 'mdia') then begin
                                    repeat
                                        ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                                        if IsSameAtomName(AtomName, 'minf') then begin
                                            repeat
                                                ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                                                if IsSameAtomName(AtomName, 'stbl') then begin
                                                    repeat
                                                        ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                                                        if IsSameAtomName(AtomName, 'stsd') then begin
                                                            MP4Stream.Seek(4, soCurrent);
                                                            MP4Stream.Read2(NumberOfDescriptions, 4);
                                                            NumberOfDescriptions := ReverseBytes32(NumberOfDescriptions);
                                                            if NumberOfDescriptions = 1 then begin
                                                                repeat
                                                                    ReadAtomHeader(MP4Stream, AtomName, AtomSize, Is64BitAtomSize);
                                                                    if IsSameAtomName(AtomName, 'mp4a') then begin
                                                                        MP4Stream.Seek($10, soCurrent);
                                                                        MP4Stream.Read2(AudioChannels, 2);
                                                                        MP4Tag.ChannelCount := ReverseBytes16(AudioChannels);
                                                                        MP4Stream.Read2(SampleSize, 2);
                                                                        MP4Tag.Resolution := ReverseBytes16(SampleSize);
                                                                        MP4Stream.Seek(2, soCurrent);
                                                                        MP4Stream.Read2(SampleRate, 4);
                                                                        MP4Tag.SampleRate := ReverseBytes32(SampleRate);
                                                                        Exit;
                                                                    end else begin
                                                                        if Is64BitAtomSize then begin
                                                                            MP4Stream.Seek(AtomSize - 16, soCurrent);
                                                                        end else begin
                                                                            MP4Stream.Seek(AtomSize - 8, soCurrent);
                                                                        end;
                                                                    end;
                                                                until (MP4Stream.Position >= MP4Stream.Size)
                                                                OR (MP4Stream.Position + AtomSize >= MP4Stream.Size);
                                                            end;
                                                        end else begin
                                                            if Is64BitAtomSize then begin
                                                                MP4Stream.Seek(AtomSize - 16, soCurrent);
                                                            end else begin
                                                                MP4Stream.Seek(AtomSize - 8, soCurrent);
                                                            end;
                                                        end;
                                                    until (MP4Stream.Position >= MP4Stream.Size)
                                                    OR (MP4Stream.Position + AtomSize >= MP4Stream.Size);
                                                end else begin
                                                    if Is64BitAtomSize then begin
                                                        MP4Stream.Seek(AtomSize - 16, soCurrent);
                                                    end else begin
                                                        MP4Stream.Seek(AtomSize - 8, soCurrent);
                                                    end;
                                                end;
                                            until (MP4Stream.Position >= MP4Stream.Size)
                                            OR (MP4Stream.Position + AtomSize >= MP4Stream.Size);
                                        end else begin
                                            if Is64BitAtomSize then begin
                                                MP4Stream.Seek(AtomSize - 16, soCurrent);
                                            end else begin
                                                MP4Stream.Seek(AtomSize - 8, soCurrent);
                                            end;
                                        end;
                                    until (MP4Stream.Position >= MP4Stream.Size)
                                    OR (MP4Stream.Position + AtomSize >= MP4Stream.Size);
                                end else begin
                                    if Is64BitAtomSize then begin
                                        MP4Stream.Seek(AtomSize - 16, soCurrent);
                                    end else begin
                                        MP4Stream.Seek(AtomSize - 8, soCurrent);
                                    end;
                                end;
                            until MP4Stream.Position >= MP4Stream.Size;
                        end else begin
                            if Is64BitAtomSize then begin
                                MP4Stream.Seek(AtomSize - 16, soCurrent);
                            end else begin
                                MP4Stream.Seek(AtomSize - 8, soCurrent);
                            end;
                        end;
                    until MP4Stream.Position >= MP4Stream.Size;
                end else begin
                    if Is64BitAtomSize then begin
                        MP4Stream.Seek(moovAtomSize - 16, soCurrent);
                    end else begin
                        MP4Stream.Seek(moovAtomSize - 8, soCurrent);
                    end;
                end;
            until (MP4Stream.Position >= MP4Stream.Size)
            OR (moovAtomSize = 0);
        except
            Result := False
        end;
    finally
        MP4Stream.Seek(PreviousPosition, soBeginning);
    end;
end;
*)

function TMP4Tag.GetGenre: String;
var
    GenreIndex: Integer;
    GenreString: String;
begin
    Result := '';
    GenreString := '';
    GenreIndex := GetInteger16('gnre');
    if (GenreIndex >= Low(ID3Genres))
    AND (GenreIndex <= High(ID3Genres))
    then begin
        GenreString := ID3Genres[GenreIndex];
    end;
    if GenreString = '' then begin
        GenreString := GetText('©gen');
    end;
    Result := GenreString;
end;

function TMP4Tag.GetGUIDXtra(const FieldName: String; out Value: TGUID): Boolean;
var
    Xtra: TMP4Xtra;
begin
    Result := False;
    Xtra := FindAtomXtra(FieldName);
    if Assigned(Xtra) then begin
        Result := Xtra.GetAsGUID(Value);
    end;
end;

function TMP4Tag.SetGenre(const Genre: String): Boolean;
var
    GenreIndex: Integer;
begin
    DeleteAllAtoms('gnre');
    DeleteAllAtoms('©gen');
    if Genre = '' then begin
        Result := True;
        Exit;
    end;
    GenreIndex := GenreToIndex(Genre);
    if GenreIndex > - 1 then begin
        Result := SetInteger16('gnre', GenreIndex);
    end else begin
        Result := SetText('©gen', Genre);
    end;
end;

function TMP4Tag.SetGUIDXtra(const FieldName: String; Value: TGUID): Boolean;
var
    Xtra: TMP4Xtra;
begin
    Result := False;
    Xtra := FindAtomXtra(FieldName);
    if NOT Assigned(Xtra) then begin
        Xtra := AddXtra(FieldName);
    end;
    if Assigned(Xtra) then begin
        Result := Xtra.SetAsGUID(Value);
    end;
end;

function TMP4Tag.GetPurchaseCountry: String;
var
    Value: UInt64;
begin
    Result := '';
    if not GetInteger('sfID', Value) then
        Exit;
    case Value of
        143460: Result := 'Australia';
        143445: Result := 'Austria';
        143446: Result := 'Belgium';
        143455: Result := 'Canada';
        143458: Result := 'Denmark';
        143447: Result := 'Finland';
        143442: Result := 'France';
        143443: Result := 'Germany';
        143448: Result := 'Greece';
        143449: Result := 'Ireland';
        143450: Result := 'Italy';
        143462: Result := 'Japan';
        143451: Result := 'Luxembourg';
        143452: Result := 'Netherlands';
        143461: Result := 'New Zealand';
        143457: Result := 'Norway';
        143453: Result := 'Portugal';
        143454: Result := 'Spain';
        143456: Result := 'Sweden';
        143459: Result := 'Switzerland';
        143444: Result := 'United Kingdom';
        143441: Result := 'United States';
        else begin
            if Value <> 0 then begin
                {$IFDEF FPC}
                Result := IntToStr(Value);
                {$ELSE}
                Result := UIntToStr(Value);
                {$ENDIF}
            end;
        end;
    end;
end;

function TMP4Tag.SetPurchaseCountry(Country: String): Boolean;
var
    Value: Integer;
begin
    Value := 0;
    if Country = 'Australia' then begin
        Value := 143460;
    end;
    if Country = 'Austria' then begin
        Value := 143445;
    end;
    if Country = 'Belgium' then begin
        Value := 143446;
    end;
    if Country = 'Canada' then begin
        Value := 143455;
    end;
    if Country = 'Denmark' then begin
        Value := 143458;
    end;
    if Country = 'Finland' then begin
        Value := 143447;
    end;
    if Country = 'France' then begin
        Value := 143442;
    end;
    if Country = 'Germany' then begin
        Value := 143443;
    end;
    if Country = 'Greece' then begin
        Value := 143448;
    end;
    if Country = 'Ireland' then begin
        Value := 143449;
    end;
    if Country = 'Italy' then begin
        Value := 143450;
    end;
    if Country = 'Japan' then begin
        Value := 143462;
    end;
    if Country = 'Luxembourg' then begin
        Value := 143451;
    end;
    if Country = 'Netherlands' then begin
        Value := 143452;
    end;
    if Country = 'New Zealand' then begin
        Value := 143461;
    end;
    if Country = 'Norway' then begin
        Value := 143457;
    end;
    if Country = 'Portugal' then begin
        Value := 143453;
    end;
    if Country = 'Spain' then begin
        Value := 143454;
    end;
    if Country = 'Sweden' then begin
        Value := 143456;
    end;
    if Country = 'Switzerland' then begin
        Value := 143459;
    end;
    if Country = 'United Kingdom' then begin
        Value := 143444;
    end;
    if Country = 'United States' then begin
        Value := 143441;
    end;
    if Value = 0 then begin
        Value := StrToIntDef(Country, 0);
    end;
    Result := SetInteger32('sfID', Value);
end;

function TMP4Tag.Assign(MP4Tag: TMP4Tag): Boolean;
var
    i: Integer;
begin
    Clear;
    if Assigned(MP4Tag) then begin
        FileName := MP4Tag.FileName;
        FLoaded := MP4Tag.Loaded;
        Version := MP4Tag.Version;
        Flags := MP4Tag.Flags;
        PaddingToWrite := MP4Tag.PaddingToWrite;
        for i := 0 to MP4Tag.Count - 1 do begin
            AddAtom(MP4Tag.Atoms[i].ID).Assign(MP4Tag.Atoms[i]);
        end;
        for i := 0 to MP4Tag.Xtras.Count - 1 do begin
            AddXtra(MP4Tag.Xtras[i].Name).Assign(MP4Tag.Xtras[i]);
        end;
    end;
    Result := True;
end;

function TMP4Tag.GetMultipleValuesMultipleAtoms(AtomName: String; List: TStrings): Boolean;
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    Result := GetMultipleValuesMultipleAtoms(ID, List);
end;

function TMP4Tag.GetMultipleValuesMultipleAtoms(AtomName: TAtomName; List: TStrings): Boolean;
var
    i: Integer;
begin
    List.clear;
    for i := 0 to Count - 1 do begin
        if IsSameAtomName(Atoms[i].ID, AtomName) then begin
            List.Add(Atoms[i].GetAsText);
        end;
    end;
    Result := List.count > 0;
end;

procedure TMP4Tag.SetMultipleValuesCommaSeparated(AtomName: String; List: TStrings);
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    SetMultipleValuesCommaSeparated(ID, List);
end;

procedure TMP4Tag.SetMultipleValuesCommaSeparated(AtomName: TAtomName; List: TStrings);
var
    i: Integer;
    Text: String;
begin
    for i := Count - 1 downto 0 do begin
        if IsSameAtomName(Atoms[i].ID, AtomName) then begin
            DeleteAtom(i);
        end;
    end;
    for i := 0 to List.count - 1 do begin
        if i < List.count - 1 then begin
            Text := List[i] + ', ';
        end else begin
            Text := List[i];
        end;
    end;
    AddAtom(AtomName).SetAsText(Text);
end;

procedure TMP4Tag.SetMultipleValuesMultipleAtoms(AtomName: String; List: TStrings);
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    SetMultipleValuesMultipleAtoms(ID, List);
end;

procedure TMP4Tag.SetMultipleValuesMultipleAtoms(AtomName: TAtomName; List: TStrings);
var
    i: Integer;
begin
    for i := Count - 1 downto 0 do begin
        if IsSameAtomName(Atoms[i].ID, AtomName) then begin
            DeleteAtom(i);
        end;
    end;
    for i := 0 to List.count - 1 do begin
        AddAtom(AtomName).SetAsText(List[i]);
    end;
end;

function TMP4Tag.DeleteAllAtoms(AtomName: TAtomName): Boolean;
var
    i: Integer;
begin
    Result := False;
    for i := Atoms.Count - 1 downto 0 do begin
        if IsSameAtomName(Atoms[i].ID, AtomName) then begin
            DeleteAtom(i);
            Result := True;
        end;
    end;
end;

function TMP4Tag.DeleteAllAtoms(const AtomName: String): Boolean;
var
    ID: TAtomName;
begin
    ID := ClearAtomName;
    StringToAtomName(AtomName, ID);
    Result := DeleteAllAtoms(ID);
end;

{ TMP4Xtra }

function TMP4Xtra.Assign(Xtra: TMP4Xtra): Boolean;
begin
    if Assigned(Xtra) then begin
        Self.Name := Xtra.Name;
        Self.PropType := Xtra.PropType;
        Self.Data.Clear;
        Self.Data.CopyFrom(Xtra.Data, 0);
        Self.Data.Seek(0, soBeginning);
        Xtra.Data.Seek(0, soBeginning);
    end else begin
        Clear;
    end;
    Result := True;
end;

procedure TMP4Xtra.Clear;
begin
    Name := '';
    PropType := 0;
    Data.Clear;
end;

constructor TMP4Xtra.Create;
begin
    inherited;
    Data := TMemoryStream.Create;
end;

destructor TMP4Xtra.Destroy;
begin
    FreeAndNil(Data);
    inherited;
end;

function TMP4Xtra.GetAsGUID(out Value: TGUID): Boolean;
begin
    Data.Seek(0, soBeginning);
    Data.Read(Pointer(@Value.D1)^, 16);
    Result := True;
    AlreadyParsed := True;
end;

function TMP4Xtra.GetAsInteger(out Value: Int64): Boolean;
var
    DataByte: Byte;
    DataWord: Word;
    DataDWord: DWord;
    Data64: Int64;
begin
    Result := False;
    Data.Seek(0, soBeginning);
    case Data.Size of
        1: begin
            Data.Read(DataByte, Data.Size);
            Value := DataByte;
            Result := True;
        end;
        2: begin
            Data.Read(DataWord, Data.Size);
            Value := DataWord;
            Result := True
        end;
        4: begin
            Data.Read(DataDWord, Data.Size);
            Value := DataDWord;
            Result := True
        end;
        8: begin
            Data.Read(Data64, Data.Size);
            Value := Data64;
            Result := True
        end;
    end;
    AlreadyParsed := True;
end;

function TMP4Xtra.GetAsDateTime(out Value: TDateTime): Boolean;
var
    Data64: UInt64;
begin
    Value := 0;
    Data.Seek(0, soBeginning);
    Data.Read(Data64, SizeOf(Data64));
    Value := IncMilliSecond(Value, Data64 div 10000);
    Value := IncYear(Value, - 299);
    Value := IncDay(Value, + 2);
    {$IFNDEF FPC}
    Value := TTimeZone.Local.ToLocalTime(Value);
    {$ENDIF}
    Result := True;
    AlreadyParsed := True;
end;

function TMP4Xtra.GetAsText: String;
var
    TagValueBytes: TBytes;
    GUID: TGUID;
    Number: Int64;
    DateTime: TDateTime;
begin
    Result := '';
    if PropType = MP4_XTRA_BT_GUID then begin
        GetAsGUID(GUID);
        Result := GUIDToString(GUID);
    end else if PropType = MP4_XTRA_BT_INT64 then begin
        if GetAsInteger(Number) then begin
            Result := IntToStr(Number);
        end;
    end else if (PropType = MP4_XTRA_BT_UNICODE) then begin
        SetLength(TagValueBytes, Data.Size);
        Data.Seek(0, soBeginning);
        Data.Read(TagValueBytes[0], Data.Size);
        Result := TEncoding.Unicode.GetString(TagValueBytes);
    end else if (PropType = MP4_XTRA_BT_FILETIME) then begin
        GetAsDateTime(DateTime);
        Result := DateTimeToStr(DateTime);
    end else begin
        Result := IntToStr(Data.Size) + ' bytes';
    end;
end;

function TMP4Xtra.GetIndex: Integer;
begin
    Result := Self.Parent.Xtras.IndexOf(Self);
end;

function TMP4Xtra.SetAsGUID(Value: TGUID): Boolean;
begin
    Data.Clear;
    Data.Write(Pointer(@Value.D1)^, 16);
    Data.Seek(0, soBeginning);
    PropType := MP4_XTRA_BT_GUID;
    Result := True;
end;

function TMP4Xtra.SetAsInteger(Value: Int64): Boolean;
begin
    Data.Clear;
    Data.Write(Value, 8);
    Data.Seek(0, soBeginning);
    PropType := MP4_XTRA_BT_INT64;
    Result := True;
end;

function TMP4Xtra.SetAsText(const Value: String): Boolean;
var
    DataBytes: TBytes;
begin
    Data.Clear;
    DataBytes := TEncoding.Unicode.GetBytes(Value);
    Data.Write(DataBytes[0], Length(DataBytes));
    Data.Seek(0, soBeginning);
    PropType := MP4_XTRA_BT_UNICODE;
    Result := True;
end;

function TMP4Xtra.SetAsDateTime(Value: TDateTime): Boolean;

    function Time2mSec(Value: TDateTime): UInt64;
    Const
        MS = 1.15740740740741E-8;
    begin
        Result := Round(Value / MS);
    end;

var
    Data64: UInt64;
begin
    Data64 := 0;
    {$IFNDEF FPC}
    Value := TTimeZone.Local.ToUniversalTime(Value);
    {$ENDIF}
    Value := IncDay(Value, - 2);
    Value := IncYear(Value, + 299);
    Data64 := Time2mSec(Value) * 10000;
    Data.Clear;
    Data.Write(Data64, SizeOf(Data64));
    Data.Seek(0, soBeginning);
    PropType := MP4_XTRA_BT_FILETIME;
    Result := True;
end;

function MP4TagErrorCode2String(ErrorCode: Integer): String;
begin
    Result := 'Unknown error code.';
    case ErrorCode of
        MP4TAGLIBRARY_SUCCESS: Result := 'Success.';
        MP4TAGLIBRARY_ERROR: Result := 'Unknown error occured.';
        MP4TAGLIBRARY_ERROR_NO_TAG_FOUND: Result := 'No MP4 tag found.';
        MP4TAGLIBRARY_ERROR_EMPTY_TAG: Result := 'MP4 tag is empty.';
        MP4TAGLIBRARY_ERROR_EMPTY_FRAMES: Result := 'MP4 tag contains only empty frames.';
        MP4TAGLIBRARY_ERROR_OPENING_FILE: Result := 'Error opening file.';
        MP4TAGLIBRARY_ERROR_READING_FILE: Result := 'Error reading file.';
        MP4TAGLIBRARY_ERROR_WRITING_FILE: Result := 'Error writing file.';
        MP4TAGLIBRARY_ERROR_DOESNT_FIT: Result := 'Error: MP4 tag doesn''t fit into the file.';
        MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := 'Error: not supported MP4 version.';
        MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := 'Error: not supported file format.';
        MP4TAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := 'Error: file is locked. Need exclusive access to write MP4 tag to this file.';
        MP4TAGLIBRARY_ERROR_UPDATE_stco: Result := 'Error: updating MP4 ''stco'' atom.';
        MP4TAGLIBRARY_ERROR_UPDATE_co64: Result := 'Error: updating MP4 ''co64'' atom.';
    end;
end;

Initialization

    MP4AtomDataID[0] := Ord('d');
    MP4AtomDataID[1] := Ord('a');
    MP4AtomDataID[2] := Ord('t');
    MP4AtomDataID[3] := Ord('a');

    MP4AtommeanID[0] := Ord('m');
    MP4AtommeanID[1] := Ord('e');
    MP4AtommeanID[2] := Ord('a');
    MP4AtommeanID[3] := Ord('n');

    MP4AtomnameID[0] := Ord('n');
    MP4AtomnameID[1] := Ord('a');
    MP4AtomnameID[2] := Ord('m');
    MP4AtomnameID[3] := Ord('e');

end.
