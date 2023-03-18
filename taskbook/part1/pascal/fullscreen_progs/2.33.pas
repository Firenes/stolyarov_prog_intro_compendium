program RandomStarMove; { 2.33.pas }

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


procedure MakeRandomDirectionIfNeeded(var s: Star;
									  var moves, dir: integer);
begin
	if moves = 0 then
	begin
		moves := random(MaxMoves) + 1;
		dir := random(Directions) + 1;
	end;

	case dir of
		1: SetDirection(s, 0, -1); { Up }
		2: SetDirection(s, 0, 1); { Down }
		3: SetDirection(s, 1, 0); { Right }
		4: SetDirection(s, -1, 0); { Left }
		else
			exit
	end
end;


{ Main }

var
	key: integer;
	s: Star;
	direction, moves: integer;
begin
	clrscr;

	s.CurX := ScreenWidth div 2;
	s.CurY := Screenheight div 2;
	s.dx := 0;
	s.dy := 0;

	moves := 0;

	ShowStar(true, s);

	while true do
	begin
		if not KeyPressed then
		begin
			MakeRandomDirectionIfNeeded(s, moves, direction);
			MoveStar(s);
			moves := moves - 1;
			delay(DelayDuration);
			continue
		end;

		GetKey(key);
		case key of
			27: break; { Esc }
		end
	end;

	clrscr
end.
