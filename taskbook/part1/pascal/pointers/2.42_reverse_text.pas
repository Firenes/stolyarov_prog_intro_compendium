program ReverseText; { 2.42_reverse_text.pas }

{ Types }

type
	CharItemPtr = ^CharItem;
	CharItem = record
		ch: char;
		next: CharItemPtr;
	end;


{ Functions }

function isCharSpacing(ch: char): boolean;
begin
	isCharSpacing := (ch = ' ') or (ch = #10);
end;


{ Procedures }

procedure SaveChar(var first: CharItemPtr; ch: char);
var
	temp: CharItemPtr;
begin
	new(temp);
	temp^.ch := ch;
	temp^.next := first;
	first := temp
end;

procedure SaveWordToString(var wordItem, stringItem: CharItemPtr; spaceCh: char);
var
	wordItemTemp: CharItemPtr;
begin
	wordItemTemp := wordItem;
	while wordItemTemp <> nil do
	begin
		SaveChar(stringItem, wordItemTemp^.ch);
		wordItemTemp := wordItemTemp^.next
	end;

	SaveChar(stringItem, spaceCh)
end;


{ Main }

var
	firstStringItem, firstStringItemTemp: CharItemPtr;
	firstWordItem: CharItemPtr;
	ch: char;
begin
	firstStringItem := nil;	
	firstWordItem := nil;

	while not eof do
	begin
		read(ch);
		if isCharSpacing(ch) then
		begin
			SaveWordToString(firstWordItem, firstStringItem, ch);
			dispose(firstWordItem);
			firstWordItem := nil
		end
		else
			SaveChar(firstWordItem, ch)
	end;

	firstStringItemTemp := firstStringItem;
	while firstStringItemTemp <> nil do
	begin
		write(firstStringItemTemp^.ch);
		firstStringItemTemp := firstStringItemTemp^.next
	end;
	writeln
end.
