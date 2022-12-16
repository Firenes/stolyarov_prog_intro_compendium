program non_space_symbols;

function IfCharInString(checkCh: char; checkString: string): boolean;
var
	ch: char;
begin
	for ch in checkString do
	begin
		if (ch = checkCh) then
			exit(true);
	end;
	IfCharInString := false;
end;

var
	inputString, totalString: string;
	ch1, ch2: char;
	charCount: integer;

begin
	readln(inputString);

	totalString := '';

	for ch1 in inputString do
	begin
		charCount := 0;

		for ch2 in inputString do
		begin
			if (ch1 = ch2) and (ch1 <> ' ') then
				charCount += 1;
		end;

		if charCount > 1 then
		begin
			if not IfCharInString(ch1, totalString) then
				totalString := totalString + ch1;
		end
	end;
	writeln(totalString);
end.
