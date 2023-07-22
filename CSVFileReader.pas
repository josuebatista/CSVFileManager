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
    function FindRecords(const RecordIdentifier: string): TList;
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

function TCSVFileReader.FindRecords(const RecordIdentifier: string): TList;
var
  i: Integer;
  RecordFields: TStringList;
begin
  Result := TList.Create;
  for i := 0 to FData.Count - 1 do
  begin
    RecordFields := TStringList.Create;
    try
      RecordFields.CommaText := FData.Strings[i];
      if RecordFields.Count > 0 then
      begin
        if RecordFields[0] = RecordIdentifier then
          Result.Add(RecordFields)
        else
          RecordFields.Free;
      end
      else
        RecordFields.Free;
    except
      RecordFields.Free;
      raise;
    end;
  end;
end;

end.

