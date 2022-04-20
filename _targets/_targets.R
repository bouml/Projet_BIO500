library(targets)
library(tarchetypes)
tar_option_set(packages = c("rmarkdown",
                            "knitr"))

source("functions.R")

list(
  tar_target(
    table_collab, table_collab_f()),
  tar_target(
    table_noeuds, table_noeuds_f()),
  tar_target(
    table_cours, table_cours_f()),
  tar_target(
    table_clean_collab, doublon_free_collab(table_collab)),
  tar_target(
    table_clean_noeuds, doublon_free_noeuds(table_noeuds)),
  tar_target(
    table_clean_cours, doublon_free_cours(table_cours))
)


              
 

    








  
  
 
  
 
  
 
 
  
 
 







