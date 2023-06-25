program Deque; { 2.10.7_deque.pas }

{ WIP }

{ Types }

type
    LongItem2Ptr = ^LongItem2;
    LongItem2 = record
        data: longint;
        prev, next: LongItem2Ptr;
    end;

    LongDeque = record
        first, last: LongItem2Ptr;
    end;


{ Interfaces }

procedure LongDequeInit(var deque: LongDeque);
begin
	deque.first = nil;
	deque.last = nil
end;

procedure LongDequePushFront(var deque: LongDeque; n: longint);
begin
end;

procedure LongDequePushBack(var deque: LongDeque; n: longint);
begin
end;

procedure LongDequePopFront(var deque: LongDeque; var n: longint);
begin
end;

procedure LongDequePopBack(var deque: LongDeque; var n: longint);
begin
end;

procedure LongDequeIsEmpty(var deque: LongDeque): boolean;
begin
	LongDequeIsEmpty := deque.first = nil
end;
