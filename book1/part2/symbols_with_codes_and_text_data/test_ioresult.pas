program TestIOResult; { test_ioresult.pas }

var
	x, y, ioRes: longint;

begin
	{$I-}
	read(x, y);
	ioRes := IOResult;

	if ioRes = 0 then
		writeln(x * y)
	else
		writeln('I couldn''t parse your input with error: ', ioRes)
end.
