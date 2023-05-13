program ReversedNumbers; { 2.10.4_reversed_numbers.pas }

{ Types }

type
	itemptr = ^item;
	item = record
		data: integer;
		next: itemptr;	
	end;


{ Main }

var
	first, temp: itemptr;
	inputNumber: integer;
begin
	first := nil;
	while not SeekEof do
	begin
		read(inputNumber);
		new(temp);
		temp^.data := inputNumber;
		temp^.next := first;
		first := temp
	end;

	temp := first;
	
	while temp <> nil do
	begin
		writeln(temp^.data);
		temp := temp^.next
	end;
end.
