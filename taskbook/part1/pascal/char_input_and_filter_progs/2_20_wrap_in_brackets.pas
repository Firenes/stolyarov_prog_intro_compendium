program WrapInRoundBrackets; { 2_20_wrap_in_brackets.pas }

{ Constants }

const
	LEFT_BRACKET = '(';
	RIGHT_BRACKET = ')';


{ Functions }

function isCharSpacing(ch: char): boolean;
begin
	isCharSpacing := (ch = #10) or (ch = ' ') or (ch = #13);
end;

{ Procedures }

procedure PrintChar(ch, leftBracket, rightBracket: char; var known, print: boolean);
begin
	if isCharSpacing(ch) then
 	begin
 		if known and print then
			write(rightBracket);

 		known := false;
		{ For printing spaces }
		write(ch);
	end
 	else
 	begin
 		if not known then
 		begin
 			print := (ch <> ' ') and (ch <> #9);
			known := true;
			write(leftBracket);
		end;

		if print then
			write(ch)
	end
end;

{ Main }
var
	ch: char;
	known, print: boolean;

begin
	known := false;
	print := false;

	while not eof do
	begin
		read(ch);
		PrintChar(ch, LEFT_BRACKET, RIGHT_BRACKET, known, print)
	end
end.

