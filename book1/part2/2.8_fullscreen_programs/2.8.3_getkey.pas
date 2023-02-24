program GetKey; { 2.8.4_getkey.pas }

uses crt;

{ Procedures }

procedure GetKey(var code: integer);
var
	c: char;
begin
	c := ReadKey;
	if c = #0 then
	begin
		c := ReadKey;
		code := -ord(c);
	end
	else
		code := ord(c)
end;

{ Main }

var
	i: integer;
begin
	repeat
		GetKey(i);
		writeln(i)
	until i = ord(' ')
end.
