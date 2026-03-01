Contexte 

  
Consigne : 
Dans votre environnement professionnel futur, vous allez peut-être être amenés à désigner, mettre en place, administrer ou maintenir une architecture VoIP (Voice over IP). 
Il est donc nécessaire de commencer tout de suite à faire une veille technologique sur la VoIP et à en relever les avantages, inconvénients, chercher les solutions existantes sur le marché, qu’elles soient intégrées, clef en main ou customisées, sur mesure... 

Rapidement, on pourrait dire que la VoIP est intéressante pour : 

● Son coût réduit. En effet, les appels VoIP sont généralement moins chers que les appels téléphoniques traditionnels. Peut-on dire la même chose de ses coûts opérationnels et de maintenance ? 

● Sa flexibilité : Un serveur VoIP offre un large panel de configuration permettant de personnaliser l’expérience utilisateur. Pourriez-vous dire en quoi la configuration VoIP d’un call center serait différente de la configuration VoIP d’un standard téléphonique d’une entreprise ? 


● Son intégration : Un serveur VoIP peut être intégré ou connecté à d'autres systèmes (Annuaires de contacts (AD), CRM) vous permettant d'automatiser certaines tâches et de faciliter la communication avec vos clients. Identifiez des sites marchands ou de service dont customer service implique des services VoIP, donnez quelques exemples et décrivez une architecture possible de leur système. 
 

● Sa scalabilité : Les serveurs VoIP sont flexibles et peuvent être mis à échelle facilement. Un bon administrateur VoIP peut augmenter ou diminuer le nombre d’utilisateurs, augmenter les capacités d’appels simultanées sans interruption de service. Une équipe peut aussi cloner et reproduire une architecture locale et la déployer sur d’autres sites... 

  
● Sa sécurité : Il est possible de configurer le chiffrement pour protéger les informations d'authentification et les appels vocaux. Il est donc plus sécurisé qu'un système téléphonique traditionnel. Effectuez quelques recherches sur les chiffrements les mieux adaptés à la VoIP. 



Réponse aux questions : 

Les chiffrements les mieux adaptés au VoIp : Le chiffrement protège vos données vocales contre les accès non autorisés. Les protocoles tels que SRTP (Secure Real-Time Transport Protocol) pour la voix et TLS (Transport Layer Security) pour les connexions garantissent la confidentialité et l’intégrité des données échangées. 
Pour aller plus loin, l’utilisation d’un VPN (Virtual Private Network) peut renforcer la sécurité en créant un tunnel crypté pour le trafic VoIP. 

 
Sécuriser les appels VoIP qui sont menacés par des pirates car utilisation d’internet pour communiquer :  
Chiffrements des communications, installer des pares-feux et des systèmes de détection, mettre des mots de passes robustes, effectuer des mis à jour régulières, sensibiliser les employés, surveiller les activités du réseau  

Sécuriser les communications VoIP de votre entreprise est essentiel pour protéger vos données sensibles et garantir la confidentialité de vos échanges. En choisissant un fournisseur comme Meilleure Téléphonie, en adoptant des solutions de chiffrement et en formant vos équipes, vous pouvez réduire les risques de cyberattaques et optimiser vos systèmes de téléphonie. Investir dans la sécurité est non seulement une obligation, mais aussi une garantie de sérénité pour votre entreprise. 



Test et validation :  

● État initial du système (1) 

● Fonctionnalité testée / périmètre du test (2) 

● Description du comportement attendu (3) 

● Séquence ou étapes de test (4) 

● Commentaires (5) 

● (Résultat du test : OK/NOK) (6) 

 

1. Plan de Test : Les points cruciaux à valider 

Avant la mise en production, notre plan de test se concentre sur les éléments critiques suivants pour garantir la stabilité et la sécurité de l'architecture : 

    Administration d'utilisateurs : Création des comptes (6001 et 6002) et prise en compte par le serveur. 

    Connectivité et Enregistrement : Capacité des clients SIP (PortSIP, MicroSIP) à s'authentifier auprès du serveur. 

    Appel simple et Sécurité : Vérification de l'établissement d'un appel avec l'audio fonctionnel, tout en validant le chiffrement (TLS et SRTP). 

    Start/Restart serveur : Vérification de la résilience du service après un redémarrage (maintien des configurations). 

 

2. Cas de tests détaillés 

