#!/bin/sh

# $0, $1, $2, $2, ... not arguments of command line but parameters' values that was programm called
# $# –– count of parameters' values


echo "My name is " $0
echo "I've got " $# " parameters"
echo "Here are the first three of them, in reverse order:"

# Пустой параметр нужен, чтобы не повлиять на работу echo
# Иначе без пустого параметра нужно было бы вводить обработать опцию с "-"
echo "" "$3 $2 $1"
