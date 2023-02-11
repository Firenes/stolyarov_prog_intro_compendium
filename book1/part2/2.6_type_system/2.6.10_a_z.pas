program a_z; { 2.6.10_a_z.pas }

var
	s: string;
	c: char;

begin
	s := '';
	for c := 'A' to 'Z' do
		s := s + c;
	writeln(s)
end.
