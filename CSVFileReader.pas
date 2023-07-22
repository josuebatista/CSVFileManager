unit CSVFileReader;

interface

uses
  SysUtils, Classes;

type
  TCSVFileReader = class
  private
    FData: TStringList;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function FindRecord(const RecordIdentifier: string): TStringList;
  end;

implementation

{ TCSVFileReader }

constructor TCSVFileReader.Create(const FileName: string);
begin
  inherited Create;
  FData := TStringList.Create;
  FData.LoadFromFile(FileName);
end;

destructor TCSVFileReader.Destroy;
begin
  FData.Free;
  inherited;
end;

function TCSVFileReader.FindRecord(const RecordIdentifier: string): TStringList;
var
  i: Integer;
  RecordFields: TStringList;
begin
  Result := nil;
  for i := 0 to FData.Count - 1 do
  begin
    RecordFields := TStringList.Create;
    try
      RecordFields.CommaText := FData.Strings[i];
      if RecordFields.Count > 0 then
      begin
        if RecordFields[0] = RecordIdentifier then
        begin
          Result := RecordFields;
          Exit;
        end;
      end;
    finally
      if Result = nil then
        RecordFields.Free;
    end;
  end;
end;

end.

