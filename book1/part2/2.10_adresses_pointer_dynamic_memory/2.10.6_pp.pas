program PointerToPointer; { 2.10.6_pp.pas }

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
	pp: ^itemptr;
	n: integer;
begin
	first := nil;
	while not SeekEof do
	begin
		read(n);
		new(temp);
		temp^.data := n;
		temp^.next := first;
		first := temp
	end;

	pp := @first;
	while pp^ <> nil do
	begin
		if pp^^.data < 0 then
		begin
			temp := pp^;
			pp^ := pp^^.next;
			dispose(temp)
		end
		else
			pp := @(pp^^.next)
	end;

	temp := first;
	while temp <> nil do
	begin
		writeln(temp^.data);
		temp := temp^.next
	end
end.
