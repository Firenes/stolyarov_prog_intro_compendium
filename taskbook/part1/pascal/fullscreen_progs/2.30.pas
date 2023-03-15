program GrowingSquare; { 2.30.pas }

uses crt;

{ Constants }

const
	LeftArrowKey = -75;
	RightArrowKey = -77;
	UpArrowKey = -72;
	DownArrowKey = -80;
	EscKey = 27;

	BaseSize = 3;


{ Types }

type
	Coordinates = record
		x, y: integer
	end;
	Field = record
		left, right, top, bottom: Coordinates;
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

	f.top.x := centerX;
	f.top.y := centerY - halfSize;

	f.right.x := centerX + halfSize;
	f.right.y := centerY;
	
	f.left.x := centerX - halfSize;
	f.left.y := centerY;

	f.bottom.x := centerX;
	f.bottom.y := centerY + halfSize
end;


procedure ShowVLine(show: boolean; x, y: integer);
var
	i: integer;
begin
	for i := 0 to BaseSize - 1 do
	begin
		GotoXY(x + i, y);
		if show then
			write('*')
		else
			write(' ')
	end;
	GotoXY(1, 1)
end;


procedure ShowHLine(show: boolean; x, y: integer);
var
	i, j: integer;
begin
	for i := 0 to BaseSize - 1 do
		for j := 0 to 1 do
		begin
			GotoXY(x, y + i);
			if show then
				write('*')
			else
				write(' ')
		end;
	GotoXY(1, 1)
end;


procedure DrawField(f: Field);
var
	i, j: integer;
begin
	for i := 0 to BaseSize - 1 do
		for j := 0 to BaseSize - 1 do
		begin
			GotoXY(f.top.x - (BaseSize div 2) + i, f.top.y + j);
			write('*')
		end;
	GotoXY(1, 1)
end;


procedure CheckBorders(var modifiedF: Field; baseF: Field);
begin
	if modifiedF.left.x < 1 then
		modifiedF.left.x := 1
	else
	if modifiedF.left.x > baseF.left.x then
		modifiedF.left.x := baseF.left.x;

	if modifiedF.right.x > ScreenWidth then
		modifiedF.right.x := ScreenWidth
	else
	if modifiedF.right.x < baseF.right.x then
		modifiedF.right.x := baseF.right.x;

	if modifiedF.top.y < 1 then
		modifiedF.top.y := 1
	else
	if modifiedF.top.y > baseF.top.y then
		modifiedF.top.y := baseF.top.y;

	if modifiedF.bottom.y > ScreenHeight then
		modifiedF.bottom.y := ScreenHeight
	else
	if modifiedF.bottom.y < baseF.bottom.y then
		modifiedF.bottom.y := baseF.bottom.y
end;


procedure MoveField(var modifiedF: Field; baseF: Field; dx, dy: integer);
var
	show: boolean;
begin
	show := (dx > 0) or (dy > 0);

	modifiedF.left.x := modifiedF.left.x - dx;
	modifiedF.right.x := modifiedF.right.x + dx;

	modifiedF.top.y := modifiedF.top.y - dy;
	modifiedF.bottom.y := modifiedF.bottom.y + dy;

	CheckBorders(modifiedF, baseF);

	if dx <> 0 then
	begin
		if dx < 1 then
		begin
			ShowHLine(show, modifiedF.left.x - 1, baseF.top.y);
			ShowHLine(show, modifiedF.right.x + 1, baseF.top.y);
		end
		else
		begin
			ShowHLine(show, modifiedF.left.x, baseF.top.y);
			ShowHLine(show, modifiedF.right.x, baseF.top.y);
		end
	end;

	if dy <> 0 then
	begin
		if dy < 1 then
		begin
			ShowVLine(show, baseF.left.x, modifiedF.top.y - 1);
			ShowVLine(show, baseF.left.x, modifiedF.bottom.y + 1);
		end
		else
		begin
			ShowVLine(show, baseF.left.x, modifiedF.top.y);
			ShowVLine(show, baseF.left.x, modifiedF.bottom.y);
		end
	end;
end;


{ Main }

var
	key: integer;
	baseF, modifiedF: Field;
begin
	clrscr;
	
	MakeFieldCoordinates(baseF);
	DrawField(baseF);

	modifiedF := baseF;

	while true do
	begin
		GetKey(key);

		case key of
			LeftArrowKey: MoveField(modifiedF, baseF, -1, 0);
			RightArrowKey: MoveField(modifiedF, baseF, 1, 0);
			UpArrowKey: MoveField(modifiedF, baseF, 0, 1);
			DownArrowKey: MoveField(modifiedF, baseF, 0, -1);
			EscKey, ord(' '): break;
		end
	end;

	clrscr
end.
