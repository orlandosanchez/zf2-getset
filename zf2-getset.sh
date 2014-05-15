#!/usr/bash

#LIST=$(grep 'public \$' $2 | sed 's/^.*\$//g' | sed 's/;//g');

LIST="${@:2}"


echo "class $1 {";
echo "";


for i in $LIST;
do
  echo "  public \$${i};";
done

echo "";

echo '  public function exchangeArray($data) {';
for i in $LIST;
do
  echo "    \$this->${i} = (\$data['${i}']) ? (\$data['${i}']) : NULL;";
done
echo '  }';

echo "";


for i in $LIST;
do
  PREFIX_PROPERTY=$(echo ${i} | sed 's/_.*$//g');
  SUFFIX_PROPERTY=$(echo ${i} | sed 's/^.*_//g');

  if [ $PREFIX_PROPERTY = $SUFFIX_PROPERTY ];
  then
    SUFFIX_PROPERTY="";
  fi

  if [ "$SUFFIX_PROPERTY" == "id" ];
  then
    echo "  public function get${PREFIX_PROPERTY^}${SUFFIX_PROPERTY^^}() {";
  else
    echo "  public function get${PREFIX_PROPERTY^}${SUFFIX_PROPERTY^}() {";
  fi 

  echo '    return $this->'${i}';';
  echo '  }';
  echo "";

  if [ "$SUFFIX_PROPERTY" == "id" ];
  then 
    echo "  public function set${PREFIX_PROPERTY^}${SUFFIX_PROPERTY^^}($"${i}") {";
  else
    echo "  public function set${PREFIX_PROPERTY^}${SUFFIX_PROPERTY^}($"${i}") {";
  fi 

  echo '    $this->'${i}' = $'${i}';';
  echo '  }';
  echo "";
done

echo "}";
