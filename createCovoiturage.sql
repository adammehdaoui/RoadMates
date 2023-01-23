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
    idParrainant INT,
    idParraine INT,
    PRIMARY KEY (idParrainant, idParraine),
    FOREIGN KEY (idParrainant) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idParraine) REFERENCES utilisateur(idUtil)
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
    finalise BOOLEAN
);

CREATE TABLE propose(
    idUtil INT,
    idTrajet INT,
    numImmatriculation CHAR(10),
    PRIMARY KEY(idUtil, idTrajet, numImmatriculation),
    FOREIGN KEY (idUtil) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idTrajet) REFERENCES trajet(idTrajet)
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
    contenuCommentaire VARCHAR(255),
    PRIMARY KEY (idUtil, idAdresse),
    FOREIGN KEY (idUtil) REFERENCES utilisateur(idUtil),
    FOREIGN KEY (idAdresse) REFERENCES adresse(idAdresse)
);
