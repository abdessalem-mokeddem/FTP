
#!/bin/bash
for ligne in `cat /home/abdes/Téléchargements/Shell_Userlist.csv`;
do
id=`echo ${ligne} | cut -d "," -f 1`
prenom=`echo ${ligne} | cut -d "," -f 2`
nom=`echo ${ligne} | cut -d "," -f 3`
mdp=`echo ${ligne} | cut -d "," -f 4`
role=`echo ${ligne} | cut -d "," -f 5`
echo "$prenom-$nom"
mdpc=$(perl -e 'print crypt($ARGV[0], "salt")', $mdp)
sudo useradd -m -p $mdpc $prenom-$nom

if [[ "$role" =~ .*Admin.* ]]
then
sudo adduser $prenom-$nom sudo
sudo adduser $prenom-$nom adm
else
echo "pas les permissions pour l'utilisateur"
fi
done
exit 0






