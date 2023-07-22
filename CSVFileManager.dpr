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
  FileName: string;
  SearchType: string;
begin
  if ParamCount < 3 then
  begin
    WriteLn('Usage: CSVFileManager --record-id <RecordIdentifier> --search-type <Type: first | all> <FilePath>');
    WriteLn('       CSVFileManager --help');
    Exit;
  end;

  if ParamStr(1) = '--help' then
  begin
    WriteLn('Options:');
    WriteLn('  --record-id    searches for a record that starts with the given record identifier');
    WriteLn('  --search-type  specifies the type of search. "first" for finding the first matching record, "all" for finding all matching records');
    Exit;
  end;

  RecordIdentifier := ParamStr(2);
  SearchType := ParamStr(4);
  FileName := ParamStr(5);

  try
    Reader := TCSVFileReader.Create(FileName);
    try
      if SearchType = 'first' then
      begin
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
      end
      else if SearchType = 'all' then
      begin
        RecordFieldsList := Reader.FindMultiRecords(RecordIdentifier);
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
      end
      else
        WriteLn('Invalid search type. Use "first" or "all".');
    finally
      Reader.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

