//********************************************************************************************************************************
//*                                                                                                                              *
//*     WAV Tag Library 1.0.23.35 © 3delite 2014-2020                                                                            *
//*     See WAV Tag Library ReadMe.txt for details.                                                                              *
//*                                                                                                                              *
//* Licenses available for usage of this component:                                                                              *
//* Freeware License: €15                                                                                                        *
//*     http://www.shareit.com/product.html?productid=300953215                                                                  *
//* Shareware License: €25                                                                                                       *
//*     http://www.shareit.com/product.html?productid=300625530                                                                  *
//* Commercial License: €100                                                                                                     *
//*     http://www.shareit.com/product.html?productid=300625529                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                        *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                          *
//*                                                                                                                              *
//* There is an ID3v2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                         *
//*                                                                                                                              *
//* and an APEv2 Library available at:                                                                                           *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                         *
//*                                                                                                                              *
//* and an MP4 Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                        *
//*                                                                                                                              *
//* and an Ogg Vorbis and Opus Tag Library available at:                                                                         *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                       *
//*                                                                                                                              *
//* a Flac Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                       *
//*                                                                                                                              *
//* a WMA Tag Library available at:                                                                                              *
//*                                                                                                                              *
//*     https://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                        *
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

unit WAVTagLibrary;

{$MINENUMSIZE 4}

{$IFDEF FPC}
    {$MODE DELPHI}{$H+}
{$ENDIF}

interface

Uses
    SysUtils,
    Classes,
    Generics.Collections;

Const
    WAVTAGLIBRARY_VERSION = $01002335;

Const
    WAVTAGLIBRARY_SUCCESS                       = 0;
    WAVTAGLIBRARY_ERROR                         = $FFFF;
    WAVTAGLIBRARY_ERROR_NO_TAG_FOUND            = 1;
    WAVTAGLIBRARY_ERROR_EMPTY_TAG               = 2;
    WAVTAGLIBRARY_ERROR_EMPTY_FRAMES            = 3;
    WAVTAGLIBRARY_ERROR_OPENING_FILE            = 4;
    WAVTAGLIBRARY_ERROR_READING_FILE            = 5;
    WAVTAGLIBRARY_ERROR_WRITING_FILE            = 6;
    WAVTAGLIBRARY_ERROR_CORRUPT                 = 7;
    WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION   = 8;
    WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT    = 9;
    WAVTAGLIBRARY_ERROR_DOESNT_FIT              = 10;
    WAVTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS   = 11;

Const
    { Format type names }
    WAV_FORMAT_UNKNOWN = 'Unknown';
    WAV_FORMAT_PCM = 'Windows PCM';
    WAV_FORMAT_ADPCM = 'Microsoft ADPCM';
    WAV_FORMAT_IEEE_FLOAT = 'PCM Float or IEEE Float';
    WAV_FORMAT_ALAW = 'A-LAW';
    WAV_FORMAT_MULAW = 'MU-LAW';
    WAV_FORMAT_DVI_IMA_ADPCM = 'DVI/IMA ADPCM';
    WAV_FORMAT_MP3 = 'MPEG Layer III';
    WAV_FORMAT_EXTENSIBLE = 'EXTENSIBLE';

type
    DWord = Cardinal;

type
    TRIFFID = Array [0..3] of Byte;
    TRIFFChunkID = Array [0..3] of Byte;

    TWaveHeader = record
        ident1: TRIFFID;                    // Must be "RIFF"
        len: DWORD;                         // Remaining length after this header
    end;

type
    TWaveds64 = record
        ds64Size: DWORD;
        RIFFSizeLow: DWORD;
        RIFFSizeHigh: DWORD;
        DataSizeLow: DWORD;
        DataSizeHigh: DWORD;
        SampleCountLow: DWORD;
        SampleCountHigh: DWORD;
        TableLength: DWORD;
    end;

type
    TWaveFmt = record
        //ident2: TWAVIdent;                // Must be "WAVE"
        //ident3: TWAVIdent;                // Must be "fmt "
        fmtSize: DWord;                     // Reserved 4 bytes
        FormatTag: Word;                    // format type
        Channels: Word;                     // number of channels (i.e. mono, stereo, etc.)
        SamplesPerSec: DWord;               // sample rate
        AvgBytesPerSec: DWord;              // for buffer estimation
        BlockAlign: Word;                   // block size of data
        BitsPerSample: Word;                // number of bits per sample of mono data
        //* WAVE_FORMAT_EXTENSIBLE
        cbSize: Word;	                    // Size of the extension: 22
        ValidBitsPerSample: Word;	        // at most 8 *  M
        ChannelMask: DWord;	                // Speaker position mask: 0
        SubFormat: Array[0..15] of Byte;    // 16
    end;

type
    // BWF "bext" tag structure
    TAG_BEXT = packed record
        Description: Array[0..255] of Byte;         // description
        Originator: Array[0..31] of Byte;           // name of the originator
        OriginatorReference: Array[0..31] of Byte;  // reference of the originator
        OriginationDate: Array[0..9] of Byte;       // date of creation (yyyy-mm-dd)
        OriginationTime: Array[0..7] of Byte;       // time of creation (hh-mm-ss)
        TimeReference: UInt64;                      // first sample count since midnight (little-endian)
        Version: Word;                              // BWF version (little-endian)
        UMID: Array[0..63] of Byte;                 // SMPTE UMID
        LoudnessValue: Word;                        // Integrated Loudness Value of the file in LUFS (multiplied by 100)
        LoudnessRange: Word;                        // Loudness Range of the file in LU (multiplied by 100)
        MaxTruePeakLevel: Word;                     // Maximum True Peak Level of the file expressed as dBTP (multiplied by 100)
        MaxMomentaryLoudness: Word;                 // Highest value of the Momentary Loudness Level of the file in LUFS (multiplied by 100)
        MaxShortTermLoudness: Word;                 // Highest value of the Short-Term Loudness Level of the file in LUFS (multiplied by 100)
        Reserved: Array[0..179] of Byte;            // reserved
    end;

    TCART_TIMER_Usage = Array[0..3] of Byte;

    TAG_CART_TIMER = packed record
        Usage: TCART_TIMER_Usage;
        Value: DWORD;
    end;

    TTAG_CART_TIMERS = Array[0..7] of TAG_CART_TIMER;

    TCART_TIMER = packed record
        Usage: String;
        Value: DWORD;
    end;

    TAG_CART = packed record
        Version: Array[0..3] of Byte;
        Title: Array[0..63] of Byte;
        Artist: Array[0..63] of Byte;
        CutID: Array[0..63] of Byte;
        ClientID: Array[0..63] of Byte;
        Category: Array[0..63] of Byte;
        Classification: Array[0..63] of Byte;
        OutCue: Array[0..63] of Byte;
        StartDate: Array[0..9] of Byte;
        StartTime: Array[0..7] of Byte;
        EndDate: Array[0..9] of Byte;
        EndTime: Array[0..7] of Byte;
        ProducerAppID: Array[0..63] of Byte;
        ProducerAppVersion: Array[0..63] of Byte;
        UserDef: Array[0..63] of Byte;
        dwLevelReference: DWORD;
        PostTimer: TTAG_CART_TIMERS;
        Reserved: Array[0..275] of Byte;
        URL: Array[0..1023] of Byte;
    end;

    PSPEVENT = ^TSPEVENT;
    TSPEVENT = packed record
        EventID: Word;// 2 bytes (ENUM)
        ParamType: Word;// 2 bytes (ENUM)
        StreamNumber: Cardinal;// is 4 bytes (ULONG)
        AudioStreamOffset: UInt64;// 8 bytes (ULONGLONG)
        wParam: Cardinal;// 4 bytes (WPARAM)
        lParam: Cardinal;// 4 bytes (LONG_PTR)
        TOKENDATA: Array of Byte;
        BOOKMARK: Array of Byte;
    end;

type
    TFixWAVEResult = (fwrFalse, fwrTrue, fwrUnsupported);

type
    TWAVTagFrameFormat = (ffUnknown, ffText, ffBinary);

type
    TWAVTag = class;

    TWAVTagFrame = class
    private
        function GetIndex: Integer;
    public
        Name: String;
        Format: TWAVTagFrameFormat;
        Stream: TMemoryStream;
        Parent: TWAVTag;
        //Index: Integer;
        AlreadyParsed: Boolean;
        Constructor Create(_Parent: TWAVTag);
        Destructor Destroy; override;
        function GetAsText: String;
        function SetAsText(const Text: String): Boolean;
        function GetAsList(var List: TStrings): Boolean;
        function SetAsList(List: TStrings): Boolean;
        procedure Clear;
        function Assign(WAVTagFrame: TWAVTagFrame): Boolean;
        property Index: Integer read GetIndex;
    end;

    TBEXT = class
    private
        function GetDescription: String;
        function GetOriginator: String;
        function GetOriginatorReference: String;
        function GetOriginationDate: String;
        function GetOriginationTime: String;
        function GetTimeReference: UInt64;
        function GetVersion: Word;
        function GetUMID: String;
        function GetReserved: String;
        function GetCodingHistory: String;
        procedure SetDescription(Value: String);
        procedure SetOriginator(Value: String);
        procedure SetOriginatorReference(Value: String);
        procedure SetOriginationDate(Value: String);
        procedure SetOriginationTime(Value: String);
        procedure SetTimeReference(Value: UInt64);
        procedure SetVersion(Value: Word);
        procedure SetUMID(Value: String);
        procedure SetReserved(Value: String);
        procedure SetCodingHistory(Value: String);
        function GetLoudnessValue: Word;
        function GetLoudnessRange: Word;
        function GetMaxTruePeakLevel: Word;
        function GetMaxMomentaryLoudness: Word;
        function GetMaxShortTermLoudness: Word;
        procedure SetLoudnessValue(Value: Word);
        procedure SetLoudnessRange(Value: Word);
        procedure SetMaxTruePeakLevel(Value: Word);
        procedure SetMaxMomentaryLoudness(Value: Word);
        procedure SetMaxShortTermLoudness(Value: Word);
    public
        BEXTChunk: TAG_BEXT;
        CodingHistoryBytes: TBytes;
        Loaded: Boolean;
        procedure Clear;
        function Assign(BEXT: TBEXT): Boolean;
        property Description: String read GetDescription write SetDescription;
        property Originator: String read GetOriginator write SetOriginator;
        property OriginatorReference: String read GetOriginatorReference write SetOriginatorReference;
        property OriginationDate: String read GetOriginationDate write SetOriginationDate;
        property OriginationTime: String read GetOriginationTime write SetOriginationTime;
        property TimeReference: UInt64 read GetTimeReference write SetTimeReference;
        property Version: Word read GetVersion write SetVersion;
        property UMID: String read GetUMID write SetUMID;
        property Reserved: String read GetReserved write SetReserved;
        property CodingHistory: String read GetCodingHistory write SetCodingHistory;
        property LoudnessValue: Word read GetLoudnessValue write SetLoudnessValue;
        property LoudnessRange: Word read GetLoudnessRange write SetLoudnessRange;
        property MaxTruePeakLevel: Word read GetMaxTruePeakLevel write SetMaxTruePeakLevel;
        property MaxMomentaryLoudness: Word read GetMaxMomentaryLoudness write SetMaxMomentaryLoudness;
        property MaxShortTermLoudness: Word read GetMaxShortTermLoudness write SetMaxShortTermLoudness;
    end;

    TCART = class
    private
        function GetVersion: String;
        function GetTitle: String;
        function GetArtist: String;
        function GetCutID: String;
        function GetClientID: String;
        function GetCategory: String;
        function GetClassification: String;
        function GetOutCue: String;
        function GetStartDate: String;
        function GetStartTime: String;
        function GetEndDate: String;
        function GetEndTime: String;
        function GetProducerAppID: String;
        function GetProducerAppVersion: String;
        function GetUserDef: String;
        function GetLevelReference: DWORD;
        function _GetPostTimer: TTAG_CART_TIMERS;
        function GetReserved: String;
        function GetURL: String;
        function GetTagText: String;
        procedure SetVersion(Value: String);
        procedure SetTitle(Value: String);
        procedure SetArtist(Value: String);
        procedure SetCutID(Value: String);
        procedure SetClientID(Value: String);
        procedure SetCategory(Value: String);
        procedure SetClassification(Value: String);
        procedure SetOutCue(Value: String);
        procedure SetStartDate(Value: String);
        procedure SetStartTime(Value: String);
        procedure SetEndDate(Value: String);
        procedure SetEndTime(Value: String);
        procedure SetProducerAppID(Value: String);
        procedure SetProducerAppVersion(Value: String);
        procedure SetUserDef(Value: String);
        procedure SetLevelReference(Value: DWORD);
        procedure _SetPostTimer(Value: TTAG_CART_TIMERS);
        procedure SetReserved(Value: String);
        procedure SetURL(Value: String);
        procedure SetTagText(Value: String);
    public
        CARTChunk: TAG_CART;
        TagTextBytes: TBytes;
        Loaded: Boolean;
        function GetPostTimer(Index: Integer; var CART_TIMER: TCART_TIMER): Boolean;
        function SetPostTimer(Index: Integer; CART_TIMER: TCART_TIMER): Boolean;
        function ClearPostTimer(Index: Integer): Boolean;
        procedure Clear;
        function Assign(CART: TCART): Boolean;
        property Version: String read GetVersion write SetVersion;
        property Title: String read GetTitle write SetTitle;
        property Artist: String read GetArtist write SetArtist;
        property CutID: String read GetCutID write SetCutID;
        property ClientID: String read GetClientID write SetClientID;
        property Category: String read GetCategory write SetCategory;
        property Classification: String read GetClassification write SetClassification;
        property OutCue: String read GetOutCue write SetOutCue;
        property StartDate: String read GetStartDate write SetStartDate;
        property StartTime: String read GetStartTime write SetStartTime;
        property EndDate: String read GetEndDate write SetEndDate;
        property EndTime: String read GetEndTime write SetEndTime;
        property ProducerAppID: String read GetProducerAppID write SetProducerAppID;
        property ProducerAppVersion: String read GetProducerAppVersion write SetProducerAppVersion;
        property UserDef: String read GetUserDef write SetUserDef;
        property LevelReference: DWORD read GetLevelReference write SetLevelReference;
        property PostTimer: TTAG_CART_TIMERS read _GetPostTimer write _SetPostTimer;
        property Reserved: String read GetReserved write SetReserved;
        property URL: String read GetURL write SetURL;
        property TagText: String read GetTagText write SetTagText;
    end;

    TEVNT = class
        Loaded: Boolean;
        SPEVENTS: Array of TSPEVENT;
        procedure Clear;
    end;

    TWAVTag = class
    private
        FFileSize: Int64;
        procedure LoadWAVEAttributes(Stream: TStream);
        function GetWAVEInformation(Stream: TStream): TWaveFmt;
        function GetCodec: String;
    public
        FileName: String;
        Loaded: Boolean;
        Size: Cardinal;
        Frames: TList<TWAVTagFrame>;
        BEXT: TBEXT;
        CART: TCART;
        Attributes: TWaveFmt;
        PlayTime: Double;
        SampleCount: UInt64;
        BitRate: Integer;
        SampleDataStartPosition: Int64;
        SampleDataSize: UInt64;
        AutomaticallyFix: Boolean;
        FixedOnSave: TFixWAVEResult;
        EVNT: TEVNT;
        Constructor Create;
        Destructor Destroy; override;
        function LoadFromFile(_FileName: String): Integer;
        function LoadFromStream(TagStream: TStream): Integer;
        function SaveToFile(_FileName: String): Integer;
        function SaveToStream(Stream: TStream): Integer;
        function AddFrame(const Name: String): TWAVTagFrame;
        function DeleteFrame(FrameIndex: Integer): Boolean; overload;
        function DeleteFrame(const Name: String): Boolean; overload;
        procedure DeleteAllFrames;
        procedure Clear;
        function Count: Integer;
        function FrameExists(const Name: String): Integer; overload;
        function FrameTypeCount(const Name: String): Integer;
        function CalculateTotalFramesSize: Integer;
        function CalculateTagSize: Integer;
        function AddTextFrame(const Name: String; const Text: String): Integer;
        procedure AddBinaryFrame(const Name: String; BinaryStream: TStream; DataSize: Integer);
        procedure SetTextFrameText(const Name: String; const Text: String);
        procedure SetListFrameText(const Name: String; List: TStrings);
        function ReadFrameByNameAsText(const Name: String): String;
        function ReadFrameByNameAsList(const Name: String; var List: TStrings): Boolean;
        procedure RemoveEmptyFrames;
        function DeleteFrameByName(const Name: String): Boolean;
        function Assign(Source: TWAVTag): Boolean;
        procedure CreateTagChunks(Stream: TStream);
        function HaveBEXT: Boolean;
        function HaveCART: Boolean;
        function CalculateBEXTSize: Integer;
        function CalculateCARTSize: Integer;
        procedure ReSetAlreadyParsedState;
        property FileSize: Int64 read FFileSize;
        property Codec: String read GetCodec;
    end;

    function ValidRIFF(TagStream: TStream): Boolean;
    function ValidRF64(TagStream: TStream): Boolean;

    function RemoveWAVTagFromFile(FileName: String): Integer;
    function RemoveWAVTagFromStream(Stream: TStream): Integer;

    function RIFFChunkIDToString(ChunkID: TRIFFChunkID): String;
    procedure String2RIFFChunkID(StringFrameID: String; var ChunkID: TRIFFChunkID);

    function WAVTagErrorCode2String(ErrorCode: Integer): String;

    function BytesToString(P: PByte; MaxBytes: Integer): String;

    function FixWAVEStream(Stream: TStream): TFixWAVEResult;
    function FixWAVEFile(FileName: String): TFixWAVEResult;

