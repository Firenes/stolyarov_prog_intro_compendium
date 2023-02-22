program z;

const
	FigureSymbol = '*';
	BackgroundSymbol = ' ';

{ Procedures }

{ Arguments }

procedure InvalidArgumentsAssert;
begin
	writeln('Invalid arguments. Enter positive odd bigger than 4');
	halt(1)
end;

procedure CheckArguments;
begin
	if (ParamCount < 1) or (ParamCount > 1) then
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

	if (checkNum > 4) and (checkNum mod 2 <> 0) then
		number := checkNum
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


procedure PrintLine(lineNumber, size: integer);
var
	halfSize: integer;

begin
	{ initialize vars }
	halfSize := size div 2;

	if (lineNumber mod halfSize = 0) then
		{ full line }
		PrintChars(FigureSymbol, size)
	else
	begin
		{ diagonal }
		PrintChars(BackgroundSymbol, size - lineNumber - 1);
		write(FigureSymbol)
	end;

	writeln
end;

{ Z letter with middle cross }

procedure PrintZ(size: integer);
var
	lineNumber: integer;
begin
	for lineNumber := 0 to size - 1 do
		PrintLine(lineNumber, size)
end;


{ Main }

var
	height: integer;
begin
	CheckArguments;

	{ converting first argument odd number }
	ConvertArgToNum(ParamStr(1), height);
	
	PrintZ(height);
end.
