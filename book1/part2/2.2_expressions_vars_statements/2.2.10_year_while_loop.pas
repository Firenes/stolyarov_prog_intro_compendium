program year_while_loop; { 2.2.10_year_while_loop.pas }

var
	year: integer;

begin
	write('Please enter your year birthday: ');
	readln(year);
	
	while (year < 1900) or (year > 2022) do
	begin
		writeln(year, ' is not a valid year!');
		write('Please try again: ');
		readln(year);
	end;
	writeln('The year ', year, ' is accepted. Thank you!')
end.
