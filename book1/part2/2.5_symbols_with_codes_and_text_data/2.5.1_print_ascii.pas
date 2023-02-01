program PrintAscii;	{ 2.5.1_print_ascii.pas }

var
	i, j: integer;
	c: char;

begin
	{ first line of header }
	write('  |');
	for c := '0' to '9' do
		write(' .', c);
	for c := 'A' to 'F' do
		write(' .', c);
	writeln;

	{ second line of header }
	write('  |');
	for i := 1 to 16 do
		write('---');
	writeln;

	{ table }
	for i := 2 to 7 do
	begin
		write(i , '.|');
		{ print line of table }
		for j := 0 to 15 do
			write('  ', char(i * 16 + j));
		writeln
	end
end.