Cas de Test n°1 : Connectivité et Enregistrement d'un utilisateur 

    État initial du système : Serveur Asterisk démarré sur Debian. Utilisateur 6001 configuré dans pjsip.conf. Application PortSIP installée sur smartphone. 

    Fonctionnalité testée / périmètre du test : Connectivité réseau et authentification SIP via TLS. 

    Description du comportement attendu : Le smartphone doit pouvoir se connecter au serveur et l'utilisateur doit apparaître avec le statut "Reachable" (Joignable) dans la console Asterisk. 

    Séquence ou étapes de test : 1. Ouvrir PortSIP et renseigner les identifiants (6001, Pass123!). 2. Forcer le transport sur "TLS" et le port sur 5061. 3. Lancer la connexion sur l'application. 4. Vérifier le statut sur le serveur via la commande asterisk -rvvvvv. 

    Commentaires : Nécessite d'accepter le certificat auto-signé sur le client pour que la connexion TLS aboutisse. 

    (Résultat du test : OK/NOK) : OK 

Cas de Test n°2 : Appel simple inter-appareils (avec sécurité) 

    État initial du système : Utilisateurs 6001 (Smartphone) et 6002 (PC) correctement enregistrés et "Reachable". 

    Fonctionnalité testée / périmètre du test : Établissement d'un appel audio bidirectionnel chiffré (SRTP). 

    Description du comportement attendu : L'appel doit aboutir, les deux utilisateurs doivent s'entendre clairement, et le flux doit être sécurisé (cadenas affiché / SRTP forcé). 

    Séquence ou étapes de test : 1. Depuis le PC (6002), composer le numéro 6001. 2. Vérifier que le smartphone sonne. 3. Décrocher sur le smartphone. 4. Parler dans les micros des deux appareils pour vérifier l'audio. 5. Raccrocher l'appel. 

    Commentaires : L'option media_encryption=sdes doit être active sur le serveur et le client doit forcer le SRTP. 

    (Résultat du test : OK/NOK) : OK 

Cas de Test n°3 : Start/Restart du serveur (Résilience) 

    État initial du système : Serveur Asterisk en cours d'exécution avec des clients connectés. 

    Fonctionnalité testée / périmètre du test : Arrêt et redémarrage du service Asterisk. 

    Description du comportement attendu : Le service doit redémarrer sans erreur critique. Les clients SIP doivent se reconnecter automatiquement au bout de quelques secondes sans action manuelle. 

    Séquence ou étapes de test : 1. Taper la commande systemctl restart asterisk sur le serveur Debian. 2. Vérifier le statut du service avec systemctl status asterisk. 3. Ouvrir la console asterisk -rvvvvv. 4. Attendre et observer la reconnexion automatique des clients (log "Added contact"). 

    Commentaires : Test essentiel pour valider que les fichiers de configuration n'ont pas d'erreurs de syntaxe qui bloqueraient le démarrage. 

    (Résultat du test : OK/NOK) : OK 

Cas de Test n°4 : Rejet d'une connexion non sécurisée 

    État initial du système : Serveur Asterisk configuré pour exiger TLSv1.2 et SRTP. 

    Fonctionnalité testée / périmètre du test : Sécurité de l'architecture. 

    Description du comportement attendu : Le serveur doit refuser tout appel ou connexion utilisant un protocole non chiffré ou obsolète. 

    Séquence ou étapes de test : 1. Sur le client, désactiver le chiffrement SRTP (mettre en clair/non chiffré). 2. Tenter d'appeler un autre utilisateur. 3. Observer les logs du serveur. 

    Commentaires : Le serveur renvoie une erreur "Couldn't negotiate stream 0:audio" et coupe l'appel instantanément, ce qui prouve que la règle de sécurité fonctionne. 

    (Résultat du test : OK/NOK) : OK 

 

 

AUTOMATISATION : 

En téléphonie, ça s'appelle un SVI (Serveur Vocal Interactif) ou IVR en anglais. 

1. Le document : Conception de ton Menu SVI 

