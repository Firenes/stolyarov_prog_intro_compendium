program SOL; { 2.10.5_sol.pas }

{ Types }

type
	LongItemPtr = ^LongItem;
	LongItem = record
		data: longint;
		next: LongItemPtr
	end;
	StackOfLongints = LongItemPtr;


{ SOL Interface }

procedure SOLInit(var stack: StackOfLongints);
begin
	stack := nil
end;

procedure SOLPush(var stack: StackOfLongints; n: longint);
var
	temp: LongItemPtr;
begin
	new(temp);
	temp^.data := n;
	temp^.next := stack;
	stack := temp
end;

procedure SOLPop(var stack: StackOfLongints; var n: longint);
var
	temp: LongItemPtr;
begin
	n := stack^.data;
	temp := stack;
	stack := stack^.next;
	dispose(temp)
end;

function SOLIsEmpty(var stack: StackOfLongints): boolean;
begin
	SOLIsEmpty := stack = nil
end;


{ Main }

var
	s: StackOfLongints;
	n: longint;
begin
	SOLInit(s);
	while not SeekEof do
	begin
		read(n);
		SOLPush(s, n)
	end;
	while not SOLIsEmpty(s) do
	begin
		SOLPop(s, n);
		writeln(n)
	end
end.
