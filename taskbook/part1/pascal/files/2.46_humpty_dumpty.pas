program PutHumptyDumpty; { 2.46_humpty_dumpty.pas }

{ Constants }

const
	humptyDumpty = 'Humpty Dumpty sat on a wall,'#10'Humpty Dumpty had a great fall.'#10'All the king''s horses,'#10'And all the king''s men,'#10'Couldn''t put Humpty together again.';


{ Main }

var
	f: text;
begin
	{$I-}
	if ParamCount < 1 then
	begin
		writeln(ErrOutput, 'Please enter file for saving text');
		halt(1)
	end;

	assign(f, ParamStr(1));
	rewrite(f);

	if IOResult <> 0 then
	begin
		writeln(ErrOutput, 'Couldn''t open a file: ', ParamStr(1));
		halt(1)
	end;

	writeln(f, humptyDumpty);
	
	if IOResult <> 0 then
	begin
		writeln(ErrOutput, 'Couldn''t write to a file: ', ParamStr(1));
		halt(1)
	end;
	close(f);
end.
