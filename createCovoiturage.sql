DROP TABLE IF EXISTS utilisateur CASCADE;
DROP TABLE IF EXISTS parraine CASCADE;
DROP TABLE IF EXISTS modele CASCADE;
DROP TABLE IF EXISTS voiture CASCADE;
DROP TABLE IF EXISTS sponsor CASCADE;
DROP TABLE IF EXISTS sponsorise CASCADE;
DROP TABLE IF EXISTS propose CASCADE;
DROP TABLE IF EXISTS trajet CASCADE;
DROP TABLE IF EXISTS etape CASCADE;
DROP TABLE IF EXISTS adresse CASCADE;
DROP TABLE IF EXISTS ville CASCADE;
DROP TABLE IF EXISTS commente CASCADE;

CREATE TABLE utilisateur(
    idUtil SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    mdp VARCHAR(50),
    nom VARCHAR(255),
    prenom VARCHAR(255),
    adresse VARCHAR(255),
    dateNaissance DATE,
    numPermis CHAR(12) UNIQUE
);

CREATE TABLE parraine(
    idParrainant INT,
    idParraine INT,
    PRIMARY KEY (idParrainant, idParraine),
    FOREIGN KEY (idParrainant) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idParraine) REFERENCES utilisateur(idUtil)
);

CREATE TABLE modele(
    idModele INT PRIMARY KEY,
    nomModele VARCHAR(50),
    nbPlaces INT,
    couleur VARCHAR(25),
    carburant VARCHAR(25),
    classeCritair CHAR(1)
);

CREATE TABLE voiture(
    numImmatriculation CHAR(10) PRIMARY KEY,
    idUtil INT,
    idModele INT,
    FOREIGN KEY (idUtil) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idModele) REFERENCES modele(idModele)
);

CREATE TABLE sponsor(
    idSponsor SERIAL PRIMARY KEY,
    raisonSociale VARCHAR(50),
    dureeTrajet INT,
    remuneration DECIMAL(8,2)
);

CREATE TABLE sponsorise(
    idSponsor INT,
    numImmatriculation CHAR(10),
    PRIMARY KEY(idSponsor, numImmatriculation),
    FOREIGN KEY (idSponsor) REFERENCES sponsor(idSponsor),
    FOREIGN KEY (numImmatriculation) REFERENCES voiture(numImmatriculation)
);

CREATE TABLE trajet(
    idTrajet SERIAL PRIMARY KEY,
    coutTrajet DECIMAL(8,2),
    finalise BOOLEAN,
    idUtil INT,
    numImmatriculation CHAR(10),
    FOREIGN KEY (idUtil) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (numImmatriculation) REFERENCES voiture(numImmatriculation)
);

CREATE TABLE ville(
    codePostal CHAR(10) PRIMARY KEY,
    nomVille VARCHAR(255)
);

CREATE TABLE adresse(
    idAdresse SERIAL PRIMARY KEY,
    numVoie INT,
    nomVoie VARCHAR(255),
    codePostal CHAR(10),
    FOREIGN KEY (codePostal) REFERENCES ville(codePostal)
);

CREATE TABLE etape(
    idEtape SERIAL PRIMARY KEY,
    departOuArrivee BOOLEAN,
    heureSouhaite TIME,
    dateSouhaitee DATE,
    heureReelle TIME,
    dateReelle DATE,
    idUtil INT,
    idTrajet INT,
    idAdresse INT,
    FOREIGN KEY (idUtil) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idTrajet) REFERENCES trajet(idTrajet),
    FOREIGN KEY (idAdresse) REFERENCES adresse(idAdresse)
);

CREATE TABLE commente(
    idUtil INT,
    idAdresse INT,
    contenuCommentaire TEXT,
    PRIMARY KEY (idUtil, idAdresse),
    FOREIGN KEY (idUtil) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idAdresse) REFERENCES adresse(idAdresse)
);

INSERT INTO utilisateur(nom, prenom, adresse,email,dateNaissance,mdp,numPermis) 
VALUES('SOUSSI', 'Ahmed','12 Route Gournay, 93160 Noisy-Le-Grand', 'soussiahmed62@gmail.com', '2000-12-12', 'ahmed.soussi', 125125125125);

