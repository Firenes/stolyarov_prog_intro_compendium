program bool_expr; { 2.2.9_bool_expr.pas }

// > –– больше
// < –– меньше
// = –– равно
// <> –– не равно
// >= –– больше или равно
// <= –– меньше или равно

// not –– отрицание
// and –– и, конъюнкция
// or –– или, дизъюнкция
// xor –– исключающая или

var
	x: integer;
	negative: boolean;

begin
	read(x);
	negative := x < 0;

	if negative then
		x := -x;
	writeln(x)
end.
