program bigger_swap; { 2.2.8 bigger_swap.pas }

var
	a: integer;
	b: integer;
	t: integer;

begin
	read(a);
	read(b);

	if a > b then
	begin
		t := a;
		a := b;
		b := t
	end;

	writeln(a);
	writeln(b);
end.
