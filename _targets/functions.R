
table_collab_f <- function() {
  temp_collab = list.files(path="data/", pattern = "collab", full.names=T)
  mycollabs = lapply(temp_collab, read.csv2)
  db_collaborations = do.call(rbind, mycollabs)
}

