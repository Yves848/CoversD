unit Control1;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls;

type
  tMultiGauge = class(TControl)
  private
    { Déclarations privées }
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
  published
    { Déclarations publiées }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [tMultiGauge]);
end;

end.
