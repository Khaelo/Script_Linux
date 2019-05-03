# Presentation
echo ''
echo '		-- Jeux du PLUS et du MOINS --	'
echo '			  Bon jeu =)		'
echo ''
echo '	==========================================='

# Variable d'environnement
nbaleatoire=$RANDOM
nbchoix=0
nbtentative=0

echo ''
echo ' -- Saisissez un chiffre entre 0 et 32765!'
echo ' -- Entrez un nombre'

echo $nbaleatoire

while [ $nbchoix -ne $nbaleatoire ] ; do
    echo "Choisissez un chiffre" ; read nbchoix
    if [ "$nbchoix" -gt $nbaleatoire ] ; then
	echo ''
	echo ' -- le nombre mystere est plus petit'
	echo ''
    elif [ "$nbchoix" -lt $nbaleatoire ] ; then
	echo ''	
	echo ' -- le nombre mystere est plus grand'
	echo ''
    fi
    nbtentative=$(( $nbtentative +1 ))
done

echo 'Gagnéééé !!!'

exit 0