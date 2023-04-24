# Projet covoiturage (postgreSQL)

## Projet en BDD pour l'ESIEE avec le sujet du Covoiturage

### 1. Présentation générale

Votre client souhaite mettre en place une plateforme de covoiturage entre particuliers.
Cette plateforme sera notamment équipée d’un site web permettant aux utilisateurs
d’organiser leurs déplacements, c’est-à-dire de trouver d’autres utilisateurs, conducteurs
ou passagers, souhaitant effectuer des trajets proches aux mêmes dates. Le présent
document recense les besoins et attentes du client.

### 2. Les passagers, les conducteurs et les véhicules

Afin d’accéder à la plateforme, les utilisateurs doivent créer un profil en renseignant
leur nom, prénom, adresse, adresse e-mail, date de naissance et un mot de passe. Par
défaut, les utilisateurs sont considérés comme passagers uniquement.
L’utilisateur peut ensuite fournir un numéro de permis de conduire pour accéder au
statut de conducteur. L’utilisateur peut alors inscrire le ou les véhicules en sa possession
dans le système. Chaque véhicule est décrit par son numéro d’immatriculation, son modèle,
son nombre de places, sa couleur, le type de carburant utilisé et sa classe Crit’Air.
Finalement, un utilisateur déjà inscrit peut parrainer l’inscription d’un nouvel utilisateur. Ce parrainage permettra à l’utilisateur parrain de recevoir une petite rémunération
à chaque fois que l’utilisateur parrainé effectue un déplacement.

### 3. Les trajets et les étapes

Les conducteurs peuvent créer une proposition de trajet sur le site web, en indiquant
une date, un lieu et une heure de départ, un lieu et une heure d’arrivée prévue, le véhicule
utilisé et le coût du trajet. Les passagers potentiels peuvent ensuite rejoindre le trajet
en proposant deux nouvelles étapes, correspondant à leur point de départ et d’arrivée
désirés. Le conducteur pourra alors choisir d’accepter le passager, et donc de rajouter
les deux étapes proposées au trajet, ou bien de refuser le passager. Ainsi, un trajet se
composera généralement de multiples étapes.
Une étape est caractérisée par un passager concerné, une heure prévue et une localisaiton. Chaque localisation est caractérisée par un nom, une adresse et une description.
Les utilisateurs peuvent ajouter des commentaires sur les localisations pour indiquer
des difficultés d’accès (par exemple, “la chaussée est en travaux”) ou bien faciliter la
rencontre des passagers et des conducteurs (par exemple, “juste derrière la station service,
attention la route est en sens unique”).
Le conducteur pourra à tout moment décider de finaliser le trajet, ce qui interdira
l’inscription de nouveaux passagers et notifiera les passagers déjà inscrits que le trajet
est accepté. Le conducteur s’engage alors à passer par chaque étape à une heure proche
de l’heure voulue.
Lors du trajet, les passagers pourront indiquer pour leur étape de départ et d’arrivée
l’heure réelle à laquelle l’étape a été atteinte par le conducteur. Une fois le trajet terminé,
c’est-à-dire lorsque toutes les étapes ont été confirmées, les passagers se partagent
équitablement le coût du trajet et sont automatiquement facturés par le système. Le
conducteur reçoit alors 80% du montant, le parrain éventuel du conducteur reçoit 5%
du montant, et la plateforme garde les 15% ou 20% restants. Les utilisateurs pourront
ensuite donner une note aux autres utilisateurs avec qui ils ont voyagé, pour évaluer
notamment leur amabilité et leur ponctualité.

### 4. Les sponsors

La plateforme est également utilisée pour mettre en lien les conducteurs avec divers partenaires commerciaux. Ces partenaires, appelés sponsors, peuvent proposer aux
conducteurs de décorer leur véhicule avec divers slogans publicitaires en échange d’une
petite rémunération chaque fois que le véhicule est utilisé pour un trajet suffisamment long.
Ainsi la plateforme recensera une liste de sponsors, avec les informations les concernant :
nature de la publicité, durée de trajet requise, rémunération. Chaque conducteur pourra
choisir, pour chacun de ses véhicules, s’il souhaite ou non le faire sponsoriser.
