/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  13/06/2014 20:46:48                      */
/*==============================================================*/


drop table if exists COMMENTAIRE;

drop table if exists COMPOSEDE;

drop table if exists CONTENIR;

drop table if exists ENCADRANTENTREPRISE;

drop table if exists ENTREPRISE;

drop table if exists ETUDIANT;

drop table if exists FICHIER;

drop table if exists MOTCLE;

drop table if exists POST;

drop table if exists PROFESSEUR;

drop table if exists PROJET;

drop table if exists REALISER;

drop table if exists SECTION;

drop table if exists TACHE;

drop table if exists UTILISATEUR;

/*==============================================================*/
/* Table : COMMENTAIRE                                          */
/*==============================================================*/
create table COMMENTAIRE
(
   ID_COMMENT           int not null,
   ID_UTILIS            int not null,
   ID_TCH               int,
   ID_POST              int,
   TEXT_COMMENT         text,
   EST_SIGNALE_COMMENT  bool,
   primary key (ID_COMMENT)
);

/*==============================================================*/
/* Table : COMPOSEDE                                            */
/*==============================================================*/
create table COMPOSEDE
(
   ID_PROJ              int not null,
   ID_TCH               int not null,
   primary key (ID_PROJ, ID_TCH)
);

/*==============================================================*/
/* Table : CONTENIR                                             */
/*==============================================================*/
create table CONTENIR
(
   ID_PROJ              int not null,
   ID_MOTC              int not null,
   primary key (ID_PROJ, ID_MOTC)
);

/*==============================================================*/
/* Table : ENCADRANTENTREPRISE                                  */
/*==============================================================*/
create table ENCADRANTENTREPRISE
(
   ID_ENCADR            int not null,
   ID_UTILIS            int not null,
   ID_ENTRP             int not null,
   FONCTION_ENCADR      varchar(30),
   primary key (ID_ENCADR)
);

/*==============================================================*/
/* Table : ENTREPRISE                                           */
/*==============================================================*/
create table ENTREPRISE
(
   ID_ENTRP             int not null,
   NOM_ENTRP            varchar(30),
   ADRESSE_ENTRP        varchar(500),
   TEL_ENTRP            char(10),
   VILLE_ENTRP          varchar(25),
   primary key (ID_ENTRP)
);

/*==============================================================*/
/* Table : ETUDIANT                                             */
/*==============================================================*/
create table ETUDIANT
(
   CNE_ETUD             char(10) not null,
   ID_UTILIS            int not null,
   FILLIERE_ETUD        varchar(30),
   NIVEAU_ETUD          int,
   primary key (CNE_ETUD)
);

/*==============================================================*/
/* Table : FICHIER                                              */
/*==============================================================*/
create table FICHIER
(
   ID_FICH              int not null,
   ID_PROJ              int not null,
   primary key (ID_FICH)
);

/*==============================================================*/
/* Table : MOTCLE                                               */
/*==============================================================*/
create table MOTCLE
(
   ID_MOTC              int not null,
   MOT_MOTC             varchar(25),
   primary key (ID_MOTC)
);

/*==============================================================*/
/* Table : POST                                                 */
/*==============================================================*/
create table POST
(
   ID_POST              int not null,
   ID_UTILIS            int not null,
   ID_SECT              int not null,
   TITRE_POST           varchar(100),
   EST_SIGNALE_POST     bool,
   primary key (ID_POST)
);

/*==============================================================*/
/* Table : PROFESSEUR                                           */
/*==============================================================*/
create table PROFESSEUR
(
   ID_PROF              int not null,
   ID_UTILIS            int not null,
   DEPARTEMENT_PROF     varchar(100),
   primary key (ID_PROF)
);

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table PROJET
(
   ID_PROJ              int not null,
   INTITULE_PROJ        varchar(100),
   DESCRIPTION_PROJ     text,
   primary key (ID_PROJ)
);

/*==============================================================*/
/* Table : REALISER                                             */
/*==============================================================*/
create table REALISER
(
   ID_PROJ              int not null,
   CNE_ETUD             char(10) not null,
   ID_PROF              int not null,
   ID_ENCADR            int not null,
   primary key (ID_PROJ, CNE_ETUD, ID_PROF, ID_ENCADR)
);

/*==============================================================*/
/* Table : SECTION                                              */
/*==============================================================*/
create table SECTION
(
   ID_SECT              int not null,
   TITRE_SECT           varchar(100),
   DESC_SECT            varchar(256),
   primary key (ID_SECT)
);