var
    RIFFID: TRIFFID;
    RF64ID: TRIFFID;
    RIFFWAVEID: TRIFFChunkID;
    RIFFLISTID: TRIFFChunkID;
    RIFFINFOID: TRIFFChunkID;
    RIFFBEXTID: TRIFFChunkID;
    RIFFCARTID: TRIFFChunkID;
    RIFFEVNTID: TRIFFChunkID;

    WAVTagLibraryAutomaticallyFix: Boolean = False;

implementation

{$IFDEF MSWINDOWS}
Uses
    {$IFDEF FPC}
    Windows;
    {$ELSE}
    WinAPI.Windows;
    {$ENDIF}
{$ENDIF}

{$IFDEF POSIX}
Uses
    Posix.UniStd,
    Posix.StdIO;
{$ENDIF}

function MakeUInt64(LowDWord, HiDWord: DWord): UInt64; inline;
begin
    Result := LowDWord OR (UInt64(HiDWord) SHL 32);
end;

function LowDWordOfUInt64(Value: UInt64): Cardinal; inline;
begin
    Result := (Value SHL 32) SHR 32;
end;

function HighDWordOfUInt64(Value: UInt64): Cardinal; inline;
begin
    Result := Value SHR 32;
end;

procedure UnSyncSafe(var Source; const SourceSize: Integer; var Dest: Cardinal);
type
    TBytes = array [0..MaxInt - 1] of Byte;
var
    I: Byte;
begin
    { Test : Source = $01 $80 -> Dest = 255
             Source = $02 $00 -> Dest = 256
             Source = $02 $01 -> Dest = 257 etc.
    }
    Dest := 0;
    for I := 0 to SourceSize - 1 do begin
        Dest := Dest shl 7;
        Dest := Dest or (TBytes(Source)[I] and $7F); // $7F = %01111111
    end;
end;

function GetBytesTryANSI(Text: String; MaxBytesLength: Integer): TBytes;
var
    ANSIString: String;
begin
    Result := TEncoding.ANSI.GetBytes(Text);
    ANSIString := TEncoding.ANSI.GetString(Result);
    if ANSIString <> Text then begin
        repeat
            Result := TEncoding.UTF8.GetBytes(Text);
            Text := Copy(Text, 1, Length(Text) - 1);
        until (Length(Result) <= MaxBytesLength)
        OR (MaxBytesLength = - 1);
    end;
end;

function GetStringTryANSI(Bytes: TBytes): String;
begin
    Result := '';
    try
        Result := TEncoding.UTF8.GetString(Bytes);
    except
        //*
    end;
    if Result = '' then begin
        try
            Result := TEncoding.ANSI.GetString(Bytes);
        except
            //*
        end;
    end;
end;

function BytesToString(P: PByte; MaxBytes: Integer): String;
var
    Counter: Integer;
    Bytes: TBytes;
begin
    Result := '';
    if MaxBytes < 1 then begin
        Exit;
    end;
    SetLength(Bytes, MaxBytes);
    Counter := 0;
    repeat
        Bytes[Counter] := P^;
        Inc(Counter);
        Inc(P);
    until (Counter > MaxBytes - 1)
    OR (Bytes[Counter - 1] = 0);
    if Counter > MaxBytes - 1 then begin
        SetLength(Bytes, MaxBytes);
    end else begin
        SetLength(Bytes, Counter - 1);
    end;
    Result := GetStringTryANSI(Bytes);
end;

function TBytesToBytes(Source: TBytes; Destination: PByte; MaxBytes: Integer): Boolean;
var
    Counter: Integer;
begin
    if Length(Source) = 0 then begin
        Result := True;
        Exit;
    end;
    Counter := 0;
    repeat
        Destination^ := Source[Counter];
        Inc(Counter);
        Inc(Destination);
    until (Counter > MaxBytes - 1)
    OR (Counter > Length(Source) - 1)
    OR (Source[Counter - 1] = 0);
    Result := True;
end;

function ZeroBytesMemory(P: PByte; MaxBytes: Integer): Boolean;
var
    Counter: Integer;
begin
    Result := True;
    Counter := 0;
    repeat
        if P^ <> 0 then begin
            Result := False;
            Break;
        end;
        Inc(P);
        Inc(Counter);
    until Counter > MaxBytes - 1;
end;

procedure StringToCART_TIMER_Usage(const Source: String; var Dest: TCART_TIMER_Usage);
var
    SourceLength: Integer;
begin
    SourceLength := Length(Source);
    {$IFDEF NEXTGEN}
    if SourceLength > 0 then begin
        Dest[0] := Ord(Source[0]);
    end else begin
        //Dest[0] := 20;
    end;
    if SourceLength > 1 then begin
        Dest[1] := Ord(Source[1]);
    end else begin
        //Dest[1] := 20;
    end;
    if SourceLength > 2 then begin
        Dest[2] := Ord(Source[2]);
    end else begin
        //Dest[2] := 20;
    end;
    if SourceLength > 3 then begin
        Dest[3] := Ord(Source[3]);
    end else begin
        //Dest[3] := 20;
    end;
    {$ELSE}
    if SourceLength > 0 then begin
        Dest[0] := Ord(Source[1]);
    end else begin
        //Dest[0] := 20;
    end;
    if SourceLength > 1 then begin
        Dest[1] := Ord(Source[2]);
    end else begin
        //Dest[1] := 20;
    end;
    if SourceLength > 2 then begin
        Dest[2] := Ord(Source[3]);
    end else begin
        //Dest[2] := 20;
    end;
    if SourceLength > 3 then begin
        Dest[3] := Ord(Source[4]);
    end else begin
        //Dest[3] := 20;
    end;
    {$ENDIF}
end;

function RIFFUpdateTagChunks({FileName: String;} SourceStream, DestinationStream, NewTagChunks: TStream; PreviousTagChunksSize: Cardinal; PaddingToWrite: Cardinal = 0): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    TotalSize: Int64;
    StartPositionSource, StartPositionDestination: Int64;
    ChunkSize: Cardinal;
    ChunkID: TRIFFChunkID;
begin
    //Result := WAVTAGLIBRARY_ERROR;
    StartPositionSource := SourceStream.Position;
    StartPositionDestination := DestinationStream.Position;
    try
        DestinationStream.CopyFrom(SourceStream, $C);
        SourceStream.Seek(StartPositionSource + 4, soBeginning);
        SourceStream.Read(RIFFChunkSize, 4);
        TotalSize := RIFFChunkSize - PreviousTagChunksSize + NewTagChunks.Size + PaddingToWrite;
        if Odd(TotalSize) then begin
            Inc(TotalSize);
        end;
        if TotalSize > $FFFFFFFF then begin
            Result := WAVTAGLIBRARY_ERROR_DOESNT_FIT;
            Exit;
        end;
        RIFFChunkSizeNew := TotalSize;
        DestinationStream.Seek(StartPositionDestination + 4, soBeginning);
        DestinationStream.Write(RIFFChunkSizeNew, 4);
        DestinationStream.Seek(0, soEnd);
        //* Write the new ILST INFO chunk
        NewTagChunks.Seek(0, soBeginning);
        DestinationStream.CopyFrom(NewTagChunks, NewTagChunks.Size);
        SourceStream.Seek(4, soCurrent);
        ChunkSize := 0;
        while SourceStream.Position + 8 < RIFFChunkSize do begin
            SourceStream.Read(ChunkID, 4);
            SourceStream.Read(ChunkSize, 4);
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            if (ChunkID[0] = RIFFBEXTID[0])
            AND (ChunkID[1] = RIFFBEXTID[1])
            AND (ChunkID[2] = RIFFBEXTID[2])
            AND (ChunkID[3] = RIFFBEXTID[3])
            then begin
                SourceStream.Seek(ChunkSize, soCurrent);
            end else begin
                if (ChunkID[0] = RIFFCARTID[0])
                AND (ChunkID[1] = RIFFCARTID[1])
                AND (ChunkID[2] = RIFFCARTID[2])
                AND (ChunkID[3] = RIFFCARTID[3])
                then begin
                    SourceStream.Seek(ChunkSize, soCurrent);
                end else begin
                    if (ChunkID[0] = RIFFLISTID[0])
                    AND (ChunkID[1] = RIFFLISTID[1])
                    AND (ChunkID[2] = RIFFLISTID[2])
                    AND (ChunkID[3] = RIFFLISTID[3])
                    then begin
                        SourceStream.Read(ChunkID, 4);
                        if (ChunkID[0] = RIFFINFOID[0])
                        AND (ChunkID[1] = RIFFINFOID[1])
                        AND (ChunkID[2] = RIFFINFOID[2])
                        AND (ChunkID[3] = RIFFINFOID[3])
                        then begin
                            SourceStream.Seek(ChunkSize - 4, soCurrent);
                        end else begin
                            SourceStream.Seek(- 12, soCurrent);
                            DestinationStream.CopyFrom(SourceStream, Int64(ChunkSize) + 8);
                        end;
                    end else begin
                        SourceStream.Seek(- 8, soCurrent);
                        DestinationStream.CopyFrom(SourceStream, Int64(ChunkSize) + 8);
                    end;
                end;
            end;
        end;
        if SourceStream.Position < SourceStream.Size then begin
            DestinationStream.CopyFrom(SourceStream, SourceStream.Size - SourceStream.Position);
        end;
        Result := WAVTAGLIBRARY_SUCCESS;
    except
        Result := WAVTAGLIBRARY_ERROR;
    end;
end;

function RF64UpdateTagChunks({FileName: String;} SourceStream, DestinationStream, NewTagChunks: TStream; PreviousTagChunksSize: Int64; PaddingToWrite: Cardinal = 0): Integer;
var
    ChunkID: TRIFFChunkID;
    RIFFChunkSize: DWord;
    RF64Size: Int64;
    TotalSize: Int64;
    StartPositionSource, StartPositionDestination: Int64;
    Waveds64: TWaveds64;
    Data: DWord;
    ChunkSize: Cardinal;
