program LongestStringFiles; { 2.52_longest_string_files.pas }

{ Types }

type
	FileInfo = record
		maxline: longint;
		maxlength: longint;
	end;
	FileInfoArray = array of FileInfo;


{ Functions }

function IsEndOfLine(ch: char): boolean;
begin
    IsEndOfLine := (ch = #10) or (ch = #13);
end;


function GetFileWithLongestLine(var fiArray: FileInfoArray): longint;
var
	i: integer;
	suitableFile, longestLine: longint;
begin
	suitableFile := 1;
	longestLine := fiArray[1].maxLength;

	for i := 1 to length(fiArray) do
	begin
		if fiArray[i].maxLength > longestLine then
			suitableFile := i
	end;
	GetFileWithLongestLine := suitableFile
end;


{ Procedures }

procedure Count(ch: char; var charCount, fileLineCount: longint);
begin
    if not IsEndOfLine(ch) then
        charCount := charCount + 1
	else
		fileLineCount := fileLineCount + 1
end;


procedure ClearCountingCharsInLine(ch: char; var charCount: longint);
begin
    if IsEndOfLine(ch) then
        charCount := 0
end;


procedure CountLongestFileString(ch: char; currStringCount, fileLineCount: longint;
								 var maxStringCount, maxfileLine: longint);
begin
	if IsEndOfLine(ch) and (currStringCount > maxStringCount) then
	begin
		maxStringCount := currStringCount;
		maxFileLine := fileLineCount
	end
end;


{ Main }

var
	ch: char;
	i: integer;
	f: text;
	fInfo: FileInfo;
	fiArray: FileInfoArray;
	fileLineCount, maxFileLine, maxLineCount, currLineCount: longint;
	fileWithLongestLine: longint;
begin
	{$I-}
	if ParamCount < 1 then
	begin
		writeln('Need one or more files');
		halt(1)
	end;

	SetLength(fiArray, ParamCount);
	for i := 1 to ParamCount do
	begin
		fInfo.maxLine := 0;
		fInfo.maxLength := 0;
		fiArray[i] := fInfo;
	end;

	maxFileLine := 0;
	fileLineCount := 0;
	maxLineCount := 0;
	currLineCount := 0;

	for i := 1 to length(fiArray) do
	begin
		assign(f, ParamStr(i));
		reset(f);
		
		if IOResult <> 0 then
		begin
			writeln(ErrOutput, 'Couldn''t open file: ', ParamStr(i));
			halt(1);
		end;

		while not eof(f) do
		begin
			read(f, ch);
			Count(ch, currLineCount, fileLineCount);
			
			CountLongestFileString(ch, currLineCount, fileLineCount,
								    maxLineCount, maxFileLine);

			ClearCountingCharsInLine(ch, currLineCount);
		end;
		fiArray[i].maxLine := maxFileLine;
		fiArray[i].maxLength := maxLineCount;

		maxLineCount := 0;
		maxFileLine := 0;
		fileLineCount := 0;

		close(f)
	end;
	
	fileWithLongestLine := GetFileWithLongestLine(fiArray);

	for i := 1 to length(fiArray) do
	begin
		assign(f, ParamStr(i));
		reset(f);

		if IOResult <> 0 then
		begin
			writeln(ErrOutput, 'Couldn''t open file: ', ParamStr(i));
			halt(1);
		end;

		if fileWithLongestLine = i then
			write('*');		

		write(ParamStr(i), ':');

		fileLineCount := 1;

		while not eof(f) do
		begin
			read(f, ch); 

			if fileLineCount = fiArray[i].maxLine then
				write(ch); 

    		if IsEndOfLine(ch) then
				fileLineCount := fileLineCount + 1;
		end;

		close(f)
	end
end.
