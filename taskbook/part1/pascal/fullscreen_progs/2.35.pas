program RandomStarMove3; { 2.35.pas }

uses crt;

{ Constants }

const
	DelayDuration = 100; { 0.1 sec }
	MaxMoves = 10;
	Directions = 4;


{ Types }

type
	Star = record
		CurX, CurY, dx, dy: integer;
	end;
	Direction = (DUp = 1, DDown, DLeft, DRight);


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


procedure ShowStar(show: boolean; s: star);
begin
	GotoXY(s.CurX, s.CurY);
	if show then
		write('*')
	else
		write(' ');
	GotoXY(1, 1);
end;


procedure MoveStar(var s: Star);
begin
	ShowStar(false, s);

	s.CurX := s.CurX + s.dx;
	if s.CurX > ScreenWidth then
		s.CurX := 1
	else
	if s.CurX < 1 then
		s.CurX := ScreenWidth;

	s.CurY := s.CurY + s.dy;
	if s.CurY > ScreenHeight then
		s.CurY := 1
	else
	if s.CurY < 1 then
		s.CurY := ScreenHeight;

	ShowStar(true, s)
end;


procedure SetDirection(var s: Star; dx, dy: integer);
begin
	s.dx := dx;
	s.dy := dy
end;


procedure SetRandomDirectionIfNeeded(var s: Star;
									 var moves, dir: integer; isManualDir: boolean);
var
	isPrevV, isCurV: boolean;
begin
	if moves = 0 then
	begin
		moves := random(MaxMoves) + 1;
		if not isManualDir then
		begin
			if dir = 0 then
				dir := random(Directions) + 1
			else
			begin
				isPrevV := (dir = ord(Direction.Dup)) or (dir = ord(Direction.DDown));
				repeat
					dir := random(Directions) + 1;
					isCurV := (dir = ord(Direction.Dup)) or (dir = ord(Direction.DDown))
				until isPrevV <> isCurV;
			end
		end
	end;


	case dir of
		ord(Direction.DUp): SetDirection(s, 0, -1); { Up }
		ord(Direction.DDown): SetDirection(s, 0, 1); { Down }
		ord(Direction.DLeft): SetDirection(s, -1, 0); { Left }
		ord(Direction.DRight): SetDirection(s, 1, 0); { Right }
		else
			exit
	end
end;


{ Main }

var
	key: integer;
	s: Star;
	currDir, moves: integer;
	isManualDir: boolean;
begin
	clrscr;

	s.CurX := ScreenWidth div 2;
	s.CurY := Screenheight div 2;
	s.dx := 0;
	s.dy := 0;

	moves := 0;
	currDir := 0;
	isManualDir := false;

	ShowStar(true, s);

	while true do
	begin
		if not KeyPressed then
		begin
			SetRandomDirectionIfNeeded(s, moves, currDir, isManualDir);
			MoveStar(s);
			moves := moves - 1;
			if moves = 0 then
				isManualDir := false;
			delay(DelayDuration);
			continue
		end;

		GetKey(key);

		if (key = -77) or (key = -75) or (key = -72) or (key = -80) then
		begin
			moves := 0;
			isManualDir := true;
		end;

		case key of
			-75: currDir := ord(Direction.DLeft); { Left }
			-77: currDir := ord(Direction.DRight); { Right }
			-72: currDir := ord(Direction.DUp); { Up }
			-80: currDir := ord(Direction.DDown); { Down }
			27: break; { Esc }
		end;
	end;

	clrscr
end.
