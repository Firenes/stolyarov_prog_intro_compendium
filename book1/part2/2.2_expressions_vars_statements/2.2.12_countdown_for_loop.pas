program countdown; { 2.2.12_countodown_for_loop.pas }

var
	i: integer;

begin
	for i := 10 downto 1 do
		write(i, '... ');
	writeln('start!')
end.