begin
    //Result := WAVTAGLIBRARY_ERROR;
    RF64Size := 0;
    StartPositionSource := SourceStream.Position;
    StartPositionDestination := DestinationStream.Position;
    try
        DestinationStream.CopyFrom(SourceStream, 3 * 4 + SizeOf(TWaveds64) + 4 + 4);
        SourceStream.Seek(StartPositionSource + 4, soBeginning);
        SourceStream.Read(RIFFChunkSize, 4);
        if RIFFChunkSize = $FFFFFFFF then begin
            SourceStream.Read(ChunkID, 4);
            if (ChunkID[0] <> Ord('W'))
            OR (ChunkID[1] <> Ord('A'))
            OR (ChunkID[2] <> Ord('V'))
            OR (ChunkID[3] <> Ord('E'))
            then begin
                Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            SourceStream.Read(ChunkID, 4);
            if (ChunkID[0] = Ord('d'))
            AND (ChunkID[1] = Ord('s'))
            AND (ChunkID[2] = Ord('6'))
            AND (ChunkID[3] = Ord('4'))
            then begin
                SourceStream.Read(Waveds64, SizeOf(TWaveds64));
                RF64Size := MakeUInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                TotalSize := RF64Size - PreviousTagChunksSize + NewTagChunks.Size + PaddingToWrite;
                //* Should not happen
                {
                if Odd(TotalSize) then begin
                    Inc(TotalSize);
                end;
                }
                //* Set new RF64 size
                DestinationStream.Seek(StartPositionDestination + 20, soBeginning);
                Data := LowDWordOfUInt64(TotalSize);
                DestinationStream.write(Data, 4);
                Data := HighDWordOfUInt64(TotalSize);
                DestinationStream.write(Data, 4);
            end;
        end;
        DestinationStream.Seek(0, soEnd);
        //* Write the new ILST INFO chunk
        NewTagChunks.Seek(0, soBeginning);
        DestinationStream.CopyFrom(NewTagChunks, NewTagChunks.Size);
        SourceStream.Seek(4, soCurrent);
        ChunkSize := 0;
        while SourceStream.Position + 8 < RF64Size do begin
            SourceStream.Read(ChunkID, 4);
            SourceStream.Read(ChunkSize, 4);
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            if (ChunkID[0] = RIFFBEXTID[0])
            AND (ChunkID[1] = RIFFBEXTID[1])
            AND (ChunkID[2] = RIFFBEXTID[2])
            AND (ChunkID[3] = RIFFBEXTID[3])
            then begin
                SourceStream.Seek(ChunkSize, soCurrent);
            end else begin
                if (ChunkID[0] = RIFFCARTID[0])
                AND (ChunkID[1] = RIFFCARTID[1])
                AND (ChunkID[2] = RIFFCARTID[2])
                AND (ChunkID[3] = RIFFCARTID[3])
                then begin
                    SourceStream.Seek(ChunkSize, soCurrent);
                end else begin
                    if (ChunkID[0] = RIFFLISTID[0])
                    AND (ChunkID[1] = RIFFLISTID[1])
                    AND (ChunkID[2] = RIFFLISTID[2])
                    AND (ChunkID[3] = RIFFLISTID[3])
                    then begin
                        SourceStream.Read(ChunkID, 4);
                        if (ChunkID[0] = RIFFINFOID[0])
                        AND (ChunkID[1] = RIFFINFOID[1])
                        AND (ChunkID[2] = RIFFINFOID[2])
                        AND (ChunkID[3] = RIFFINFOID[3])
                        then begin
                            SourceStream.Seek(ChunkSize - 4, soCurrent);
                        end else begin
                            SourceStream.Seek(- 12, soCurrent);
                            DestinationStream.CopyFrom(SourceStream, Int64(ChunkSize) + 8);
                        end;
                    end else begin
                        SourceStream.Seek(- 8, soCurrent);
                        DestinationStream.CopyFrom(SourceStream, Int64(ChunkSize) + 8);
                    end;
                end;
            end;
        end;
        if SourceStream.Position < SourceStream.Size then begin
            DestinationStream.CopyFrom(SourceStream, SourceStream.Size - SourceStream.Position);
        end;
        Result := WAVTAGLIBRARY_SUCCESS;
    except
        Result := WAVTAGLIBRARY_ERROR;
    end;
end;

Constructor TWAVTagFrame.Create(_Parent: TWAVTag);
begin
    Inherited Create;
    Self.Parent := _Parent;
    Name := '';
    Stream := TMemoryStream.Create;
    Format := ffUnknown;
end;

Destructor TWAVTagFrame.Destroy;
begin
    FreeAndNil(Stream);
    Inherited;
end;

function TWAVTagFrame.GetAsText: String;
var
    i: Integer;
    Data: Byte;
    Bytes: TBytes;
begin
    Result := '';
    if Format <> ffText then begin
        Exit;
    end;
    Stream.Seek(0, soBeginning);
    SetLength(Bytes, Stream.Size - 1);
    for i := 0 to Stream.Size - 2 do begin
        Stream.Read(Data, 1);
        Bytes[i] := Data;
    end;
    Stream.Seek(0, soBeginning);
    Result := GetStringTryANSI(Bytes);
end;

function TWAVTagFrame.GetIndex: Integer;
begin
    Result := Self.Parent.Frames.IndexOf(Self);
end;

function TWAVTagFrame.SetAsText(const Text: String): Boolean;
var
    Bytes: TBytes;
    ZeroByte: Byte;
begin
    Stream.Clear;
    if Text = '' then begin
        Result := True;
        Exit;
    end;
    ZeroByte := 0;
    Bytes := GetBytesTryANSI(Text, - 1);
    Stream.Write(Bytes[0], Length(Bytes));
    Stream.Write(ZeroByte, 1);
    Stream.Seek(0, soBeginning);
    Format := ffText;
    Result := True;
end;

function TWAVTagFrame.SetAsList(List: TStrings): Boolean;
var
    i: Integer;
    Data: Byte;
    NameBytes: TBytes;
    ValueBytes: TBytes;
begin
    Stream.Clear;
    for i := 0 to List.Count - 1 do begin
        SetLength(NameBytes, 0);
        SetLength(ValueBytes, 0);
        NameBytes := GetBytesTryANSI(List.Names[i], - 1);
        ValueBytes := GetBytesTryANSI(List.ValueFromIndex[i], - 1);
        Stream.Write(NameBytes[0], Length(NameBytes));
        Data := $0D;
        Stream.Write(Data, 1);
        Data := $0A;
        Stream.Write(Data, 1);
        Stream.Write(ValueBytes[0], Length(ValueBytes));
        Data := $0D;
        Stream.Write(Data, 1);
        Data := $0A;
        Stream.Write(Data, 1);
        Data := $00;
        Stream.Write(Data, 1);
    end;
    Stream.Seek(0, soBeginning);
    Format := ffText;
    Result := True;
end;

function TWAVTagFrame.GetAsList(var List: TStrings): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
    NameStr: String;
    ValueStr: String;
    ByteCounter: Integer;
begin
    Result := False;
    List.Clear;
    if Format <> ffText then begin
        Exit;
    end;
    Stream.Seek(0, soBeginning);
    while Stream.Position < Stream.Size do begin
        SetLength(Bytes, 0);
        ByteCounter := 0;
        repeat
            Stream.Read(Data, 1);
            if Data = $0D then begin
                Stream.Read(Data, 1);
                if Data = $0A then begin
                    Break;
                end;
            end;
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := Data;
            Inc(ByteCounter);
        until Stream.Position >= Stream.Size - 1;
        NameStr := GetStringTryANSI(Bytes);
        SetLength(Bytes, 0);
        ByteCounter := 0;
        repeat
            Stream.Read(Data, 1);
            if Data = $0D then begin
                Stream.Read(Data, 1);
                if Data = $0A then begin
                    Break;
                end;
            end;
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := Data;
            Inc(ByteCounter);
        until Stream.Position >= Stream.Size - 1;
        ValueStr := GetStringTryANSI(Bytes);
        List.Append(NameStr + '=' + ValueStr);
        Result := True;
    end;
    Stream.Seek(0, soBeginning);
end;

procedure TWAVTagFrame.Clear;
begin
    Format := ffUnknown;
    Stream.Clear;
end;

function TWAVTagFrame.Assign(WAVTagFrame: TWAVTagFrame): Boolean;
begin
    Self.Clear;
    if WAVTagFrame <> nil then begin
        Format := WAVTagFrame.Format;
        WAVTagFrame.Stream.Seek(0, soBeginning);
        Stream.CopyFrom(WAVTagFrame.Stream, WAVTagFrame.Stream.Size);
        Stream.Seek(0, soBeginning);
        WAVTagFrame.Stream.Seek(0, soBeginning);
    end;
    Result := True;
end;

Constructor TWAVTag.Create;
begin
    Inherited;
    Frames := TList<TWAVTagFrame>.Create;
    Frames.Capacity := 256;
    BEXT := TBEXT.Create;
    CART := TCART.Create;
    EVNT := TEVNT.Create;
    Clear;
    AutomaticallyFix := WAVTagLibraryAutomaticallyFix;
end;

Destructor TWAVTag.Destroy;
begin
    Clear;
    FreeAndNil(BEXT);
    FreeAndNil(CART);
    FreeAndNil(EVNT);
    FreeAndNil(Frames);
    Inherited;
end;

procedure TWAVTag.DeleteAllFrames;
var
    i: Integer;
begin
    for i := Frames.Count - 1 downto 0 do begin
        Frames[i].Free;
        Frames.Delete(i);
    end;
    Frames.Capacity := 256;
end;

function GetID3v2Size(const Source: TStream): Cardinal;
type
    ID3v2Header = packed record
        ID: array [1..3] of Byte;
        Version: Byte;
        Revision: Byte;
        Flags: Byte;
        Size: Cardinal;
    end;
var
    Header: ID3v2Header;
begin
    // Get ID3v2 tag size (if exists)
    Result := 0;
    Source.Seek(0, soFromBeginning);
    Source.Read(Header, SizeOf(ID3v2Header));
    if (Header.ID[1] = Ord('I'))
    AND (Header.ID[2] = Ord('D'))
    AND (Header.ID[3] = Ord('3'))
    then begin
        UnSyncSafe(Header.Size, 4, Result);
        Inc(Result, 10);
        if Result > Source.Size then begin
            Result := 0;
        end;
    end;
end;

