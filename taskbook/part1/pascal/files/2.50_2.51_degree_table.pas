program DegreeTable; { 2.50_degree_table }

uses math;

{ Constants }

const
	stepTitle = 'step';
	sinTitle = 'sin';
	cosTitle = 'cos';
	tgTitle = 'tg';
	ctgTitle = 'ctg';
	minWidth = 3;
	columnCount = 5;

type
	Rows = Array [1..columnCount] of string;


{ Functions }

function RadianCount(angle: real): real;
begin
	RadianCount := angle * pi / 180.0
end;


{ Procedures }

procedure ConvertStrToReal(realArg: String; var realNum: real);
var
	i: integer;
	intPart, temp: integer;
	fraction: real;
	isFractionPart: boolean;
	res: word;
begin
	isFractionPart := false;
	intPart := 0;
	fraction := 0.0;
	for i := 1 to length(realArg) do
	begin
		if (realArg[i] = '.') or (realArg[i] = ',') then
		begin
			isFractionPart := true;
			continue
		end;

		val(realArg[i], temp, res);
		if res <> 0 then
		begin
			writeln('Failed to cast number');
			halt(1);
		end;
		
		if isFractionPart then
			fraction := fraction / 10 + temp / 10
		else
			intPart := intPart * 10 + temp;
	end;
	realNum := real(intPart) + fraction
end;


procedure FormatResult(res: real; maxFracture: integer; var resStr: string);
var
    temp: string;
    i, cutIndex: integer;
    hasFracture: boolean;
begin
    str(res:0:maxFracture, temp);
    hasFracture := false;
    cutIndex := 0;
    for i := 1 to length(temp) do
    begin
        if (temp[i] = '.') or (temp[i] = ',') then
            cutIndex := i;
        if (cutIndex > 0) and (i > cutIndex) then
            if temp[i] <> '0' then
            begin
                cutIndex := i;
                hasFracture := true
            end 
    end;
    if hasFracture then
        delete(temp, cutIndex + 1, length(temp) - cutIndex)
    else
        delete(temp, cutIndex, length(temp) - cutIndex + 1); 
    resStr := temp
end;


procedure CountColumnWidth(value: real; maxFracture: integer;
						   var count: integer);
var
	resString: string;
begin
	FormatResult(value, maxFracture, resString);
	count := length(resString) + 2;
end;


procedure DrawContent(var f: text; content: Rows; columnCount, maxWidth: integer);
var
	i, j, spaceWidth: integer;
begin
	write(f, '|');
	for i := 1 to columnCount do
	begin
		write(f, ' ');
		write(f, content[i]);
		spaceWidth := maxWidth - length(content[i]) - 1; 
		for j := 0 to spaceWidth - 1 do
			write(f, ' ');
		write(f, '|')
	end;
	writeln(f);
end;


procedure DrawSeparator(var f: text; columnCount, maxWidth: integer);
var
	i, j: integer;
begin
	write(f, '|');
	for i := 0 to columnCount - 1 do
	begin
		for j := 0 to maxWidth - 1 do
			write(f, '-');
		write(f, '|')
	end;
	writeln(f);
end;


procedure DrawHeader(var f: text; columnCount, maxWidth: integer);
var
	headerTitles: Rows
		= (stepTitle, sinTitle, cosTitle, tgTitle, ctgTitle);
begin
	DrawSeparator(f, columnCount, maxWidth);	
	DrawContent(f, headerTitles, columnCount, maxWidth);
	DrawSeparator(f, columnCount, maxWidth)
end;


{ Main }

var
	startAngle, endAngle, step, currAngle: real;
	radian: real;
	err: word;
	f: text;
	fraction, maxWidth: integer;
	contentRows: Rows;
begin
	{$I-}
	if ParamCount <> 5 then
	begin
		writeln('Need enter file name, start anlge, end angle, step, fraction');
		halt(1)
	end;

	assign(f, ParamStr(1));
	rewrite(f);

	if IOResult <> 0 then
	begin
		writeln('Couldn''t open a file: ', ParamStr(1));
		halt(1)
	end;

	ConvertStrToReal(ParamStr(2), startAngle);
	ConvertStrToReal(ParamStr(3), endAngle);
	ConvertStrToReal(ParamStr(4), step);
	val(ParamStr(5), fraction, err);
	if err <> 0 then
	begin
		writeln('Failed to cast fraction');
		halt(1)
	end;

	maxWidth := fraction + 4; { + symbols: 2 spaces, integer and dot }
	DrawHeader(f, columnCount, maxWidth);

	currAngle := startAngle;

	while currAngle <= endAngle do
	begin
		radian := RadianCount(currAngle);
		FormatResult(currAngle, fraction, contentRows[1]);
		FormatResult(sin(radian), fraction, contentRows[2]);
		FormatResult(cos(radian), fraction, contentRows[3]);
		FormatResult(tan(radian), fraction, contentRows[4]);
		FormatResult(cotan(radian), fraction, contentRows[5]);

		DrawContent(f, contentRows, columnCount, maxWidth);
		currAngle += step	
	end;

	DrawSeparator(f, columnCount, maxWidth);

	close(f);
end.
