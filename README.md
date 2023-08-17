# CSV File Manager

A Borland Delphi 7 utility designed for efficient management and manipulation of CSV files using the command line.

## Features

- **CSV File Reading**: Enables reading specific records or fields from a CSV file.
- **CSV File Writing**: Modify specific fields within records in a CSV file.
- **Command Line Interface**: Provides intuitive command-line options for easy interaction.

## Setup and Usage

1. **Setup**:
   - Clone the repository.
   - Open the project in Borland Delphi 7.
   - Compile and build the application.

2. **Usage**:
   - Run the generated `.exe` files (`CSVFileManager.exe` and `CSVFieldManager.exe`) from the command line with the appropriate parameters.

## Command-Line Options

### For `CSVFileManager.exe`

```
Usage: CSVFileManager.exe --record-id <RecordIdentifier> --search-type <Type: first | all> <FilePath>
```
- `--record-id`: Specifies the record identifier to search for.
- `--search-type`: Specifies the type of search ("first" for finding the first matching record or "all" for finding all matching records).

### For `CSVFieldManager.exe`

```
Usage: CSVFieldManager.exe --record-id <RecordIdentifier> --field-position <Position> [--write-value <Value>] <FilePath>
```

- `--record-id`: Specifies the record identifier to search for.
- `--field-position`: Specifies the position of the field within the record.
- `--write-value`: (Optional) Value to write to the field at the specified position.

## Contributing

Contributions are welcome! If you have suggestions, bug reports, or enhancements to propose, please:

1. Fork the repository.
2. Create a new branch for your changes.
3. Submit a pull request.

## License

This project is licensed under the MIT License. Refer to `LICENSE` file for more details.
