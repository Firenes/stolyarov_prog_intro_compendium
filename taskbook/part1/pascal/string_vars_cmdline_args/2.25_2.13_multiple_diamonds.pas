program multiple_diamonds;

{ Procedures }

{ Arguments }

procedure InvalidArgumentsAssert;
begin
    writeln('Invalid arguments. Enter positive odd and integer.');
    halt(1)
end;

procedure CheckArguments;
begin
    if (ParamCount < 2) or (ParamCount > 2) then
        InvalidArgumentsAssert;
end;

procedure ConvertArgToNum(arg: string; var number: integer);
var
    err: word;
	checkNum: integer;
begin
    val(arg, checkNum, err);

    if err <> 0 then
        InvalidArgumentsAssert;	

	number := checkNum
end;

procedure ConvertArgToHeight(arg: string; var height: integer);
var
    checkNum: integer;
begin
	ConvertArgToNum(arg, checkNum);

    if (checkNum > 0) and (checkNum mod 2 <> 0) then
        height := checkNum
    else
        InvalidArgumentsAssert
end;

procedure ConvertArgToCount(arg: string; var count: integer);
var
    checkNum: integer;
begin
	ConvertArgToNum(arg, checkNum);
    if checkNum > 0 then
        count := checkNum
    else
        InvalidArgumentsAssert
end;


{ Common }

procedure PrintChars(ch: char; count: longint);
var
	i: integer;
begin
	for i := 1 to count do
		write(ch)
end;


procedure PrintLine(lineNumber, halfSize: integer);
begin
	{ left part }
	PrintChars(' ', halfSize + 1 - lineNumber);
	write('*');

	{ diamond }
	if lineNumber > 1 then
	begin
		PrintChars(' ', 2 * lineNumber - 3);
		write('*')
	end;

	{ right part }
	PrintChars(' ', halfSize + 1 - lineNumber);

	{ space between diamonds }
	write(' ')
end;

{ Diamonds }

procedure PrintDiamond(h, count: integer);
var
	halfSize, lineNumber, diamondsCount: integer;
begin
	halfSize := h div 2;

	for lineNumber := 1 to halfSize + 1 do
	begin
		for diamondsCount := 1 to count do
			PrintLine(lineNumber, halfSize);
		writeln
	end;

	for lineNumber := halfSize downto 1 do
	begin
		for diamondsCount := 1 to count do
			PrintLine(lineNumber, halfSize);
		writeln
	end
end;

{ Main }

var
	height, count: integer;
begin
	{ ask user to enter odd number }
	ConvertArgToHeight(ParamStr(1), height);

	{ ask user to enter diamonds's count }
	ConvertArgToCount(ParamStr(2), count);

	PrintDiamond(height, count);
end.
