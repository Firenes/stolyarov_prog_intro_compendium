program z_multiple;

{ Constants }

const
	FigureSymbol = '*';
	BackgroundSymbol = ' ';
	Spacing = 1;


{ Procedures }

{ Arguments }

procedure InvalidArgumentsAssert;
begin
	writeln('Invalid arguments. Enter positive odd bigger than 4 and integer.');
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

	if (checkNum > 4) and (checkNum mod 2 <> 0) then
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

{ Print Z Line }

procedure PrintLine(lineNumber, size, halfSize: integer);
begin
	if (lineNumber mod halfSize = 0) then
		{ full line }
		PrintChars(FigureSymbol, size)
	else
	begin
		{ diagonal }
		PrintChars(BackgroundSymbol, size - lineNumber - 1);
		write(FigureSymbol);
		PrintChars(BackgroundSymbol, lineNumber)
	end;
end;

{ Print Zs diagonally }

procedure PrintZs(size, count: integer);
var
    lineNumber, halfSize, zPrinted, currentZ: integer;
begin
	halfSize := size div 2;
	zPrinted := 1;

    for lineNumber := 0 to (size + halfSize * (count - 1)) - 1 do
	begin		
		for currentZ := 0 to zPrinted - 1 do
		begin
			if (lineNumber + 1 >= (size + (currentZ * halfSize) + 1)) then
				{ Free space after Z printed }
				PrintChars(BackgroundSymbol, size)
			else
				{ Print Z lines }
				PrintLine((lineNumber + (currentZ * (halfSize + 1))) mod size, size, halfSize);

			{ Spacing between Zs }
			PrintChars(BackgroundSymbol, Spacing)
		end;

		{ New line when ended to print Zs before new started }
		writeln;

		{ Indicates when new Z will start }
		if ((lineNumber + 1) mod halfSize = 0) then
		begin
			if zPrinted <> count then
				zPrinted := zPrinted + 1;
		end;
	end
end;


{ Main }

var
	height, count: integer;
begin
	CheckArguments;

	{ convert first argument to odd number }
	ConvertArgToHeight(ParamStr(1), height);

	{ convert second argument to integer }
	ConvertArgToCount(ParamStr(2), count);

	PrintZs(height, count);
end.
