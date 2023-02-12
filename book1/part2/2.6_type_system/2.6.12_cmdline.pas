program cmdline; { 2_6_12_cmdline.pas }

var
	i: integer;

begin
	for i := 0 to ParamCount do
		writeln('[', i, ']: ', ParamStr(i))
end.
