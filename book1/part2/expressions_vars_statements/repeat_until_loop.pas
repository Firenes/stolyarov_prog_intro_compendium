program repeat_until_loop;

//var
//	year: integer;
//
//begin
//	repeat
//		readln(year);
//	until (year >= 1900) and (year < 2022);
//
//	writeln('Your year is correct ', year);
//end.

var
	x: integer;
	sum: integer;

begin
	sum := 0;
	
	repeat
		readln(x);
		sum := sum + x;
		writeln('sum = ', sum)
	until sum > 1000
end.