INSERT INTO utilisateur(nom, prenom, adresse,email,dateNaissance,mdp,numPermis) 
VALUES('MEHDAOUI--JORGE', 'Adam','1 rue du pommier de l"eglise, 94170 Le Perreux sur Marne', 'adamlafrite@gmail.com', '2002-07-13', 'jeanfrite', NULL);

INSERT INTO utilisateur(nom, prenom, adresse,email,dateNaissance,mdp,numPermis) 
VALUES('FRANCIS', 'Nadime',NULL, 'francis.nadime@u-pem.fr',NULL, 'francis.nadime', 555555555666);

INSERT INTO utilisateur(nom, prenom, adresse,email,dateNaissance,mdp,numPermis) 
VALUES('ANSARY', 'Laura','Lidl', 'laura.ansary@gmail.com','2002-07-04', 'life.life', NULL);

INSERT INTO utilisateur(nom, prenom, adresse, email, dateNaissance, mdp, numPermis)
VALUES('Castle', 'Rock', '48 rue de la Santé, 75014 Paris', 'castle.rock@life.com', '1999-12-12', 'castlerock', 456897132479);

INSERT INTO modele(idmodele, nommodele, nbplaces, couleur, carburant, classeCritair) 
VALUES(1, 'Toyota Panda Trueno AE86', 5, 'blanc', 'essence', '4'), 
(2, 'Mitsubishi GTO Twin Turbo', 5, 'rouge', 'essence', '4'), 
(3, 'Porsche 911', 2, 'gris', 'essence', '4'), 
(4, 'Renault Clio 1', 5, 'blanc', 'diesel', '4'), 
(5, 'Tesla Model 3', 5, 'bleu', 'electric', '4');

INSERT INTO voiture(numImmatriculation, idUtil, idModele) 
VALUES('123456789', 2, 1), 
('234567891', 1, 5), 
('4455668899', 3, 2), 
('4577865421', 4, 3), 
('8956213654', 5, 4);

INSERT INTO sponsor(raisonSociale, dureeTrajet, remuneration)
VALUES('Nike', 60, 200.00), 
('Adidas', 60, 150.00),  
('Tik Tok', 30, 80.00), 
('RedBull', 30, 120.00);

INSERT INTO sponsorise(idSponsor, numImmatriculation)
VALUES(1,'123456789'), 
(1, '234567891'), 
(2, '4455668899'), 
(3, '4577865421'), 
(4, '8956213654');

INSERT INTO trajet(coutTrajet, finalise, idUtil, numImmatriculation)
VALUES(50.00, FALSE, 1, '234567891'), 
(40.00, FALSE, 3, '4455668899'), 
(35.00, TRUE, 5, '8956213654');

INSERT INTO ville(codePostal, nomVille)
VALUES('94170', 'Le Perreux sur Marne'), 
('75016', 'Paris 16e'), 
('75013', 'Paris 13e'), 
('77420', 'Champs-Sur-Marne'), 
('45000', 'Orléans');

INSERT INTO adresse(numVoie, nomVoie, codePostal)
VALUES(4, 'rue du pommier de l"eglise', '94170'), 
(8, 'rue Marie', '94170'), 
(11, 'rue Robert Diaquin', '94170'),
(1, 'rue Abel Ferry', '75016'), 
(5, 'rue Antoine Roucher', '75016'), 
(13, 'rue Caillaux', '75013'), 
(25, 'avenue de Choisy', '75013'), 
(2, 'Avnue du Général de Gaulle', '77420'), 
(4, 'Rue de la Garenne', '77420'),
(10, 'Avenue Dauphine', '45000'),
(15, 'Rue d"Illiers', '45000');

INSERT INTO etape(departOuArrivee, heureSouhaite, dateSouhaitee, heureReelle, dateReelle, idUtil, idTrajet, idAdresse)
VALUES(TRUE, '07:00:00', '2023-02-02', NULL, NULL, 1, 2, 1), 
(FALSE, '08:00:00', '2023-02-02', NULL, NULL, 1, 2, 2),
(TRUE, '15:00:00', '2023-01-28', NULL, NULL, 3, 1, 4), 
(FALSE, '15:40:00', '2023-01-28', NULL, NULL, 3, 1, 6), 
(TRUE, '12:00:00', '2023-02-05', '12:10:00', '2023-02-05', 4, 3, 8), 
(FALSE, '13:10:00', '2023-02-05', '13:20:00', '2023-02-05', 4, 3, 10);
