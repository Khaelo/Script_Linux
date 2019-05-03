PROJECT_FOLDER=$1
SAVE_FOLDER_PATH=$2
TOMORROW=$(date --date="tomorrow" '+%A')

if [ ! -d $PROJECT_FOLDER ]; then
	echo "Le dossier n'existe pas !"
fi
if [ -d $SAVE_FOLDER_PATH ]; then
	echo "Fichier de sauvegarde enregistré !"
else
	echo "Le fichier n'existe pas. Voulez-vous le créer ? (o/n)"
	read entry
	
	if [ $entry = "o" ] || [ $entry = "O" ]; then
		mkdir $SAVE_FOLDER_PATH
		echo "Dossier créé !"
	else
		echo "Opération annulée !"
		exit 
	fi
fi

full_save() {
	LATEST_BACKUP="$SAVE_FOLDER_PATH+backup_project_`date "+%d.%m.%Y_%H.%M.%S"`.tar.gz"
	tar -czpf $LATEST_BACKUP $PROJECT_FOLDER
}
full_save

partial_save() {
	TEST_BACKUP_FOLDER=$SAVE_FOLDER_PATH+test
	mkdir $TEST_BACKUP_FOLDER
	tar -C $TEST_BACKUP_FOLDER -xzf $LATEST_BACKUP
	ARCHIVE_FOLDER=$(ls "$TEST_BACKUP_FOLDER")
	DIFFERENCE=$(diff "$PROJECT_FOLDER" "$TEST_BACKUP_FOLDER/$ARCHIVE_FOLDER")
	echo $DIFFERENCE
	if [ ! -z "$DIFFERENCE" ] ; then
		full_save
		echo "saved"
	fi
	rm -r $TEST_BACKUP_FOLDER
}

echo "Une sauvegarde à été effectuée, vous pouvez maintenant laisser le script tourner en arrière plan pour effectuer les tâches de sauvegardes automatiques."
while [ true ]
do
	sleep 1800
	NOW=$(date '+%A')

	if [ $NOW = $TOMORROW ] ; then

		if [ $NOW = "vendredi" ] ; then
			full_save
			TOMORROW=$(date --date="tomorrow" '+%A')
		else
			partial_save
			TOMORROW=$(date --date="tomorrow" '+%A')
		fi
	fi

done