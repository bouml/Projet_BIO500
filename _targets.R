library(targets)
library(tarchetypes)
tar_option_set(packages = c("rmarkdown",
                            "knitr"))

list(
    tar_target( 
      collab_1,
      read.table("data/collaboration_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )),
    tar_target(
      collab_2,
      read.csv("data/collaborations_amelie.csv", skip = 1, header=F,sep = ";")),
     tar_target(
       collab_3,
       read.table("data/collaborations_anthonystp.txt", skip=1, header = F, sep= ";")),
     tar_target(
       collab_4,
       read.csv("data/collaborations_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";")),
     tar_target(  
       collab_5,
       read.csv("data/collaborations_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";", colClasses = c("character","character", "character", "character", "NULL"))),
     tar_target(  
       collab_6,
       read.table("data/collaborations_FXC_MF_TC_LRT_WP..txt", skip=1, header = F, sep= "\t", colClasses = c("character","character", "character", "character", "NULL", "NULL","NULL"))),
     tar_target(  
       collab_7,
       read.table("data/collaborations_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";", colClasses = c("character","character", "character", "character", "NULL"))),
     tar_target(  
       collab_8,
       read.table("data/collaborations_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")),
     tar_target(  
       collab_9,
       read.table("data/collaborations_martineau.txt", skip=1, header = F, sep= ";")),
     tar_target(
       c1,
       read.table("data/Cours_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )),
     tar_target(
       c2,
       read.csv("data/cours_amelie.csv", skip = 1, header=F,sep = ";",colClasses = c("character","integer","integer","integer","integer","NULL", "NULL"))),
     tar_target(
       c3,
       read.table("data/cours_anthonystp.txt", skip=1, header = F, sep= ";",colClasses = c("character","integer","integer","integer","NULL","integer"))),
     tar_target(
       c4,
       read.csv("data/cours_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";")),
     tar_target(
       c5,
       read.csv("data/cours_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";",)),
     tar_target(     
       c6,
       read.table("data/cours_FXC_MF_TC_LRT_WP..txt", skip=1, header = F, sep= "\t")),
     tar_target(
       c7,
       read.table("data/cours_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";")),
     tar_target(
       c8,
       read.table("data/cours_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")),
     tar_target(
       c9,
       read.table("data/cours_martineau.txt", skip=1, header = F, sep= ";")),
    tar_target(
       n1,
       read.table("data/etudiant_Alexis_Nadya_Edouard_Penelope.txt",skip = 1, header=F, sep ="\t" )),
     tar_target(
       n2,
       read.csv("data/noeuds_amelie.csv", skip = 1, header=F,sep = ";")),
     tar_target(
       n3,
       read.table("data/noeuds_anthonystp .txt", skip=1, header = F, sep= ";")),
     tar_target(
       n4,
       read.csv("data/noeuds_cvl_jl_jl_mp_xs.csv", skip = 1, header=F,sep = ";",colClasses = c("NULL","character", "integer", "character", "character", "integer"))), 
     tar_target(
       n5,
       read.csv("data/noeuds_DP-GL-LB-ML-VQ_txt.csv", skip = 1, header=F,sep = ";")),
     tar_target(
       n6,
       read.table("data/noeuds_FXC_MF_TC_LRT_WP.txt", skip=1, header = F, sep= "\t",)),
     tar_target(
       n7,
       read.table("data/etudiant_IL_MDH_ASP_MB_OL.txt", skip=1, header = F, sep= ";")),
     tar_target(
       n8,
       read.table("data/noeuds_jbcaldlvjlgr.txt", skip=1, header = F, sep= ";")),
     tar_target(
       n9,
       read.table("data/noeuds_martineau.txt", skip=1, header = F, sep= ";"))
    )
  

    








  
  
 
  
 
  
 
 
  
 
 







