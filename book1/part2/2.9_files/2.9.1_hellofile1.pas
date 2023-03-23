program HelloFile; { 2.9.1_hellofile1.pas }

{ Constants }

const
	message = 'Hello, world!';
	filename = 'hello1.txt';

{ Main }

var
	f: text;
begin
	assign(f, filename);
	rewrite(f);
	writeln(f, message);
	close(f)
end.