function CheckRIFF(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
begin
    Result := False;
    PreviousPosition := TagStream.Position;
    try
        try
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = RIFFID[0])
            AND (Identification[1] = RIFFID[1])
            AND (Identification[2] = RIFFID[2])
            AND (Identification[3] = RIFFID[3])
            then begin
                Result := True;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function SeekRIFF(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFLISTID[0])
                AND (ChunkID[1] = RIFFLISTID[1])
                AND (ChunkID[2] = RIFFLISTID[2])
                AND (ChunkID[3] = RIFFLISTID[3])
                then begin
                    TagStream.Read(ChunkID, 4);
                    if (ChunkID[0] = RIFFINFOID[0])
                    AND (ChunkID[1] = RIFFINFOID[1])
                    AND (ChunkID[2] = RIFFINFOID[2])
                    AND (ChunkID[3] = RIFFINFOID[3])
                    then begin
                        Result := ChunkSize + 8;
                        Exit;
                    end;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function SeekRIFFBEXT(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFBEXTID[0])
                AND (ChunkID[1] = RIFFBEXTID[1])
                AND (ChunkID[2] = RIFFBEXTID[2])
                AND (ChunkID[3] = RIFFBEXTID[3])
                then begin
                    Result := ChunkSize + 8;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function SeekRIFFCART(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFCARTID[0])
                AND (ChunkID[1] = RIFFCARTID[1])
                AND (ChunkID[2] = RIFFCARTID[2])
                AND (ChunkID[3] = RIFFCARTID[3])
                then begin
                    Result := ChunkSize + 8;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function SeekRIFFEVNT(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFEVNTID[0])
                AND (ChunkID[1] = RIFFEVNTID[1])
                AND (ChunkID[2] = RIFFEVNTID[2])
                AND (ChunkID[3] = RIFFEVNTID[3])
                then begin
                    Result := ChunkSize + 8;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function ValidRIFF(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
begin
    Result := False;
    PreviousPosition := TagStream.Position;
    try
        try
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = RIFFID[0])
            AND (Identification[1] = RIFFID[1])
            AND (Identification[2] = RIFFID[2])
            AND (Identification[3] = RIFFID[3])
            then begin
                TagStream.Read(RIFFChunkSize, 4);
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = RIFFWAVEID[0])
                AND (ChunkID[1] = RIFFWAVEID[1])
                AND (ChunkID[2] = RIFFWAVEID[2])
                AND (ChunkID[3] = RIFFWAVEID[3])
                then begin
                    Result := True;
                    ChunkSize := 0;
                    while TagStream.Position < TagStream.Size do begin
                        if TagStream.Position >= Int64(RIFFChunkSize) + 8 then begin
                            Exit;
                        end;
                        TagStream.Read(ChunkID, 4);
                        TagStream.Read(ChunkSize, 4);
                        if Odd(ChunkSize) then begin
                            Inc(ChunkSize);
                        end;
                        TagStream.Seek(ChunkSize, soCurrent);
                        if TagStream.Position > TagStream.Size then begin
                            Result := False;
                            Exit;
                        end;
                    end;
                end;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function CheckRF64(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
begin
    Result := False;
    PreviousPosition := TagStream.Position;
    try
        try
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = RF64ID[0])
            AND (Identification[1] = RF64ID[1])
            AND (Identification[2] = RF64ID[2])
            AND (Identification[3] = RF64ID[3])
            then begin
                Result := True;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function SeekRF64(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    ds64DataSize: UInt64;
    Waveds64: TWaveds64;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('s'))
                AND (ChunkID[2] = Ord('6'))
                AND (ChunkID[3] = Ord('4'))
                then begin
                    TagStream.Read(Waveds64, SizeOf(TWaveds64));
                    TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    Continue;
                end;
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFLISTID[0])
                AND (ChunkID[1] = RIFFLISTID[1])
                AND (ChunkID[2] = RIFFLISTID[2])
                AND (ChunkID[3] = RIFFLISTID[3])
                then begin
                    TagStream.Read(ChunkID, 4);
                    if (ChunkID[0] = RIFFINFOID[0])
                    AND (ChunkID[1] = RIFFINFOID[1])
                    AND (ChunkID[2] = RIFFINFOID[2])
                    AND (ChunkID[3] = RIFFINFOID[3])
                    then begin
                        Result := ChunkSize + 8;
                        Exit;
                    end;
                end else begin
                    if ((ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a')))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        ds64DataSize := MakeUInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh);
                        TagStream.Seek(ds64DataSize, soCurrent);
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function SeekRF64BEXT(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    ds64DataSize: UInt64;
    Waveds64: TWaveds64;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('s'))
                AND (ChunkID[2] = Ord('6'))
                AND (ChunkID[3] = Ord('4'))
                then begin
                    TagStream.Read(Waveds64, SizeOf(TWaveds64));
                    TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    Continue;
                end;
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFBEXTID[0])
                AND (ChunkID[1] = RIFFBEXTID[1])
                AND (ChunkID[2] = RIFFBEXTID[2])
                AND (ChunkID[3] = RIFFBEXTID[3])
                then begin
                    Result := ChunkSize + 8;
                    Exit;
                end else begin
                    if ((ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a')))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        ds64DataSize := MakeUInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh);
                        TagStream.Seek(ds64DataSize, soCurrent);
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function SeekRF64CART(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    ds64DataSize: UInt64;
    Waveds64: TWaveds64;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('s'))
                AND (ChunkID[2] = Ord('6'))
                AND (ChunkID[3] = Ord('4'))
                then begin
                    TagStream.Read(Waveds64, SizeOf(TWaveds64));
                    TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    Continue;
                end;
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFCARTID[0])
                AND (ChunkID[1] = RIFFCARTID[1])
                AND (ChunkID[2] = RIFFCARTID[2])
                AND (ChunkID[3] = RIFFCARTID[3])
                then begin
                    Result := ChunkSize + 8;
                    Exit;
                end else begin
                    if ((ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a')))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        ds64DataSize := MakeUInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh);
                        TagStream.Seek(ds64DataSize, soCurrent);
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function SeekRF64EVNT(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    ds64DataSize: UInt64;
    Waveds64: TWaveds64;
begin
    Result := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('s'))
                AND (ChunkID[2] = Ord('6'))
                AND (ChunkID[3] = Ord('4'))
                then begin
                    TagStream.Read(Waveds64, SizeOf(TWaveds64));
                    TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    Continue;
                end;
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                if (ChunkID[0] = RIFFEVNTID[0])
                AND (ChunkID[1] = RIFFEVNTID[1])
                AND (ChunkID[2] = RIFFEVNTID[2])
                AND (ChunkID[3] = RIFFEVNTID[3])
                then begin
                    Result := ChunkSize + 8;
                    Exit;
                end else begin
                    if ((ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a')))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        ds64DataSize := MakeUInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh);
                        TagStream.Seek(ds64DataSize, soCurrent);
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function ValidRF64(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
    RIFFChunkSize: DWord;
    //DS64Size: Int64;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    Waveds64: TWaveds64;
begin
    Result := False;
    //DS64Size := 0;
    PreviousPosition := TagStream.Position;
    try
        try
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = RF64ID[0])
            AND (Identification[1] = RF64ID[1])
            AND (Identification[2] = RF64ID[2])
            AND (Identification[3] = RF64ID[3])
            then begin
                TagStream.Read(RIFFChunkSize, 4);
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = RIFFWAVEID[0])
                AND (ChunkID[1] = RIFFWAVEID[1])
                AND (ChunkID[2] = RIFFWAVEID[2])
                AND (ChunkID[3] = RIFFWAVEID[3])
                AND (RIFFChunkSize = $FFFFFFFF)
                then begin
                    TagStream.Read(ChunkID, 4);
                    if (ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('s'))
                    AND (ChunkID[2] = Ord('6'))
                    AND (ChunkID[3] = Ord('4'))
                    then begin
                        TagStream.Read(Waveds64, SizeOf(TWaveds64));
                        //DS64Size := MakeInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                        TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    end;
                    Result := True;
                    ChunkSize := 0;
                    while TagStream.Position < TagStream.Size do begin
                        //if TagStream.Position >= RIFFSize then begin
                        //    Exit;
                        //end;
                        TagStream.Read(ChunkID, 4);
                        TagStream.Read(ChunkSize, 4);
                        if Odd(ChunkSize) then begin
                            Inc(ChunkSize);
                        end;
                        if ((ChunkID[0] = Ord('d'))
                        AND (ChunkID[1] = Ord('a'))
                        AND (ChunkID[2] = Ord('t'))
                        AND (ChunkID[3] = Ord('a')))
                        AND (ChunkSize = $FFFFFFFF)
                        then begin
                            TagStream.Seek(MakeUInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh), soCurrent);
                        end else begin
                            TagStream.Seek(ChunkSize, soCurrent);
                        end;
                        if TagStream.Position > TagStream.Size then begin
                            Result := False;
                            Exit;
                        end;
                    end;
                end;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function TWAVTag.LoadFromStream(TagStream: TStream): Integer;
var
    PreviousPosition: Int64;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    LISTINFOChunkPosition: Int64;
    LISTChunkSize: DWord;
    ID3v2Size: Cardinal;
    BEXTChunkPosition: Int64;
    BEXTChunkSize: DWord;
    CARTChunkPosition: Int64;
    EVNTChunkPosition: Int64;
    CARTChunkSize: DWord;
    EVNTChunkSize: DWord;
    BEXTCodingHistoryBytesSize: Integer;
    CARTTextBytesSize: Integer;
    TempWord: Word;
begin
    Result := WAVTAGLIBRARY_ERROR;
    Loaded := False;
    BEXT.Loaded := False;
    CART.Loaded := False;
    Clear;
    try
        PreviousPosition := TagStream.Position;
        FFileSize := TagStream.Size;
        { Seek past the ID3v2 tag, if there is one }
        ID3v2Size := GetID3v2Size(TagStream);
        TagStream.Seek(ID3v2Size, soBeginning);
        try
            if CheckRIFF(TagStream) then begin
                LISTChunkSize := SeekRIFF(TagStream);
            end else begin
                TagStream.Seek(PreviousPosition, soBeginning);
                if CheckRF64(TagStream) then begin
                    LISTChunkSize := SeekRF64(TagStream);
                end else begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            {
            if LISTChunkSize = 0 then begin
                Result := WAVTAGLIBRARY_ERROR_NO_TAG_FOUND;
                Exit;
            end;
            }
            LISTINFOChunkPosition := TagStream.Position - 4 - 8;
            while TagStream.Position < LISTINFOChunkPosition + LISTChunkSize do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if Odd(ChunkSize) then begin
                    Inc(ChunkSize);
                end;
                with AddFrame(RIFFChunkIDToString(ChunkID)) do begin
                    Stream.CopyFrom(TagStream, ChunkSize);
                    Format := ffText;
                end;
                //if Odd(ChunkSize) then begin
                //    TagStream.Seek(1, soCurrent);
                //end;
            end;
            //* BEXT
            TagStream.Seek(PreviousPosition, soBeginning);
            if CheckRIFF(TagStream) then begin
                BEXTChunkSize := SeekRIFFBEXT(TagStream);
            end else begin
                TagStream.Seek(PreviousPosition, soBeginning);
                if CheckRF64(TagStream) then begin
                    BEXTChunkSize := SeekRF64BEXT(TagStream);
                end else begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            if BEXTChunkSize > 0 then begin
                BEXTChunkPosition := TagStream.Position - 8;
                TagStream.Read(BEXT.BEXTChunk.Description[0], SizeOf(TAG_BEXT));
                BEXTCodingHistoryBytesSize := BEXTChunkPosition + BEXTChunkSize - TagStream.Position;
                if BEXTCodingHistoryBytesSize > 0 then begin
                    SetLength(BEXT.CodingHistoryBytes, BEXTCodingHistoryBytesSize);
                    TagStream.Read(BEXT.CodingHistoryBytes[0], BEXTCodingHistoryBytesSize);
                end;
                BEXT.Loaded := True;
            end;
            //* CART
            TagStream.Seek(PreviousPosition, soBeginning);
            if CheckRIFF(TagStream) then begin
                CARTChunkSize := SeekRIFFCART(TagStream);
            end else begin
                TagStream.Seek(PreviousPosition, soBeginning);
                if CheckRF64(TagStream) then begin
                    CARTChunkSize := SeekRF64CART(TagStream);
                end else begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            if CARTChunkSize > 0 then begin
                CARTChunkPosition := TagStream.Position - 8;
                TagStream.Read(CART.CARTChunk.Version[0], SizeOf(TAG_CART));
                CARTTextBytesSize := CARTChunkPosition + CARTChunkSize - TagStream.Position;
                if CARTTextBytesSize > 0 then begin
                    SetLength(CART.TagTextBytes, CARTTextBytesSize);
                    TagStream.Read(CART.TagTextBytes[0], CARTTextBytesSize);
                end;
                CART.Loaded := True;
            end;
            //* EVNT
            TagStream.Seek(PreviousPosition, soBeginning);
            if CheckRIFF(TagStream) then begin
                EVNTChunkSize := SeekRIFFEVNT(TagStream);
            end else begin
                TagStream.Seek(PreviousPosition, soBeginning);
                if CheckRF64(TagStream) then begin
                    EVNTChunkSize := SeekRF64EVNT(TagStream);
                end else begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            if EVNTChunkSize > 0 then begin
                EVNTChunkPosition := TagStream.Position - 8;
                while TagStream.Position < EVNTChunkPosition + EVNTChunkSize do begin
                    SetLength(EVNT.SPEVENTS, Length(EVNT.SPEVENTS) + 1);
                    TagStream.Read(EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1], 24);
                    //* Token data
                    if (EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].EventID = 3)
                    AND (EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].wParam > 0)
                    then begin
                        SetLength(EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].TOKENDATA, EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].wParam);
                        TagStream.Read(EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].TOKENDATA[0], EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].wParam);
                        while TagStream.Position mod 4 <> 0 do begin
                            TagStream.Seek(1, soCurrent);
                        end;
                        //* Unknown skip 2 bytes
                        //TagStream.Seek(2, soCurrent);
                        TagStream.Read(TempWord, 2);
                    end;
                    //* Bookmark
                    if (EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].EventID = 4)
                    AND (EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].wParam > 0)
                    then begin
                        SetLength(EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].BOOKMARK, EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].wParam);
                        TagStream.Read(EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].BOOKMARK[0], EVNT.SPEVENTS[Length(EVNT.SPEVENTS) - 1].wParam);
                        while TagStream.Position mod 4 <> 0 do begin
                            TagStream.Seek(1, soCurrent);
                        end;
                        //* Unknown skip 2 bytes
                        //TagStream.Seek(2, soCurrent);
                        TagStream.Read(TempWord, 2); //* This code is not yet tested
                    end;
                end;
                EVNT.Loaded := True;
            end;
            //* Load WAV attributes
            LoadWAVEAttributes(TagStream);
            Loaded := True;
        finally
            TagStream.Seek(PreviousPosition, soBeginning);
        end;
        Result := WAVTAGLIBRARY_SUCCESS;
    except
        if Result <> WAVTAGLIBRARY_ERROR_CORRUPT then begin
            Result := WAVTAGLIBRARY_ERROR;
        end;
    end;
end;

function TWAVTag.LoadFromFile(_FileName: String): Integer;
var
    FileStream: TFileStream;
begin
    Clear;
    Loaded := False;
    if NOT FileExists(_FileName) then begin
        Result := WAVTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        FileStream := TFileStream.Create(_FileName, fmOpenRead OR fmShareDenyWrite);
    except
        Result := WAVTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        Result := LoadFromStream(FileStream);
        if (Result = WAVTAGLIBRARY_SUCCESS)
        OR (Result = WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION)
        then begin
            Self.FileName := _FileName;
        end;
    finally
        FreeAndNil(FileStream);
    end;
end;

function TWAVTag.AddFrame(const Name: String): TWAVTagFrame;
begin
    Result := nil;
    try
        if Frames.Count = Frames.Capacity then begin
            Frames.Capacity := Frames.Capacity + 256;
        end;
        Result := TWAVTagFrame.Create(Self);
        Result.Name := Name;
        Frames.Add(Result);
    except
        //*
    end;
end;

function TWAVTag.DeleteFrame(FrameIndex: Integer): Boolean;
begin
    Result := False;
    if (FrameIndex >= Frames.Count)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    Frames[FrameIndex].Free;
    Frames.Delete(FrameIndex);
    Result := True;
end;

function TWAVTag.DeleteFrame(const Name: String): Boolean;
var
    Index: Integer;
begin
    Result := False;
    Index := FrameExists(Name);
    if (Index >= Frames.Count)
    OR (Index < 0)
    then begin
        Exit;
    end;
    Result := DeleteFrame(Index);
end;

function TWAVTag.FrameExists(const Name: String): Integer;
var
    i: Integer;
begin
    Result := -1;
    for i := 0 to Frames.Count - 1 do begin
        if Name = Frames[i].Name then begin
            Result := i;
            Break;
        end;
    end;
end;

function TWAVTag.FrameTypeCount(const Name: String): Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := 0 to Frames.Count - 1 do begin
        if Name = Frames[i].Name then begin
            Inc(Result);
        end;
    end;
end;

function TWAVTag.HaveBEXT: Boolean;
begin
    if Length(BEXT.CodingHistoryBytes) > 0 then begin
        Result := True;
        Exit;
    end;
    Result := NOT ZeroBytesMemory(@BEXT.BEXTChunk.Description[0], SizeOf(BEXT.BEXTChunk));
