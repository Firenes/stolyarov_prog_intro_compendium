program cube;

function Cube(x: real): real;
begin
	Cube := x * x * x;
end;

{ Main part }
var
	res, n: real;

begin
	writeln('Enter real number: ');
	readln(n);
	res := Cube(n);
	writeln('Coub of ', n:2:2, ' is ', res:2:2)
end.
