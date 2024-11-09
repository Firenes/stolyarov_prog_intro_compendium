program BinaryTreeExample; { 2.11.5_binary_tree_example.pas }

{ Types }

type
	TreeNodePtr = ^TreeNode;
	TreeNode = record
		data: longint;
		left, right: TreeNodePtr;
	end;
	TreeNodePos = ^TreeNodePtr;


{ Functions }

function SumTree(p: TreeNodePtr): longint;
begin
	if p = nil then
		{ Изначальная сумма без нодов }
		SumTree := 0
	else
		{
			Рекурсивное сложение стороны нод
			Складываются все ноды левой от рута
			Добавление текущей
			Складываются все ноды правой от рута
		}
		SumTree := SumTree(p^.left) + p^.data + SumTree(p^.right)
end;


{ Procedures }

procedure AddToTree(var p: TreeNodePtr; val: longint;
					var ok: boolean);
begin
	if p = nil then
	begin
		{ Создание нод, если текущей нет }
		new(p);
		p^.data := val;
		p^.left := nil;
		p^.right := nil;
		{ true, если нода успешно создалась }
		ok := true
	end
	else
	{ Если значение меньше текущего, добавляется слева }
	if val < p^.data then
		AddToTree(p^.left, val, ok)
	else
	{ Если значение больше текущего, добавляется справа }
	if val > p^.data then
		AddToTree(p^.right, val, ok)
	else
		{
			false, если число равно значению ноды,
			это крайний сценарий, в данном примере не обрабатывается
		}
		ok := false
end;

procedure IsInTree(p: TreeNodePtr; val: longint;
				   var res: boolean);
begin
	if p = nil then
		res := false
	else
	if val < p^.data then
		IsInTree(p^.left, val, res)
	else
	if val > p^.data then
		IsInTree(p^.right, val, res)
	else
		res := false
end;


{ Refactoring }

{ Functions }

function SearchTree(var p: TreeNodePtr; val: longint): TreeNodePos;
begin
	{
		Возвращается адрес текущей ноды,
		если число должно находиться в это ноде (пустая) или
		если число равно той, что в ноде
	}
	if (p = nil) or (p^.data = val) then
		SearchTree := @p
	else
	{ Возвращение адреса левой ноды, если значение меньше в текущей }
	if val < p^.data then
		SearchTree := SearchTree(p^.left, val)
	else
	{ Возвращение адреса правой ноды, если значение больше в текущей }
		SearchTree := SearchTree(p^.right, val)
end;

function IsInTreeRef(p: TreeNodePtr; val: longint): boolean;
begin
	IsInTreeRef := SearchTree(p, val)^ <> nil
end;


{ Procedures }

procedure AddToTreeRef(var p: TreeNodePtr; val: longint;
					   var ok: boolean);
var
	pos: TreeNodePos;
begin
	{ Поиск адреса ноды по значению }
	pos := SearchTree(p, val);
	{ Создание ноды, если по адресу пусто }
	if pos^ = nil then
	begin
		new(pos^);
		pos^^.data := val;
		pos^^.left := nil;
		pos^^.right := nil;
		{ true, если нода успешно создалась true }
		ok := true
	end
	else
		{
			false, т.к. значение в ноде равно добавляемому значению.
			Крайний сценарий, не обрабатывается.
		}
		ok := false
end;

{ Main }

var
	root: TreeNodePtr;
begin

end.