end;

function TWAVTag.HaveCART: Boolean;
begin
    if Length(CART.TagTextBytes) > 0 then begin
        Result := True;
        Exit;
    end;
    Result := NOT ZeroBytesMemory(@CART.CARTChunk.Version[0], SizeOf(CART.CARTChunk));
end;

function TWAVTag.CalculateBEXTSize: Integer;
begin
    Result := SizeOf(BEXT.BEXTChunk) + Length(BEXT.CodingHistoryBytes);
    if Length(BEXT.CodingHistoryBytes) > 0 then begin
        if BEXT.CodingHistoryBytes[Length(BEXT.CodingHistoryBytes) - 1] <> 0 then begin
            Inc(Result);
        end;
    end;
    if Odd(Result) then begin
        Inc(Result);
    end;
end;

function TWAVTag.CalculateCARTSize: Integer;
begin
    Result := SizeOf(CART.CARTChunk) + Length(CART.TagTextBytes);
    if Length(CART.TagTextBytes) > 0 then begin
        if CART.TagTextBytes[Length(CART.TagTextBytes) - 1] <> 0 then begin
            Inc(Result);
        end;
    end;
    if Odd(Result) then begin
        Inc(Result);
    end;
end;

function TWAVTag.SaveToFile(_FileName: String): Integer;
var
    SourceStream, DestinationStream: TStream;
    PreviousPosition, SeekPosition: Int64;
    LISTChunkSize: Cardinal;
    BEXTChunkSize: Cardinal;
    CARTChunkSize: Cardinal;
    NewILSTINFOBEXTCARTChunkStream: TStream;
    NewRIFFSizeDWord: DWord;
    ID3v2Size: Cardinal;
begin
    Result := WAVTAGLIBRARY_ERROR;
    SourceStream := nil;
    DestinationStream := nil;
    try
        RemoveEmptyFrames;
        if NOT FileExists(_FileName) then begin
            SourceStream := TFileStream.Create(_FileName, fmCreate OR fmShareDenyWrite);
            //* Create a new RIFF file with only a LIST INFO chunk
            SourceStream.Write(RIFFID[0], SizeOf(TRIFFID));
            NewRIFFSizeDWord := 4;
            SourceStream.Write(NewRIFFSizeDWord, SizeOf(NewRIFFSizeDWord));
            SourceStream.Write(RIFFWAVEID[0], SizeOf(TRIFFChunkID));
            SourceStream.Seek(0, soBeginning);
        end else begin
            try
                SourceStream := TFileStream.Create(_FileName, fmOpenReadWrite OR fmShareExclusive);
            except
                Result := WAVTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
                Exit;
            end;
        end;
        try
            SourceStream.Seek(0, soBeginning);
            if CheckRIFF(SourceStream) then begin
                if NOT ValidRIFF(SourceStream) then begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end else begin
                SourceStream.Seek(0, soBeginning);
                if CheckRF64(SourceStream) then begin
                    if NOT ValidRF64(SourceStream) then begin
                        Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                        Exit;
                    end;
                end else begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            SourceStream.Seek(0, soBeginning);
            try
                DestinationStream := TFileStream.Create(ChangeFileExt(_FileName, '.tmp'), fmCreate);
            except
                Result := WAVTAGLIBRARY_ERROR_WRITING_FILE;
                Exit;
            end;
            { Copy and seek past the ID3v2 tag, if there is one }
            ID3v2Size := GetID3v2Size(SourceStream);
            SourceStream.Seek(0, soFromBeginning);
            if ID3v2Size > 0 then begin
                DestinationStream.CopyFrom(SourceStream, ID3v2Size);
            end;
            PreviousPosition := SourceStream.Position;
            NewILSTINFOBEXTCARTChunkStream := TMemoryStream.Create;
            try
                CreateTagChunks(NewILSTINFOBEXTCARTChunkStream);
                if CheckRIFF(SourceStream) then begin
                    if NOT ValidRIFF(SourceStream) then begin
                        Result := WAVTAGLIBRARY_ERROR_CORRUPT;
                        Exit;
                    end;
                    SeekPosition := SourceStream.Position;
                    LISTChunkSize := SeekRIFF(SourceStream);
                    SourceStream.Seek(SeekPosition, soBeginning);
                    BEXTChunkSize := SeekRIFFBEXT(SourceStream);
                    SourceStream.Seek(SeekPosition, soBeginning);
                    CARTChunkSize := SeekRIFFCART(SourceStream);
                    SourceStream.Seek(0, soBeginning);
                    RIFFUpdateTagChunks(SourceStream, DestinationStream, NewILSTINFOBEXTCARTChunkStream, LISTChunkSize + BEXTChunkSize + CARTChunkSize);
                end else begin
                    SourceStream.Seek(PreviousPosition, soBeginning);
                    if CheckRF64(SourceStream) then begin
                        if NOT ValidRF64(SourceStream) then begin
                            Result := WAVTAGLIBRARY_ERROR_CORRUPT;
                            Exit;
                        end;
                        SeekPosition := SourceStream.Position;
                        LISTChunkSize := SeekRF64(SourceStream);
                        SourceStream.Seek(SeekPosition, soBeginning);
                        BEXTChunkSize := SeekRF64BEXT(SourceStream);
                        SourceStream.Seek(SeekPosition, soBeginning);
                        CARTChunkSize := SeekRF64CART(SourceStream);
                        SourceStream.Seek(0, soBeginning);
                        RF64UpdateTagChunks(SourceStream, DestinationStream, NewILSTINFOBEXTCARTChunkStream, Int64(LISTChunkSize) + Int64(BEXTChunkSize) + Int64(CARTChunkSize));
                    end else begin
                        Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                        Exit;
                    end;
                end;
            finally
                FreeAndNil(NewILSTINFOBEXTCARTChunkStream);
            end;
            Result := WAVTAGLIBRARY_SUCCESS;
        finally
            {$IFDEF NEXTGEN}
            if Assigned(SourceStream) then begin
                SourceStream.DisposeOf;
                SourceStream := nil;
            end;
            if Assigned(DestinationStream) then begin
                DestinationStream.DisposeOf;
                DestinationStream := nil;
            end;
            {$ELSE}
            if Assigned(SourceStream) then begin
                FreeAndNil(SourceStream);
            end;
            if Assigned(DestinationStream) then begin
                FreeAndNil(DestinationStream);
            end;
            {$ENDIF}
            if (Result = WAVTAGLIBRARY_SUCCESS)
            AND FileExists(ChangeFileExt(_FileName, '.tmp'))
            then begin
                SysUtils.DeleteFile(_FileName);
                SysUtils.RenameFile(ChangeFileExt(_FileName, '.tmp'), _FileName);
            end;
        end;
    except
        Result := WAVTAGLIBRARY_ERROR;
    end;
end;

function TWAVTag.SaveToStream(Stream: TStream): Integer;
var
    DestinationStream: TStream;
    PreviousPosition, SeekPosition: Int64;
    LISTChunkSize: Cardinal;
    BEXTChunkSize: Cardinal;
    CARTChunkSize: Cardinal;
    NewILSTINFOBEXTCARTChunkStream: TStream;
    NewRIFFSizeDWord: DWord;
    ID3v2Size: Cardinal;
begin
    Result := WAVTAGLIBRARY_ERROR;
    Stream.Seek(0, soBeginning);
    DestinationStream := nil;
    try
        RemoveEmptyFrames;
        if Stream.Size = 0 then begin
            //* Create a new RIFF file with only a LIST INFO chunk
            Stream.Write(RIFFID[0], SizeOf(TRIFFID));
            NewRIFFSizeDWord := 4;
            Stream.Write(NewRIFFSizeDWord, SizeOf(NewRIFFSizeDWord));
            Stream.Write(RIFFWAVEID[0], SizeOf(TRIFFChunkID));
            Stream.Seek(0, soBeginning);
        end else begin
            if AutomaticallyFix then begin
                FixedOnSave := FixWAVEStream(Stream);
            end;
        end;
        try
            Stream.Seek(0, soBeginning);
            if CheckRIFF(Stream) then begin
                if NOT ValidRIFF(Stream) then begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end else begin
                Stream.Seek(0, soBeginning);
                if CheckRF64(Stream) then begin
                    if NOT ValidRF64(Stream) then begin
                        Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                        Exit;
                    end;
                end else begin
                    Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
            end;
            Stream.Seek(0, soBeginning);
            try
                DestinationStream := TMemoryStream.Create;
            except
                Result := WAVTAGLIBRARY_ERROR_WRITING_FILE;
                Exit;
            end;
            { Copy and seek past the ID3v2 tag, if there is one }
            ID3v2Size := GetID3v2Size(Stream);
            Stream.Seek(0, soFromBeginning);
            if ID3v2Size > 0 then begin
                DestinationStream.CopyFrom(Stream, ID3v2Size);
            end;
            PreviousPosition := Stream.Position;
            NewILSTINFOBEXTCARTChunkStream := TMemoryStream.Create;
            try
                CreateTagChunks(NewILSTINFOBEXTCARTChunkStream);
                if CheckRIFF(Stream) then begin
                    if NOT ValidRIFF(Stream) then begin
                        Result := WAVTAGLIBRARY_ERROR_CORRUPT;
                        Exit;
                    end;
                    SeekPosition := Stream.Position;
                    LISTChunkSize := SeekRIFF(Stream);
                    Stream.Seek(SeekPosition, soBeginning);
                    BEXTChunkSize := SeekRIFFBEXT(Stream);
                    Stream.Seek(SeekPosition, soBeginning);
                    CARTChunkSize := SeekRIFFCART(Stream);
                    Stream.Seek(0, soBeginning);
                    RIFFUpdateTagChunks(Stream, DestinationStream, NewILSTINFOBEXTCARTChunkStream, LISTChunkSize + BEXTChunkSize + CARTChunkSize);
                end else begin
                    Stream.Seek(PreviousPosition, soBeginning);
                    if CheckRF64(Stream) then begin
                        if NOT ValidRF64(Stream) then begin
                            Result := WAVTAGLIBRARY_ERROR_CORRUPT;
                            Exit;
                        end;
                        SeekPosition := Stream.Position;
                        LISTChunkSize := SeekRF64(Stream);
                        Stream.Seek(SeekPosition, soBeginning);
                        BEXTChunkSize := SeekRF64BEXT(Stream);
                        Stream.Seek(SeekPosition, soBeginning);
                        CARTChunkSize := SeekRF64CART(Stream);
                        Stream.Seek(0, soBeginning);
                        RF64UpdateTagChunks(Stream, DestinationStream, NewILSTINFOBEXTCARTChunkStream, Int64(LISTChunkSize) + Int64(BEXTChunkSize) + Int64(CARTChunkSize));
                    end else begin
                        Result := WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                        Exit;
                    end;
                end;
            finally
                FreeAndNil(NewILSTINFOBEXTCARTChunkStream);
            end;
            Result := WAVTAGLIBRARY_SUCCESS;
        finally
            if Result = WAVTAGLIBRARY_SUCCESS then begin
                Stream.Size := 0;
                Stream.CopyFrom(DestinationStream, 0);
            end;
            Stream.Seek(0, soBeginning);
            if Assigned(DestinationStream) then begin
                FreeAndNil(DestinationStream);
            end;
        end;
    except
        Result := WAVTAGLIBRARY_ERROR;
    end;
end;

function TWAVTag.CalculateTagSize: Integer;
var
    TotalTagSize: Integer;
begin
    TotalTagSize := CalculateTotalFramesSize;
    TotalTagSize := TotalTagSize + 4 + 8;
    TotalTagSize := TotalTagSize + CalculateBEXTSize + 8;
    TotalTagSize := TotalTagSize + CalculateCARTSize + 8;
    Result := TotalTagSize;
end;

function TWAVTag.CalculateTotalFramesSize: Integer;
var
    TotalFramesSize: Integer;
    i: Integer;
begin
    TotalFramesSize := 0;
    for i := 0 to Frames.Count - 1 do begin
        TotalFramesSize := TotalFramesSize + Frames[i].Stream.Size + 4 + 4;
        if Odd(Frames[i].Stream.Size) then begin
            Inc(TotalFramesSize);
        end;
    end;
    Result := TotalFramesSize;
end;

procedure TWAVTag.Clear;
begin
    DeleteAllFrames;
    FileName := '';
    Loaded := False;
    Size := 0;
    BEXT.Clear;
    CART.Clear;
    EVNT.Clear;
    FillChar(Self.Attributes, SizeOf(TWaveFmt), 0);
    PlayTime := 0;
    SampleCount := 0;
    FFileSize := 0;
    SampleDataStartPosition := 0;
    SampleDataSize := 0;
    FixedOnSave := fwrFalse;
end;

function TWAVTag.Count: Integer;
begin
    Result := Frames.Count;
end;

function TWAVTag.AddTextFrame(const Name: String; const Text: String): Integer;
begin
    with AddFrame(Name) do begin
        SetAsText(Text);
        Result := Index;
    end;
end;

procedure TWAVTag.AddBinaryFrame(const Name: String; BinaryStream: TStream; DataSize: Integer);
var
    PreviousPosition: Int64;
begin
    with AddFrame(Name) do begin
        PreviousPosition := BinaryStream.Position;
        Stream.CopyFrom(BinaryStream, DataSize);
        Format := ffBinary;
        BinaryStream.Seek(PreviousPosition, soBeginning);
    end;
end;

procedure TWAVTag.SetTextFrameText(const Name: String; const Text: String);
var
    i: Integer;
    l: Integer;
begin
    i := 0;
    l := Frames.Count;
    while (i < l)
    AND (Frames[i].Name <> Name)
    do begin
        inc(i);
    end;
    if i = l then begin
        AddTextFrame(Name, Text);
    end else begin
        Frames[i].SetAsText(Text);
    end;
end;

