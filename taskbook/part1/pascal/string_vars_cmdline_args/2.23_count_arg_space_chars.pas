program CountSpaceCharsInArg; { 2.23_count_arg_space_chars }

{ Functions }

function IsSpaceChar(ch: char): boolean;
begin
	IsSpaceChar := (ch = ' ') or (ch = #9) or (ch = #10) or (ch = #13)
end;


{ Procedures }

procedure CheckParamCount;
begin
	if ParamCount <> 1 then
	begin
		writeln('Enter only one parameter');
		halt(1)
	end
end;


{ Main }

var
	arg: string;
	i: integer;
	known, print: boolean;
	count: integer;

begin
	CheckParamCount;
	arg := ParamStr(1);
	known := false;
	print := false;
	count := 0;

	for i := 1 to length(arg) do
	begin
		if IsSpaceChar(arg[i]) or (length(arg) = i) then
		begin
			if known and print then
				count := count + 1;
			known := false
		end
		else
		begin
			if not known then
			begin
				print := (arg[i] <> ' ') and (arg[i] <> #9);
				known := true
			end
		end
	end;
	
	writeln('count: ', count);
end.
