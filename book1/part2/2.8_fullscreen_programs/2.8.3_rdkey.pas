program RdKey; { 2.8.3_rdkey.pas }

uses crt;

var
	c, cc: char;

begin
	repeat
		c := Readkey;
		cc := c;
		if (cc < #32) or (cc > #126) then
			cc := '?';
		writeln(ord(c), ' (', cc, ')')
	until c = ' '
end.
