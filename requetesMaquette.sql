-- Page d'accueil
-- Une fois le nom d'utilisateur et le mot de passe saisi :

SELECT mdp 
FROM utilisateur
WHERE utilisateur.email = ${email};

-- Si le mot de passe correspond alors l'utilisateur est connecté
-- Sinon on affiche un message d'erreur

-- Profil

SELECT modele.nom, voiture.numImmatriculation
FROM utilisateur, modele, nom
WHERE utilisateur.idUtil = voiture.idUtil
AND voiture.idModele = modele.idModele 
AND utilisateur.idUtil = ${idUtil};

-- Organisation trajet

-- Mon trajet en cours

-- On récupère l'id du trajet en cours 
-- S'il n'y en a pas, on affiche une page montrant que l'utilisateur n'a pas de trajet en cours

SELECT idTrajet
FROM trajet, etape
WHERE etape.idTrajet = trajet.idTrajet
AND etape.idUtil = ${idUtil}
AND etape.heureReelle IS NULL;

-- Puis on affiche sa contenu

SELECT adresse.numvoie, adresse.nomvoie, adresse.codepostal, ville 
FROM utilisateur, etape, adresse, trajet
WHERE utilisateur.idUtil = etape.idUtil
AND etape.idAdresse = adresse.idAdresse
AND adresse.codePostal = ville.codePostal
AND trajet.${idTrajet};

-- Statistiques
--Top 3 des villes où passent les voitures sponsorisées par un sponsor

SELECT ville.nomVille, count(*)
FROM ville, adresse, etape, trajet, voiture, sponsorise, sponsor
WHERE sponsor.idSponsor = sponsorise.idSponsor
AND sponsorise.numImmatriculation = voiture.numImmatriculation
AND voiture.numImmatriculation = trajet.numImmatriculation
AND trajet.idTrajet = etape.idTrajet
AND etape.idAdresse = adresse.idAdresse
AND adresse.codePostal = ville.codePostal 
AND sponsor.idSponsor = ${idSponsor}
GROUP BY ville.nomVille
ORDER BY count(*) DESC
LIMIT 3;

--Recherche d'utilisateurs en fonction des villes par lesquelles ils passent
--Ces utilisateurs sont ceux qui effectuent les trajet

SELECT utilisateur.* 
FROM utilisateur, trajet, adresse, ville
WHERE utilisateur.idUtil = trajet.idUtil 
AND trajet.idTrajet = etape.idTrajet
AND etape.idAdresse = adresse.idAdresse
AND adresse.codePostal = ville.codePostal
AND ville.nom LIKE '%${nomVille}%';

-- Inscription

INSERT INTO utilisateur(nom, prenom, adresse, email, dateNaissance, mdp, numPermis)
VALUES(${nom}, ${prenom}, ${adresse}, ${email}, ${dateNaissance}, ${mdp}, ${numPermis});