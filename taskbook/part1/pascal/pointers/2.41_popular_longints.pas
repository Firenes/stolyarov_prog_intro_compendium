program PopularLongints; { 2.41_popular_longints.pas }

{ Types }

type
	LongItemPtr = ^LongItem;
	LongItem = record
		data: longint;
		count: longint;
		next: LongItemPtr;
	end;


{ Procedures }

procedure IncrementIfFound(var found: boolean; data: longint; first: LongItemPtr; var longest: longint);
var
	temp: LongItemPtr;
begin
	temp := first;
	while temp <> nil do
	begin
		if temp^.data = data then
		begin
			temp^.count := temp^.count + 1;
			found := true;
			if longest < temp^.count then
				longest := temp^.count
		end;
		temp := temp^.next
	end
end;

procedure ReadLongints(var first: LongItemPtr; var longest: longint);
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
		IncrementIfFound(found, n, first, longest);
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

procedure PrintPopularLongints(var first: LongItemPtr; longest: longint);
var
	temp: LongItemPtr;
begin
	temp := first;
	while temp <> nil do
	begin
		if temp^.count = longest then
			writeln(temp^.data);
		temp := temp^.next
	end
end;


{ Main }

var
	first: LongItemPtr;
	longest: longint;
begin
	first := nil;
	longest := 1;

	ReadLongints(first, longest);
	
	PrintPopularLongints(first, longest)
end.
