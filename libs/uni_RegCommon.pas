unit uni_RegCommon;

interface

uses
  OnGuard, OgUtil, Classes;

var
  MachineModifier : longint;
  MachineKey : TKey;
  Expires : TDateTime;
  RegistrationInfo : TStringList;

function IsReleaseCodeValid (ReleaseCodeString: string; const SerialNumber : longint) : boolean;
procedure SaveRegistrationInformation (const ReleaseCodeString: string; const SerialNumber : longint);
procedure GetRegistrationInformation (var ReleaseCodeString: string; var SerialNumber : longint);

implementation

uses
  SysUtils;

const
  RegistrationFile = 'REGISTRATION.DAT';

function IsReleaseCodeValid (ReleaseCodeString: string; const SerialNumber : longint) : boolean;
var
  CalculatedReleaseCode : TCode;
begin
  // Remove spaces from the Release code
  while pos(' ', ReleaseCodeString) > 0 do
    System.Delete(ReleaseCodeString, pos(' ', ReleaseCodeString), 1);

  // Calculate the release code based on the serial number and the calculated machine modifier
  InitSerialNumberCode(MachineKey, SerialNumber, Expires, CalculatedReleaseCode);

  // Compare the two release codes
  result := AnsiUpperCase(ReleaseCodeString) = AnsiUpperCase(BufferToHex(CalculatedReleaseCode, sizeof(CalculatedReleaseCode)));
end;

procedure SaveRegistrationInformation (const ReleaseCodeString: string; const SerialNumber : longint);
begin
  // Save the information for the application
  RegistrationInfo := TStringList.Create;
  RegistrationInfo.Add(format('%d',[SerialNumber]));
  RegistrationInfo.Add(ANSIUpperCase(ReleaseCodeString));
  RegistrationInfo.SaveToFile(RegistrationFile);
  RegistrationInfo.Free;
end;

procedure GetRegistrationInformation (var ReleaseCodeString: string; var SerialNumber : longint);
begin
  // Read the information for the application
  if FileExists(RegistrationFile) then begin
    RegistrationInfo := TStringList.Create;
    RegistrationInfo.LoadFromFile(RegistrationFile);
    SerialNumber := StrToInt(RegistrationInfo[0]);
    ReleaseCodeString := RegistrationInfo[1];
    RegistrationInfo.Free;
  end else begin
    SerialNumber := 0;
    ReleaseCodeString := '';
  end;
end;

const
  Key : TKey = ($9B,$15,$01,$EA,$70,$43,$DD,$47,$3F,$93,$22,$1B,$4E,$35,$A1,$87);
initialization
  Expires := 0;
  MachineKey := Key;
  MachineModifier := ABS(CreateMachineID([midUser, midSystem, {midNetwork,} midDrives]));
  ApplyModifierToKeyPrim(MachineModifier,MachineKey,sizeof(MachineKey));
end.

