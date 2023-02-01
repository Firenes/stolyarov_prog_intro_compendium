program SimpleSum; { 2.5.4_simple_sum.pas }

var
	sum, count, n: longint;

begin
	sum := 0;
	count := 0;
//	while not eof do { неправильно }
	while not SeekEof do { правильно }
	begin
		read(n);
		sum := sum + n;
		count := count + 1;
	end;
	writeln(count, ' ', sum)
end.
