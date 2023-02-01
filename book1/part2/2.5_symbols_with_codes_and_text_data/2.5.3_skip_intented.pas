program SkipIntended; { 2.5.3_skip_indented.pas }

var
	c: char;
	know, print: boolean;

begin
	know := false;
	print := false;

	while not eof do
	begin
		read(c);

		if c = #10 then
		begin
			if know and print then
				writeln;
			{ начинается следующая строка }
			know := false
		end
		else
		begin
			if not know then
			begin
				print := (c <> ' ') and (c <> #9);
				know := true
			end;	
		
			{ know = true всегда }	
			if print then
				write(c)
		end
	end
end.
