unit Control1;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls;

type
  tMultiGauge = class(TControl)
  private
    { D�clarations priv�es }
  protected
    { D�clarations prot�g�es }
  public
    { D�clarations publiques }
  published
    { D�clarations publi�es }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [tMultiGauge]);
end;

end.
