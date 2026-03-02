#!/bin/bash

shuf contacts.csv > contacts_melanges.csv

while IFS= read -r numero
do
  if [ -z "$numero" ]; then continue; fi

  cat <<EOF > /tmp/call_$numero.call
Channel: PJSIP/$numero
Context: from-internal
Extension: 800
Priority: 1
EOF

  mv /tmp/call_$numero.call /var/spool/asterisk/outgoing/
  sleep 15

done < contacts_melanges.csv



Explication du code : 

/bin/bash : Indique au système que ce fichier est un script exécutable par l'interpréteur Bash.

 shuf contacts.csv > contacts_melanges.csv : Mélange aléatoirement les lignes du fichier contacts.csv 
 et enregistre le résultat dans un nouveau fichier pour ne pas appeler toujours dans le même ordre.

 while IFS= read -r numero : Démarre une boucle qui lit le fichier ligne par ligne. 
 La variable "numero" récupère la valeur de chaque ligne (le numéro de téléphone).

 if [ -z "$numero" ]; then continue; fi : Vérifie si la ligne est vide. 
 Si c'est le cas, le script passe directement à la ligne suivante sans rien faire.

 cat <<EOF > /tmp/call_$numero.call : Crée un fichier temporaire (Call File) avec le contenu suivant :
 - Channel : Définit le protocole (PJSIP) et le destinataire.
 - Context : Envoie l'appel vers le contexte interne défini dans extensions.conf.
 - Extension : Connecte l'appelé directement au numéro 800 (le SVI).
 - Priority : Démarre à la première étape du plan de numérotation.
 EOF : Marque la fin de l'écriture du fichier.

 mv /tmp/call_$numero.call /var/spool/asterisk/outgoing/ : Déplace le fichier vers le dossier 
 de "spool" d'Asterisk. C'est ce déplacement qui déclenche l'appel automatique immédiatement.

 sleep 15 : Marque une pause de 15 secondes entre chaque lancement d'appel pour ne pas 
 saturer le serveur ou harceler les contacts.

 done < contacts_melanges.csv : Indique à la boucle "while" d'utiliser le fichier mélangé 
 comme source de données.