procedure TWAVTag.SetListFrameText(const Name: String; List: TStrings);
var
    i: Integer;
    l: Integer;
begin
    i := 0;
    l := Frames.Count;
    while (i < l)
    AND (Frames[i].Name <> Name)
    do begin
        inc(i);
    end;
    if i = l then begin
        AddFrame(Name).SetAsList(List);
    end else begin
        Frames[i].SetAsList(List);
    end;
end;

function TWAVTag.ReadFrameByNameAsText(const Name: String): String;
var
    i: Integer;
    l: Integer;
begin
    Result := '';
    l := Frames.Count;
    i := 0;
    while (i <> l)
    AND (Frames[i].Name <> Name)
    do begin
        inc(i);
    end;
    if i = l then begin
        Result := '';
    end else begin
        if Frames[i].Format = ffText then begin
            Result := Frames[i].GetAsText;
        end;
    end;
end;

function TWAVTag.ReadFrameByNameAsList(const Name: String; var List: TStrings): Boolean;
var
    i: Integer;
    l: Integer;
begin
    Result := False;
    l := Frames.Count;
    i := 0;
    while (i <> l)
    AND (Frames[i].Name <> Name)
    do begin
        inc(i);
    end;
    if i = l then begin
        Result := False;
    end else begin
        if Frames[i].Format = ffText then begin
            Result := Frames[i].GetAsList(List);
        end;
    end;
end;

procedure TWAVTag.RemoveEmptyFrames;
var
    i: Integer;
begin
    for i := Frames.Count - 1 downto 0 do begin
        if Frames[i].Stream.Size = 0 then begin
            DeleteFrame(i);
        end;
    end;
end;

procedure TWAVTag.ReSetAlreadyParsedState;
var
    i: Integer;
begin
    for i := 0 to Frames.Count - 1 do begin
        Frames[i].AlreadyParsed := False;
    end;
end;

function TWAVTag.DeleteFrameByName(const Name: String): Boolean;
var
    i: Integer;
    l: Integer;
begin
    l := Frames.Count;
    i := 0;
    while (i <> l) and (Frames[i].Name <> Name) do begin
        inc(i);
    end;
    if i = l then begin
        Result := False;
        Exit;
    end;
    Frames[i].Free;
    Frames.Delete(i);
    Result := True;
end;

function TWAVTag.Assign(Source: TWAVTag): Boolean;
var
    i: Integer;
begin
    Clear;
    try
        FileName := Source.FileName;
        Loaded := Source.Loaded;
        Size := Source.Size;
        for i := 0 to Source.Frames.Count - 1 do begin
            case Source.Frames[i].Format of
                ffText: begin
                    SetTextFrameText(Source.Frames[i].Name, Source.Frames[i].GetAsText);
                end;
                ffBinary: begin
                    Source.Frames[i].Stream.Seek(0, soBeginning);
                    AddBinaryFrame(Source.Frames[i].Name, Source.Frames[i].Stream, Source.Frames[i].Stream.Size);
                end;
            end;
        end;
        Result := True;
    except
        Result := False;
    end;
end;

function RemoveWAVTagFromFile(FileName: String): Integer;
var
    ClearWAVTag: TWAVTag;
begin
    if NOT FileExists(FileName) then begin
        Result := WAVTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        ClearWAVTag := TWAVTag.Create;
        try
            Result := ClearWAVTag.SaveToFile(FileName);
        finally
            FreeAndNil(ClearWAVTag);
        end;
    except
        Result := WAVTAGLIBRARY_ERROR;
    end;
end;

function RemoveWAVTagFromStream(Stream: TStream): Integer;
var
    ClearWAVTag: TWAVTag;
begin
    if Stream.Size = 0 then begin
        Result := WAVTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        ClearWAVTag := TWAVTag.Create;
        try
            Result := ClearWAVTag.SaveToStream(Stream);
        finally
            FreeAndNil(ClearWAVTag);
        end;
    except
        Result := WAVTAGLIBRARY_ERROR;
    end;
end;

function RIFFChunkIDToString(ChunkID: TRIFFChunkID): String;
var
    i: integer;
begin
    Result := '';
    for i := Low(TRIFFChunkID) to High(TRIFFChunkID) do begin
        if ChunkID[i] <> 0 then begin
            Result := Result + Char(ChunkID[i]);
        end;
    end;
end;

procedure String2RIFFChunkID(StringFrameID: String; var ChunkID: TRIFFChunkID);
begin
    {$IFDEF NEXTGEN}
    ChunkID[0] := Ord(StringFrameID[0]);
    ChunkID[1] := Ord(StringFrameID[1]);
    ChunkID[2] := Ord(StringFrameID[2]);
    ChunkID[3] := Ord(StringFrameID[3]);
    {$ELSE}
    ChunkID[0] := Ord(StringFrameID[1]);
    ChunkID[1] := Ord(StringFrameID[2]);
    ChunkID[2] := Ord(StringFrameID[3]);
    ChunkID[3] := Ord(StringFrameID[4]);
    {$ENDIF}
end;

procedure TWAVTag.CreateTagChunks(Stream: TStream);
var
    i: Integer;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    Data: Byte;
begin
    Data := 0;
    //* Empty tag is used for RemoveWAVTagFromFile()
    if Count > 0 then begin
        Stream.Write(RIFFLISTID[0], SizeOf(TRIFFChunkID));
        ChunkSize := CalculateTotalFramesSize + 4;
        Stream.Write(ChunkSize, 4);
        Stream.Write(RIFFINFOID[0], SizeOf(TRIFFChunkID));
        for i := 0 to Count - 1 do begin
            String2RIFFChunkID(Frames[i].Name, ChunkID);
            Stream.Write(ChunkID[0], SizeOf(TRIFFChunkID));
            ChunkSize := Frames[i].Stream.Size;
            Stream.Write(ChunkSize, 4);
            Frames[i].Stream.Seek(0, soBeginning);
            Stream.CopyFrom(Frames[i].Stream, Frames[i].Stream.Size);
            if Odd(Frames[i].Stream.Size) then begin
                Stream.Write(Data, 1);
            end;
        end;
    end;
    if HaveBEXT then begin
        if BEXT.Version = 0 then begin
            BEXT.Version := 1;
        end;
        Stream.Write(RIFFBEXTID[0], SizeOf(TRIFFChunkID));
        ChunkSize := CalculateBEXTSize;
        Stream.Write(ChunkSize, 4);
        Stream.Write(BEXT.BEXTChunk.Description[0], SizeOf(BEXT.BEXTChunk));
        if Length(BEXT.CodingHistoryBytes) > 0 then begin
            Stream.Write(BEXT.CodingHistoryBytes[0], Length(BEXT.CodingHistoryBytes));
            if BEXT.CodingHistoryBytes[Length(BEXT.CodingHistoryBytes) - 1] <> 0 then begin
                Stream.Write(Data, 1);
            end;
        end;
        if Odd(Stream.Size) then begin
            Stream.Write(Data, 1);
        end;
    end;
    if HaveCART then begin
        if CART.Version = '' then begin
            CART.Version := '0101';
        end;
        Stream.Write(RIFFCARTID[0], SizeOf(TRIFFChunkID));
        ChunkSize := CalculateCARTSize;
        Stream.Write(ChunkSize, 4);
        Stream.Write(CART.CARTChunk.Version[0], SizeOf(CART.CARTChunk));
        if Length(CART.TagTextBytes) > 0 then begin
            Stream.Write(CART.TagTextBytes[0], Length(CART.TagTextBytes));
            if CART.TagTextBytes[Length(CART.TagTextBytes) - 1] <> 0 then begin
                Stream.Write(Data, 1);
            end;
        end;
        if Odd(Stream.Size) then begin
            Stream.Write(Data, 1);
        end;
    end;
end;

function WAVTagErrorCode2String(ErrorCode: Integer): String;
begin
    Result := 'Unknown error code.';
    case ErrorCode of
        WAVTAGLIBRARY_SUCCESS: Result := 'Success.';
        WAVTAGLIBRARY_ERROR: Result := 'Unknown error occured.';
        WAVTAGLIBRARY_ERROR_NO_TAG_FOUND: Result := 'No WAV LIST INFO tag found.';
        WAVTAGLIBRARY_ERROR_EMPTY_TAG: Result := 'WAV LIST INFO tag is empty.';
        WAVTAGLIBRARY_ERROR_EMPTY_FRAMES: Result := 'WAV LIST INFO tag contains only empty frames.';
        WAVTAGLIBRARY_ERROR_OPENING_FILE: Result := 'Error opening file.';
        WAVTAGLIBRARY_ERROR_READING_FILE: Result := 'Error reading file.';
        WAVTAGLIBRARY_ERROR_WRITING_FILE: Result := 'Error writing file.';
        WAVTAGLIBRARY_ERROR_CORRUPT: Result := 'Error: corrupt file.';
        WAVTAGLIBRARY_ERROR_DOESNT_FIT: Result := 'Error: WAV LIST INFO chunk doesn''t fit into the file.';
        WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := 'Error: not supported WAV LIST INFO version.';
        WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := 'Error: not supported file format.';
        WAVTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := 'Error: file is locked. Need exclusive access to write WAV tags to this file.';
    end;
end;

{ TBEXT }

function TBEXT.Assign(BEXT: TBEXT): Boolean;
begin
    Self.BEXTChunk := BEXT.BEXTChunk;
    Self.CodingHistory := BEXT.CodingHistory;
    Result := True;
end;

procedure TBEXT.Clear;
begin
    FillChar(Pointer(@BEXTChunk)^, SizeOf(BEXTChunk), 0);
    SetLength(CodingHistoryBytes, 0);
end;

function TBEXT.GetCodingHistory: String;
begin
    Result := '';
    if Length(CodingHistoryBytes) > 0 then begin
        Result := BytesToString(@CodingHistoryBytes[0], Length(CodingHistoryBytes));
    end;
end;

function TBEXT.GetDescription: String;
begin
    Result := BytesToString(@BEXTChunk.Description[0], SizeOf(BEXTChunk.Description));
end;

function TBEXT.GetLoudnessRange: Word;
begin
    Result := BEXTChunk.LoudnessRange;
end;

function TBEXT.GetLoudnessValue: Word;
begin
    Result := BEXTChunk.LoudnessValue;
end;

function TBEXT.GetMaxMomentaryLoudness: Word;
begin
    Result := BEXTChunk.MaxMomentaryLoudness;
end;

function TBEXT.GetMaxShortTermLoudness: Word;
begin
    Result := BEXTChunk.MaxShortTermLoudness;
end;

function TBEXT.GetMaxTruePeakLevel: Word;
begin
    Result := BEXTChunk.MaxTruePeakLevel;
end;

function TBEXT.GetOriginationDate: String;
begin
    Result := BytesToString(@BEXTChunk.OriginationDate[0], SizeOf(BEXTChunk.OriginationDate));
end;

function TBEXT.GetOriginationTime: String;
begin
    Result := BytesToString(@BEXTChunk.OriginationTime[0], SizeOf(BEXTChunk.OriginationTime));
end;

function TBEXT.GetOriginator: String;
begin
    Result := BytesToString(@BEXTChunk.Originator[0], SizeOf(BEXTChunk.Originator));
end;

function TBEXT.GetOriginatorReference: String;
begin
    Result := BytesToString(@BEXTChunk.OriginatorReference[0], SizeOf(BEXTChunk.OriginatorReference));
end;

function TBEXT.GetReserved: String;
begin
    Result := BytesToString(@BEXTChunk.Reserved[0], SizeOf(BEXTChunk.Reserved));
end;

function TBEXT.GetTimeReference: UInt64;
begin
    Result := BEXTChunk.TimeReference;
end;

function TBEXT.GetUMID: String;
var
    Bytes: TBytes;
    Counter: Integer;
begin
    Result := '';
    if BEXTChunk.Version > 0 then begin
        SetLength(Bytes, 64);
        for Counter := 0 to 63 do begin
            Result := Result + ' ' + IntToHEX(BEXTChunk.UMID[Counter], 2);
        end;
        Result := Trim(Result);
    end;
end;

function TBEXT.GetVersion: Word;
begin
    Result := BEXTChunk.Version;
end;

procedure TBEXT.SetCodingHistory(Value: String);
begin
    CodingHistoryBytes := GetBytesTryANSI(Value, - 1);
end;

procedure TBEXT.SetDescription(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@BEXTChunk.Description[0])^, SizeOf(BEXTChunk.Description), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(BEXTChunk.Description));
    TBytesToBytes(Bytes, @BEXTChunk.Description[0], SizeOf(BEXTChunk.Description));
end;

procedure TBEXT.SetLoudnessRange(Value: Word);
begin
    BEXTChunk.LoudnessRange := Value;
end;

procedure TBEXT.SetLoudnessValue(Value: Word);
begin
    BEXTChunk.LoudnessValue := Value;
end;

procedure TBEXT.SetMaxMomentaryLoudness(Value: Word);
begin
    BEXTChunk.MaxMomentaryLoudness := Value;
end;

procedure TBEXT.SetMaxShortTermLoudness(Value: Word);
begin
    BEXTChunk.MaxShortTermLoudness := Value;
end;

procedure TBEXT.SetMaxTruePeakLevel(Value: Word);
begin
    BEXTChunk.MaxTruePeakLevel := Value;
end;

procedure TBEXT.SetOriginationDate(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@BEXTChunk.OriginationDate[0])^, SizeOf(BEXTChunk.OriginationDate), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(BEXTChunk.OriginationDate));
    TBytesToBytes(Bytes, @BEXTChunk.OriginationDate[0], SizeOf(BEXTChunk.OriginationDate));
end;

procedure TBEXT.SetOriginationTime(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@BEXTChunk.OriginationTime[0])^, SizeOf(BEXTChunk.OriginationTime), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(BEXTChunk.OriginationTime));
    TBytesToBytes(Bytes, @BEXTChunk.OriginationTime[0], SizeOf(BEXTChunk.OriginationTime));
