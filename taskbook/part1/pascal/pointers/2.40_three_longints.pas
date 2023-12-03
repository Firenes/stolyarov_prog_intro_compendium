program ThreeLongints; { 2.40_three_longints.pas }

{ Types }

type
	LongItemPtr = ^LongItem;
	LongItem = record
		data: longint;
		count: longint;
		next: LongItemPtr;
	end;


{ Procedures }

procedure IncrementIfFound(var found: boolean; data: longint; first: LongItemPtr);
var
	temp: LongItemPtr;
begin
	temp := first;
	while temp <> nil do
	begin
		if temp^.data = data then
		begin
			temp^.count := temp^.count + 1;
			found := true
		end;
		temp := temp^.next
	end
end;

procedure ReadLongints(var first: LongItemPtr);
var
	n: longint;
	found: boolean;
	last: LongItemPtr;
begin
	while not SeekEof do
	begin
		read(n);
		if first = nil then
		begin
			new(first);
			last := first
		end;

		found := false;
		IncrementIfFound(found, n, first);
		if not found then
		begin
			new(last^.next);
			last := last^.next;	

			last^.data := n;
			last^.count := 1;
			last^.next := nil
		end
	end
end;

procedure PrintThreeCountLongints(var first: LongItemPtr);
var
	temp: LongItemPtr;
begin
	temp := first;
	while temp <> nil do
	begin
		if temp^.count = 3 then
			writeln(temp^.data);
		temp := temp^.next
	end
end;


{ Main }

var
	first: LongItemPtr;
begin
	first := nil;

	ReadLongints(first);
	
	PrintThreeCountLongints(first)
end.
