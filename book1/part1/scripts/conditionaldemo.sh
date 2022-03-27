#!/bin/sh

# Условиями в баше занимается команда "test",
# либо можно положить условие в квадратные скобки "[ условие ]"
#
# К примеру, 
# [ -f "file.txt" ] –– существует ли файл "file.txt"
# [ "$I" -lt 25 ]   -- значение перменной I меньше 25
# [ "$A" == "abc" ] –– значение перменной A равна строке "abc"
# [ "$A" != "abc" ] –– значение перменной A не равна строке "abc"

# -lt –– меньше, чем (less than)
# -le –– меньше или равен (less than or equal)
# -gt –– больше, чем (greater than)
# -ge –– больше или равен (greater than or equal)

if [ -f "file.txt" ]; then
	cat "file.txt"
else
	echo "File file.txt not found"
fi

# С test было бы так:

#if test -f "file.txt" ; then
#	cat "file.txt"
#else
#	echo "File file.txt not found"
#fi
