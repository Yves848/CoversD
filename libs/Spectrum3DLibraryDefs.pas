//********************************************************************************************************************************
//*                                                                                                                              *
//*     TSpectrum3D 1.2.21.35 © 3delite 2008-2020                                                                                *
//*     See TSpectrum3D ReadMe.txt for details.                                                                                  *
//*                                                                                                                              *
//* Licenses available for usege of this library:                                                                                *
//* Freeware License: €15                                                                                                        *
//* 	http://www.shareit.com/product.html?productid=300961247                                                                  * 
//* Shareware License: €25                                                                                                       *
//* 	http://www.shareit.com/product.html?productid=300064121                                                                  *
//* Commercial License: €125                                                                                                     *
//*	http://www.shareit.com/product.html?productid=300064123                                                                  *
//*                                                                                                                              *
//* Home page:                                                                                                                   *
//*     https://www.3delite.hu/Object Pascal Developer Resources/tspectrum3d.html                                                *
//*                                                                                                                              *
//* Note: If you plan using TSpectrum3D in you programs (shareware or commercial), you'll also need a BASS license               *
//* available separatelly from:                                                                                                  *
//*                                                                                                                              *
//*     http://www.un4seen.com/bass.html                                                                                         *
//*                                                                                                                              *
//* Credits:                                                                                                                     *
//* Ian Luck @ www.un4seen.com - for the great BASS audio library.                                                               *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

unit Spectrum3DLibraryDefs;

interface

uses
  Windows, SysUtils, Classes;

const
    Spectrum3DDLL = 'Spectrum3DLibrary.dll';

const
    NAME_Spectrum3D_Create               = 'Spectrum3D_Create';
    NAME_Spectrum3D_Free                 = 'Spectrum3D_Free';
    NAME_Spectrum3D_SetChannel           = 'Spectrum3D_SetChannel';
    NAME_Spectrum3D_GetChannel           = 'Spectrum3D_GetChannel';
    NAME_Spectrum3D_Render               = 'Spectrum3D_Render';
    NAME_Spectrum3D_ReAlign              = 'Spectrum3D_ReAlign';
    NAME_Spectrum3D_GetParams            = 'Spectrum3D_GetParams';
    NAME_Spectrum3D_SetParams            = 'Spectrum3D_SetParams';
    NAME_Spectrum3D_ReInitialize         = 'Spectrum3D_ReInitialize';

type
    PSpectrum3D_CreateParams = ^TSpectrum3D_CreateParams;
    TSpectrum3D_CreateParams = record
        ParentHandle: HWND;
        AntiAliasing: Cardinal;
    end;

type
    PSpectrum3D_Settings = ^TSpectrum3D_Settings;
    TSpectrum3D_Settings = record
        D3D11Device: Pointer;
        D3D11DeviceContext: Pointer;
        GFXZoom: Double;
        GFXScroll: Double;
        GFXAmplitude: Double;
        ShowText: Bool;
        FontSize: Integer;
        FontColor: Cardinal;
        ShowGridLines: Bool;
        GradientGrid: Bool;
        BackgroundColor: Cardinal;
        //BackgroundPictureFileName: PChar;
        //BackgroundPictureStretch: Bool;
        CustomSampleRate: Integer;
        CallbackOnNeedFFTData: Pointer;
    end;

type
    t_Spectrum3D_Create             = function(Params: PSpectrum3D_CreateParams): Pointer; stdcall;
    t_Spectrum3D_Free               = function(Display: Pointer): LongBool; stdcall;
    t_Spectrum3D_SetChannel         = function(Display: Pointer; Channel: DWord): LongBool; stdcall;
    t_Spectrum3D_GetChannel         = function(Display: Pointer): DWord; stdcall;
    t_Spectrum3D_Render             = function(Display: Pointer): Bool; stdcall;
    t_Spectrum3D_ReAlign            = function(Display: Pointer; ParentHandle: HWND): LongBool; stdcall;
    t_Spectrum3D_GetParams          = function(Display: Pointer; Settings: PSpectrum3D_Settings): LongBool; stdcall;
    t_Spectrum3D_SetParams          = function(Display: Pointer; Params: PSpectrum3D_Settings): LongBool; stdcall;
    t_Spectrum3D_ReInitialize       = function(Display: Pointer): LongBool; stdcall;
    //* Callback function
    t_Spectrum3D_OnNeedFFTData      = function(Display: Pointer; Data: PSingle; ValuesCount: Integer): Integer stdcall;

    function InitSpectrum3DLibrary: Boolean;
    function FreeSpectrum3DLibrary: Boolean;    
    
var
    Spectrum3D_Create: t_Spectrum3D_Create;
    Spectrum3D_Free: t_Spectrum3D_Free;
    Spectrum3D_SetChannel: t_Spectrum3D_SetChannel;
    Spectrum3D_GetChannel: t_Spectrum3D_GetChannel;
    Spectrum3D_Render: t_Spectrum3D_Render;
    Spectrum3D_ReAlign: t_Spectrum3D_ReAlign;
    Spectrum3D_GetParams: t_Spectrum3D_GetParams;
    Spectrum3D_SetParams: t_Spectrum3D_SetParams;
    Spectrum3D_ReInitialize: t_Spectrum3D_ReInitialize;
    Spectrum3DDLLHandle: THandle = 0;
    Spectrum3DDLLLoaded: Boolean = False;

implementation

function InitSpectrum3DLibrary: Boolean;
begin
    Spectrum3DDLLHandle := SafeLoadLibrary(PChar(Spectrum3DDLL));
    Result := Spectrum3DDLLHandle <> 0;
    if Result then begin
        Spectrum3D_Create       := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_Create));
        Spectrum3D_Free         := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_Free));
        Spectrum3D_SetChannel   := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_SetChannel));
        Spectrum3D_GetChannel   := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_GetChannel));
        Spectrum3D_Render       := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_Render));
        Spectrum3D_ReAlign      := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_ReAlign));
        Spectrum3D_GetParams    := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_GetParams));
        Spectrum3D_SetParams    := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_SetParams));
        Spectrum3D_ReInitialize := GetProcAddress(Spectrum3DDLLHandle, PChar(NAME_Spectrum3D_ReInitialize));

        if (@Spectrum3D_Create = nil)
        OR (@Spectrum3D_Free = nil)
        OR (@Spectrum3D_SetChannel = nil)
        OR (@Spectrum3D_GetChannel = nil)
        OR (@Spectrum3D_Render = nil)
        OR (@Spectrum3D_ReAlign = nil)
        OR (@Spectrum3D_GetParams = nil)
        OR (@Spectrum3D_SetParams = nil)
        OR (@Spectrum3D_ReInitialize = nil)
            then Result := False;

        if Result then begin
            Spectrum3DDLLLoaded := True;
        end else begin
            FreeLibrary(Spectrum3DDLLHandle);
            Spectrum3DDLLHandle := 0;
            Spectrum3DDLLLoaded := False;
        end;
    end;
end;

function FreeSpectrum3DLibrary: Boolean;
begin
    Result := False;
    if Spectrum3DDLLHandle <> 0 then begin
        Result := FreeLibrary(Spectrum3DDLLHandle);
        if Result then begin
            Spectrum3DDLLHandle := 0;
            Spectrum3DDLLLoaded := False;
        end;
    end;
end;

Initialization

    InitSpectrum3DLibrary;

Finalization

    FreeSpectrum3DLibrary;

end.
