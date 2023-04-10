program WriteToEof; { 2.49_write_to_eof }

{ Main }

var
	c: char;
	f: text;
begin
	{$I-}

	if ParamCount <> 1 then
	begin
		writeln(ErrOutput, 'Needs file name');
		halt(1)
	end;

	assign(f, ParamStr(1));
	rewrite(f);

	if IOResult <> 0 then
	begin
		writeln(ErrOutput, 'Couldn''t open a file: ', ParamStr(1));
		halt(1)
	end;

	while not eof do
	begin
		read(c);
		write(f, c)
	end;

	close(f);
end.
