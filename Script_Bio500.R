setwd("/Users/laurenceboum/Desktop/met_comp/Projet_BIO500")


#install.packages("RSQLite")
library(RSQLite)
con= dbConnect(SQLite(), dbname="./projet.db")

#dbSendQuery(con, "DROP TABLE noeuds;")
#dbSendQuery(con, "DROP TABLE collaborations;")
#dbSendQuery(con, "DROP TABLE cours;")


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
collab_1= read.table("collaboration_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )
collab_2= read.csv("collaborations_amelie.csv", skip = 1, header=F,sep = ";")
collab_3= read.table("collaborations_anthonystp.txt", skip=1, header = F, sep= ";")
collab_4= read.csv("collaborations_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";")
collab_5= read.csv("collaborations_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";", colClasses = c("character","character", "character", "character", "NULL"))
collab_6= read.table("collaborations_FXC_MF_TC_LRT_WP..txt", skip=1, header = F, sep= "\t", colClasses = c("character","character", "character", "character", "NULL", "NULL","NULL"))
collab_7= read.table("collaborations_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";", colClasses = c("character","character", "character", "character", "NULL"))
collab_8= read.table("collaborations_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")
collab_9= read.table("collaborations_martineau.txt", skip=1, header = F, sep= ";")

db_collaborations=rbind(collab_1,collab_2,collab_3,collab_4,collab_5,collab_6,collab_7,collab_8,collab_9)
colnames(db_collaborations)=(c("etudiant1","etudiant2","sigle","date"))


#     FICHIERS COURS
c1= read.table("Cours_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )
c2= read.csv("cours_amelie.csv", skip = 1, header=F,sep = ";",colClasses = c("character","integer","integer","integer","integer","NULL", "NULL"))
c3= read.table("cours_anthonystp.txt", skip=1, header = F, sep= ";",colClasses = c("character","integer","integer","integer","NULL","integer"))
colnames(c3)=(c("sigle","credit","obligatoire","laboratoire","libre"))
c4= read.csv("cours_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";")
c5= read.csv("cours_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";",)
c6= read.table("cours_FXC_MF_TC_LRT_WP..txt", skip=1, header = F, sep= "\t")
c7= read.table("cours_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";")
c8= read.table("cours_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")
c9= read.table("cours_martineau.txt", skip=1, header = F, sep= ";")

cours0=rbind(c1,c2,c4,c5,c6,c7,c8,c9)
colnames(cours0)=(c("sigle","credit","obligatoire","laboratoire","libre"))

db_cours=rbind(cours0,c3)

#     FICHIERS NOEUDS
n1= read.table("etudiant_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )
n2= read.csv("noeuds_amelie.csv", skip = 1, header=F,sep = ";")
n3= read.table("noeuds_anthonystp .txt", skip=1, header = F, sep= ";")
n4= read.csv("noeuds_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";",colClasses = c("NULL","character", "integer", "character", "character", "integer"))
colnames(n4)=(c("nom_prenom","annee_debut","session_debut","programme","coop"))
n5= read.csv("noeuds_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";")
n6= read.table("noeuds_FXC_MF_TC_LRT_WP.txt", skip=1, header = F, sep= "\t",)
n7= read.table("etudiant_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";")
n8= read.table("noeuds_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")
n9= read.table("noeuds_martineau.txt", skip=1, header = F, sep= ";")

noeuds0=rbind(n1,n2,n3,n5,n6,n7,n8,n9)
colnames(noeuds0)=(c("nom_prenom","annee_debut","session_debut","programme","coop"))

db_noeuds=rbind(noeuds0,n4)


##########################################################################################
##########  ENLEVER LES ERREURS ET DOUBLONS  #############################################
##########################################################################################

# COLLABORATIONS            
#          ENLEVER LES DOUBLONS
is.duplicated_cours <- duplicated(db_collaborations[,1:3]) 
sub.collaborations <- subset(db_collaborations, is.duplicated_cours==F) 

sub.collaborations <- unique(db_collaborations)

#          METTRE EN ORDRE
order_collaboration <- sub.collaborations[order(sub.collaborations$etudiant1),]

#          ENLEVER LES ERREURS
order_collaboration$etudiant1[order_collaboration$etudiant1 %in% c("arseneault_benoit","arsenault_benoit+G5:J30")]<-"arsenault_benoit"
order_collaboration$etudiant1[order_collaboration$etudiant1 %in% c("baubien_marie")]<-"beaubien_marie"
order_collaboration$etudiant1[order_collaboration$etudiant1 %in% c("bertiaume_elise")]<-"berthiaume_elise"

#          ENLEVER LES AUTRES DOUBLONS
is.duplicated_collaborations <- duplicated(order_collaboration$etudiant1)
data_collaborations <- subset(order_collaboration, is.duplicated_collaborations==F)  
collaborations <- unique(o.collaborations)


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
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("codaire_francois_xavier")]<-"codaire_francoisxavier"
order_noeuds$nom_prenom[order_noeuds$nom_prenom %in% c("hamzaoui_karime")]<-"hamzaoui_karim"

#         ENLEVER LES AUTRES DOUBLONS
is.duplicated_noeuds <- duplicated(order_noeuds$nom_prenom)
data_noeuds <- subset(order_noeuds, is.duplicated_noeuds==F)  

##########################################################################################
##########  INJECTION DES DONNEES          ###############################################
##########################################################################################
dbWriteTable(con, append = TRUE, name = "collaborations", value = data_collaborations, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cours", value = data_cours, row.names = FALSE)   
dbWriteTable(con, append = TRUE, name = "noeuds", value = data_noeuds, row.names = FALSE)

##########################################################################################
##########      REQUETES      ############################################################
##########################################################################################
# 1) Nombre de liens par etudiant
sql_requete <- "
SELECT etudiant1, count(DISTINCT etudiant2) AS nb_collaborations FROM (
  SELECT DISTINCT etudiant1, etudiant2
    FROM collaborations
)
GROUP BY etudiant1
ORDER BY nb_collaborations
;"
nb_collaborations <- dbGetQuery(con, sql_requete)
show(nb_collaborations)   




# 2) Decompte de liens par paire d_etudiants