Architecture du Serveur Vocal Interactif (Numéro d'accès : 800) 

    Accueil : L'appelant compose le numéro 800. L'automate décroche et joue un message de bienvenue : "Bienvenue dans notre entreprise. Veuillez choisir un service." 

    Touche 1 (Service Comptabilité) : Transfère l'appel vers l'utilisateur 6001. 

    Touche 2 (Service Technique) : Transfère l'appel vers l'utilisateur 6002. 

    Touche i (Erreur) : Si l'appelant tape une mauvaise touche (ex: 9), un message d'erreur est joué et le menu se répète. 

    Touche t (Timeout) : Si l'appelant ne fait rien pendant 5 secondes, l'automate dit au revoir et raccroche. 



Résumé du Projet : 
 Projet VoIP - Déploiement, Sécurisation et Automatisation sous Asterisk 

 1. Introduction et Architecture
Ce projet a pour but de déployer une infrastructure de téléphonie sur IP (VoIP) d'entreprise à l'aide d'un serveur Asterisk hébergé sur une machine virtuelle Debian. Deux clients SIP (PJSIP) ont été configurés :
6001 : Utilisateur mobile (PortSIP sur iPhone)
6002 : Utilisateur bureau (MicroSIP sur PC)

La sécurité étant au cœur de ce déploiement, les communications sont intégralement chiffrées : TLS pour la signalisation (protection des identifiants) et SRTP pour le flux média (protection de la voix).


 2. Plan de Test et Validation avant Mise en Production
Afin de garantir le bon fonctionnement de l'architecture et la robustesse des règles de sécurité, les tests suivants ont été réalisés avec succès :

Cas de Test n°1 : Connectivité et Enregistrement d'un utilisateur
État initial du système : Serveur Asterisk démarré. Utilisateurs configurés dans `pjsip.conf`.
Fonctionnalité testée : Authentification SIP via TLS.
Description du comportement attendu : Le client doit pouvoir se connecter au serveur (port 5061) et apparaître avec le statut "Reachable" dans la console.
Séquence de test : 1. Configuration du compte sur l'application PortSIP avec transport TLS forcé.
  2. Lancement de la connexion.
  3. Vérification du statut via `asterisk -rvvvvv`.
Commentaires : Le certificat auto-signé du serveur a été accepté manuellement par le client.
Résultat du test : OK

 Cas de Test n°2 : Appel simple et Sécurité (SRTP)
État initial du système : Utilisateurs 6001 et 6002 enregistrés et en ligne.
Fonctionnalité testée : Établissement d'un appel audio bidirectionnel chiffré.
Description du comportement attendu : L'appel aboutit avec un audio clair. Le flux doit être sécurisé (cadenas affiché sur l'application client).
Séquence de test : 1. Appel du 6001 vers le 6002.
  2. Décrochage et test audio (micro/haut-parleur).
  3. Vérification de l'indicateur de chiffrement sur l'interface de l'application.
Commentaires : L'option `media_encryption=sdes` est bien active sur le serveur.
Résultat du test : OK

 Cas de Test n°3 : Start/Restart du serveur (Résilience)
État initial du système : Serveur Asterisk en cours d'exécution avec clients connectés.
Fonctionnalité testée : Redémarrage du service (`systemctl restart asterisk`).
Description du comportement attendu : Le service redémarre sans erreur fatale, et les clients se reconnectent automatiquement.
Séquence de test : 1. Redémarrage du service via le terminal Debian.
  2. Observation de la console Asterisk pour valider la reconnexion ("Added contact").
Commentaires : Confirme l'absence d'erreurs de syntaxe bloquantes dans les fichiers `.conf`.
Résultat du test : OK

 Cas de Test n°4 : Rejet d'une connexion non sécurisée
État initial du système : Serveur configuré pour exiger un flux chiffré.
  Fonctionnalité testée : Robustesse des règles de sécurité.
  Description du comportement attendu : Le serveur refuse tout appel utilisant un protocole audio en clair.
  Séquence de test : 1. Désactivation du SRTP sur l'application client.
  2. Tentative d'appel.
  Commentaires : Le serveur renvoie une erreur de négociation média et coupe l'appel, prouvant que la politique de sécurité est strictement appliquée.
  Résultat du test : OK



 3. Automatisation : Serveur Vocal Interactif (SVI)
Pour améliorer l'accueil téléphonique, un standard automatique a été mis en place sur le numéro d'accès 800.

Arborescence du Menu :
Accueil : Décrochage automatique et message vocal de bienvenue.
  Touche 1 (Service A) : Transfert de l'appel vers l'utilisateur 6001.
  Touche 2 (Service B) : Transfert de l'appel vers l'utilisateur 6002.
  Touche i (Erreur) : Si l'appelant compose un choix invalide, un message d'erreur est joué et le menu boucle.
  Timeout (t) : Si l'appelant ne fait aucun choix pendant 5 secondes, le serveur lui dit au revoir et raccroche.



 4. Automatisation : Script de Prospection (Appels Automatiques)
Pour simuler une campagne de prospection, un script Bash (`automate.sh`) a été développé. 

Fonctionnement :
1. Le script lit un fichier `contacts.csv` contenant une liste de numéros cibles.
2. Il randomise l'ordre des appels grâce à la commande `shuf`.
3. Il génère dynamiquement des "Call Files" (.call) qu'il place dans le dossier `/var/spool/asterisk/outgoing/`.
4. Asterisk initie alors automatiquement l'appel vers le contact. Dès que celui-ci décroche, il est directement mis en relation avec le SVI (numéro 800).
5. Une temporisation de 15 secondes est incluse entre chaque appel.
