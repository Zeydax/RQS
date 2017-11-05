CREATE TABLE Artists (
    IdArt     NUMBER(6),--MAX=6
    NomArt	  VARCHAR2(40),
    CONSTRAINT artist_pk 		PRIMARY KEY (IdArt),
    CONSTRAINT artist_name_ck 	CHECK (NomArt IS NOT NULL)
);

CREATE TABLE Certifications (
    IdCerti      	NUMBER GENERATED ALWAYS AS IDENTITY,
    NomCerti    	VARCHAR2(5), --95 QUantile = 5
    --description 	VARCHAR2(1000), -- ce champ est là pour expliqué la spécifité de la certication , expliqué ce qu'il represente 
    CONSTRAINT certi_pk 			PRIMARY KEY (IdCerti),
    CONSTRAINT certi_NomCerti_NotNull 	CHECK (NomCerti IS NOT NULL),
	--Il faut ajouter un déclencheur qui va update les champs de movie_ext pour qu'ils correspondent à la contrainte
	CONSTRAINT cert_NomCerti_ck 	CHECK (NomCerti IN ('G', 'PG', 'PG-13', 'R', 'NC-17')),
    CONSTRAINT cert_NomCerti_un 	UNIQUE (NomCerti)
);

CREATE TABLE status ( --denormaliser
    IdStatus      	NUMBER GENERATED ALWAYS AS IDENTITY,
    NomStatus    	VARCHAR2(8),-- 95 quartile = 8
    CONSTRAINT status_pk 		PRIMARY KEY (IdStatus),
    CONSTRAINT status_NomStatus_ck 	CHECK (NomStatus IS NOT NULL),
    CONSTRAINT status_NomStatus_un 	UNIQUE (NomStatus)
);

CREATE TABLE genres (
    IdGenre   	  NUMBER(5) ,-- MAX=5
    NomGenre 	  VARCHAR2(12),-- 95 quantile=11 et 995 quantile=15
    CONSTRAINT genres_pk 		PRIMARY KEY (IdGenre),
    CONSTRAINT genres_NomGenre_ck 	CHECK (NomGenre IS NOT NULL),
    CONSTRAINT genres_NomGenre_un 	UNIQUE (NomGenre)
);

CREATE TABLE posters (
	IdPoster 	NUMBER 	GENERATED ALWAYS AS IDENTITY,
	--film		NUMBER ,
	PathImage 	VARCHAR2(100),
	Image 		BLOB DEFAULT EMPTY_BLOB(),
	CONSTRAINT posters_pk PRIMARY KEY (IdPoster)
);

-- Voir les valeurs d'analyse CI
CREATE TABLE Films (
    IdFilm			NUMBER(6),
    Titre			VARCHAR2(60) NOT NULL,
	Titre_Original  VARCHAR2(60),
    status        	NUMBER, 
    tagline  	  	VARCHAR2(175),
    Date_Real  		DATE,
    Vote_Average  	NUMBER(2),
    vote_count    	NUMBER(4) NOT NULL,
    certification 	NUMBER,
    Duree       	NUMBER(6),
    Budget        	NUMBER(10,2) NOT NULL,
    poster        	NUMBER,
    CONSTRAINT films_pk 					PRIMARY KEY (IdFilm),
    CONSTRAINT films_status_fk  			FOREIGN KEY (status) REFERENCES status(IdStatus),
	CONSTRAINT films_vote_count_minVal_ck 	CHECK (vote_count IS NULL OR vote_count >= 0),
	CONSTRAINT films_certification_fk 		FOREIGN KEY (certification) REFERENCES certifications(IdCerti),
	CONSTRAINT films_Duree_minVal_ck 		CHECK (Duree IS NULL OR Duree >= 0),
	CONSTRAINT films_Budget_minVal_ck 		CHECK (Budget IS NULL OR Budget >= 0),
	CONSTRAINT films_poster_fk  			FOREIGN KEY (poster) REFERENCES posters(IdPoster)
);



CREATE TABLE REALISER (
    Film    NUMBER(6) CONSTRAINT REALISER_Film_fk REFERENCES Films (IdFilm),
    Artist  NUMBER(7) CONSTRAINT REALISER_Artist_fk REFERENCES Artists (IdArt),
    CONSTRAINT movie_director_pk 	PRIMARY KEY (Film, Artist)
);

CREATE TABLE Film_Genre (
    genre 	NUMBER(5) CONSTRAINT Film_Genre_genre_fk REFERENCES genres (IdGenre),
    Film 	NUMBER(6) CONSTRAINT Film_Genre_Film_fk REFERENCES Films (IdFilm),
    CONSTRAINT Films_Genre_pk 	PRIMARY KEY (genre, Film)
);
CREATE TABLE JOUER (
    Film  		NUMBER(6) CONSTRAINT JOUER_movie_fk REFERENCES Films (IdFilm),
    Artist 		NUMBER(7) CONSTRAINT JOUER_artist_fk REFERENCES Artists (IdArt),
	Role		VARCHAR2(24),
    CONSTRAINT films_actor_pk 	PRIMARY KEY (Film, Artist)
);

CREATE TABLE Films_Copies (
	id      	NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
	movie  		NUMBER(6) CONSTRAINT copy_movie_fk REFERENCES films (IdFilm),
	nbCopie		NUMBER(2) CONSTRAINT nbCopie_Ck	CHECK(nbCopie>=0),
	CONSTRAINT Films_Copies_pk 	PRIMARY KEY (id)
);