program StarColorSquareControl; { 2.29.pas }

uses crt;

{ Constants }

const
	SquareSize = 10;
	MaxScreenSize = 12;
	ColorCount = 16;

var
	AllColors: array [1..ColorCount] of word =
	(
		Black, Blue, Green, Cyan,
		Red, Magenta, Brown, LightGray,
		DarkGray, LightBlue, LightGreen, LightCyan,
		LightRed, LightMagenta, Yellow, White
	);

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
	Direction = (DirToRight, DirDown, DirToLeft, DirUp);


{ Functions }

function Equal(c1, c2: Coordinates): boolean;
begin
	Equal := (c1.x = c2.x) and (c1.y = c2.y)
end;


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


procedure ClearColorScreen;
begin
	write(#27'[0m')
end;


procedure CountCurrentCount(var curColor: integer);
begin
	curColor := curColor + 1;
	if curColor > ColorCount then
		curColor := 1
end;


procedure ChangeDelay(var duration: integer; incr: integer);
begin
	if (duration > 100) or (duration < 400) then
		duration := duration + incr
end;


procedure ShowPoint(show: boolean; var p: Point; currColor: integer);
begin
	GotoXY(p.cur.x, p.cur.y);
	ClearColorScreen;
	if show then
	begin
		TextColor(currColor);
		write('#')
	end
	else
		write('*');
	GotoXY(1, 1)
end;


procedure MovePoint(var p: Point; f: Field; currColor: integer);
begin
	ShowPoint(false, p, currColor);

	p.cur.x := p.cur.x + p.d.x;
	p.cur.y := p.cur.y + p.d.y;

	ShowPoint(true, p, currColor);
end;


procedure SetDirection(var p: Point; dx, dy: integer);
begin
	p.d.x := dx;
	p.d.y := dy;
end;


procedure SetDirectionByClockwise(var p: Point; dir: Direction);
begin
	case dir of
	DirToRight: SetDirection(p, 1, 0);
	   DirDown: SetDirection(p, 0, 1);
	 DirToLeft: SetDirection(p, -1, 0);
	     DirUp: SetDirection(p, 0, -1);
	end
end;


procedure MoveClockwise(var p: Point; f: Field);
var
	dir: Direction;
begin
	if Equal(p.cur, f.topLeft)
		or ((p.cur.x >= f.topLeft.x) and (p.cur.x < f.topRight.x)
			and (p.cur.y = f.topLeft.y)) then
		dir := DirToRight;

	if Equal(p.cur, f.topRight)
		or ((p.cur.y > f.topRight.y) and (p.cur.y < f.bottomRight.y)
			and (p.cur.x = f.topRight.x)) then
		dir := DirDown;

	if Equal(p.cur, f.bottomRight)
		or ((p.cur.x > f.bottomLeft.x) and (p.cur.x < f.bottomRight.x)
			and (p.cur.y = f.bottomRight.y)) then
		dir := DirToLeft;

	if Equal(p.cur, f.bottomLeft)
		or ((p.cur.y > f.topLeft.y) and (p.cur.y < f.bottomLeft.y)
			and (p.cur.x = f.bottomLeft.x)) then
		dir := DirUp;

	SetDirectionByClockWise(p, dir)
end;


procedure MoveCounterClockwise(var p: Point; f: Field);
var
	dir: Direction;
begin
	if Equal(p.cur, f.topRight)
		or ((p.cur.x >= f.topLeft.x) and (p.cur.x < f.topRight.x)
			and (p.cur.y = f.topLeft.y)) then
		dir := DirToLeft;

	if Equal(p.cur, f.bottomRight)
		or ((p.cur.y > f.topRight.y) and (p.cur.y < f.bottomRight.y)
			and (p.cur.x = f.topRight.x)) then
		dir := DirUp;

	if Equal(p.cur, f.bottomLeft)
		or ((p.cur.x > f.bottomLeft.x) and (p.cur.x < f.bottomRight.x)
			and (p.cur.y = f.bottomRight.y)) then
		dir := DirToRight;

	if Equal(p.cur, f.topLeft)
		or ((p.cur.y > f.topLeft.y) and (p.cur.y < f.bottomLeft.y)
			and (p.cur.x = f.bottomLeft.x)) then
		dir := DirDown;

	SetDirectionByClockWise(p, dir)
end;


procedure MakeFieldCoordinates(isClockwise: boolean; var f: Field);
var
	centerX, centerY, halfSize: integer;
begin
	centerX := ScreenWidth div 2;
	centerY := ScreenHeight div 2;
	halfSize := SquareSize div 2;

	f.topLeft.x := centerX - halfSize;
	f.topLeft.y := centerY - halfSize;

	if isClockwise then
	begin
		f.topRight.x := centerX + halfSize - 1;
		f.topRight.y := centerY - halfSize;

		f.bottomLeft.x := centerX - halfSize;
		f.bottomLeft.y := centerY + halfSize;

		f.bottomRight.x := centerX + halfSize;
		f.bottomRight.y := centerY + halfSize - 1;
	end
	else
	begin
		f.topRight.x := centerX + halfSize;
		f.topRight.y := centerY - halfSize;

		f.bottomLeft.x := centerX - halfSize;
		f.bottomLeft.y := centerY + halfSize - 1;

		f.bottomRight.x := centerX + halfSize - 1;
		f.bottomRight.y := centerY + halfSize - 1;
	end
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
	key: integer;
	isClockwise: boolean;
	delayDuration: integer;
	currColor: integer;

begin
	if (ScreenWidth < MaxScreenSize) or (ScreenHeight < MaxScreenSize) then
		halt(1);
	
	clrscr;
	
	isClockwise := true;
	delayDuration := 100;

	currColor := 1;

	MakeFieldCoordinates(isClockwise, f);
	DrawField(f);

	p.cur.x := f.topLeft.x;
	p.cur.y := f.topLeft.y;
	p.d.x := 0;
	p.d.y := 0;

	ShowPoint(true, p, AllColors[currColor]);

	while true do
	begin
		if not KeyPressed then
		begin
			MovePoint(p, f, AllColors[currColor]);
			delay(DelayDuration);

			MakeFieldCoordinates(isClockwise, f);

			if isClockwise then
				MoveClockwise(p, f)
			else
				MoveCounterClockwise(p, f);

			CountCurrentCount(currColor);

			continue
		end;

		GetKey(key);
		case key of
			ord(' '): isClockwise := not isClockwise;
			27: break; { ESC }
			-75: ChangeDelay(delayDuration, 10); { Left }
			-77: ChangeDelay(delayDuration, -10); { Right }
		end
	
	end;

	ClearColorScreen;
	clrscr
end.
