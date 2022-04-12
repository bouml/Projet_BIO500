#install.packages("rticles")
#install.packages("igraph")
#install.packages("tarchetypes")
#nstall.packages("tinytext")
#tinytex::install_tinytex()

library(tarchetypes)
library(igraph)
library(rticles)
library(RSQLite)
library(RSQLite)

con= dbConnect(SQLite(), dbname="./projet.db")

dbSendQuery(con, "DROP TABLE noeuds;")
dbSendQuery(con, "DROP TABLE collaborations;")
dbSendQuery(con, "DROP TABLE cours;")


##########################################################################################
##########      CREATION DES TABLES             ##########################################
##########################################################################################

#     TABLE NOEUDS
noeuds_sql= 'CREATE TABLE noeuds (
  nom_prenom VARCHAR(50) NOT NULL,
  annee_debut DATE(4),
  session_debut CHAR(1),
  programme VARCHAR(20),
  coop BOOLEAN(1),
  PRIMARY KEY (nom_prenom)
);'
dbSendQuery(con, noeuds_sql) #Envoie l'information a la table


#     TABLE COURS
cours_sql= 'CREATE TABLE cours (
  sigle CHAR(6) NOT NULL,
  credit INTEGER(1) ,
  obligatoire BOOLEAN(1),
  laboratoire BOOLEAN(1),
  libre BOOLEAN(1),
  PRIMARY KEY (sigle)
);'
dbSendQuery(con, cours_sql) #Envoie l'information a la table


#     TABLE COLLABORATION
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
dbSendQuery(con, collab_sql) #Envoie l'information a la table


##########################################################################################
##########    VISUALISER LES TABLES   ####################################################
##########################################################################################
dbListTables(con)



##########################################################################################
##########       LECTURE DES FICHIERS           ##########################################
##########################################################################################

