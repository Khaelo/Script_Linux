# Variable d'environnement
url=''

echo "Inserez l'URL de la vidéo que vous souhaitez télécharger:"
read url

youtube-dl -x "$url"