program StarV1; { 2.26.pas }

uses crt;

{ Constants }

const
	DelayDuration = 100; { 0.1 sec }

{ Types }

type
	Star = record
		CurX, CurY, dx: integer;
	end;

{ Procedures }

procedure ShowStar(show: boolean; var s: Star);
begin
	GotoXY(s.CurX, s.CurY);
	if show then
		write('*')
	else
		write(' ');
	GotoXY(1, 1)
end;


procedure MoveStar(var s: Star; var count: integer);
begin
	ShowStar(false, s);

	s.CurX := s.CurX + s.dx;
	if s.CurX > ScreenWidth then
	begin
		s.CurX := ScreenWidth - 1;
		count := count + 1;
	end
	else
	if s.CurX < 1 then
	begin
		s.CurX := 2;
		count := count + 1;
	end;
	
	ShowStar(true, s);
end;


procedure SetDirection(var s: Star; dx: integer);
begin
	s.dx := dx;
end;

{ Main }

var
	s: Star;
	count: integer;

begin
	clrscr;

	s.CurX := ScreenWidth div 2;
	s.CurY := ScreenHeight div 2;
	s.dx := 0;
	count := 0;

	ShowStar(true, s);

	while true do
	begin
		if KeyPressed then
			break;
		MoveStar(s, count);
		delay(DelayDuration);

		if count mod 2 = 0 then
			SetDirection(s, 1) { right }
		else
			SetDirection(s, -1) { left }
	end;

	clrscr
end.
