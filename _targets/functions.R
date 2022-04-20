##################IN CASE###################################################
tar_edit()
install.packages("usethis")
library("usethis")
tar_script()
tar_glimpse()
tar_make()
tar_visnetwork()

##################UPLOADER DONNÉES##########################################
#Pour collab
table_collab_f <- function() {
  temp_collab = list.files(path="data/", pattern = "collab", full.names=T)
  mycollabs = lapply(temp_collab, read.csv2)
  db_collaborations = do.call(rbind, mycollabs)
}

#Pour noeuds
table_noeuds_f <- function() {
  temp_noeuds = list.files(path="data/", pattern = "noeuds", full.names=T)
  mynoeuds = lapply(temp_noeuds, read.csv2)
  db_noeuds = do.call(rbind, mynoeuds)
}

#Pour cours
table_cours_f <- function() {
  temp_cours = list.files(path="data/", pattern = "cours", full.names=T)
  mycours = lapply(temp_cours, read.csv2)
  db_cours = do.call(rbind, mycours)
}

#pas fait l'étape pour enlever les erreurs j'imagine que ça va être spécifique à chaque script
###############ENLEVER LES DOUBLONS + METTRE EN ORDRE#########################################
#Pour collab
doublon_free_collab <- function() {
  is.duplicated_collaborations <- duplicated(db_collaborations[,1:3]) 
  sub.collaborations <- subset(db_collaborations, is.duplicated_collaborations==F) 
  order_collaboration <- sub.collaborations[order(sub.collaborations$etudiant1),]
}
  
#Pour noeuds
doublon_free_noeuds <- function() {
  is.duplicated_noeuds <- duplicated(db_noeuds[,1:3]) 
  sub.noeuds <- subset(db_noeuds, is.duplicated_noeuds==F) 
  order_noeuds <- sub.noeuds[order(sub.noeuds$etudiant1),]
}

#Pour cours
doublon_free_cours <- function() {
  is.duplicated_cours <- duplicated(db_cours[,1:3]) 
  sub.cours <- subset(db_cours, is.duplicated_cours==F) 
  order_cours <- sub.cours[order(sub.cours$etudiant1),]
}

###############CRÉER LES TABLES SQL ET INJECTER L'INFORMATION DANS LES TABLES########################################
#Pour collaboration
table_collab_sql_f <- function() {
collab_sql= 'CREATE TABLE collaborations (
  etudiant1 VARCHAR(50) NOT NULL,
  etudiant2 VARCHAR(50) NOT NULL,
  sigle CHAR(6),                                        
  date DATE(3),
  PRIMARY KEY (etudiant1, etudiant2, sigle)
  FOREIGN KEY (etudiant1) REFERENCES noeuds(nom_prenom)
  FOREIGN KEY (etudiant2) REFERENCES noeuds(nom_prenom)
  FOREIGN KEY (sigle) REFERENCES cours(sigle)   
);'
dbSendQuery(con, collab_sql) 
dbWriteTable(con, append = TRUE, name = "collaborations", value = order_collaboration, row.names = FALSE)
}

#Pour noeuds
table_noeuds_sql_f <- function() {
noeuds_sql= 'CREATE TABLE noeuds (
  nom_prenom VARCHAR(50) NOT NULL,
  annee_debut DATE(4),
  session_debut CHAR(1),
  programme VARCHAR(20),
  coop BOOLEAN(1),
  PRIMARY KEY (nom_prenom)
);'
dbSendQuery(con, noeuds_sql) 
dbWriteTable(con, append = TRUE, name = "noeuds", value = order_noeuds, row.names = FALSE)
}

#Pour cours
table_cours_sql_f <- function() {
cours_sql= 'CREATE TABLE cours (
  sigle CHAR(6) NOT NULL,
  credits INTEGER(1) ,
  obligatoire BOOLEAN(1),
  laboratoire BOOLEAN(1),
  libre BOOLEAN(1),
  PRIMARY KEY (sigle)
);'
dbSendQuery(con, cours_sql) 
dbWriteTable(con, append = TRUE, name = "cours", value = order_cours, row.names = FALSE)   
}
