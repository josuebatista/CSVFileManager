program CSVFileManager;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, CSVFileReader in 'CSVFileReader.pas';

var
  Reader: TCSVFileReader;
  RecordIdentifier: string;
  RecordFieldsList: TList;
  RecordFields: TStringList;
  i, j: Integer;
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
      RecordFieldsList := Reader.FindRecords(RecordIdentifier);
      if Assigned(RecordFieldsList) then
      begin
        try
          if RecordFieldsList.Count > 0 then
          begin
            for i := 0 to RecordFieldsList.Count - 1 do
            begin
              RecordFields := TStringList(RecordFieldsList.Items[i]);
              for j := 0 to RecordFields.Count - 1 do
                WriteLn(RecordFields[j]);
              WriteLn('---');
            end;
          end
          else
            WriteLn('Record not found');
        finally
          for i := 0 to RecordFieldsList.Count - 1 do
            TStringList(RecordFieldsList.Items[i]).Free;
          RecordFieldsList.Free;
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

