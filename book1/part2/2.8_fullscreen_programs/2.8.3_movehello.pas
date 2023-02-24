program MovingHello; { 2.8.3_movehello.pas }

uses crt;

const
	Message = 'Hello, world!';

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
		code := ord(c);
end;

procedure CheckBorders(var x, y: integer; msg: string);
begin
	if x > (ScreenWidth - length(msg)) then
		x := ScreenWidth - length(msg) + 1;
	if x < 1 then
		x := 1;
	if y > ScreenHeight then
		y := ScreenHeight;
	if y < 1 then
		y := 1
end;

procedure ShowMessage(x, y: integer; msg: string);
begin
	GotoXY(x, y);
	write(msg);
	GotoXY(1, 1)
end;

procedure HideMessage(x, y: integer; msg: string);
var
	len, i: integer;
begin
	len := length(msg);
	GotoXY(x, y);
	for i := 1 to len do
		write(' ');
	GotoXY(2, 1)
end;

procedure MoveMessage(var x, y: integer; msg: string; dx, dy: integer);
begin
	HideMessage(x, y, msg);
	x := x + dx;
	y := y + dy;
	CheckBorders(x, y, msg);
	ShowMessage(x, y, msg);
end;

{ Main }

var
	CurX, CurY: integer;
	c: integer;
begin
	clrscr;

	CurX := (ScreenWidth - length(Message)) div 2;
	CurY := ScreenHeight div 2;

	ShowMessage(CurX, CurY, Message);

	while true do
	begin
		GetKey(c);
		if c > 0 then { не расширенный код; выходим }
			break;
		case c of
			-75:	{ стрелка влево }
				MoveMessage(CurX, CurY, Message, -1, 0);
			-77:	{ стрелка вправо }
				MoveMessage(CurX, CurY, Message, 1, 0);
			-72:	{ стрелка вверх }
				MoveMessage(CurX, CurY, Message, 0, -1);
			-80:	{ стрелка вниз }
				MoveMessage(CurX, CurY, Message, 0, 1);
		end
	end;

	clrscr;
end.
