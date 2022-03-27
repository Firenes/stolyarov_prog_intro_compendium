program swquare100_while_loop;

var
	i: integer;

begin
	i := 1;

	while i <= 100 do
	begin
		//writeln(i * i);
		write(i * i, ' ');
		i := i + 1
	end
end.
