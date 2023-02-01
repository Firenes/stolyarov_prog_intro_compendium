program function_boolean;

{ Functions }

function IsLatinLetter(ch: char): boolean;
begin
	IsLatinLetter :=
		((ch >= 'A') and (ch <= 'Z')) or
		((ch >= 'a') and (ch <= 'z'))
end;

{ Main part }

var
	ch: char;

begin
	writeln('Check is character is latin: ');
	readln(ch);
	writeln('Your char ''', ch, ''' is latin: ', IsLatinLetter(ch))
end.
