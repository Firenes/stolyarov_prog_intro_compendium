program z;

const
	FigureSymbol = '*';
	BackgroundSymbol = ' ';

{ Procedures }

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
	{ ask user to enter odd number }
	repeat
		write('Enter the Z''s height (positive odd and more than 5): ');
		readln(height);
	until (height > 4) and (height mod 2 <> 0);
	
	PrintZ(height);
end.
