program PrintTwoCharWords; { 2_21_print_two_char_words.pas }

{ Functions }

function isCharSpacing(ch: char): boolean;
begin
	isCharSpacing := (ch = #10) or (ch = ' ') or (ch = #13);
end;


{ Procedures }

procedure CountCharsInWord(ch: char; var charCount: longint);
begin
    if not isCharSpacing(ch) then
        charCount := charCount + 1 
end;

procedure ClearCountingCharsInWord(ch: char; var charCount: longint);
begin
    if isCharSpacing(ch) then
        charCount := 0
end;

procedure ClearFirstAndSecondChars(var firstCh, secondCh: char);
begin
	firstCh := #0;
	secondCh := #0
end;

procedure PrintTwoSymbolWord(ch: char; charCount: longint;
							 var firstCh, secondCh: char);
begin
	if not isCharSpacing(ch) then
	begin
		if charCount = 1 then
			firstCh := ch;
		if charCount = 2 then
			secondCh := ch;
		if charCount > 2 then
			ClearFirstAndSecondChars(firstCh, secondCh)
	end
	else
	begin
		if charCount = 2 then
		begin
			write(firstCh);
			write(secondCh);
			write(ch);
			ClearFirstAndSecondChars(firstCh, secondCh)
		end
	end
end;


{ Main }

var
	ch: char;
	firstCh, secondCh: char;
	charsCount: longint;

begin

	while not eof do
	begin
		read(ch);
		CountCharsInWord(ch, charsCount);
		PrintTwoSymbolWord(ch, charsCount, firstCh, secondCh);
		ClearCountingCharsInWord(ch, charsCount)
	end
end.
