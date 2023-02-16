program ArgsHandling; { 2.22_args_handling.pas }

{ Functions }

function ArgLength(index: integer): integer;
begin
	ArgLength := length(ParamStr(index))
end;


{ Procedures }

procedure CheckArgsNoEmpty;
begin
	if ParamCount = 0 then
		halt(1)
end;


procedure ConcatenateString(var base: string; attach: string);
begin
	if length(base) = 0 then
		base := base + attach
	else
		base := base + ' ' + attach
end;


// (a)
procedure LongestArg(currArg: integer; var longest: integer);
begin
	if ArgLength(longest) < ArgLength(currArg) then
		longest := currArg
end;


// (b)
procedure FindNonRepeatingChars(currArg: integer; var unique: string);
var
	i, j: integer;
	arg: string;
	count: integer;
	isUnique: boolean;
begin
	isUnique := true;
	arg := ParamStr(currArg);

	for i := 1 to ArgLength(currArg) do
	begin
		count := 0;
		for j := 1 to ArgLength(currArg) do
		begin
			if arg[i] = arg[j] then
				count := count + 1;

			if count > 1 then
				isUnique := false
		end;
		if not isUnique then
			break
	end;

	if isUnique then
		ConcatenateString(unique, arg)
end;


// (c)
procedure FindAtAndDots(currArg: integer; var atArgs, dotsArgs: string);
var
	i: integer;
	atCount, dotsCount: integer;
	arg: string;
begin
	atCount := 0;
	dotsCount := 0;
	arg := ParamStr(currArg);

	for i := 1 to ArgLength(currArg) do
	begin
		if arg[i] = '@' then
			atCount := atCount + 1;
		if arg[i] = '.' then
			dotsCount := dotsCount + 1;
	end;

	if atCount = 1 then
		ConcatenateString(atArgs, arg);
	if dotsCount > 1 then
		ConcatenateString(dotsArgs, arg)
end;


// (d)
procedure FindNumberArgs(currArg: integer; var numArgs: string);
var
	i: integer;
	arg: string;
	isNum: boolean;
begin
	arg := ParamStr(currArg);
	isNum := false;

	for i := 1 to ArgLength(currArg) do
	begin
		isNum := (arg[i] >= '0') and (arg[i] <= '9');

		if not isNum then
			break
	end;

	if isNum then
		ConcatenateString(numArgs, arg)
end;


// (e)
procedure FindRepeatedCharsArgs(currArg: integer; var repeatedCharsArgs: string);
var
	i: integer;
	arg: string;
	ch: char;
	isSuitable: boolean;
begin
	arg := ParamStr(currArg);
	ch := arg[1];
	isSuitable := true;

	for i := 2 to ArgLength(currArg) do
	begin
		if ch <> arg[i] then
			isSuitable := false
	end;

	if isSuitable then
		ConcatenateString(repeatedCharsArgs, arg)
end;


// (f)
procedure FindLatinArgs(currArg: integer; var latinArgs: string);
var
	i: integer;
	arg: string;
	isLatin: boolean;
begin
	arg := ParamStr(currArg);
	isLatin := false;

	for i := 1 to ArgLength(currArg) do
	begin
		if ((arg[i] >= 'a') and (arg[i] <= 'z'))
		or ((arg[i] >= 'A') and (arg[i] <= 'Z')) then
			isLatin := true
		else
		begin
			isLatin := false;
			break
		end
	end;

	if isLatin then
		ConcatenateString(latinArgs, arg)
end;


// (g)
procedure FindSameCharsInFirstArgs(currArg: integer; var suitableArgs: string);
var
	i, j: integer;
	arg: string;
	firstArg: string;
	hasCommonChars: boolean;
begin
	if currArg = 1 then
		exit;

	arg := ParamStr(currArg);
	firstArg := ParamStr(1);
	hasCommonChars := false;

	for i := 1 to ArgLength(currArg) do
		for j := 1 to length(firstArg) do
			if arg[i] = firstArg[j] then
				hasCommonChars := true;

	if hasCommonChars then
		ConcatenateString(suitableArgs, arg)
end;


{ Main }

var
	i: integer;
	// (a)
	longest: integer;
	// (b)
	argsWithUniqueChars: string;
	// (c)
	atArgs, dotsArgs: string;
	// (d)
	numberArgs: string;
	// (e)
	repeatedCharsArgs: string;
	// (f)
	latinArgs: string;
	// (g)
	sameCharsInFirstArgs: string;

begin
	CheckArgsNoEmpty;

	longest := 1;

	for i := 1 to ParamCount do
	begin
		// (a)
		LongestArg(i, longest);

		// (b)
		FindNonRepeatingChars(i, argsWithUniqueChars);

		// (c)
		FindAtAndDots(i, atArgs, dotsArgs);

		// (d)
		FindNumberArgs(i, numberArgs);

		// (e)
		FindRepeatedCharsArgs(i, repeatedCharsArgs);

		// (f)
		FindLatinArgs(i, latinArgs);

		// (g)
		FindSameCharsInFirstArgs(i, sameCharsInFirstArgs)
	end;

	writeln('longest: ', ParamStr(longest));
	writeln('unique chars: ', argsWithUniqueChars);
	writeln('@: ', atArgs);
	writeln('more than one dot: ', dotsArgs);
	writeln('numbers: ', numberArgs);
	writeln('repeated chars: ', repeatedCharsArgs);
	writeln('latin: ', latinArgs);
	writeln('same chars in first arg: ', sameCharsInFirstArgs)
end.