end;

procedure TBEXT.SetOriginator(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@BEXTChunk.Originator[0])^, SizeOf(BEXTChunk.Originator), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(BEXTChunk.Originator));
    TBytesToBytes(Bytes, @BEXTChunk.Originator[0], SizeOf(BEXTChunk.Originator));
end;

procedure TBEXT.SetOriginatorReference(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@BEXTChunk.OriginatorReference[0])^, SizeOf(BEXTChunk.OriginatorReference), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(BEXTChunk.OriginatorReference));
    TBytesToBytes(Bytes, @BEXTChunk.OriginatorReference[0], SizeOf(BEXTChunk.OriginatorReference));
end;

procedure TBEXT.SetReserved(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@BEXTChunk.Reserved[0])^, SizeOf(BEXTChunk.Reserved), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(BEXTChunk.Reserved));
    TBytesToBytes(Bytes, @BEXTChunk.Reserved[0], SizeOf(BEXTChunk.Reserved));
end;

procedure TBEXT.SetTimeReference(Value: UInt64);
begin
    BEXTChunk.TimeReference := Value;
end;

procedure TBEXT.SetUMID(Value: String);
var
    i: Integer;
    List: TStrings;
    DataByte: Byte;
begin
    FillChar(Pointer(@BEXTChunk.UMID[0])^, SizeOf(BEXTChunk.UMID), 0);
    List := TStringList.Create;
    try
        List.Delimiter := ' ';
        List.StrictDelimiter := True;
        List.DelimitedText := Value;
        for i := 0 to List.Count - 1 do begin
            DataByte := StrToIntDef('$' + List[i], 0);
            BEXTChunk.UMID[i] := DataByte;
            if i >= Length(BEXTChunk.UMID) - 1 then begin
                Break;
            end;
        end;
    finally
        FreeAndNil(List);
    end;
end;

procedure TBEXT.SetVersion(Value: Word);
begin
    BEXTChunk.Version := Value;
end;

{ TCART }

function TCART.Assign(CART: TCART): Boolean;
begin
    Self.CARTChunk := CART.CARTChunk;
    Self.TagText := CART.TagText;
    Result := True;
end;

procedure TCART.Clear;
begin
    FillChar(Pointer(@CARTChunk)^, SizeOf(CARTChunk), 0);
    SetLength(TagTextBytes, 0);
end;

function TCART.ClearPostTimer(Index: Integer): Boolean;
begin
    Result := False;
    if (Index < Low(CARTChunk.PostTimer))
    OR (Index > High(CARTChunk.PostTimer))
    then begin
        Exit;
    end;
    FillChar(CARTChunk.PostTimer[Index].Usage, 4, 0);
    CARTChunk.PostTimer[Index].Value := 0;
end;

function TCART.GetArtist: String;
begin
    Result := BytesToString(@CARTChunk.Artist[0], SizeOf(CARTChunk.Artist));
end;

function TCART.GetCategory: String;
begin
    Result := BytesToString(@CARTChunk.Category[0], SizeOf(CARTChunk.Category));
end;

function TCART.GetClassification: String;
begin
    Result := BytesToString(@CARTChunk.Classification[0], SizeOf(CARTChunk.Classification));
end;

function TCART.GetClientID: String;
begin
    Result := BytesToString(@CARTChunk.ClientID[0], SizeOf(CARTChunk.ClientID));
end;

function TCART.GetCutID: String;
begin
    Result := BytesToString(@CARTChunk.CutID[0], SizeOf(CARTChunk.CutID));
end;

function TCART.GetEndDate: String;
begin
    Result := BytesToString(@CARTChunk.EndDate[0], SizeOf(CARTChunk.EndDate));
end;

function TCART.GetEndTime: String;
begin
    Result := BytesToString(@CARTChunk.EndTime[0], SizeOf(CARTChunk.EndTime));
end;

function TCART.GetLevelReference: DWORD;
begin
    Result := CARTChunk.dwLevelReference;
end;

function TCART.GetOutCue: String;
begin
    Result := BytesToString(@CARTChunk.OutCue[0], SizeOf(CARTChunk.OutCue));
end;

function TCART._GetPostTimer: TTAG_CART_TIMERS;
begin
    Result := CARTChunk.PostTimer;
end;

function TCART.GetProducerAppID: String;
begin
    Result := BytesToString(@CARTChunk.ProducerAppID[0], SizeOf(CARTChunk.ProducerAppID));
end;

function TCART.GetProducerAppVersion: String;
begin
    Result := BytesToString(@CARTChunk.ProducerAppVersion[0], SizeOf(CARTChunk.ProducerAppVersion));
end;

function TCART.GetReserved: String;
begin
    Result := BytesToString(@CARTChunk.Reserved[0], SizeOf(CARTChunk.Reserved));
end;

function TCART.GetStartDate: String;
begin
    Result := BytesToString(@CARTChunk.StartDate[0], SizeOf(CARTChunk.StartDate));
end;

function TCART.GetStartTime: String;
begin
    Result := BytesToString(@CARTChunk.StartTime[0], SizeOf(CARTChunk.StartTime));
end;

function TCART.GetTagText: String;
begin
    Result := '';
    if Length(TagTextBytes) > 0 then begin
        Result := BytesToString(@TagTextBytes[0], Length(TagTextBytes));
    end;
end;

function TCART.GetTitle: String;
begin
    Result := BytesToString(@CARTChunk.Title[0], SizeOf(CARTChunk.Title));
end;

function TCART.GetURL: String;
begin
    Result := BytesToString(@CARTChunk.URL[0], SizeOf(CARTChunk.URL));
end;

function TCART.GetUserDef: String;
begin
    Result := BytesToString(@CARTChunk.UserDef[0], SizeOf(CARTChunk.UserDef));
end;

function TCART.GetVersion: String;
begin
    Result := BytesToString(@CARTChunk.Version[0], SizeOf(CARTChunk.Version));
end;

procedure TCART.SetArtist(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.Artist[0])^, SizeOf(CARTChunk.Artist), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.Artist));
    TBytesToBytes(Bytes, @CARTChunk.Artist[0], SizeOf(CARTChunk.Artist));
end;

procedure TCART.SetCategory(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.Category[0])^, SizeOf(CARTChunk.Category), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.Category));
    TBytesToBytes(Bytes, @CARTChunk.Category[0], SizeOf(CARTChunk.Category));
end;

procedure TCART.SetClassification(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.Classification[0])^, SizeOf(CARTChunk.Classification), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.Classification));
    TBytesToBytes(Bytes, @CARTChunk.Classification[0], SizeOf(CARTChunk.Classification));
end;

procedure TCART.SetClientID(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.ClientID[0])^, SizeOf(CARTChunk.ClientID), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.ClientID));
    TBytesToBytes(Bytes, @CARTChunk.ClientID[0], SizeOf(CARTChunk.ClientID));
end;

procedure TCART.SetCutID(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.CutID[0])^, SizeOf(CARTChunk.CutID), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.CutID));
    TBytesToBytes(Bytes, @CARTChunk.CutID[0], SizeOf(CARTChunk.CutID));
end;

procedure TCART.SetEndDate(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.EndDate[0])^, SizeOf(CARTChunk.EndDate), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.EndDate));
    TBytesToBytes(Bytes, @CARTChunk.EndDate[0], SizeOf(CARTChunk.EndDate));
end;

procedure TCART.SetEndTime(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.EndTime[0])^, SizeOf(CARTChunk.EndTime), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.EndTime));
    TBytesToBytes(Bytes, @CARTChunk.EndTime[0], SizeOf(CARTChunk.EndTime));
end;

procedure TCART.SetLevelReference(Value: DWORD);
begin
    CARTChunk.dwLevelReference := Value;
end;

procedure TCART.SetOutCue(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.OutCue[0])^, SizeOf(CARTChunk.OutCue), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.OutCue));
    TBytesToBytes(Bytes, @CARTChunk.OutCue[0], SizeOf(CARTChunk.OutCue));
end;

procedure TCART._SetPostTimer(Value: TTAG_CART_TIMERS);
begin
    CARTChunk.PostTimer := Value;
end;

procedure TCART.SetProducerAppID(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.ProducerAppID[0])^, SizeOf(CARTChunk.ProducerAppID), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.ProducerAppID));
    TBytesToBytes(Bytes, @CARTChunk.ProducerAppID[0], SizeOf(CARTChunk.ProducerAppID));
end;

procedure TCART.SetProducerAppVersion(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.ProducerAppVersion[0])^, SizeOf(CARTChunk.ProducerAppVersion), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.ProducerAppVersion));
    TBytesToBytes(Bytes, @CARTChunk.ProducerAppVersion[0], SizeOf(CARTChunk.ProducerAppVersion));
end;

procedure TCART.SetReserved(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.Reserved[0])^, SizeOf(CARTChunk.Reserved), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.Reserved));
    TBytesToBytes(Bytes, @CARTChunk.Reserved[0], SizeOf(CARTChunk.Reserved));
end;

procedure TCART.SetStartDate(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.StartDate[0])^, SizeOf(CARTChunk.StartDate), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.StartDate));
    TBytesToBytes(Bytes, @CARTChunk.StartDate[0], SizeOf(CARTChunk.StartDate));
end;

procedure TCART.SetStartTime(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.StartTime[0])^, SizeOf(CARTChunk.StartTime), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.StartTime));
    TBytesToBytes(Bytes, @CARTChunk.StartTime[0], SizeOf(CARTChunk.StartTime));
end;

procedure TCART.SetTagText(Value: String);
begin
    TagTextBytes := GetBytesTryANSI(Value, - 1);
end;

procedure TCART.SetTitle(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.Title[0])^, SizeOf(CARTChunk.Title), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.Title));
    TBytesToBytes(Bytes, @CARTChunk.Title[0], SizeOf(CARTChunk.Title));
end;

procedure TCART.SetURL(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.URL[0])^, SizeOf(CARTChunk.URL), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.URL));
    TBytesToBytes(Bytes, @CARTChunk.URL[0], SizeOf(CARTChunk.URL));
end;

procedure TCART.SetUserDef(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.UserDef[0])^, SizeOf(CARTChunk.UserDef), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.UserDef));
    TBytesToBytes(Bytes, @CARTChunk.UserDef[0], SizeOf(CARTChunk.UserDef));
end;

procedure TCART.SetVersion(Value: String);
var
    Bytes: TBytes;
begin
    FillChar(Pointer(@CARTChunk.Version[0])^, SizeOf(CARTChunk.Version), 0);
    Bytes := GetBytesTryANSI(Value, SizeOf(CARTChunk.Version));
    TBytesToBytes(Bytes, @CARTChunk.Version[0], SizeOf(CARTChunk.Version));
end;

function TCART.GetPostTimer(Index: Integer; var CART_TIMER: TCART_TIMER): Boolean;
begin
    Result := False;
    if (Index < Low(CARTChunk.PostTimer))
    OR (Index > High(CARTChunk.PostTimer))
    then begin
        Exit;
    end;
    CART_TIMER.Usage := BytesToString(@CARTChunk.PostTimer[Index].Usage[0], 4);
    CART_TIMER.Value := CARTChunk.PostTimer[Index].Value;
    Result := True;
end;

function TCART.SetPostTimer(Index: Integer; CART_TIMER: TCART_TIMER): Boolean;
begin
    Result := False;
    if (Index < Low(CARTChunk.PostTimer))
    OR (Index > High(CARTChunk.PostTimer))
    then begin
        Exit;
    end;
    ClearPostTimer(Index);
    StringToCART_TIMER_Usage(CART_TIMER.Usage, CARTChunk.PostTimer[Index].Usage);
    CARTChunk.PostTimer[Index].Value := CART_TIMER.Value;
    Result := True;
end;

function TWAVTag.GetCodec: String;
begin
    { Get format type name }
    case Attributes.FormatTag of
        1: Result := WAV_FORMAT_PCM;
        2: Result := WAV_FORMAT_ADPCM;
        3: Result := WAV_FORMAT_IEEE_FLOAT;
        6: Result := WAV_FORMAT_ALAW;
        7: Result := WAV_FORMAT_MULAW;
        17: Result := WAV_FORMAT_DVI_IMA_ADPCM;
        85: Result := WAV_FORMAT_MP3;
        65534: Result := WAV_FORMAT_EXTENSIBLE;
    else
        Result := WAV_FORMAT_UNKNOWN;
    end;
end;

function TWAVTag.GetWAVEInformation(Stream: TStream): TWaveFmt;
var
    SourceHeader: TWaveHeader;
    ChunkIdent: TRIFFChunkID;
    ChunkSize: DWord;
    SourceISRF64: Boolean;
    Sourceds64: TWaveds64;
    SampleNumber: DWord;
    DataSize32: DWord;
    DataPosition: Int64;
    PreviousPosition: Int64;
