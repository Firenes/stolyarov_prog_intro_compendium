program RandomStarMove5; { 2.37.pas }

uses crt;

{ Constants }

const
	DelayDuration = 100; { 0.1 sec }
	MaxMoves = 10;
	Directions = 4;
	MovesDelay = 10;
	BaseSize = 3;


{ Types }

type
	Star = record
		CurX, CurY, dx, dy: integer;
	end;
	Direction = (DUp = 1, DDown, DLeft, DRight);
	Coordinates = record
		x, y: integer
	end;
	Field = record
		topLeft, topRight, bottomLeft, bottomRight: Coordinates;
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


procedure MakeFieldCoordinates(var f: Field);
var
	centerX, centerY, halfSize: integer;
begin
	centerX := ScreenWidth div 2;
	centerY := ScreenHeight div 2;
	halfSize := BaseSize div 2;

	f.topLeft.x := centerX - halfSize;
	f.topLeft.y := centerY - halfSize;

	f.topRight.x := centerX + halfSize - 1;
	f.topRight.y := centerY - halfSize;

	f.bottomLeft.x := centerX - halfSize;
	f.bottomLeft.y := centerY + halfSize;

	f.bottomRight.x := centerX + halfSize;
	f.bottomRight.y := centerY + halfSize - 1;
end;


procedure DrawField(f: Field);
var
	i, j: integer;
begin
	for i := 0 to BaseSize - 1 do
		for j := 0 to BaseSize - 1 do
			begin
				GotoXY(f.topLeft.x + i, f.topLeft.y + j);
				write('@')
			end;
	GotoXY(1, 1)
end;


procedure CheckStarInField(s: Star; f: Field; var complete: boolean);
begin
	if (s.CurX >= f.topLeft.x) and (s.CurX <= f.topRight.x)
		and (s.CurY = f.topLeft.y) then
		complete := true
	else
	if (s.CurY >= f.topRight.y) and (s.CurY <= f.bottomRight.y)
		and (s.CurX = f.topRight.x) then
		complete := true
	else
	if (s.CurX >= f.bottomLeft.x) and (s.CurX <= f.bottomRight.x)
		and (s.CurY = f.bottomRight.y) then
		complete := true
	else
	if (s.CurY >= f.topLeft.y) and (s.CurY <= f.bottomLeft.y)
		and (s.CurX = f.bottomLeft.x) then
		complete := true
	else
		complete := false
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
				dir := ord(Direction.DRight)
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


procedure HandleDirection(key: integer; var dir: integer; var esc: boolean);
begin
	case key of
		-75: dir := ord(Direction.DLeft); { Left }
		-77: dir := ord(Direction.DRight); { Right }
		-72: dir := ord(Direction.DUp); { Up }
		-80: dir := ord(Direction.DDown); { Down }
		27: esc := true; { Esc }
	end
end;

procedure CompleteWinGame;
var
	winMsg: string;
begin
	winMsg := 'YOU WIN';
	
	clrscr;
	GotoXY(ScreenWidth div 2 - length(winMsg) div 2, ScreenHeight div 2);	
	write(winMsg);
	GotoXY(1, 1);

	while not KeyPressed do
		if KeyPressed then
			break
end;


{ Main }

var
	key: integer;
	f: Field;
	s: Star;
	currDir, moves: integer;
	isManualDir: boolean;
	nextDir, delayMoves: integer;
	esc, isComplete: boolean;
begin
	clrscr;

	MakeFieldCoordinates(f);
	DrawField(f);

	s.CurX := 1;
	s.CurY := 1;
	s.dx := 0;
	s.dy := 0;

	moves := 0;
	currDir := 0;
	isManualDir := false;
	nextDir := 0;
	delayMoves := 0;
	esc := false;

	ShowStar(true, s);

	while true do
	begin
		if not KeyPressed then
		begin
			if (nextDir <> 0) and (delayMoves = 0) then
			begin
				currDir := nextDir;
				isManualDir := true;
				moves := 0;
				nextDir := 0
			end;

			SetRandomDirectionIfNeeded(s, moves, currDir, isManualDir);
			MoveStar(s);
			moves := moves - 1;
			if delayMoves <> 0 then
				delayMoves := delayMoves - 1;
			if moves = 0 then
				isManualDir := false;

			CheckStarInField(s, f, isComplete);
			if isComplete then
				break;

			delay(DelayDuration);
			continue
		end;

		GetKey(key);

		if (key = -77) or (key = -75) or (key = -72) or (key = -80) then
		begin
			if delayMoves <> 0 then
			begin
				HandleDirection(key, nextDir, esc);
				continue
			end;
			moves := 0;
			isManualDir := true;
			if delayMoves = 0 then
				delayMoves := MovesDelay;
		end;
		HandleDirection(key, currDir, esc);
		if esc then
			break;
	end;

	if isComplete then
		CompleteWinGame;

	clrscr
end.
