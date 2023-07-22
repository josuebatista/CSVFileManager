program CSVFileManager;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, CSVFileReader in 'CSVFileReader.pas';

var
  Reader: TCSVFileReader;
  RecordIdentifier: string;
  RecordFields: TStringList;
  i: Integer;
begin
  if ParamCount < 2 then
  begin
    WriteLn('Usage: CSVFileManager <RecordIdentifier> <FilePath>');
    Exit;
  end;

  try
    RecordIdentifier := ParamStr(1);
    Reader := TCSVFileReader.Create(ParamStr(2));
    try
      RecordFields := Reader.FindRecord(RecordIdentifier);
      if Assigned(RecordFields) then
      begin
        try
          for i := 0 to RecordFields.Count - 1 do
            WriteLn(RecordFields[i]);
        finally
          RecordFields.Free;
        end;
      end
      else
        WriteLn('Record not found');
    finally
      Reader.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