begin
    SampleNumber := 0;
    DataPosition := 0;

    Stream.Seek(0, soBeginning);

    Stream.Read(SourceHeader, SizeOf(TWaveHeader));

    SourceISRF64 := (SourceHeader.ident1[0] = RF64ID[0])
        AND (SourceHeader.ident1[1] = RF64ID[1])
        AND (SourceHeader.ident1[2] = RF64ID[2])
        AND (SourceHeader.ident1[3] = RF64ID[3])
    ;

    Stream.Read(ChunkIdent, 4);
    if (ChunkIdent[0] <> RIFFWAVEID[0])
    OR (ChunkIdent[1] <> RIFFWAVEID[1])
    OR (ChunkIdent[2] <> RIFFWAVEID[2])
    OR (ChunkIdent[3] <> RIFFWAVEID[3])
    then begin
        Exit;
    end;

    if SourceISRF64 then begin
        Stream.Read(ChunkIdent, 4);
        if (ChunkIdent[0] = Ord('d'))
        AND (ChunkIdent[1] = Ord('s'))
        AND (ChunkIdent[2] = Ord('6'))
        AND (ChunkIdent[3] = Ord('4'))
        then begin
            Stream.Read(Sourceds64, SizeOf(TWaveds64));
            //SampleDataStartPosition := Stream.Position;
            SampleDataSize := MakeUInt64(Sourceds64.DataSizeLow, Sourceds64.DataSizeHigh);
            SampleCount := MakeUInt64(Sourceds64.SampleCountLow, Sourceds64.SampleCountHigh);
            Stream.Seek(Sourceds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
        end;
    end;

    repeat
        Stream.Read(ChunkIdent, 4);
        if (ChunkIdent[0] <> Ord('f'))
        OR (ChunkIdent[1] <> Ord('m'))
        OR (ChunkIdent[2] <> Ord('t'))
        OR (ChunkIdent[3] <> Ord(' '))
        then begin
            Stream.Read(ChunkSize, 4);
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            Stream.Seek(ChunkSize, soCurrent);
        end;
    until ((ChunkIdent[0] = Ord('f'))
        AND (ChunkIdent[1] = Ord('m'))
        AND (ChunkIdent[2] = Ord('t'))
        AND (ChunkIdent[3] = Ord(' ')))
    OR (Stream.Position >= Stream.Size);

    PreviousPosition := Stream.Position - 4;

    Stream.Read(Result, SizeOf(TWaveFmt));

    if (Result.FormatTag <> $FFFE)
    OR (Result.fmtSize <> SizeOf(TWaveFmt))
    then begin
        Result.cbSize := 0;
        Result.ValidBitsPerSample := 0;
        Result.ChannelMask := 0;
        FillChar(Result.SubFormat[0], SizeOf(Result.SubFormat), 0);
    end;

    Stream.Seek(PreviousPosition, soBeginning);

    repeat
        Stream.Read(ChunkIdent, 4);
        //* fact
        if (ChunkIdent[0] = Ord('f'))
        AND (ChunkIdent[1] = Ord('a'))
        AND (ChunkIdent[2] = Ord('c'))
        AND (ChunkIdent[3] = Ord('t'))
        then begin
            Stream.Read(SampleNumber, 4);
            Stream.Seek(- 4, soCurrent);
        end;
        //* data
        if (ChunkIdent[0] <> Ord('d'))
        OR (ChunkIdent[1] <> Ord('a'))
        OR (ChunkIdent[2] <> Ord('t'))
        OR (ChunkIdent[3] <> Ord('a'))
        then begin
            Stream.Read(ChunkSize, 4);
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            DataPosition := Stream.Position;
            Stream.Seek(ChunkSize, soCurrent);
        end;
    until ((ChunkIdent[0] = Ord('d'))
        AND (ChunkIdent[1] = Ord('a'))
        AND (ChunkIdent[2] = Ord('t'))
        AND (ChunkIdent[3] = Ord('a')))
    OR (Stream.Position >= Stream.Size);

    Stream.Read(DataSize32, 4);
    if DataSize32 > Stream.Size - DataPosition then begin
        DataSize32 := Stream.Size - DataPosition;
    end;

    SampleDataStartPosition := Stream.Position;
    if NOT SourceISRF64 then begin
        SampleDataSize := DataSize32;
        SampleCount := DataSize32 div Result.BlockAlign;
    end;

    if SampleNumber div Result.BlockAlign <= 0 then begin
        PlayTime := SampleDataSize / Result.AvgBytesPerSec;
    end else begin
        PlayTime := SampleCount / Result.SamplesPerSec;
    end;

    BitRate := Result.AvgBytesPerSec div 125;
end;

procedure TWAVTag.LoadWAVEAttributes(Stream: TStream);
begin
    FillChar(Self.Attributes, SizeOf(TWaveFmt), 0);
    Self.Attributes := GetWAVEInformation(Stream);
end;

function FixWAVEStream(Stream: TStream): TFixWAVEResult;
var
    SourceHeader: TWaveHeader;
    ChunkIdent: TRIFFChunkID;
    ChunkSize32: DWord;
    ChunkSize64: UInt64;
    SourceISRF64: Boolean;
    Sourceds64: TWaveds64;
    DataSize32: DWord;
    DataSize: Int64;
    DataPosition: Int64;
    PreviousPosition: Int64;
    TotalChunksSize32: Cardinal;
    TotalChunksSize64: UInt64;
    NeedFix: Boolean;
    NeedFixData: Boolean;
    ZeroByte: Byte;
    WaveFmt: TWaveFmt;
    fmtPosition: Cardinal;
    dataPaddingNeeded: Cardinal;
    i: Integer;
    Data: DWord;
    SampleCount: UInt64;
    NewSampleCount: UInt64;
begin
    Result := fwrFalse;
    FillChar(WaveFmt, SizeOf(TWaveFmt), 0);
    SampleCount := 0;
    DataSize := 0;
    NeedFix := False;
    NeedFixData := False;
    ZeroByte := 0;
    PreviousPosition := Stream.Position;
    try
        Stream.Read(SourceHeader, SizeOf(TWaveHeader));
        SourceISRF64 := (SourceHeader.ident1[0] = RF64ID[0])
            AND (SourceHeader.ident1[1] = RF64ID[1])
            AND (SourceHeader.ident1[2] = RF64ID[2])
            AND (SourceHeader.ident1[3] = RF64ID[3])
        ;
        Stream.Read(ChunkIdent, 4);
        if (ChunkIdent[0] <> RIFFWAVEID[0])
        OR (ChunkIdent[1] <> RIFFWAVEID[1])
        OR (ChunkIdent[2] <> RIFFWAVEID[2])
        OR (ChunkIdent[3] <> RIFFWAVEID[3])
        then begin
            Result := fwrUnsupported;
            Exit;
        end;
        if SourceISRF64 then begin
            Stream.Read(ChunkIdent, 4);
            if (ChunkIdent[0] = Ord('d'))
            AND (ChunkIdent[1] = Ord('s'))
            AND (ChunkIdent[2] = Ord('6'))
            AND (ChunkIdent[3] = Ord('4'))
            then begin
                Stream.Read(Sourceds64, SizeOf(TWaveds64));
                DataSize := MakeUInt64(Sourceds64.DataSizeLow, Sourceds64.DataSizeHigh);
                SampleCount := MakeUInt64(Sourceds64.SampleCountLow, Sourceds64.SampleCountHigh);
                Stream.Seek(- (SizeOf(TWaveds64) + 4), soCurrent);
            end;
        end;
        //* RIFF size
        TotalChunksSize64 := 4;
        //* Last 'data' chunk's content position (that might be truncated)
        DataPosition := 0;
        repeat
            Stream.Read(ChunkIdent, 4);
            Stream.Read(ChunkSize32, 4);
            ChunkSize64 := ChunkSize32;
            //* data
            if (ChunkIdent[0] = Ord('d'))
            AND (ChunkIdent[1] = Ord('a'))
            AND (ChunkIdent[2] = Ord('t'))
            AND (ChunkIdent[3] = Ord('a'))
            then begin
                DataPosition := Stream.Position;
                if SourceISRF64 then begin
                    ChunkSize64 := DataSize;
                end;
                if NOT SourceISRF64 then begin
                    DataSize := ChunkSize64;
                end;
                if DataSize > Stream.Size - DataPosition then begin
                    DataSize := Stream.Size - DataPosition;
                    ChunkSize64 := DataSize;
                    NeedFix := True;
                    NeedFixData := True;
                end;
            end;
            //* fmt
            if (ChunkIdent[0] = Ord('f'))
            AND (ChunkIdent[1] = Ord('m'))
            AND (ChunkIdent[2] = Ord('t'))
            AND (ChunkIdent[3] = Ord(' '))
            then begin
                fmtPosition := Stream.Position;
                Stream.Seek(- 4, soCurrent);
                Stream.Read(WaveFmt, SizeOf(TWaveFmt));
                Stream.Seek(fmtPosition, soBeginning);
            end;
            //* Sum the chunk sizes
            if Odd(ChunkSize64) then begin
                //* Check if padded with a 0 byte
                Stream.Seek(ChunkSize64, soCurrent);
                Stream.Read(ZeroByte, 1);
                if ZeroByte <> 0 then begin
                    Result := fwrUnsupported;
                    Exit;
                end;
                Stream.Seek(-(ChunkSize64 + 1), soCurrent);
                Inc(ChunkSize64);
            end;
            TotalChunksSize64 := TotalChunksSize64 + ChunkSize64 + 8;
            //* Seek to next chunk
            Stream.Seek(ChunkSize64, soCurrent);
        until (Stream.Position >= Stream.Size)
        OR ((NOT SourceISRF64) AND (Stream.Position >= SourceHeader.len + 8))
        OR (SourceISRF64 AND (Stream.Position >= MakeUInt64(Sourceds64.RIFFSizeLow, Sourceds64.RIFFSizeHigh) + 8));
        //* Decide if padding is needed
        if WaveFmt.BlockAlign > 0 then begin
            dataPaddingNeeded := DataSize mod WaveFmt.BlockAlign;
        end else begin
            //* Unknown align
            dataPaddingNeeded := 0;
        end;
        Inc(DataSize, dataPaddingNeeded);
        Inc(TotalChunksSize64, dataPaddingNeeded);
        //* Is total size valid?
        if SourceISRF64 then begin
            if TotalChunksSize64 <> MakeUInt64(Sourceds64.RIFFSizeLow, Sourceds64.RIFFSizeHigh) then begin
                NeedFix := True;
            end;
        end else begin
            if TotalChunksSize64 <> SourceHeader.len then begin
                NeedFix := True;
            end;
        end;
        if NeedFix then begin
            //* Update total size
            if SourceISRF64 then begin
                //* Set new RF64 size
                Stream.Seek(PreviousPosition + 20, soBeginning);
                Data := LowDWordOfUInt64(TotalChunksSize64);
                Stream.Write(Data, 4);
                Data := HighDWordOfUInt64(TotalChunksSize64);
                Stream.Write(Data, 4);
            end else begin
                TotalChunksSize32 := TotalChunksSize64;
                Stream.Seek(PreviousPosition + 4, soBeginning);
                Stream.Write(TotalChunksSize32, 4);
            end;
            //* Update data chunk size
            if NeedFixData then begin
                if SourceISRF64 then begin
                    //* Set new RF64 size
                    Data := LowDWordOfUInt64(DataSize);
                    Stream.Write(Data, 4);
                    Data := HighDWordOfUInt64(DataSize);
                    Stream.Write(Data, 4);
                    //* Set new sample count
                    if WaveFmt.BlockAlign > 0 then begin
                        NewSampleCount := DataSize div WaveFmt.BlockAlign;
                    end else begin
                        //* This is only an estimation
                        NewSampleCount := Trunc(SampleCount * (DataSize / MakeUInt64(Sourceds64.DataSizeLow, Sourceds64.DataSizeHigh)));
                    end;
                    Data := LowDWordOfUInt64(NewSampleCount);
                    Stream.Write(Data, 4);
                    Data := HighDWordOfUInt64(NewSampleCount);
                    Stream.Write(Data, 4);
                    //* Add padding bytes if needed
                    Stream.Seek(DataPosition + DataSize - dataPaddingNeeded, soCurrent);
                    for i := 1 to dataPaddingNeeded do begin
                        Stream.Write(ZeroByte, 1);
                    end;
                end else begin
                    DataSize32 := DataSize;
                    Stream.Seek(DataPosition - 4, soBeginning);
                    Stream.Write(DataSize32, 4);
                    //* Add padding bytes if needed
                    Stream.Seek(DataSize32 - dataPaddingNeeded, soCurrent);
                    for i := 1 to dataPaddingNeeded do begin
                        Stream.Write(ZeroByte, 1);
                    end;
                end;
            end;
            //* File is fixed
            Result := fwrTrue;
        end;
    finally
        Stream.Seek(PreviousPosition, soBeginning);
    end;
end;

function FixWAVEFile(FileName: String): TFixWAVEResult;
var
    Stream: TFileStream;
begin
    Result := fwrFalse;
    if NOT FileExists(FileName) then begin
        Exit;
    end;
    Stream := TFileStream.Create(FileName, fmOpenReadWrite);
    try
        Result := FixWAVEStream(Stream);
    finally
        FreeAndNil(Stream);
    end;
end;

{ TEVNT }

procedure TEVNT.Clear;
begin
    SetLength(SPEVENTS, 0);
end;

Initialization

    RIFFID[0] := Ord('R');
    RIFFID[1] := Ord('I');
    RIFFID[2] := Ord('F');
    RIFFID[3] := Ord('F');

    RF64ID[0] := Ord('R');
    RF64ID[1] := Ord('F');
    RF64ID[2] := Ord('6');
    RF64ID[3] := Ord('4');

    RIFFWAVEID[0] := Ord('W');
    RIFFWAVEID[1] := Ord('A');
    RIFFWAVEID[2] := Ord('V');
    RIFFWAVEID[3] := Ord('E');

    RIFFLISTID[0] := Ord('L');
    RIFFLISTID[1] := Ord('I');
    RIFFLISTID[2] := Ord('S');
    RIFFLISTID[3] := Ord('T');

    RIFFINFOID[0] := Ord('I');
    RIFFINFOID[1] := Ord('N');
    RIFFINFOID[2] := Ord('F');
    RIFFINFOID[3] := Ord('O');

    RIFFBEXTID[0] := Ord('b');
    RIFFBEXTID[1] := Ord('e');
    RIFFBEXTID[2] := Ord('x');
    RIFFBEXTID[3] := Ord('t');

    RIFFCARTID[0] := Ord('c');
    RIFFCARTID[1] := Ord('a');
    RIFFCARTID[2] := Ord('r');
    RIFFCARTID[3] := Ord('t');

    RIFFEVNTID[0] := Ord('E');
    RIFFEVNTID[1] := Ord('V');
    RIFFEVNTID[2] := Ord('N');
    RIFFEVNTID[3] := Ord('T');

end.


