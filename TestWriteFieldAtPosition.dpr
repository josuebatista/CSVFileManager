program TestWriteFieldAtPosition;

{$APPTYPE CONSOLE}


uses
  SysUtils, CSVFileReader;

var
  CSVReader: TCSVFileReader;
  RecordIdentifier, ThisValue, FilePath: string;
  FieldPosition, RecordIdNumber, ResultCode: Integer;
begin
  // Check if enough command-line arguments are provided
  if ParamCount < 5 then
  begin
    WriteLn('Usage: TestCSVFileReader <FilePath> <RecordIdentifier> <FieldPosition> <ThisValue> <RecordIdNumber>');
    Halt(1);
  end;

  // Initialize variables from command-line arguments
  FilePath := ParamStr(1);
  RecordIdentifier := ParamStr(2);
  FieldPosition := StrToInt(ParamStr(3));
  ThisValue := ParamStr(4);
  RecordIdNumber := StrToInt(ParamStr(5));

  // Create an instance of TCSVFileReader
  CSVReader := TCSVFileReader.Create(FilePath);
  try
    // Call WriteFieldAtPosition
    ResultCode := CSVReader.WriteFieldAtPosition(RecordIdentifier, FieldPosition, ThisValue, RecordIdNumber);

    // Output the result
    WriteLn('Result code: ', ResultCode);
  finally
    CSVReader.Free;
  end;
end.
