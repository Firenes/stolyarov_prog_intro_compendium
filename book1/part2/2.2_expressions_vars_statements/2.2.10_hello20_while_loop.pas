program hello20; { 2.2.10_hello20_while_loop.pas }

var
	i: integer;

begin
	i := 0;
	while i < 20 do
	begin
		writeln('Hello, World!');
		i := i + 1
	end
end.
