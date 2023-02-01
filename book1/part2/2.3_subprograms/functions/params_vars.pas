program params_vars;

{ Procedure }

procedure powers(x: real; var quad, cube, fourth, fifth: real);
begin
    quad := x * x;
    cube := quad * x;
    fourth := cube * x;
    fifth := fourth * x
end;

{ Main Part }

var
    x, p, q, r, t: real;

begin
	x := 17.5;
    powers(x, p, q, r, t);

	writeln('x: ', x:2:2);
	writeln('quad: ', p:2:2);
	writeln('cube: ', q:2:2);
	writeln('fourth: ', r:2:2);
	writeln('fifth: ', t:2:2)
end.