#     FICHIERS COLLABORATION 
collab_1= read.table("data/collaboration_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )
collab_2= read.csv("data/collaborations_amelie.csv", skip = 1, header=F,sep = ";")
collab_3= read.table("data/collaborations_anthonystp.txt", skip=1, header = F, sep= ";")
collab_4= read.csv("data/collaborations_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";")
collab_5= read.csv("data/collaborations_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";", colClasses = c("character","character", "character", "character", "NULL"))
collab_6= read.table("data/collaborations_FXC_MF_TC_LRT_WP..txt", skip=1, header = F, sep= "\t", colClasses = c("character","character", "character", "character", "NULL", "NULL","NULL"))
collab_7= read.table("data/collaborations_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";", colClasses = c("character","character", "character", "character", "NULL"))
collab_8= read.table("data/collaborations_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")
collab_9= read.table("data/collaborations_martineau.txt", skip=1, header = F, sep= ";")

db_collaborations=rbind(collab_1,collab_2,collab_3,collab_4,collab_5,collab_6,collab_7,collab_8,collab_9)
colnames(db_collaborations)=(c("etudiant1","etudiant2","sigle","date"))
db_collaborations$etudiant1 <- trimws(db_collaborations$etudiant1)
db_collaborations$etudiant2 <- trimws(db_collaborations$etudiant2)
db_collaborations$sigle <- trimws(db_collaborations$sigle)


#     FICHIERS COURS
c1= read.table("data/Cours_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )
c2= read.csv("data/cours_amelie.csv", skip = 1, header=F,sep = ";",colClasses = c("character","integer","integer","integer","integer","NULL", "NULL"))
c3= read.table("data/cours_anthonystp.txt", skip=1, header = F, sep= ";",colClasses = c("character","integer","integer","integer","NULL","integer"))
colnames(c3)=(c("sigle","credit","obligatoire","laboratoire","libre"))
c4= read.csv("data/cours_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";")
c5= read.csv("data/cours_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";",)
c6= read.table("data/cours_FXC_MF_TC_LRT_WP..txt", skip=1, header = F, sep= "\t")
c7= read.table("data/cours_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";")
c8= read.table("data/cours_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")
c9= read.table("data/cours_martineau.txt", skip=1, header = F, sep= ";")

cours0=rbind(c1,c2,c4,c5,c6,c7,c8,c9)
colnames(cours0)=(c("sigle","credit","obligatoire","laboratoire","libre"))

db_cours=rbind(cours0,c3)
db_cours$sigle <- trimws(db_cours$sigle)


#     FICHIERS NOEUDS
n1= read.table("data/etudiant_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )
n2= read.csv("data/noeuds_amelie.csv", skip = 1, header=F,sep = ";")
n3= read.table("data/noeuds_anthonystp .txt", skip=1, header = F, sep= ";")
n4= read.csv("data/noeuds_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";",colClasses = c("NULL","character", "integer", "character", "character", "integer"))
colnames(n4)=(c("nom_prenom","annee_debut","session_debut","programme","coop"))
n5= read.csv("data/noeuds_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";")
n6= read.table("data/noeuds_FXC_MF_TC_LRT_WP.txt", skip=1, header = F, sep= "\t",)
n7= read.table("data/etudiant_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";")
n8= read.table("data/noeuds_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")
n9= read.table("data/noeuds_martineau.txt", skip=1, header = F, sep= ";")

noeuds0=rbind(n1,n2,n3,n5,n6,n7,n8,n9)
colnames(noeuds0)=(c("nom_prenom","annee_debut","session_debut","programme","coop"))

db_noeuds=rbind(noeuds0,n4)
db_noeuds$nom_prenom <- trimws(db_noeuds$nom_prenom)


##########################################################################################
##########  ENLEVER LES ERREURS ET DOUBLONS  #############################################
##########################################################################################

# COLLABORATIONS 
#          ENLEVER LES ERREURS
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

#          ENLEVER LES DOUBLONS
is.duplicated_collaborations <- duplicated(db_collaborations[,1:3]) 
sub.collaborations <- subset(db_collaborations, is.duplicated_collaborations==F) 

#          METTRE EN ORDRE
order_collaboration <- sub.collaborations[order(sub.collaborations$etudiant1),]

#retirer une auto-collaboration
# 1: Spotter l'auto-collab
which(order_collaboration$etudiant1==order_collaboration$etudiant2)
order_collaboration <- order_collaboration[-c(1936),]
# COURS  
#         ENLEVER LES DOUBLONS
is.duplicated_cours <- duplicated(db_cours$sigle)
sub.cours <- subset(db_cours, is.duplicated_cours==F)  

#         METTRE EN ORDRE
data_cours <- sub.cours[order(sub.cours$sigle),]


# NOEUDS
#         ENLEVER LES DOUBLONS
is.duplicated_noeuds <- duplicated(db_noeuds$nom_prenom)
sub.noeuds <- subset(db_noeuds, is.duplicated_noeuds==F)  

#         METTRE EN ORDRE
order_noeuds <- sub.noeuds[order(sub.noeuds$nom_prenom),]

#         ENLEVER LES ERREURS
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("arseneault_benoit","arsenault_benoit+G5:J30")]<-"arsenault_benoit"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("baubien_marie")]<-"beaubien_marie"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("bertiaume_elise")]<-"berthiaume_elise"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("codaire_francois_xavier")]<-"codaire_francoisxavier"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("hamzaoui_karime")]<-"hamzaoui_karim"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("cloutier_zachari","cloutier_zach")]<-"cloutier_zachary"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("stpierre_anthony")]<-"saintpierre_anthony"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("stpierre_audreyann")]<-"saintpierre_audreyann"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("lefevbre_isabelle")]<-"lefebvre_isabelle"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("hamelin_maili")]<-"dhamelin_maili"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("stamant_xavier")]<-"saintamant_xavier"

#         ENLEVER LES AUTRES DOUBLONS
is.duplicated_noeuds <- duplicated(order_noeuds$nom_prenom)
data_noeuds <- subset(order_noeuds, is.duplicated_noeuds==F)  

##########################################################################################
##########  INJECTION DES DONNEES          ###############################################
##########################################################################################
dbWriteTable(con, append = TRUE, name = "collaborations", value = order_collaboration, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cours", value = data_cours, row.names = FALSE)   
dbWriteTable(con, append = TRUE, name = "noeuds", value = data_noeuds, row.names = FALSE)

##########################################################################################
##########      REQUETES      ############################################################
##########################################################################################

#         1) Nombre de liens par etudiant
liens_par_etudiant<- "
SELECT etudiant1, count(DISTINCT etudiant2) AS nb_collaborations 
  FROM (SELECT DISTINCT etudiant1, etudiant2
    FROM collaborations)

  GROUP BY etudiant1
  ORDER BY nb_collaborations
;"
nb_collaborations <- dbGetQuery(con, liens_par_etudiant)
show(nb_collaborations)   

#         2) Decompte de liens par paire d_etudiants
liens_par_paire<- "
SELECT etudiant1, etudiant2, count(DISTINCT sigle) AS nb_liens
     FROM (SELECT DISTINCT etudiant1, etudiant2, sigle 
      FROM collaborations)
    
     
     GROUP BY etudiant1, etudiant2
     ORDER BY nb_liens
;"
nb_liens<- dbGetQuery(con, liens_par_paire)
show(nb_liens) 

#     3) Nombre d_etudiants
etudiants<- "
SELECT count(DISTINCT etudiant1) as nb_etudiants
  FROM collaborations
  
;"
nb_etudiants<- dbGetQuery(con, etudiants)
show(nb_etudiants) 

#     4) Calcul de la connectance
# C = L/S^2
S2=as.numeric(nb_etudiants^2)
L= sum(nb_collaborations$nb_collaborations)

C=L/S2



# 5) Matrice d'adjacence
matrice_sql<- "
SELECT etudiant1, etudiant2 
  FROM collaborations
  
;"
data_matrice<- dbGetQuery(con, matrice_sql)
show(data_matrice) 

adj_collab <- table(data_matrice) #Extraire les donnees de la table avec une requete au lieu de referencer directement a ordercollaboration



##etudiant2 <- as.vector(colnames(adj_collab))
##etudiant1 <- as.vector(rownames(adj_collab))
##etudiants <- cbind(etudiant1,etudiant2)
##Pour vérifier le nombre d'étudiants si ca donne pas une matrice carrée

g <- graph.adjacency(adj_collab)
plot(g, vertex.label=NA, edge.arrow.mode = 0,
     vertex.frame.color = NA,
     layout = layout.circle(g))


############QUESTIONS##################################################################
#Idée de questions à répondre par oui ou non à partir d'une figure 
#Est-ce qu'il y a des gens parmi toute la base de données qui ont travaillé plus de 10 fois avec le même coéquipier dans des projets d'équipe ? oui/non (Histogramme, x= nb de collaborations avec une même personne, y= nb de fois que x collaborations entre deux mêmes étudiants est arrivées)
#Est-ce qu'il y a un lien entre 2 étudiants de niveau 4 ou plus ? oui/non (Histogramme, x= nb de liens entre chaque étudiant, y= nb de fois que des étudiants sont liés par x liens)
#Est-ce qu'il y a eu 20 travaux d'équipe, ou plus, réalisés par un étudiant du cours de BIO500 ? oui/non (Nuage de points ou Histogramme (ou à partir d'un tableau?), x= étudiants du cours BIO500, y= nb de travaux d'équipe réalisés, pourra mettre une barre à y=20) 

###########ESSAI POUR NETWORK GRAPH###################################################
#Première option
Etudiant= order_collaboration[, c('etudiant1', 'etudiant2')]
 levs <- unique(unlist(Etudiant, use.names = FALSE))
 adjacency_matrix = table(lapply(Etudiant, factor, levs))
#Réduire les marges sinon ne peut pas s'afficher
par(mar=c(0.1,0.1,0.1,0.1))
#Construire le graphique
network <- graph_from_adjacency_matrix(adj_collab)
#Pour enlever tous les détails dans le graph
plot(network, vertex.label = NA, edge.arrow.mode = 0, 
     vertex.frame.color = NA)
#Va devoir l'arranger car ce n'est pas super de la façon qu'il est présenté

#Deuxième option avec ggplot
#https://briatte.github.io/ggnet/ - le site à partir duquel j'ai trouvé la documentation, c'est super facile pour changer les paramètres du graph
install.packages("network")
library(network)
install.packages("sna")
library(sna)
install.packages("ggplot2")
library(ggplot2)
install.packages("GGally")
library(GGally)
install.packages("intergraph")
library(intergraph)

simp_network=simplify(network)

ggnet2(simp_network, node.size = 2, node.color = "black", edge.size = 0.5, edge.color = "grey", mode = "kamadakawai")

#Maly est une belle patate