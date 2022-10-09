program convert_to_binary;

var
	input, res: longint;


function convert_to_binary(number: longint): longint;
var
	result, temp: longint;

begin
	temp := number;
	result := 0;

	while temp > 0 do
	begin
		if (temp and 1) = 1 then
			result := result + 1;
		temp := temp shr 1;
	end;

	convert_to_binary := result;
end;


begin
	write('Введите число для конвертации в двоичное значение: ');
	readln(input);

	res := convert_to_binary(input);
	writeln(res);
end.
