program HelloString; { 2.6.9_hello_string.pas }

var
	hello: array [1..30] of char;
	i: integer;

begin
	hello := 'Hello, world!';
	for i := 1 to 30 do
	begin
		if hello[i] = #0 then
			break;
		write(hello[i])
	end;
	writeln
end.
