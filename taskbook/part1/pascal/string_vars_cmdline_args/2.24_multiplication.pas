program Multiplication; { 2.24_multiplication.pas }

{ Procedures }

procedure InvalidArgumentsAssert;
begin
	writeln('Invalid arguments. Need real and integer numbers');
	halt(1)
end;


procedure FailedCastRealAssert;
begin
	writeln('Failed to cast string to real');
	halt(2)
end;


procedure FailedCastIntegerAssert;
begin
	writeln('Failed to cast string to integer');
	halt(2)
end;


procedure CheckArguments(var realArg, integerArg: string);
var
	i: integer;
	isReal, isInteger: boolean;
begin
	if (ParamCount < 1) or (ParamCount > 2) then
		InvalidArgumentsAssert;

	realArg := ParamStr(1);
	integerArg := ParamStr(2);
	isReal := false;
	isInteger := true;

	for i := 1 to length(realArg) do
	begin
		if (realArg[i] = '.') or (realArg[i] = ',') then
			isReal := true
	end;

	for i := 1 to length(integerArg) do
	begin
		if (integerArg[i] < '0') or (integerArg[i] > '9') then
			isInteger := false
	end;

	if not isReal or not isInteger then
		InvalidArgumentsAssert;
end;


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
			FailedCastRealAssert;
		
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


{ Main }

var
	realArg, integerArg: string;
	realNum: real;
	integerNum: integer;
	res: real;
	resStr: string;
	err: word;
begin
	CheckArguments(realArg, integerArg);	

	ConvertStrToReal(realArg, realNum);
	
	val(integerArg, integerNum, err);
	if err <> 0 then
		FailedCastIntegerAssert;

	res := realNum * real(integerNum);
	FormatResult(res, integerNum, resStr);

	writeln(resStr);
end.