/*==============================================================*/
/* Table : TACHE                                                */
/*==============================================================*/
create table TACHE
(
   ID_TCH               int not null,
   TITRE_TCH            varchar(100),
   DESCRIPTION_TCH      text,
   DATE_DEBUT_TCH       date,
   DUREE_TCH            int,
   primary key (ID_TCH)
);

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR
(
   ID_UTILIS            int not null,
   CNE_ETUD             char(10),
   ID_PROF              int,
   ID_ENCADR            int,
   NOM_UTILIS           varchar(25),
   PRENOM_UTILIS        varchar(25),
   EMAIL_UTILS          varchar(256),
   MOT_DE_PASSE_UTILIS  varchar(30),
   ROLE_UTILS           char(4),
   TEL_UTILS            char(10),
   primary key (ID_UTILIS)
);

alter table COMMENTAIRE add constraint FK_COMMENTERPOST foreign key (ID_POST)
      references POST (ID_POST) on delete restrict on update restrict;

alter table COMMENTAIRE add constraint FK_COMMENTERTACHE foreign key (ID_TCH)
      references TACHE (ID_TCH) on delete restrict on update restrict;

alter table COMMENTAIRE add constraint FK_ECRIRE foreign key (ID_UTILIS)
      references UTILISATEUR (ID_UTILIS) on delete restrict on update restrict;

alter table COMPOSEDE add constraint FK_COMPOSEDE foreign key (ID_PROJ)
      references PROJET (ID_PROJ) on delete restrict on update restrict;

alter table COMPOSEDE add constraint FK_COMPOSEDE2 foreign key (ID_TCH)
      references TACHE (ID_TCH) on delete restrict on update restrict;

alter table CONTENIR add constraint FK_CONTENIR foreign key (ID_PROJ)
      references PROJET (ID_PROJ) on delete restrict on update restrict;

alter table CONTENIR add constraint FK_CONTENIR2 foreign key (ID_MOTC)
      references MOTCLE (ID_MOTC) on delete restrict on update restrict;

alter table ENCADRANTENTREPRISE add constraint FK_IDENTIFIER2 foreign key (ID_UTILIS)
      references UTILISATEUR (ID_UTILIS) on delete restrict on update restrict;

alter table ENCADRANTENTREPRISE add constraint FK_TRAVAILLE foreign key (ID_ENTRP)
      references ENTREPRISE (ID_ENTRP) on delete restrict on update restrict;

alter table ETUDIANT add constraint FK_UTILISATEURETUDIANT foreign key (ID_UTILIS)
      references UTILISATEUR (ID_UTILIS) on delete restrict on update restrict;

alter table FICHIER add constraint FK_JOINDRE foreign key (ID_PROJ)
      references PROJET (ID_PROJ) on delete restrict on update restrict;

alter table POST add constraint FK_CONTENIRPOST foreign key (ID_SECT)
      references SECTION (ID_SECT) on delete restrict on update restrict;

alter table POST add constraint FK_PUBLIER foreign key (ID_UTILIS)
      references UTILISATEUR (ID_UTILIS) on delete restrict on update restrict;

alter table PROFESSEUR add constraint FK_EST2 foreign key (ID_UTILIS)
      references UTILISATEUR (ID_UTILIS) on delete restrict on update restrict;

alter table REALISER add constraint FK_REALISER foreign key (ID_PROJ)
      references PROJET (ID_PROJ) on delete restrict on update restrict;

alter table REALISER add constraint FK_REALISER2 foreign key (CNE_ETUD)
      references ETUDIANT (CNE_ETUD) on delete restrict on update restrict;

alter table REALISER add constraint FK_REALISER3 foreign key (ID_PROF)
      references PROFESSEUR (ID_PROF) on delete restrict on update restrict;

alter table REALISER add constraint FK_REALISER4 foreign key (ID_ENCADR)
      references ENCADRANTENTREPRISE (ID_ENCADR) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_EST3 foreign key (ID_PROF)
      references PROFESSEUR (ID_PROF) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_IDENTIFIER3 foreign key (ID_ENCADR)
      references ENCADRANTENTREPRISE (ID_ENCADR) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_UTILISATEURETUDIANT2 foreign key (CNE_ETUD)
      references ETUDIANT (CNE_ETUD) on delete restrict on update restrict;

