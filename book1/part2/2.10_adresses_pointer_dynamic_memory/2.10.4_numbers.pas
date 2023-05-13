program Numbers; { 2.10.4_numbers.pas }

{ Types }

type
	itemptr = ^item;
	item = record
		data: integer;
		next: itemptr;
	end;


{ Main }

var
	first, last, temp: itemptr;
	inputNumber: integer;
begin
	first := nil;
	last := nil;
	while not SeekEof do
	begin
		read(inputNumber);
		if first = nil then
		begin
			new(first);
			last := first
		end
		else
		begin
			new(last^.next);
			last := last^.next
		end;
		last^.data := inputNumber;
		last^.next := nil
	end;
	
	temp := first;

	while temp <> nil do
	begin
		writeln(temp^.data);
		writeln(temp^.data);
		temp := temp^.next
	end;
end.
