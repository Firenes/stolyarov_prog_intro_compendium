program GenerateNumBin; { 2.9.3_gennumbin.pas }

{ Constants }

const
	name = '2.9.3_numbers.bin';
	start = 1000;
	step = 1001;
	count = 100;


{ Main }

var
	f: file of longint;
	i: integer;
	n: longint;
begin
	assign(f, name);
	rewrite(f);
	n := start;
	for i := 1 to count do
	begin
		write(f, n);
		n := n + step
	end;
	close(f);
end.
