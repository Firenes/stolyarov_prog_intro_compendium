program CatFile; { 2.47_cat_file.pas }

{ Main }

var
	f: text;
	content: string;
begin
	{$I-}
	if ParamCount <> 1 then
	begin
		writeln(ErrOutput, 'Need file name');
		halt(1)
	end;

	assign(f, ParamStr(1));
	reset(f);

	if IOResult <> 0 then
	begin
		writeln(ErrOutput, 'Couldn''t open a file', ParamStr(1));
		halt(1)
	end;

	while not eof(f) do
	begin
		readln(f, content);
		writeln(content);
	end;

	close(f)
end.
