program RokkEbol; { 2.43_rokk_ebol.pas }

{ Types }

type
	CharItemPtr = ^CharItem;
	CharItem = record
		ch: char;
		next: CharItemPtr;
	end;

type 
	WordsItemPtr = ^WordsItem;
	WordsItem = record
		charItem: CharItemPtr;
		next: WordsItemPtr;
	end;


{ Functions }

function isCharSpacing(ch: char): boolean;
begin
	isCharSpacing := (ch = ' ') or (ch = #10);
end;


{ Procedures }

procedure SaveChar(var first, last: CharItemPtr; ch: char);
begin
	if first = nil then
	begin
		new(first);
		last := first;
	end
	else
	begin
		new(last^.next);
		last := last^.next;
	end;
	
	last^.ch := ch;
	last^.next := nil
end;

procedure SaveWords(var first, last: WordsItemPtr; var charItem: CharItemPtr);
begin
	if first = nil then
	begin
		new(first);
		last := first;
	end
	else
	begin
		new(last^.next);
		last := last^.next;
	end;

	last^.charItem := charItem;
	last^.next := nil
end;


{ Main }

var
	firstCharItem, lastCharItem, charItemTemp: CharItemPtr;
	firstWordItem, lastWordItem, wordItemTemp: WordsItemPtr;
	ch: char;
	maxChars, currChars, i, j: integer;
begin
	firstCharItem := nil;
	lastCharItem := nil;

	firstWordItem := nil;
	lastWordItem := nil;

	maxChars := 0;
	currChars := 0;

	while not eof do
	begin
		read(ch);
		if isCharSpacing(ch) then
		begin
			SaveWords(firstWordItem, lastWordItem, firstCharItem);
			firstCharItem := nil;
			lastCharItem := nil;
			if currChars > maxChars then
				maxChars := currChars;

			currChars := 0;
		end
		else
		begin
			SaveChar(firstCharItem, lastCharItem, ch);
			currChars += 1
		end
	end;

	for i := 1 to maxChars do
	begin
		wordItemTemp := firstWordItem;
		while wordItemTemp <> nil do
		begin
			charItemTemp := wordItemTemp^.charItem;
			for j := 1 to i do
			begin
				if j = i then
				begin
					if charItemTemp <> nil then
						write(charItemTemp^.ch)
					else
						write(' ')
				end;
				if charItemTemp <> nil then
					charItemTemp := charItemTemp^.next
			end;
			wordItemTemp := wordItemTemp^.next
		end;
		writeln
	end;
end.
