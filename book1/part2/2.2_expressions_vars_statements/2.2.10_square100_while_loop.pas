program square100_while_loop; { 2.2.10_square100_while_loop.pas }

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
