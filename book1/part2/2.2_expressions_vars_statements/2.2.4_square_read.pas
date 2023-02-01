program square_read;

var
	//x: integer;
	//x: longint;
	x: qword;
begin
	// Оператор ввода. Тут происходит ввод из стандартного потока ввода
	read(x);
	x := x * x;
	writeln(x)
end.
