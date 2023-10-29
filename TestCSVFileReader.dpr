program TestCSVFileReader;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, CSVFileReader in 'CSVFileReader.pas';


var
  Reader: TCSVFileReader;
  Count: Integer;
  UPC: String;

begin
  try
      // Create an instance of TCSVFileReader and load the test CSV file
      //Reader := TCSVFileReader.Create('C:\Workarea\CSVFileManager\TestCSVFile.csv');
      Reader := TCSVFileReader.Create('C:\True Commerce\Transaction Manager\Shipping_Import\sotpi_6867625026_20230720.203424.756.csv');
      try
        // Count the number of 'ITM' records and display the result
        Count := Reader.CountRecordIdentifier('ITM');
        //WriteLn('Test');
        WriteLn('Number of ITM records: ', IntToStr(Count));
        UPC := Reader.ReadFieldAtPosition('HDR',5);
        WriteLn('UPC value: ', UPC);
      finally
        Reader.Free;
      end;
  except
    on E: Exception do
      WriteLn('An error occurred: ', E.Message);
  end;
end.
