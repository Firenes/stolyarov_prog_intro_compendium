program ColorSquare; { 2.32.pas }

uses crt;

{ Constants }

const
	BaseSize = 5;
	ColorCount = 16;


{ Types }

type
	Coordinates = record
		x, y: integer
	end;
	Field = record
		left, right, top, bottom: Coordinates;
	end;


{ Arrays }

var
	AllColors: array [1..ColorCount] of word =
	(
		Black, Blue, Green, Cyan,
		Red, Magenta, Brown, LightGray,
		DarkGray, LightBlue, LightGreen, LightCyan,
		LightRed, LightMagenta, Yellow, White
	);


{ Procedures }

procedure ClearColorScreen;
begin
	write(#27'[0m')
end;


procedure CheckCurrentColor(var currColor: integer);
begin
	if currColor > ColorCount then
		currColor := 1;
	
	if currColor < 1 then
		currColor := ColorCount
end;


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


procedure DrawField(f: Field; var currColor: integer; dColor: integer);
var
	i, j: integer;
begin
	ClearColorScreen;

	currColor := currColor + dColor;

	CheckCurrentColor(currColor);

	for i := 0 to BaseSize - 1 do
		for j := 0 to BaseSize - 1 do
		begin
			GotoXY(f.top.x - (BaseSize div 2) + i, f.top.y + j);
			TextColor(AllColors[currColor]);
			write('*');
		end;
	GotoXY(1, 1)
end;


{ Main }

var
	key: integer;
	f: Field;
	currColor: integer;
begin
	clrscr;

	currColor := 0;
	
	MakeFieldCoordinates(f);
	DrawField(f, currColor, 0);

	ClearColorScreen;

	while true do
	begin
		GetKey(key);
		case key of
			 27: break; { ESC }
			-75: DrawField(f, currColor, -1); { Left }
			-77: DrawField(f, currColor, 1); { Right }
		end
	end;

	ClearColorScreen;

	clrscr;
end.
