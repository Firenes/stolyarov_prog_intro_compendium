program hanoi; { 2.11.2_hanoi.pas }

{ Procedures }

{
	source – номер исходного стержня;
	target – номер целевого стержня;
	transit – номер промежуточного стержня;
	n – количество дисков.
}
procedure solve(source, target, transit, n: integer);
begin
	if n = 0 then
		exit;

	solve(source, target, transit, n - 1);
	writeln(n, ': ', source, ' -> ', target);
	solve(transit, target, source, n - 1)
end;

{ Main }

var
	n, code: integer;
begin
	if ParamCount < 1 then
	begin
		writeln(ErrOutput, 'No parameters given');
		halt(1)
	end;

	val(ParamStr(1), n, code);	

	if (code <> 0) or (n < 1) then
	begin
		writeln(ErrOutput, 'Invalud token count');
		halt(1)
	end;

	solve(1, 3, 2, n)
end.
