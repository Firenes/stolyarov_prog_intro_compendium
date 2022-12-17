program vertical_ascii;

function MakeColumnHexDescription(number: integer): string;
begin
	if (number = 0) then
		MakeColumnHexDescription := '0/8'
	else if (number = 1) then
		MakeColumnHexDescription := '1/9'
	else if (number = 2) then
		MakeColumnHexDescription := '2/A'
	else if (number = 3) then
		MakeColumnHexDescription := '3/B'
	else if (number = 4) then
		MakeColumnHexDescription := '4/C'
	else if (number = 5) then
		MakeColumnHexDescription := '5/D'
	else if (number = 6) then
		MakeColumnHexDescription := '6/E'
	else if (number = 7) then
		MakeColumnHexDescription := '7/F'
end;

var
	i, j: integer;
	c: char;

begin
	write('    |');
	for c := '2' to '7' do
	begin
		write(' ', c, '.');
		write(' ', c, '.');
	end;
	writeln;

	write('    |');
	for i := 1 to 12 do
		write('---');
	writeln;

	for i := 0 to 7 do
	begin
		write('.', MakeColumnHexDescription(i), '|');
		for j := 4 to 15 do
			write('  ', char(j * 8 + i));
		writeln;
	end;	
end.
