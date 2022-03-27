program abs_num_conditional;

var
	x: integer;
begin
	read(x);

	//if x > 0 then
	//	writeln(x)
	//else
	//	writeln(-x)
	
	if x < 0 then
		x := -x;
	writeln(x)
end.
