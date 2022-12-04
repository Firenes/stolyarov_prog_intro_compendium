program z_multiple;

{ Constants }

const
	FigureSymbol = '*';
	BackgroundSymbol = ' ';
	Spacing = 1;

{ Procedures }

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
	{ ask user to enter odd number }
	repeat
		write('Enter the Z''s height (positive odd and more than 5): ');
		readln(height);
		write('Enter count of Z: ');
		readln(count)
	until (height > 4) and (height mod 2 <> 0) and (count > 0);

	PrintZs(height, count);
end.
