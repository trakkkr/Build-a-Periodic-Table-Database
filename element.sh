#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# ./element.sh を実行した場合、Please provide an element as an argument. のみを出力して実行を終了する必要があります。
# ./element.sh 1、./element.sh H、または ./element.sh Hydrogen を実行した場合、The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius. のみを出力する必要があります。
# 別の元素を入力して ./element.sh スクリプトを実行した場合、指定された元素に関連する情報を含む同じ形式の出力が得られる必要があります。
# element.sh スクリプトに入力された引数が、データベース内に atomic_number、symbol、または name として存在しない場合、出力は I could not find that element in the database. のみである必要があります。

#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# 引数が空
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# 引数がある
# 引数を元にDBの元素情報を検索（原子番号、記号、名前のいずれかに一致するか）
ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number::text = '$1' OR symbol = '$1' OR name = '$1';")

# データベースに見つからなかった場合
if [[ -z $ELEMENT_INFO ]]
then
  echo "I could not find that element in the database."
  exit
else
  # ここに、データが見つかった場合の処理（文字列の整形と出力）を書きます
  echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELTING BAR BOILING
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
fi