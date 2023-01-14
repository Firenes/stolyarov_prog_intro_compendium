program FilterOk; { filter_ok.pas }

var
	c: char;

begin
	while not eof do
	begin
		read(c);
		if c = #10 then
			writeln('Ok');
	end;
	writeln('Good Bye!')
end.
