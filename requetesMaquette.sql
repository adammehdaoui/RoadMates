-- Page de connexion
-- Une fois le nom d'utilisateur et le mot de passe saisi :

SELECT mdp 
FROM utilisateur
WHERE utilisateur.email = ${email};

-- Si le mot de passe correspond alors l'utilisateur est connecté
-- Sinon on affiche un message d'erreur

--Profil
--On récupère toutes les voitures que possède un utilisateur (l'utilisateur connecté
--en l'occurence)

SELECT modele.nomModele, voiture.numImmatriculation
FROM utilisateur, modele, voiture
WHERE utilisateur.idUtil = voiture.idUtil
AND voiture.idModele = modele.idModele 
AND utilisateur.idUtil = ${idUtil};

--Ajout d'un véhicule pour un utilisateur

INSERT INTO voiture (numImmatriculation, idUtil, idModele) 
VALUES (${numImmatriculation}, ${idUtil}, ${idModele});

--Récupération des opérations bancaires d'un utilisateur

SELECT 0.80 * coutTrajet AS operations
FROM trajet, utilisateur
WHERE trajet.idUtil = utilisateur.idUtil
AND utilisateur.idUtil = ${idUtil}
UNION
SELECT DISTINCT -1 * (coutTrajet / compteur)
FROM trajet, etape, (SELECT count(idUtil)/2 AS compteur, idTrajet
                    FROM etape
                    GROUP BY idTrajet) compteur_voyageur
WHERE trajet.idTrajet = etape.idTrajet
AND departOuArrivee NOT IN ('departTrajet', 'arriveeTrajet')
AND compteur_voyageur.idTrajet = etape.idTrajet
AND etape.idUtil = ${idUtil};

--Récupération de son historique

SELECT Trajet.idTrajet, nomVille, 'départ' AS departArrivee
FROM Trajet, Etape, Adresse, Ville
WHERE Trajet.idTrajet = Etape.idTrajet
AND Etape.idAdresse = Adresse.idAdresse
AND Adresse.codePostal = Ville.codePostal
AND Trajet.idUtil = ${idUtil}
AND Etape.departOuArrivee = 'departTrajet'
UNION
SELECT Trajet.idTrajet, nomVille, 'arrivée'
FROM Trajet, Etape, Adresse, Ville
WHERE Trajet.idTrajet = Etape.idTrajet
AND Etape.idAdresse = Adresse.idAdresse
AND Adresse.codePostal = Ville.codePostal
AND Trajet.idUtil = ${idUtil}
AND Etape.departOuArrivee = 'arriveeTrajet'


--Organisation trajet
--Une fois le bouton d'enregistrement cliqué :

INSERT INTO Trajet (coutTrajet, finalise, idUtil, numImmatriculation)
VALUES (${coutTrajet}, ${finalise}, ${idUtil}, ${numImmatriculation});

--On récupère les identifiants d'adresses entrées par l'utilisateur au moment de l'enregistrement
--du trajet

SELECT idAdresse
FROM Adresse
WHERE numVoie = ${numVoie} 
AND nomVoie = ${nomVoie}
AND codePostal = ${codePostal};

--Création du départ principal et de l'arrivée principale du trajet précédent 

INSERT INTO etape(departOuArrivee, heureSouhaitee, dateSouhaitee, idUtil, idTrajet, idAdresse)
VALUES ('departTrajet', heureSouhaitee, dateSouhaitee, idUtil, idTrajet, idAdresse);

INSERT INTO etape(departOuArrivee, heureSouhaitee, dateSouhaitee, idUtil, idTrajet, idAdresse)
VALUES ('arriveeTrajet', heureSouhaitee, dateSouhaitee, idUtil, idTrajet, idAdresse);

--Mon trajet en cours

--On récupère l'id du trajet en cours 
--S'il n'y en a pas, on affiche une page montrant que l'utilisateur n'a pas de trajet en cours

SELECT trajet.idTrajet
FROM trajet, etape
WHERE etape.idTrajet = trajet.idTrajet
AND etape.idUtil = ${idUtil}
AND etape.heureSouhaitee < current_time
AND etape.dateSouhaitee = current_date;

--Puis on affiche son contenu à partir de son id

--Départ principal

SELECT nomVille, heureSouhaitee, dateSouhaitee, heureReelle, dateReelle
FROM trajet, etape, adresse, ville
WHERE trajet.idTrajet = etape.idTrajet
AND etape.idAdresse = adresse.idAdresse
AND adresse.codePostal = ville.codePostal
AND trajet.idTrajet = ${idTrajet}
AND etape.departOuArrivee = 'departTrajet';

--Arrivée principale

SELECT nomVille,heureSouhaitee, dateSouhaitee,heureReelle,dateReelle
FROM trajet, etape, adresse, ville
WHERE trajet.idTrajet = etape.idTrajet
AND etape.idAdresse = adresse.idAdresse
AND adresse.codePostal = ville.codePostal
AND trajet.idTrajet = ${idTrajet}
AND etape.departOuArrivee = 'arriveeTrajet';

--Autres étapes

SELECT ville.nomVille, etape.departOuArrivee, etape.heureSouhaitee, etape.dateSouhaitee, etape.heureReelle,
etape.dateReelle
FROM trajet, etape, adresse, ville
WHERE trajet.idTrajet = etape.idTrajet
and etape.idAdresse = adresse.idAdresse
and adresse.codePostal = ville.codePostal
and trajet.idTrajet = ${idTrajet}
and etape.departOuArrivee NOT IN ("arriveeTrajet","departTrajet");

--Statistiques
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
LIMIT 5;

--Recherche d'utilisateurs en fonction des villes par lesquelles ils passent
--Ces utilisateurs sont ceux qui effectuent les trajet

SELECT utilisateur.* 
FROM utilisateur, trajet, adresse, ville
WHERE utilisateur.idUtil = trajet.idUtil 
AND trajet.idTrajet = etape.idTrajet
AND etape.idAdresse = adresse.idAdresse
AND adresse.codePostal = ville.codePostal
AND ville.nom LIKE '%${nomVille}%';

UPDATE etape SET heureReelle = current_time, dateReelle = current_date
WHERE idEtape =  ${idEtape}
AND idTrajet = ${idTrajet}

--Inscription
--Une fois le bouton d'inscription cliqué et les valeurs récupérées :

INSERT INTO utilisateur(nom, prenom, adresse, email, dateNaissance, mdp, numPermis)
VALUES(${nom}, ${prenom}, ${adresse}, ${email}, ${dateNaissance}, ${mdp}, ${numPermis});
