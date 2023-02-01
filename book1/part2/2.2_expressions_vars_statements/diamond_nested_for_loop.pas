program diamond_nested_for_loop;

var
	n, h, i, j: integer;

begin
	{ ask user to enter odd number }
	repeat
		writeln('Enter the diamond''s height (positive odd): ');
		readln(h);
		writeln('Enter an odd number');
	until (h > 0) and (h mod 2 <> 0);

	writeln('Your number is odd ', h);

	n := h div 2;

	{ Printing diamond's top part }
	for i := 1 to n + 1 do
	begin
		for j := 1 to n + 1 - i do
			write(' ');
		write('*');
		
		if i > 1 then
		begin
			for j := 1 to 2 * i - 3 do
				write(' ');
			write('*');
		end;
		writeln;
	end;

	{ Printing diamond's lower part }
	for i := n downto 1 do
	begin
		for j := 1 to n + 1 - i do
			write(' ');
		write('*');

		if i > 1 then
		begin
			for j := 1 to 2 * i - 3 do
				write(' ');
			write('*');
		end;
		writeln;
	end;
end.
