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
'CREATE TABLE collaborations (
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
'CREATE TABLE noeuds (
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
'CREATE TABLE cours (
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

###############REQUÊTES SQL#########################################################
# 1) Nombre de liens par etudiant
liens_par_etudiant_f <- function() {
liens_par_etudiant = "
SELECT etudiant1, count(DISTINCT etudiant2) AS nb_collaborations 
  FROM (SELECT DISTINCT etudiant1, etudiant2
    FROM collaborations)

  GROUP BY etudiant1
  ORDER BY nb_collaborations
;"
nb_collaborations <- dbGetQuery(con, liens_par_etudiant)
show(nb_collaborations) 
}

# 2) Decompte de liens par paire d_etudiants
lien_par_paire_etudiant_f <- function() {
liens_par_paire <- "
SELECT etudiant1, etudiant2, count(DISTINCT sigle) AS nb_liens
     FROM (SELECT DISTINCT etudiant1, etudiant2, sigle 
      FROM collaborations)
    
     
     GROUP BY etudiant1, etudiant2
     ORDER BY nb_liens
;"
nb_liens<- dbGetQuery(con, liens_par_paire)
show(nb_liens) 
}

# 3) Nombre d_etudiants
nb_etudiant_f <- function() {
etudiants <- "
SELECT count(DISTINCT etudiant1) as nb_etudiants
  FROM collaborations
  
;"
nb_etudiants<- dbGetQuery(con, etudiants)
show(nb_etudiants) 
}

# 4) Calcul de la connectance
calcul_connectance <- function() {
S2=as.numeric(nb_etudiants^2)
L= sum(nb_collaborations$nb_collaborations)
C=L/S2
}

##################MATRICE D'ADJACENCE#############################################################
matrice_adjacence_f <- function() {
matrice_sql<- "
SELECT etudiant1, etudiant2 
  FROM collaborations
  ;"
data_matrice<- dbGetQuery(con, matrice_sql)
show(data_matrice) 
adj_collab <- table(data_matrice)
}

#################FIGURES##########################################################################
# 1) Production du reseau de liens de la totalite des etudiants 
reaseau_f <- function() {
#Réduire les marges sinon ne peut pas s'afficher
par(mar=c(0.1,0.1,0.1,0.1))
#Construire le graphique
network <- graph_from_adjacency_matrix(adj_collab)
}

figure_un_f <- funtion() {
# Faire la figure
plot(network, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = NA)
# Calculer le degré 
deg=apply(adj_collab, 2, sum) + apply(adj_collab, 1, sum) 
# Le rang pour chaque noeud
rk=rank(deg)
# Faire un code de couleur
col.vec=rainbow(nrow(adj_collab))
# Attribuer aux noeuds la couleur
V(network)$color = col.vec[rk]
# Refaire la figure
plot(network, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = NA)
# Faire un code de taille
col.vec.taille=seq(2, 10, length.out = nrow(adj_collab))
# Attribuer aux noeuds la couleur
V(network)$size = col.vec.taille[rk]
# Refaire la figure
plot(network, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = NA)
}

# 2) Existe-t-il une correlation entre le nombre de liens et la centralite

figure_deux_f <- function() {
  par(mar=c(5,5,5,5))
centralite=eigen_centrality(network)$vector 
nombre_de_liens=nb_collaborations[,2]
plot(nombre_de_liens,centralite,pch=20,main="Relation entre la centralité et le nombre de liens", xlab = "Nombre de liens", ylab= "Centralité")
cor.test(nombre_de_liens,centralite)
}

# 3) Calculer le bacon number des etudiants par rapport a elisabeth 
figure_trois_f <- function() {
par(mar=c(5,5,5,5))
distance=distances(network)
bacon_number=as.matrix(distance[,168])
hist(bacon_number, xlab="Nombre de Bacon", ylab="Fréquence",main="Degrés de séparation d'Élisabeth Roy",breaks = 6)
}
