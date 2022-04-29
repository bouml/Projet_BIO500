##################IN CASE###################################################
##tar_edit()
##install.packages("usethis")
##library("usethis")
##tar_script()
##tar_glimpse()
##tar_make()
##tar_visnetwork()

##################UPLOADER DONNÉES##########################################
#Create DB
create_db <- function() {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
}
#Pour collab
table_collab_f <- function() {
  temp_collab <- list.files(path="data/", pattern = "collab", full.names=T)
  mycollabs <- lapply(temp_collab, read.csv2)
  db_collaborations <- do.call(rbind, mycollabs)
}

#Pour noeuds
table_noeuds_f <- function() {
  temp_noeuds <- list.files(path="data/", pattern = "noeuds", full.names=T)
  mynoeuds <- lapply(temp_noeuds, read.csv2)
  db_noeuds <- do.call(rbind, mynoeuds)
}

#Pour cours
table_cours_f <- function() {
  temp_cours <- list.files(path="data/", pattern = "cours", full.names=T)
  mycours <- lapply(temp_cours, read.csv2)
  db_cours <- do.call(rbind, mycours)
}

#pas fait l'étape pour enlever les erreurs j'imagine que ça va être spécifique à chaque script
###############ENLEVER LES DOUBLONS + METTRE EN ORDRE#########################################
#Pour collab
doublon_free_collab <- function(db_collaborations) {
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("arseneault_benoit","arsenault_benoit+G5:J30")]<-"arsenault_benoit"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("baubien_marie")]<-"beaubien_marie"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("bertiaume_elise")]<-"berthiaume_elise"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("codaire_francois_xavier")]<-"codaire_francoisxavier"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("hamzaoui_karime")]<-"hamzaoui_karim"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("cloutier_zachari","cloutier_zach")]<-"cloutier_zachary"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("stpierre_anthony")]<-"saintpierre_anthony"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("stpierre_audreyann")]<-"saintpierre_audreyann"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("viel_lapointe")]<-"viellapointe_catherine"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("vielapointe_catherine")]<-"viellapointe_catherine"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("saintamant_xavier")]<-"stamant_xavier"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("raymon_louisphilippe")]<-"raymond_louisphilippe"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("plewenski_david")]<-"plewinski_david"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("nadonbeaumier_ed+G5:J30ouard")]<-"nadonbeaumier_edouard"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("martineau_alex")]<-"martineau_alexandre"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("lefevbre_isabelle")]<-"lefebvre_isabelle"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("leclair_oliver")]<-"leclerc_olivier"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("leclerc_oliver")]<-"leclerc_olivier"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("langlois_claudianne")]<-"langlois_claudieanne"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("elisabeth_roy")]<-"roy_elisabeth"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("coulombe_Jessica")]<-"coulombe_jessica"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("coulombre_jessica")]<-"coulombe_jessica"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("d_hamelin_maili","hamelin_maili")]<-"dhamelin_maili"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("jameslaurie_veldon")]<-"laurie_veldonjames"
  db_collaborations$etudiant1[db_collaborations$etudiant1 %in% c("stamant_xavier")]<-"saintamant_xavier"
  
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("arseneault_benoit","arsenault_benoit+G5:J30")]<-"arsenault_benoit"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("baubien_marie")]<-"beaubien_marie"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("bertiaume_elise")]<-"berthiaume_elise"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("codaire_francois_xavier")]<-"codaire_francoisxavier"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("hamzaoui_karime")]<-"hamzaoui_karim"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("cloutier_zachari","cloutier_zach")]<-"cloutier_zachary"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("stpierre_anthony")]<-"saintpierre_anthony"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("stpierre_audreyann")]<-"saintpierre_audreyann"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("viel_lapointe")]<-"viellapointe_catherine"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("vielapointe_catherine")]<-"viellapointe_catherine"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("saintamant_xavier")]<-"stamant_xavier"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("raymon_louisphilippe")]<-"raymond_louisphilippe"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("plewenski_david")]<-"plewinski_david"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("nadonbeaumier_ed+G5:J30ouard")]<-"nadonbeaumier_edouard"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("martineau_alex")]<-"martineau_alexandre"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("lefevbre_isabelle")]<-"lefebvre_isabelle"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("leclair_oliver")]<-"leclerc_olivier"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("leclerc_oliver")]<-"leclerc_olivier"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("langlois_claudianne")]<-"langlois_claudieanne"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("elisabeth_roy")]<-"roy_elisabeth"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("coulombe_Jessica")]<-"coulombe_jessica"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("coulombre_jessica")]<-"coulombe_jessica"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("d_hamelin_maili","hamelin_maili")]<-"dhamelin_maili"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("jameslaurie_veldon")]<-"laurie_veldonjames"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("stamant_xavier")]<-"saintamant_xavier"
  db_collaborations$etudiant2[db_collaborations$etudiant2 %in% c("mathieu_fauchon")]<-"fauchon_mathieu"
  
  db_collaborations$sigle[db_collaborations$sigle %in% c("tbs303")]<-"TSB303"
  db_collaborations$sigle[db_collaborations$sigle %in% c("tbS303")]<-"TSB303"
  db_collaborations$sigle[db_collaborations$sigle %in% c("TBS303")]<-"TSB303"
  
  is.duplicated_collaborations <- duplicated(db_collaborations[,1:3]) 
  sub.collaborations <- subset(db_collaborations, is.duplicated_collaborations==F) 
  order_collaboration <- sub.collaborations[order(sub.collaborations$etudiant1),]
  order_collaboration <- order_collaboration[-c(which(order_collaboration$etudiant1==order_collaboration$etudiant2)),]
}
  
