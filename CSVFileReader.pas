unit CSVFileReader;

interface

uses
  SysUtils, Classes;

type
  TCSVFileReader = class
  private
    FFileName: string;
    FData: TStringList;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function ReadRecord(const RecordIdentifier: string): TStringList;
    //function ReadFieldAtPosition(const RecordIdentifier: string; FieldPosition: Integer): string;
    function ReadFieldAtPosition(const RecordIdentifier: string; FieldPosition: Integer; RecordIdNumber: Integer = 1): string;
    function WriteFieldAtPosition(const RecordIdentifier: string; FieldPosition: Integer; const ThisValue: string): Integer;
    function CountRecordIdentifier(const RecordIdentifier: string): Integer;
  end;

implementation

{ TCSVFileReader }

constructor TCSVFileReader.Create(const FileName: string);
begin
  inherited Create;
  FFileName := FileName;
  FData := TStringList.Create;
  FData.LoadFromFile(FFileName);
end;

destructor TCSVFileReader.Destroy;
begin
  FData.Free;
  inherited;
end;

function TCSVFileReader.ReadRecord(const RecordIdentifier: string): TStringList;
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

{
function TCSVFileReader.ReadFieldAtPosition(const RecordIdentifier: string; FieldPosition: Integer): string;
var
  RecordFields: TStringList;
begin
  Result := '';
  RecordFields := ReadRecord(RecordIdentifier);
  if Assigned(RecordFields) then
  try
    if (FieldPosition >= 0) and (FieldPosition < RecordFields.Count) then
      Result := RecordFields[FieldPosition];
  finally
    RecordFields.Free;
  end;
end;
}

function TCSVFileReader.ReadFieldAtPosition(const RecordIdentifier: string; FieldPosition: Integer; RecordIdNumber: Integer = 1): string;
var
  i: Integer;
  RecordFields: TStringList;
  ocurrence: Integer;
begin
  Ocurrence := 0;
  for i := 0 to FData.Count - 1 do
  begin
    RecordFields := TStringList.Create;
    try
      RecordFields.CommaText := FData.Strings[i];
      if RecordFields.Count > 0 then
      begin
        if RecordFields[0] = RecordIdentifier then
        begin
          Inc(Ocurrence);
          if Ocurrence = RecordIdNumber then
          begin
            try
              if (FieldPosition >= 0) and (FieldPosition < RecordFields.Count) then
                Result := RecordFields[FieldPosition];
              finally
                RecordFields.Free;
            end;
            Break;
          end;
        end;
      end;
    finally
      if Result = '' then
        RecordFields.Free;
    end;
  end;
end;

function TCSVFileReader.WriteFieldAtPosition(const RecordIdentifier: string; FieldPosition: Integer; const ThisValue: string): Integer;
var
  i: Integer;
  RecordFields: TStringList;
begin
  Result := 1;  // Record not found
  for i := 0 to FData.Count - 1 do
  begin
    RecordFields := TStringList.Create;
    try
      RecordFields.CommaText := FData.Strings[i];
      if (RecordFields.Count > 0) and (RecordFields[0] = RecordIdentifier) then
      begin
        if (FieldPosition >= 0) and (FieldPosition < RecordFields.Count) then
        begin
          RecordFields[FieldPosition] := ThisValue;
          FData.Strings[i] := RecordFields.CommaText;  // Update the record in FData
          FData.SaveToFile(FFileName);  // Save changes to the CSV file
          Result := 0;  // Field updated successfully
          Exit;
        end
        else
        begin
          Result := 2;  // Field position not found
          Exit;
        end;
      end;
    finally
      RecordFields.Free;
    end;
  end;
end;

function TCSVFileReader.CountRecordIdentifier(const RecordIdentifier: string): Integer;
var
  i: Integer;
  Count: Integer;
begin
  Count := 0;
  for i := 0 to FData.Count - 1 do
  begin
    if Pos(RecordIdentifier, FData.Strings[i]) = 1 then
      Inc(Count);
  end;
  Result := Count;
end;

end.

