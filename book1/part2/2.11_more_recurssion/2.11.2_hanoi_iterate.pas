program hanoi_iterate;

{ Functions }

function IntermRod(src, dst: integer): integer;
begin
	if (src <> 1) and (dst <> 1) then
		IntermRod := 1
	else
	if (src <> 2) and (dst <> 2) then
		IntermRod := 2
	else
		IntermRod := 3
end;


{ Procedures }

procedure Solve(n: integer);
type
	TaskState = (TsClearing, TsLargest, TsFinal);

	ptask = ^task;
	task = record
		amount, src, dst: integer;
		state: TaskState;
		next: ptask
	end;

var
	first, tmp: ptask;
begin
	new(first);
	first^.amount := n;
	first^.src := 1;
	first^.dst := 3;
	first^.state := TsClearing;
	first^.next := nil;

	while first <> nil do
	begin
		case first^.state of
			TsClearing:
				begin
					first^.state := TsLargest;
					if first^.amount > 1 then
					begin
						new(tmp);
						tmp^.src := first^.src;
						tmp^.dst := IntermRod(first^.src, first^.dst);
						tmp^.amount := first^.amount - 1;
						tmp^.state := TsClearing;
						tmp^.next := first;
						first := tmp
					end
				end;

			TsLargest:
				begin
					first^.state := TsFinal;
					writeln(first^.amount, ': ', first^.src, ' -> ', first^.dst);
					if first^.amount > 1 then
					begin
						new(tmp);
						tmp^.src := IntermRod(first^.src, first^.dst);
						tmp^.dst := first^.dst;
						tmp^.amount := first^.amount - 1;
						tmp^.state := TsClearing;
						tmp^.next := first;
						first := tmp
					end
				end;

			TsFinal:
				begin
					tmp := first;
					first := first^.next;
					dispose(tmp)
				end
		end
	end
end;


{ Main }

var
	n, code: integer;
begin
	if ParamCount < 1 then
	begin
		writeln(ErrOutput, 'No parameters');
		halt(1)
	end;

	val(ParamStr(1), n, code);

	if (code <> 0) and (n < 1) then
	begin
		writeln('Invalid token count');
		halt(1)
	end;

	Solve(n)
end.