#Pour noeuds
doublon_free_noeuds <- function(db_noeuds) {
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("arseneault_benoit","arsenault_benoit+G5:J30")]<-"arsenault_benoit"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("baubien_marie")]<-"beaubien_marie"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("bertiaume_elise")]<-"berthiaume_elise"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("codaire_francois_xavier")]<-"codaire_francoisxavier"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("hamzaoui_karime")]<-"hamzaoui_karim"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("cloutier_zachari","cloutier_zach")]<-"cloutier_zachary"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("stpierre_anthony")]<-"saintpierre_anthony"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("stpierre_audreyann")]<-"saintpierre_audreyann"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("lefevbre_isabelle")]<-"lefebvre_isabelle"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("hamelin_maili")]<-"dhamelin_maili"
  db_noeuds$nom_prenom[db_noeuds$nom_prenom %in% c("stamant_xavier")]<-"saintamant_xavier"
  
  is.duplicated_noeuds <- duplicated(db_noeuds$nom_prenom) 
  sub.noeuds <- subset(db_noeuds, is.duplicated_noeuds==F) 
  order_noeuds <- sub.noeuds[order(sub.noeuds$nom_prenom),]
}

#Pour cours
doublon_free_cours <- function(db_cours) {
  is.duplicated_cours <- duplicated(db_cours$sigle) 
  sub.cours <- subset(db_cours, is.duplicated_cours==F) 
  order_cours <- sub.cours[order(sub.cours$sigle),]
}

###############CRÉER LES TABLES SQL ET INJECTER L'INFORMATION DANS LES TABLES########################################
#Pour collaboration
table_collab_sql_f <- function(db, order_collaboration) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  dbSendQuery(con, "DROP TABLE collaborations;")
  collab_sql <- 'CREATE TABLE collaborations (
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
  dbReadTable(con, "collaborations")
}

#Pour noeuds
table_noeuds_sql_f <- function(db, order_noeuds) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  dbSendQuery(con, "DROP TABLE noeuds;")
  noeuds_sql <- 'CREATE TABLE noeuds (
  nom_prenom VARCHAR(50) NOT NULL,
  annee_debut DATE(4),
  session_debut CHAR(1),
  programme VARCHAR(20),
  coop BOOLEAN(1),
  PRIMARY KEY (nom_prenom)
  );'
  dbSendQuery(con, noeuds_sql) 
  dbWriteTable(con, append = TRUE, name = "noeuds", value = order_noeuds, row.names = FALSE)
  dbReadTable(con, "noeuds")
}

#Pour cours
table_cours_sql_f <- function(db, order_cours) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  dbSendQuery(con, "DROP TABLE cours;")
  cours_sql <- 'CREATE TABLE cours (
  sigle CHAR(6) NOT NULL,
  credits INTEGER(1) ,
  obligatoire BOOLEAN(1),
  laboratoire BOOLEAN(1),
  libre BOOLEAN(1),
  PRIMARY KEY (sigle)
  );'
  dbSendQuery(con, cours_sql) 
  dbWriteTable(con, append = TRUE, name = "cours", value = order_cours, row.names = FALSE)
  dbReadTable(con, "cours")
}

