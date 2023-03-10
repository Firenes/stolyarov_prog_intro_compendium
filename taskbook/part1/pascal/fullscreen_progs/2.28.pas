program StarSquare; { 2.28.pas }

uses crt;

{ Constants }

const
	DelayDuration = 100; { 0.1 sec }
	SquareSize = 10;
	MaxScreenSize = 12;


{ Types }

type
	Coordinates = record
		x, y: integer;
	end;
	Point = record
		cur, d: Coordinates;
	end;
	Field = record
		topLeft, topRight, bottomLeft, bottomRight: Coordinates;
	end;


{ Functions }

function Equal(c1, c2: Coordinates): boolean;
begin
	Equal := (c1.x = c2.x) and (c1.y = c2.y)
end;


{ Procedures }

procedure ShowPoint(show: boolean; var p: Point);
begin
	GotoXY(p.cur.x, p.cur.y);
	if show then
		write('#')
	else
		write('*');
	GotoXY(1, 1)
end;


procedure MovePoint(var p: Point; f: Field);
begin
	ShowPoint(false, p);

	p.cur.x := p.cur.x + p.d.x;
	p.cur.y := p.cur.y + p.d.y;

	ShowPoint(true, p);
end;


procedure SetDirection(var p: Point; dx, dy: integer);
begin
	p.d.x := dx;
	p.d.y := dy;
end;


procedure MoveClockwise(var p: Point; f: Field);
var
	toRight, down, toLeft, up: boolean;
begin
	toRight := Equal(p.cur, f.topLeft)
		or ((p.cur.x >= f.topLeft.x) and (p.cur.x < f.topRight.x)
			and (p.cur.y = f.topLeft.y));

	down := Equal(p.cur, f.topRight)
		or ((p.cur.y > f.topRight.y) and (p.cur.y < f.bottomRight.y)
			and (p.cur.x = f.topRight.x));

	toLeft := Equal(p.cur, f.bottomRight)
		or ((p.cur.x > f.bottomLeft.x) and (p.cur.x < f.bottomRight.x)
			and (p.cur.y = f.bottomRight.y));

	up := Equal(p.cur, f.bottomLeft)
		or ((p.cur.y > f.topLeft.y) and (p.cur.y < f.bottomLeft.y)
			and (p.cur.x = f.bottomLeft.x));

	if toRight then
		SetDirection(p, 1, 0)
	else
	if down then
		SetDirection(p, 0, 1)
	else
	if toLeft then
		SetDirection(p, -1, 0)
	else
	if up then
		SetDirection(p, 0, -1)	

end;


procedure MakeFieldCoordinates(var f: Field);
var
	centerX, centerY, halfSize: integer;
begin
	centerX := ScreenWidth div 2;
	centerY := ScreenHeight div 2;
	halfSize := SquareSize div 2;

	f.topLeft.x := centerX - halfSize;
	f.topLeft.y := centerY - halfSize;

	f.topRight.x := centerX + halfSize - 1;
	f.topRight.y := centerY - halfSize;

	f.bottomLeft.x := centerX - halfSize;
	f.bottomLeft.y := centerY + halfSize;

	f.bottomRight.x := centerX + halfSize;
	f.bottomRight.y := centerY + halfSize - 1;

	writeln('centerX: ', centerX, ' centerY: ', centerY, ' halfSize: ', halfSize);
	writeln('topLeft: ', f.topLeft.x, ':', f.topLeft.y);
	writeln('topRight: ', f.topRight.x, ':', f.topRight.y);

	writeln('dif left-right: ', f.topRight.x - f.topLeft.x);
	writeln('dif top-bottom: ', f.bottomRight.y - f.topRight.y);

end;


procedure DrawField(f: Field);
var
	i, j: integer;
begin
	for i := 0 to SquareSize - 1 do
		for j := 0 to SquareSize - 1 do
			begin
				GotoXY(f.topLeft.x + i, f.topLeft.y + j);
				write('*')
			end;
	GotoXY(1, 1)
end;


{ Main }

var
	f: Field;
	p: Point;

begin
	if (ScreenWidth < MaxScreenSize) or (ScreenHeight < MaxScreenSize) then
		halt(1);
	
	clrscr;

	MakeFieldCoordinates(f);
	DrawField(f);

	p.cur.x := f.topLeft.x;
	p.cur.y := f.topLeft.y;
	p.d.x := 0;
	p.d.y := 0;

	ShowPoint(true, p);

	while true do
	begin
		if KeyPressed then
			break;

		MovePoint(p, f);
		delay(DelayDuration);

		MoveClockwise(p, f);
	end;

	clrscr
end.
