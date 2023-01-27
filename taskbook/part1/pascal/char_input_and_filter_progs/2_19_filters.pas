program Filters; { 2_19_filters.pas }


{ Functions }

function isCharSpacing(ch: char): boolean;
begin
	isCharSpacing := (ch = #10) or (ch = ' ') or (ch = #13);
end;


function AreAllRoundBracketsClosed(openCount, closedCount: longint): string;
begin
	if openCount = closedCount then
		AreAllRoundBracketsClosed := 'YES'
	else
		AreAllRoundBracketsClosed := 'NO'
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


// (a)
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


// (e)
procedure CountWordsInString(ch: char; wCount: longint; var wInString: longint);
begin
	if ch = #10 then
	begin
		writeln('count in string: ', wCount - wInString);
		wInString := wCount;
	end
end;


procedure CountLongestWord(ch: char; charsInWordCount: longint; var longest: longint);
begin
	if IsCharSpacing(ch) then
	begin
		if charsInWordCount > longest then
			longest := charsInWordCount
	end
end;

procedure CountShortestWord(ch: char; charsInWordCount: longint; var shortest: longint);
begin
	if IsCharSpacing(ch) then
	begin
		if (shortest = 0) or (charsInWordCount < shortest) then
			shortest := charsInWordCount
	end
end;


// (f)
procedure CountLongestWordInString(ch: char; charsInWordCount: longint;
								   var longestInString: longint);
begin
	CountLongestWord(ch, charsInWordCount, longestInString);
	if ch = #10 then
	begin
		writeln('longest in string: ', longestInString);
		longestInString := 0
	end
end;


procedure CountSpaceLine(ch: char; var spaceLine: longint);
begin
	if ch = ' ' then
		spaceLine := spaceLine + 1
end;

procedure ClearCountingSpaceLine(ch: char; var spaceLine: longint);
begin
	if ch <> ' ' then
		spaceLine := 0
end;

procedure CountLongestSpaceLine(ch: char; spaceLine: longint;
								var spaceLongestLine: longint);
begin
	if ch <> ' ' then
	begin
		if spaceLine > spaceLongestLine then
			spaceLongestLine := spaceLine
	end
end;


// (g)
procedure CountAllRoundBrackets(ch: char; var openCount, closedCount: longint);
begin
	if ch = '(' then
		openCount := openCount + 1;

	if ch = ')' then
		closedCount := closedCount + 1;
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

	wInString: longint;
	longest, shortest: longint;

	longestInString: longint;
	spaceLine, spaceLongestLine: longint;

	openRoundBracketsCount: longint;
	closedRoundBracketsCount: longint;

begin
	while not eof do
	begin
		read(ch);
		CountCharsInWord(ch, charsInWordCount);
		CountSpaceLine(ch, spaceLine);

		// (a)
		CountWords(ch, wCount, known, print);
		// (b)
		CountEvenAndOddWords(ch, charsInWordCount, evenCount, oddCount);
		// (c)
		CountMoreSevenAndLessTwo(ch, charsInWordCount, moreSevenCount, lessTwoCount);
		// (d)
		SaveLastWordChar(ch, lastChar);
		CountWordsStartAEndZ(ch, lastChar, charsInWordCount, isStartedFromA, fromAtoZWordCount);
		// (e)
		CountLongestWord(ch, charsInWordCount, longest);
		CountShortestWord(ch, charsInWordCount, shortest);
		CountWordsInString(ch, wCount, wInString);
		// (f)
		CountLongestWordInString(ch, charsInWordCount, longestInString);
		CountLongestSpaceLine(ch, spaceLine, spaceLongestLine);
		// (g)
		CountAllRoundBrackets(ch, openRoundBracketsCount, closedRoundBracketsCount);

		ClearCountingCharsInWord(ch, charsInWordCount);
		ClearCountingSpaceLine(ch, spaceLine);
	end;	

	writeln('count: ', wCount);
	writeln('even words: ', evenCount);
	writeln('odd words: ', oddCount);
	writeln('more than seven: ', moreSevenCount);
	writeln('less than two: ', lessTwoCount);
	writeln('started A, ended z: ', fromAtoZWordCount);
	writeln('longest: ', longest);
	writeln('shortest: ', shortest);
	writeln('longest space line: ', spaceLongestLine);
	writeln('all round brackets closed: ', AreAllRoundBracketsClosed(openRoundBracketsCount, closedRoundBracketsCount));
end.

