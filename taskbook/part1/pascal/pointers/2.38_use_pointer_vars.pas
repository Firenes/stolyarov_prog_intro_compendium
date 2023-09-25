program UsePointerVars; { 2.38_use_pointer_vars.pas }

type
	iptr3 = array [1..3] of ^integer;
var
	a: iptr3;
	p: ^iptr3;
	x, y, z: integer;
begin
	x := 1;
	y := 2;
	z := 3;

	a[1] := @x;
	a[2] := @y;
	a[3] := @z;

	p := @a;
	
	writeln(p^[1]^);
	writeln(p^[2]^);
	writeln(p^[3]^)
end.
