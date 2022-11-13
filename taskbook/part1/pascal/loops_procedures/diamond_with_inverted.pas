program diamonds_with_inverted;

{ Procedures }

{ Common }

procedure PrintChars(ch: char; count: longint);
var
	i: integer;
begin
	for i := 1 to count do
		write(ch)
end;


procedure InvertCharactersIfNeeded(var figure, background: char;
								   isInverted: boolean);
var
	temp: char;
begin
	if isInverted then
	begin
		temp := figure;
		figure := background;
		background := temp
	end
end;


procedure PrintLine(lineNumber, halfSize: integer;
					isInverted: boolean);
var
	figure, background: char;

begin
	{ chars }
	figure := '*';
	background := ' ';
	InvertCharactersIfNeeded(figure, background, isInverted);

	{ left part }
	PrintChars(background, halfSize + 1 - lineNumber);
	write(figure);

	{ diamond }
	if lineNumber > 1 then
	begin
		PrintChars(figure, 2 * lineNumber - 3);
		write(figure)
	end;

	{ right side for inverted state }
	if isInverted then	
		PrintChars('*', halfSize + 1 - lineNumber);

	writeln
end;

{ Diamonds }

procedure PrintDiamond(h: integer);
var
	halfSize, lineNumber: integer;
begin
	halfSize := h div 2;

	for lineNumber := 1 to halfSize + 1 do
		PrintLine(lineNumber, halfSize, false);
	for lineNumber := halfSize downto 1 do
		PrintLine(lineNumber, halfSize, false)
end;


procedure PrintInvertedDiamond(h: integer);
var
	halfSize, lineNumber: integer;
begin
	halfSize := h div 2;

	PrintChars('*', h + 2);
	writeln;
	for lineNumber := 1 to halfSize + 1 do
		PrintLine(lineNumber, halfSize + 1, true);
	for lineNumber := halfSize downto 1 do
		PrintLine(lineNumber, halfSize + 1, true);
	PrintChars('*', h + 2);
	writeln;
end;

{ Main }

var
	height: integer;
begin
	{ ask user to enter odd number }
	repeat
		write('Enter the diamond''s height (positive odd): ');
		readln(height);
	until (height > 0) and (height mod 2 <> 0);
	
	PrintDiamond(height);
	writeln;
	PrintInvertedDiamond(height)
end.
