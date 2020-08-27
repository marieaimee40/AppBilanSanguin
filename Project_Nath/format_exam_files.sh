#!/bin/sh

egrep "(Mr|Mme).*[0-9]{4}/[0-9]{2}.*|ARN.*(copie/|copies/)|ARN.*(og/m|og/m)|DDN|prelevement" $1 | tr -d '\t' | tr -s " " > workfile.txt

# Remplacement de caracteres
sed -i '' 's:‹:<:g' workfile.txt
sed -i '' 's:Mr:Mr :g' workfile.txt
sed -i '' 's:Mme:Mme :g' workfile.txt
sed -i '' 's:/m1:/ml:g' workfile.txt

# Suppression de caracteres
sed -i '' 's:PROJET OPP-ERA::g' workfile.txt
sed -i '' 's:Nombre de copies d::g' workfile.txt
sed -i '' 's:ARN VIH1/ml::g' workfile.txt
sed -i '' 's:Nombre de log copies d::g' workfile.txt
sed -i '' 's:inflc::g' workfile.txt
sed -i '' 's:inf20::g' workfile.txt
sed -i '' 's:DDN::g' workfile.txt
sed -i '' 's:Date de prelevement::g' workfile.txt
sed -i '' 's+:++g' workfile.txt

# Suppression des caracteres de retours à la ligne
sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g' workfile.txt > workfile.no_newlines

# Creation de nouveaux retours a la ligne
sed 's/Mr/\'$'\nMr/g' workfile.no_newlines | sed 's/Mme/\'$'\nMme/g' > workfile.new_newlines

# Un peu de nettoyage
sed "s/'//g" workfile.new_newlines |grep "copie" > workfile.ready_for_output

# Formattage final
awk -F" " -v OFS=";" '{print $1,$2,$3,$4,$5,$7}' workfile.ready_for_output > $2

# Suppression de tous les fichiers temporaires
rm workfile.txt workfile.no_newlines workfile.new_newlines workfile.ready_for_output

