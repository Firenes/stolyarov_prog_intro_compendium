program goto_tests;

{ Procedures }

procedure Counting(count, stop: longint);
label
	AllDone;

var
	i: longint;

begin
	for i := 0 to count do
	begin
		if i = stop then
			goto AllDone;

		writeln('Counting:', i)
	end;

	AllDone:
		writeln('goto called');
		exit
end;


procedure Counting2(count, stop: longint);
label
	AllDone;

var
	i: longint;

begin
	{ Make endless cycle }
	AllDone:
		writeln('goto called');

	for i := 0 to count do
	begin
		if i = stop then
			goto AllDone;

		writeln('Counting:', i)
	end;

end;

{ Main }

begin
	writeln('Start counting');
	Counting(10, 4);
	//Counting2(10, 4);
	writeln('Stop counting')
end.
