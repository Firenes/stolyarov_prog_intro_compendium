program Filters; { 2_19_filters.pas }


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


procedure SaveLastWordChar(ch: char; var lastChar: char);
begin
	if not isCharSpacing(ch) then
		lastChar := ch
end;


// (a) part
procedure CountWords(ch: char; var count: longint; var known, print: boolean);
begin
	if isCharSpacing(ch) then
	begin
		if known and print then
			count := count + 1;
		known := false
	end
	else
	begin
		if not known then
		begin
			print := (ch <> ' ') and (ch <> #9);
			known := true
		end
	end
end;


// (b)
procedure CountEvenAndOddWords(ch: char; charsInWordCount: longint;
							   var evenCount, oddCount: longint);
begin
	if isCharSpacing(ch) then
	begin
		if (charsInWordCount mod 2) = 0 then
			evenCount := evenCount + 1
		else
			oddCount := oddCount + 1
	end 
end;


// (c)
procedure CountMoreSevenAndLessTwo(ch: char; charsInWordCount: longint;
								   var moreSevenCount, lessTwoCount: longint);
begin
	if isCharSpacing(ch) then
	begin
		if charsInWordCount > 7 then
			moreSevenCount := moreSevenCount + 1;

		if charsinWordCount < 2 then
			lessTwoCount := lessTwoCount + 1
	end
end;


// (d)
procedure CountWordsStartAEndZ(ch, lastChar: char; charsInWordCount: longint;
							   var isStartedFromA: boolean;
							   var fromAtoZWordCount: longint);
begin
	if (charsInWordCount = 1) and (ch = 'A') then
		isStartedFromA := true;

	if IsCharSpacing(ch) and isStartedFromA and (lastChar = 'z') then
	begin
		fromAtoZWordCount := fromAtoZWordCount + 1;
		isStartedFromA := false
	end
end;


{ Main }

var
	ch: char;
	known, print: boolean;
	wCount: longint;
	
	charsInWordCount: longint;
	evenCount, oddCount: longint;

	moreSevenCount, lessTwoCount: longint;

	lastChar: char;
	isStartedFromA: boolean;
	fromAtoZWordCount: longint;

begin
	while not eof do
	begin
		read(ch);
		CountCharsInWord(ch, charsInWordCount);
		
		// (a)
		CountWords(ch, wCount, known, print);
		// (b)
		CountEvenAndOddWords(ch, charsInWordCount, evenCount, oddCount);
		// (c)
		CountMoreSevenAndLessTwo(ch, charsInWordCount, moreSevenCount, lessTwoCount);
		// (d)
		SaveLastWordChar(ch, lastChar);
		CountWordsStartAEndZ(ch, lastChar, charsInWordCount, isStartedFromA, fromAtoZWordCount);

		ClearCountingCharsInWord(ch, charsInWordCount);
	end;	

	writeln('count: ', wCount);
	writeln('even words: ', evenCount);
	writeln('odd words: ', oddCount);
	writeln('more than seven: ', moreSevenCount);
	writeln('less than two: ', lessTwoCount);
	writeln('started A, ended z: ', fromAtoZWordCount);
end.

