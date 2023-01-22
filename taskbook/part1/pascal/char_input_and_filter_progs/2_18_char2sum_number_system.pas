program InputCharsToNumbersWithDiffNumberSystem; { 2_18_char2sum_number_system.pas }

{ Procedure }

procedure CheckChar(ch: char;
					base: integer;
					var result: longint;
					var success: boolean);
var
	res: integer;

begin
	res := -1;
	
	if (ch >= '0') and (ch <= '9') then
		res := ord(ch) - ord('0');
	if (ch >= 'a') and (ch <= 'z') then
		res := ord(ch) - ord('a') + 10;
	if (ch >= 'A') and (ch <= 'Z') then
		res := ord(ch) - ord('A') + 10;

	if (res = -1) or (res >= base) then
	begin
		success := false;
		exit
	end;

	result := res;
	success := true
end;

procedure ReadChar(base: integer; var success: boolean; var result: longint);
var
	c: char;
	res, curr: longint;
	pos: integer;
	successRead: boolean;

begin
	res := 0;
	pos := 0;
	
	repeat
		read(c);
		pos := pos + 1;
	until (c <> ' ') and (c <> #10);

	while (c <> ' ') and (c <> #10) do
	begin
		CheckChar(c, base, curr, successRead);
		if (successRead = false) then
		begin
			writeln('Unexpected ''', c, ''' in pos: ', pos);
			readln;
			success := false;
			exit
		end;
		res := res * base + curr;
		read(c);
		pos := pos + 1;
	end;

	result := res;
	success := true;
end;

{ Main }

var
	ok: boolean;
	base: integer;
	res: longint;

begin
	res := 0;

	repeat
		write('Please enter base number system from 2 to 36: ');
		read(base);

		if (base < 2) or (base > 36) then
			ok := false
		else
			ok := true
	until ok;

	repeat
		ReadChar(base, ok, res)
	until ok;

	writeln(res)
end.
