program QOL; { 2.10.5_qol.pas }

{ Types }

type
	LongItemPtr = ^LongItem;
	LongItem = record
		data: longint;
		next: LongItemPtr
	end;
	QueueOfLongints = record
		first, last: LongItemPtr;
	end;

{ QOL Interface }

procedure QOLInit(var queue: QueueOfLongints);
begin
	queue.first := nil;
	queue.last := nil
end;

procedure QOLPut(var queue: QueueOfLongints; n: longint);
begin
	if queue.first = nil then
	begin
		new(queue.first);
		queue.last := queue.first;
	end
	else
	begin
		new(queue.last^.next);
		queue.last := queue.last^.next
	end;
	queue.last^.data := n;
	queue.last^.next := nil
end;

procedure QOLGet(var queue: QueueOfLongints; var n: longint);
var
	temp: LongItemPtr;
begin
	n := queue.first^.data;
	temp := queue.first;
	queue.first := queue.first^.next;
	if queue.first = nil then
		queue.last := nil;
	dispose(temp)
end;

function QOLIsEmpty(var queue: QueueOfLongints): boolean;
begin
	QOLIsEmpty := queue.first = nil
end;


{ Main }

var
	q: QueueOfLongints;
	n: longint;
begin
	QOLInit(q);
	while not SeekEof do
	begin
		read(n);
		QOLPut(q, n)
	end;
	while not QOLIsEmpty(q) do
	begin
		QOLGet(q, n);
		writeln(n)
	end
end.