###############REQUÊTES SQL#########################################################
# 1) Nombre de liens par etudiant
liens_par_etudiant_f <- function(data) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  liens_par_etudiant <-
  "SELECT etudiant1, count(DISTINCT etudiant2) AS nb_collaborations 
  FROM (SELECT DISTINCT etudiant1, etudiant2
    FROM collaborations)

  GROUP BY etudiant1
  ORDER BY nb_collaborations
  ;"
  nb_collaborations <- dbGetQuery(con, liens_par_etudiant)
}

# 2) Decompte de liens par paire d_etudiants
lien_par_paire_etudiant_f <- function(data) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  liens_par_paire <- "
  SELECT etudiant1, etudiant2, count(DISTINCT sigle) AS nb_liens
     FROM (SELECT DISTINCT etudiant1, etudiant2, sigle 
      FROM collaborations)
    
     
     GROUP BY etudiant1, etudiant2
     ORDER BY nb_liens
  ;"
  nb_liens<- dbGetQuery(con, liens_par_paire)
}

# 3) Nombre d_etudiants
nb_etudiant_f <- function(data) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  etudiants <- "
  SELECT count(DISTINCT etudiant1) as nb_etudiants
  FROM collaborations
  
  ;"
  nb_etudiants<- dbGetQuery(con, etudiants)
}

# 4) Calcul de la connectance
calcul_connectance <- function(nb_etudiants,nb_collaborations) {
  S2=as.numeric(nb_etudiants^2)
  L= sum(nb_collaborations$nb_collaborations)
  C=L/S2
}

##################MATRICE D'ADJACENCE#############################################################
matrice_adjacence_f <- function(data) {
  con <- dbConnect(SQLite(), dbname = "./projet.db")
  on.exit(dbDisconnect(con))
  matrice_sql<- "
  SELECT etudiant1, etudiant2 
  FROM collaborations
  ;"
  data_matrice<- dbGetQuery(con, matrice_sql)
  adj_collab <- table(data_matrice)
}

#################FIGURES##########################################################################
# 1) Production du reseau de liens de la totalite des etudiants 
reseau_f <- function(adj_collab) {
  network <- graph_from_adjacency_matrix(adj_collab)
}

figure_un_f <- function(network,adj_collab) {
  pdf(file = "results/reseau.pdf")
  #Réduire les marges 
  par(mar=c(0.1,0.1,2,0.1))
  # Calculer le degré 
  deg=apply(adj_collab, 2, sum) + apply(adj_collab, 1, sum) 
  # Le rang pour chaque noeud
  rk=rank(deg)
  # Faire un code de couleur
  col.vec=rainbow(nrow(adj_collab))
  # Attribuer aux noeuds la couleur
  V(network)$color = col.vec[rk]
  # Faire un code de taille
  col.vec.taille=seq(2, 10, length.out = nrow(adj_collab))
  # Attribuer aux noeuds la couleur
  V(network)$size = col.vec.taille[rk]
  # Refaire la figure
  plot(network, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = NA)
}

# 2) Existe-t-il une correlation entre le nombre de liens et la centralite

figure_deux_f <- function(network,nb_collaborations) {
  pdf(file = "results/centralite.pdf")
  par(mar=c(5,5,5,5))
  centralite=eigen_centrality(network)$vector 
  nombre_de_liens=nb_collaborations[,2]
  plot(nombre_de_liens,centralite,pch=20, 
     xlab = "Nombre de liens", ylab= "Centralite")
  cor.test(nombre_de_liens,centralite)
}

# 3) Calculer le bacon number des etudiants par rapport a elisabeth 
figure_trois_f <- function(network) {
  pdf(file = "results/bacon.pdf")
  par(mar=c(5,5,5,5))
  distance=distances(network)
  bacon_number=as.matrix(distance[,168])
  bacon_number=bacon_number[bacon_number!=0]
  hist(bacon_number, xlab="Nombre de Bacon", ylab="Frequence", breaks = c(0.5,1.5,2.5,3.5,4.5), main=NULL)
}
