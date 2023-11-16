program CallingProperties; { 2.39_calling_properties.pas }

// https://stackoverflow.com/questions/76548849/i-got-an-error-when-trying-to-pass-a-pointer-to-a-procedure-in-free-pascal

{
  With ^twoptrs parameter in procedure Pascal doesn't want compile
  so I use TwoPtrsPtr type
}

{ Types }

type
	pair = record
		a: integer;
		b: real;
	end;

	TwoPtrsPtr = ^twoptrs;
	twoptrs = record
		g, h: ^pair;
		t: ^integer;
	end;


{ Procedures }

procedure proc1(p: TwoPtrsPtr);
begin
	writeln('twoptrs.g: (', p^.g^.a, ', ', p^.g^.b, ')');
	writeln('twoptrs.h: (', p^.h^.a, ', ', p^.h^.b, ')');
	writeln('twoptrs.t: ', p^.t^)
end;


{ Main }

var
	tp2: twoptrs;
	m, n: pair;
	x: integer;
begin
	m.a := 10;
	m.b := 1.5;

	n.a := 20;
	n.b := 2.5;

	x := 100;

	tp2.g := @m;
	tp2.h := @n;
	tp2.t := @x;

	proc1(@tp2)
end.
