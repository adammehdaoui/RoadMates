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
    nom VARCHAR(255),
    adresse VARCHAR(255),
    email CHAR(50),
    dateNaissance DATE,
    mdp CHAR(50),
    numPermis CHAR(12)
);

CREATE TABLE parraine(
    idParrainant REFERENCES utilisateur(idUtil),
    idParraine REFERENCES utilisateur(idUtil),
    PRIMARY KEY (idParrainant, idParraine)
);

CREATE TABLE modele(
    idModele INT PRIMARY KEY,
    nbPlaces INT,
    couleur VARCHAR(25),
    carburant CHAR(10),
    classeCritair CHAR(1)
);

CREATE TABLE voiture(
    numImmatriculation CHAR(10) PRIMARY KEY,
    idUtil REFERENCES utilisateur(idUtil),
    idModele REFERENCES modele(idModele),
);

CREATE TABLE sponsor(
    idSponsor SERIAL PRIMARY KEY,
    raisonSociale VARCHAR(50),
    dureeTrajet INT,
    remuneration DECIMAL(8,2)
);

CREATE TABLE sponsorise(
    idSponsor REFERENCES sponsor(idSponsor),
    numImmatriculation REFERENCES voiture(numImmatriculation),
    PRIMARY KEY(idSponsor, numImmatriculation)
);

CREATE TABLE trajet(
    idTrajet SERIAL PRIMARY KEY,
    coutTrajet DECIMAL(8,2),
    finalise BOOLEAN
);

CREATE TABLE propose(
    idUtil REFERENCES utilisateur(idUtil),
    idTrajet REFERENCES trajet(idTrajet),
    numImmatriculation REFERENCES voiture(numImmatriculation),
    PRIMARY KEY(idUtil, idTrajet, numImmatriculation)
);

CREATE TABLE ville(
    codePostal CHAR(10),
    nomVille VARCHAR(255)
);


CREATE TABLE adresse(
    idAdresse SERIAL PRIMARY KEY,
    numVoie INT,
    nomVoie VARCHAR(255),
    codePostal REFERENCES ville(codePostal)
);

CREATE TABLE etape(
    idEtape SERIAL PRIMARY KEY,
    departOuArrivee BOOLEAN,
    heureSouhaite TIME,
    dateSouhaitee DATE,
    heureReelle TIME,
    dateReelle DATE,
    idUtil REFERENCES utilisateur(idUtil),
    idTrajet REFERENCES trajet(idTrajet),
    idAdresse REFERENCES adresse(idAdresse)
);

CREATE TABLE commente(
    idUtil REFERENCES utilisateur(idUtil),
    idAdresse REFERENCES adresse(idAdresse),
    contenuCommentaire VARCHAR(255),
    PRIMARY KEY (idUtil, idAdresse)
);

