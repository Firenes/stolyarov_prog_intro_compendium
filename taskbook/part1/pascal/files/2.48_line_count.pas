program LineCount; { 2.48_line_count.pas }

{ Main }

var
	f: text;
	count: longint;
begin
	{$I-}
	if ParamCount <> 1 then
	begin
		writeln(ErrOutput, 'Need enter file name');
		halt(1)
	end;

	assign(f, ParamStr(1));
	reset(f);
	
	if IOResult <> 0 then
	begin
		writeln(ErrOutput, 'Couldn''t open a file');
		halt(1)
	end;

	count := 0;
	while not eof(f) do 
	begin
//		while not SeekEoln(f) do
			count := count + 1;
		readln(f)
	end;

	close(f);
	writeln(count)
end.
