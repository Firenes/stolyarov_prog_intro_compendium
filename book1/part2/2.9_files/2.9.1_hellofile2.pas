program HelloFile2; { 2.9.1_hellofile2.pas }

{ Constants }

const
	message = 'Hello, world!';
	filename = 'hello2.txt';

{ Main }

var
	f: text;
begin
	{$I-}
	assign(f, filename);
	rewrite(f);
	if IOResult <> 0 then
	begin
		writeln('Couldn''t open file ', filename);
		halt(1)
	end;

	writeln(f, message);

	if IOResult <> 0 then
	begin
		writeln('Couldn''t write to file ', filename);
		halt(1)
	end;
	close(f)	
end.
