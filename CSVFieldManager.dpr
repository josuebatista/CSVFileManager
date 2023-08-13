program CSVFieldManager;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, CSVFileReader in 'CSVFileReader.pas';

var
  Reader: TCSVFileReader;
  RecordIdentifier: string;
  FieldValue: string;
  WriteValue: string;
  FieldPosition: Integer;
  FileName: string;
  WriteResult: Integer;
begin
  if ParamCount < 5 then
  begin
    WriteLn('Usage: CSVFieldManager --record-id <RecordIdentifier> --field-position <Position> [--write-value <Value>] <FilePath>');
    Exit;
  end;

  // Parsing command-line arguments
  RecordIdentifier := ParamStr(2);
  FieldPosition := StrToIntDef(ParamStr(4), -1);  // Convert field position to integer or default to -1 if invalid

  // Checking if --write-value argument is provided
  if (ParamStr(5) = '--write-value') and (ParamCount >= 7) then
  begin
    WriteValue := ParamStr(6);
    FileName := ParamStr(7);
  end
  else
  begin
    WriteValue := '';
    FileName := ParamStr(5);
  end;

  try
    Reader := TCSVFileReader.Create(FileName);
    try
      if WriteValue <> '' then
      begin
        WriteResult := Reader.WriteFieldAtPosition(RecordIdentifier, FieldPosition, WriteValue);
        WriteLn(WriteResult);
      end
      else
      begin
        FieldValue := Reader.ReadFieldAtPosition(RecordIdentifier, FieldPosition);
        if FieldValue <> '' then
          WriteLn(FieldValue)
        else
          WriteLn('Record or field not found');
      end;
    finally
      Reader.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

