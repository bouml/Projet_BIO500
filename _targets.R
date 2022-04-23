library(targets)
library(tarchetypes)
tar_option_set(packages = c("rmarkdown",
                            "knitr","usethis"))

source("R/functions.R")

list(
  tar_target(
    table_collab, 
    table_collab_f()),
  tar_target(
    table_noeuds, 
    table_noeuds_f()),
  tar_target(
    table_cours, 
    table_cours_f()),
  tar_target(
    table_clean_collab, 
    doublon_free_collab(table_collab)),
  tar_target(
    table_clean_noeuds, 
    doublon_free_noeuds(table_noeuds)),
  tar_target(
    table_clean_cours, 
    doublon_free_cours(table_cours)),
  tar_target(
    table_collab_sql, 
    table_collab_sql_f(table_clean_collab)),
  tar_target(
    table_noeuds_sql, 
    table_noeuds_sql_f(table_clean_noeuds)),
  tar_target(
    table_cours_sql, 
    table_cours_sql_f(table_clean_cours)),
  tar_target(
    requete_nb_collab, 
    liens_par_etudiant_f(table_collab_sql)),
  tar_target(
    lien_par_paire_etudiant, 
    lien_par_paire_etudiant_f(table_collab_sql)),
  tar_target(
    nb_etudiant, 
    nb_etudiant_f(table_collab_sql)),
  tar_target(
    connectance, 
    calcul_connectance(table_clean_noeuds, table_clean_collab)),
  tar_target(
    matrice_adjacence, 
    matrice_adjacence_f(table_collab_sql)),
  tar_target(
    reseau, 
    reseau_f(matrice_adjacence)),
  tar_target(
    figure_un, 
    figure_un_f(reseau, matrice_adjacence)),
  tar_target(
    figure_deux, 
    figure_deux_f(reseau, requete_nb_collab)),
  tar_target(
    figure_trois, 
    figure_trois_f(reseau))
)

    








  
  
 
  
 
  
 
 
  
 
 







