program diamond_procedure.pas;

procedure PrintChars(ch: char; count: integer);
var
	i: integer;
begin
	for i:= 1 to count do
		write(ch)
end;

procedure PrintLineOfDiamond(i, n: integer);
begin
	PrintChars(' ', n + 1 - i);
	write('*');

	if i > 1 then
	begin
		PrintChars(' ', 2 * i - 3);
		write('*');
	end;
	writeln;
end;

{ Main part of program }
var
	n, h, i: integer;

begin
	{ ask user to enter odd number }
	repeat
		writeln('Enter the diamond''s height (positive odd): ');
		readln(h);
		writeln('Enter an odd number');
	until (h > 0) and (h mod 2 <> 0);

	writeln('Your number is odd ', h);

	n := h div 2;

	for i := 1 to n + 1 do
		PrintLineOfDiamond(i, n);
	for i := n downto 1 do
		PrintLineOfDiamond(i, n)
end.
