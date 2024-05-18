program IntsCount; { 2.44_ints_count.pas }

{ Types }

type
	DigitItemPtr = ^DigitItem;
	DigitItem = record
		digit: char;
		next: DigitItemPtr;
	end;

	DigitSeqItemPtr = ^DigitSeqItem;
	DigitSeqItem = record
		seq: DigitItemPtr;
		count: integer;
		next: DigitSeqItemPtr;
	end;

	StringItemPtr = ^StringItem;
	StringItem = record
		digitSeqs: DigitSeqItemPtr;
		longest: integer;
		next: StringItemPtr;
	end;


{ Functions }

function isDigit(digit: char): boolean;
begin
	isDigit := (digit >= '0') and (digit <= '9')
end;

function isEndOfString(ch: char): boolean;
begin
	isEndOfString := ch = #10
end;


{ Procedures }

procedure PutDigitItem(var first, last: DigitItemPtr; digit: char);
begin
	if first = nil then
	begin
		new(first);
		last := first
	end
	else
	begin
		new(last^.next);
		last := last^.next
	end;

	last^.digit := digit;
	last^.next := nil
end;

procedure DisposeDigitItem(var digitItem: DigitItemPtr);
var
	tempDigitItem, nextDigitItem: DigitItemPtr;
begin
	tempDigitItem := digitItem;
	while tempDigitItem <> nil do
	begin
		nextDigitItem := tempDigitItem^.next;
		dispose(tempDigitItem);
		tempDigitItem := nextDigitItem
	end
end;


procedure PutDigitSeqItem(var first, last: DigitSeqItemPtr; var seq: DigitItemPtr; count: integer);
begin
	if first = nil then
	begin
		new(first);
		last := first
	end
	else
	begin
		new(last^.next);
		last := last^.next
	end;

	last^.seq := seq;
	last^.count := count;
	last^.next := nil
end;

procedure DisposeDigitSeqItem(var digitSeqItem: DigitSeqItemPtr);
var
	tempDigitSeqItem, nextDigitSeqItem: DigitSeqItemPtr;
begin
	tempDigitSeqItem := digitSeqItem;
	while tempDigitSeqItem <> nil do
	begin
		nextDigitSeqItem := tempDigitSeqItem^.next;	
		DisposeDigitItem(tempDigitSeqItem^.seq);
		dispose(tempDigitSeqItem);
		tempDigitSeqItem := nextDigitSeqItem
	end;
end;


procedure PutStringItem(var first, last: StringItemPtr; 
                        var digitSeqs: DigitSeqItemPtr;
                        longest: integer);
begin
	if first = nil then
	begin
		new(first);
		last := first
	end
	else
	begin
		new(last^.next);
		last := last^.next
	end;

	last^.digitSeqs := digitSeqs;
	last^.longest := longest;
	last^.next := nil
end;

procedure DisposeStringItem(var stringItem: StringItemPtr);
var
	nextStringItem: StringItemPtr;
begin
	nextStringItem := stringItem^.next;	
	DisposeDigitSeqItem(stringItem^.digitSeqs);
	dispose(stringItem);
	stringItem := nextStringItem
end;


procedure SaveDigits(var initialStringItem: StringItemPtr);
var
	ch: char;
	firstStringItem, lastStringItem: StringItemPtr;
	firstDigitSeqItem, lastDigitSeqItem: DigitSeqItemPtr;
	firstDigitItem, lastDigitItem: DigitItemPtr;
	digitCount, longest: integer;
begin
	digitCount := 0;
	longest := digitCount;

	firstStringItem := initialStringItem;
	lastStringItem := nil;

	firstDigitSeqItem := nil;
	lastDigitSeqItem := nil;

	firstDigitItem := nil;
	lastDigitItem := nil;

	while not eof do
	begin
		read(ch);
		
		if isDigit(ch) then
		begin
			PutDigitItem(firstDigitItem, lastDigitItem, ch);	
			digitCount += 1
		end
		else
		begin
			if digitCount <> 0 then
			begin
				if longest < digitCount then
					longest := digitCount;

				PutDigitSeqItem(firstDigitSeqItem, lastDigitSeqItem, firstDigitItem, digitCount);

				digitCount := 0;
				firstDigitItem := nil;
				lastDigitItem := nil
			end
		end;

		if isEndOfString(ch) then
		begin
			PutStringItem(firstStringItem, lastStringItem, firstDigitSeqItem, longest);
			longest := 0;
			firstDigitSeqItem := nil;
			lastDigitSeqItem := nil
		end
	end;

	initialStringItem := firstStringItem
end;


procedure PrintLongestDigits(var initialStringItem: StringItemPtr);
var
	tempStringItem: StringItemPtr;
	tempDigitSeqItem: DigitSeqItemPtr;
	tempDigitItem: DigitItemPtr;
begin
	tempStringItem := initialStringItem;
	while tempStringItem <> nil do
	begin
		tempDigitSeqItem := tempStringItem^.digitSeqs;

		while tempDigitSeqItem <> nil do
		begin
			if tempDigitSeqItem^.count <> tempStringItem^.longest then
			begin
				tempDigitSeqItem := tempDigitSeqItem^.next;
				continue
			end;

			tempDigitItem := tempDigitSeqItem^.seq;

			while tempDigitItem <> nil do
			begin
				write(tempDigitItem^.digit);
				tempDigitItem := tempDigitItem^.next
			end;

			if tempDigitSeqItem^.next <> nil then
				write(' ')
			else
				writeln;

			tempDigitSeqItem := tempDigitSeqItem^.next
		end;

		DisposeStringItem(tempStringItem)
	end
end;


{ Main }

var
	initialStringItem: StringItemPtr;
begin
	initialStringItem := nil;

	SaveDigits(initialStringItem);
	PrintLongestDigits(initialStringItem)
end.
