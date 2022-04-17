ma_figure1 = function(data, resultat_modele) {
  Etudiant= data_matrice
  levs <- unique(unlist(Etudiant, use.names = FALSE))
  adjacency_matrix = table(lapply(Etudiant, factor, levs))
  #Réduire les marges sinon ne peut pas s'afficher
  par(mar=c(0.1,0.1,0.1,0.1))
  #Construire le graphique
  network <- graph_from_adjacency_matrix(adj_collab)
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



ma_figure2 = function(data, resultat_modele) {
  par(mar=c(5,5,5,5))
  centralite=eigen_centrality(network)$vector 
  nombre_de_liens=nb_collaborations[,2]
  plot(nombre_de_liens,centralite,pch=20,main="Relation entre la centralité et le nombre de liens", xlab = "Nombre de liens", ylab= "Centralité")

  cor.test(nombre_de_liens,centralite)
}

  
  
ma_figure3 = function(data, resultat_modele) {
  par(mar=c(5,5,5,5))
  distance=distances(network)
  bacon_number=as.matrix(distance[,168])
  hist(bacon_number, xlab="Nombre de Bacon", ylab="Fréquence",main="Degrés de séparation d'Élisabeth Roy",breaks = 6)
}
  
