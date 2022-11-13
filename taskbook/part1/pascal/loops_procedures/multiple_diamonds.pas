program multiple_diamonds;

{ Procedures }

{ Common }

procedure PrintChars(ch: char; count: longint);
var
	i: integer;
begin
	for i := 1 to count do
		write(ch)
end;


procedure PrintLine(lineNumber, halfSize: integer);
var
	figure, background: char;

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
	repeat
		write('Enter the diamond''s height (positive odd): ');
		readln(height);
	until (height > 0) and (height mod 2 <> 0);
	
	{ ask user to enter diamonds's count }
	write('Enter diamond''s count: ');
	readln(count);

	PrintDiamond(height, count);
end.
